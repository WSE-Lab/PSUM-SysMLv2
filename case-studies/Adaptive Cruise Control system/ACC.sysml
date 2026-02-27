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

            // Specifying IndeterminacySources
            /**
            * The radars could be physically blocked or disabled, 
            * with IndeterminayNature being Non-determinism
            */
            «IndeterminacySource<nd>» part radar : Radar[*] {
                «IndeterminacySpecification» constraint radarBlocked {
                    isBlocked == true
                }

                «IndeterminacySpecification» constraint radarNotBlocked {
                    isBlocked == false
                }
            }
            /**
            * The information provided by lasers and the cameras could lack sufficient precision, granularity, or fidelity 
            * to fully and accurately represent the observed phenomenon, 
            * with IndeterminayNature being InsufficientResolution
            */
            «IndeterminacySource<isr>» part laser : Lidar[*];

            «IndeterminacySource<isr>» part camera : Camera[*];

            «IndeterminacySource<nd>» part acc_controller : ACC_Controller[1] {
                «IndeterminacySpecification» constraint controllerOperational {
                    isOperational == true
                }

                «IndeterminacySpecification» constraint controllerNotOperational {
                    isOperational == false
                }
            }

            part powertrain : Powertrain[1];

            «IndeterminacySource<nd>» part brake : Brake[*] {
                «IndeterminacySpecification» constraint brakeOperational {
                    isOperational == true
                }

                «IndeterminacySpecification» constraint brakeNotOperational {
                    isOperational == false
                }
            }
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
            «IndeterminacySource<nd>» part engine : Engine {
                «IndeterminacySpecification» constraint engineOperational {
                    isOperational == true
                }

                «IndeterminacySpecification» constraint engineNotOperational {
                    isOperational == false
                }
            }
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
            then idle;

            state idle;
            state ready;
            state error;
            state accOn parallel {
                state perceptionLayerState {
                    entry;
                    then idle;

                    state idle;

                    state perceiving {
                        // To perceive and measure the forward vehicle's current distance, speed, acceleration and other parameters
                        do action perceive;
                    }

                    transition startPerception first idle then perceiving;

                    transition inPerception
                        first perceiving
                        do send PerceptionSignal()
                        then perceiving;
                }

                «BeliefStatement» state decisionLayerState  {
                    entry;
                    then waitingForSignal;

                    state waitingForSignal;
                    state deciding {
                        // To make control decision based on the signal from perception layer
                        «BeliefStatement» do action 'decide' {
                            // Decision logic can be implemented here
                            «Uncertainty<ocr, epi, subj>, Effect» action sendControlSignal send ControlSignal() via acc.acc_controller {
                                // Specifying reducibility of uncertainty
                                u_reducibility = PartiallyReducible;
                                // Specifying pattern of uncertainty
                                u_pattern = Random;

                                // Specifying indeterminacy source and specification
                                // '::>' represents for references (reference subsetting in sysmlv2)
                                «IndeterminacySpecification» ref constraint controllerOperational ::> acc.acc_controller.controllerOperational;
                                «IndeterminacySpecification» ref constraint radarNotBlocked ::> acc.radar.radarNotBlocked;
                                «IndeterminacySpecification» constraint overallSpecification {
                                    controllerOperational and radarNotBlocked
                                }

                                «Effect» ref ::> controlLayerState.normalAcceleration;
                                «Effect» ref ::> controlLayerState.normalDeceleration;

                                // To measure the probability of the uncertainty
                                measurement {
                                    m_degree = "TODO";
                                }
                            }
                        }
                    }
                    then waitingForSignal;

                    // The radar is not blocked, and the decision layer can receive PerceptionSignal
                    «Uncertainty<ocr, epi, subj» transition startDeciding
                        first waitingForSignal
                        accept PerceptionSignal
                        then deciding {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref ::> acc.radar.radarNotBlocked;

                            «Effect» ref ::> deciding.'decide'.sendControlSignal;

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    // The radar is blocked, and the decision layer cannot receive PerceptionSignal
                    «Uncertainty<ocr, epi, subj>» transition failToStartDeciding
                        first waitingForSignal
                        accept PerceptionSignal
                        then waitingForSignal {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref ::> acc.radar.radarBlocked;

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    metadata collisionRisk : RiskMetadata::Risk about failToStartDeciding {
                        totalRisk {
                            impact = RiskMetadata::LevelEnum::high;
                        }
                    }
                }

                «BeliefStatement» state controlLayerState {
                    entry;
                    then maintainingSpeed;

                    // Vehicle is cruising at the target speed with no acceleration or deceleration command active
                    state maintainingSpeed;

                    // Vehicle has successfully decelerated and is now traveling at the target (lower) speed
                    state deceleratedToTargetSpeed;

                    // Vehicle was commanded to decelerate but failed to reach the target speed within the expected time window (e.g., due to brake degradation)
                    state notDeceleratedToTargetSpeed;
                        then error;

                    // Vehicle has successfully accelerated and is now traveling at the target (higher) speed
                    state acceleratedToTargetSpeed;

                    // Vehicle was commanded to accelerate but failed to reach the target speed within the expected time window (e.g., due to engine power loss, throttle malfunction)
                    state notAcceleratedToTargetSpeed;
                        then error;

                    // An additional state to indicate that the ACC behavior deviates from the expected acceleration or deceleration
                    state error;

                    // The acc_controller and brake works normally
                    «Uncertainty<ocr, epi, subj>, Effect» transition normalDeceleration
                        first maintainingSpeed
                        accept DecelerationSignal
                        do action brake
                        then deceleratedToTargetSpeed {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref constraint brakeOperational ::> acc.brake.brakeOperational;
                            «IndeterminacySpecification» ref constraint controllerOperational ::> acc.acc_controller.controllerOperational;
                            «IndeterminacySpecification» ref constraint radarNotBlocked ::> acc.radar.radarNotBlocked;
                            «IndeterminacySpecification» constraint overallSpecification {
                                brakeOperational and controllerOperational and radarNotBlocked
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    // The radar is blocked or the acc_controller and brake works abnormally
                    «Uncertainty<ocr, epi, subj>» transition abnormalDeceleration
                        first maintainingSpeed
                        accept DecelerationSignal
                        then notDeceleratedToTargetSpeed {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref constraint brakeNotOperational ::> acc.brake.brakeNotOperational;
                            «IndeterminacySpecification» ref constraint controllerNotOperational ::> acc.acc_controller.controllerNotOperational;
                            «IndeterminacySpecification» ref constraint radarBlocked ::> acc.radar.radarBlocked;
                            «IndeterminacySpecification» constraint overallSpecification {
                                brakeNotOperational or controllerNotOperational or radarBlocked
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }

                            metadata collisionRisk : RiskMetadata::Risk {
                                totalRisk {
                                    impact = RiskMetadata::LevelEnum::high;
                                }
                            }
                        }

                    transition finishDeceleration
                        first deceleratedToTargetSpeed
                        then maintainingSpeed;

                    // The acc_controller and engine in powertrain works normally
                    «Uncertainty<ocr, epi, subj>, Effect» transition normalAcceleration
                        first maintainingSpeed
                        accept AccelerationSignal
                        do action throttle
                        then acceleratedToTargetSpeed {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref constraint engineOperational ::> acc.powertrain.engine.engineOperational;
                            «IndeterminacySpecification» ref constraint controllerOperational ::> acc.acc_controller.controllerOperational;
                            «IndeterminacySpecification» ref constraint radarNotBlocked ::> acc.radar.radarNotBlocked;
                            «IndeterminacySpecification» constraint overallSpecification {
                                engineOperational and controllerOperational and radarNotBlocked
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    // The radar is blocked or the acc_controller and brake works abnormally
                    «Uncertainty<ocr, epi, subj>» transition abnormalAcceleration
                        first maintainingSpeed
                        accept AccelerationSignal
                        then notAcceleratedToTargetSpeed {
                            // Specifying reducibility of uncertainty
                            u_reducibility = PartiallyReducible;
                            // Specifying pattern of uncertainty
                            u_pattern = Random;
                            // Specifying indeterminacy source and specification
                            // '::>' represents for references (reference subsetting in sysmlv2)
                            «IndeterminacySpecification» ref constraint engineNotOperational ::> acc.powertrain.engine.engineNotOperational;
                            «IndeterminacySpecification» ref constraint controllerNotOperational ::> acc.acc_controller.controllerNotOperational;
                            «IndeterminacySpecification» ref constraint radarBlocked ::> acc.radar.radarBlocked;
                            «IndeterminacySpecification» constraint overallSpecification {
                                engineNotOperational or controllerNotOperational or radarBlocked
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }

                            metadata collisionRisk : RiskMetadata::Risk {
                                totalRisk {
                                    impact = RiskMetadata::LevelEnum::high;
                                }
                            }
                        }

                    transition finishAcceleration
                        first acceleratedToTargetSpeed
                        then maintainingSpeed;
                }
            }
            transition setACC first idle then ready;

            transition accerror first idle then error;

            transition turnOnACC first ready accept ACCTurnOnSignal then accOn;

            transition turnOffACC first accOn accept ACCTurnOffSignal then idle;
        }
    }

    package SignalDefinition {
        private import BehavioralModel::ACCState::*;
        «UncertaintyTopic» item def PerceptionSignal {
            «Uncertainty» ref ::> accOn.decisionLayerState.startDeciding;
            «Uncertainty» ref ::> accOn.decisionLayerState.failToStartDeciding;
        }
        item def ACCTurnOnSignal;
        item def ACCTurnOffSignal;
        item def ControlSignal;
        «UncertaintyTopic» item def AccelerationSignal :> ControlSignal {
            «Uncertainty» ref ::> accOn.controlLayerState.normalAcceleration;
            «Uncertainty» ref ::> accOn.controlLayerState.abnormalAcceleration;
        }
        «UncertaintyTopic» item def DecelerationSignal :> ControlSignal {
            «Uncertainty» ref ::> accOn.controlLayerState.normalDeceleration;
            «Uncertainty» ref ::> accOn.controlLayerState.abnormalDeceleration;
        }
    }

}