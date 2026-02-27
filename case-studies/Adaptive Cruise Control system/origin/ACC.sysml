package ACC {
    private import StructuralModel::*;
    private import BehavioralModel::*;
    private import SignalDefinition::*;
    package StructuralModel {
        // Standard library
        private import ScalarValues::*;
        part def 'Adaptive cruise control system' {
            attribute id : String;
            attribute current_speed : Integer;
            attribute set_speed : Integer;
            attribute target_speed : Integer;
            attribute relative_distance : Real;

            part radar : Radar[*];
            part laser : Lidar[*];
            part camera : Camera[*];
            part acc_controller : ACC_Controller[1];
            part powertrain : Powertrain[1];
            part brake : Brake[*];

        }

        part def Sensor {
            // Horizontal field of view (in degrees)
            attribute fovHorizontal : Real;
            // Vertical field of view (in degrees)
            attribute fovVertical : Real;
        }

        part def Radar :> Sensor {
            // Maximum detection range (in meters)
            attribute range : Real;

            // Indicates whether the radar's field of view is currently obstructed
            attribute isBlocked : Boolean;
        }

        part def Lidar :> Sensor {
            // Lidar inherits horizontal and vertical field of view from Sensor
        }

        part def Camera :> Sensor {
            // Image resolution (in megapixels, MP)
            attribute resolution : Real;
        }

        part def ACC_Controller {
            /**
            * Responsible for ordering the powertrain and brake system with required commands
            */
            // Indicates whether the ACC_Controller is operational
            attribute isOperational : Boolean;
        }

        part def Powertrain {
            part engine : Engine;
        }

        part def Engine {
            // Current throttle command (0.0 = idle, 1.0 = full power)
            attribute throttle : Real;

            // Engine rotational speed (in revolutions per minute, RPM)
            attribute rpm : Real;

            // Indicates whether the engine is operational
            attribute isOperational : Boolean;
        }

        part def Brake {
            // Brake pedal position or actuation level (0.0 = released, 1.0 = fully applied)
            attribute pedalPosition : Real;

            // Current braking torque applied to the wheels (in Newton-meters, N·m)
            attribute brakingTorque : Real;

            // Indicates whether the brake system is operational (e.g., no fluid leak or fault)
            attribute isOperational : Boolean;
        }

        exhibit state accState : ACCState;
    }

    package BehavioralModel {
        state def ACCState {
            part acc: 'Adaptive cruise control system';

            entry;
            then Idle;

            state Idle;
            state Ready;
            state Error;
            state AccOn parallel {
                state PerceptionLayerState {
                    entry;
                    then Idle;

                    state Idle;

                    state Perceptioning {
                        // To perceive and measure the forward vehicle's current distance, speed, acceleration and other parameters
                        do action perceive;
                    }

                    transition startPerception first Idle then Perceptioning;

                    transition inPerception
                        first Perceptioning
                        do send PerceptionSignal()
                        then Perceptioning;
                }

                state DecisionLayerState {
                    entry;
                    then waitingForSignal;

                    state waitingForSignal;
                    state deciding {
                        // To make control decision based on the signal from perception layer
                        do action 'decide' {
                            // Decision logic can be implemented here
                            action sendControlSignal send ControlSignal() via acc.acc_controller;
                        }
                    }
                    then waitingForSignal;

                    transition startDeciding
                        first waitingForSignal
                        accept PerceptionSignal
                        then deciding;
                }
                state ControlLayerState {
                    entry;
                    then maintainingSpeed;

                    // Vehicle is cruising at the target speed with no acceleration or deceleration command active
                    state maintainingSpeed;

                    // Vehicle has successfully decelerated and is now traveling at the target (lower) speed
                    state deceleratedToTargetSpeed;

                    // Vehicle has successfully accelerated and is now traveling at the target (higher) speed
                    state acceleratedToTargetSpeed;

                    // The acc_controller and brake works normally
                    transition normalDeceleration
                        first maintainingSpeed
                        accept DecelerationSignal
                        do action brake
                        then deceleratedToTargetSpeed;

                    transition finishDeceleration
                        first deceleratedToTargetSpeed
                        then maintainingSpeed;

                    // The acc_controller and engine in powertrain works normally
                    transition normalAcceleration
                        first maintainingSpeed
                        accept AccelerationSignal
                        do action throttle
                        then acceleratedToTargetSpeed;

                    transition finishAcceleration
                        first acceleratedToTargetSpeed
                        then maintainingSpeed;
                }
            }

            transition setACC first Idle then Ready;

            transition ACCError first Idle then Error;

            transition turnOnACC first Ready accept ACCTurnOnSignal then AccOn;

            transition turnOffACC first AccOn accept ACCTurnOffSignal then Idle;
        }
    }

    package SignalDefinition {
        item def PerceptionSignal;
        item def ACCTurnOnSignal;
        item def ACCTurnOffSignal;
        item def ControlSignal;
        item def AccelerationSignal :> ControlSignal;
        item def DecelerationSignal :> ControlSignal;
    }

}