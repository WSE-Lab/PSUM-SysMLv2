package DroneModelLogical{

    library package Drone_SharedAssetsSuperset {


        package Drone {

            private import DroneBattery::**;
            private import DroneEngine::**;
            private import DroneBody::**;
            private import DroneFlightControl::**;  

            abstract part def Drone {

                // Attributes
                attribute massActual : ISQ::MassValue;


                // Spatial extent
                item :>> shape = body.shape;
                item boundingBox :> boundingShapes = body.boundingBox;

                // Timeslices            
                timeslice parking {
                    snapshot startCharging {
                        // model some start charging conditions
                    }
                    then snapshot stopCharging;
                }
                then timeslice flying {
                    :>> battery[1];
                }

                // States
                «BeliefStatement» state droneStates {
                    entry; then off;

                    state off;
                    «Uncertainty<ocr, epi, subj>» accept SigSwitchOn then standBy {
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }
                    «Uncertainty<ocr, epi, subj>» accept SigSwitchOn then off {
                        // Fail to switch on
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitNotOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }

                    state standBy;
                    «Uncertainty<ocr, epi, subj>» accept SigSwitchOff then off {
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }
                    «Uncertainty<ocr, epi, subj>» accept SigSwitchOff then standBy {
                        // Fail to switch off
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitNotOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }

                    «Uncertainty<ocr, epi, subj>» transition standBy_charging
                        first standBy
                        accept SigStartCharging
                        then charging {
                            «IndeterminacySpecification» ref constraint chargerOperational ::> charger.chargerOperational;
                            «IndeterminacySpecification» ref constraint chargingInterfaceOperational ::> battery.chargingInterface.chargingInterfaceOperational;
                            «IndeterminacySpecification» ref constraint firmwareFunctioning ::> battery.firmware.firmwareFunctioning;
                            «IndeterminacySpecification» constraint overallSpecification {
                                chargerOperational and chargingInterfaceOperational and firmwareFunctioning
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    «Uncertainty<ocr, epi, subj>» transition failToStartCharging
                        first standBy
                        accept SigStartCharging
                        then standBy {
                            «IndeterminacySpecification» ref constraint chargerNotOperational ::> charger.chargerNotOperational;
                            «IndeterminacySpecification» ref constraint chargingInterfaceNotOperational ::> battery.chargingInterface.chargingInterfaceNotOperational;
                            «IndeterminacySpecification» ref constraint firmwareNotFunctioning ::> battery.firmware.firmwareNotFunctioning;
                            «IndeterminacySpecification» constraint overallSpecification {
                                chargerNotOperational or chargingInterfaceNotOperational or firmwareNotFunctioning
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    «Uncertainty<ocr, epi, subj>» transition standBy_ready 
                        first standBy
                        accept SigActivate
                        then ready {
                            «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitOperational;

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    «Uncertainty<ocr, epi, subj>» transition failToActivate
                        first standBy
                        accept SigActivate
                        then standBy {
                            «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitNotOperational;

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    state charging;

                    «Uncertainty<ocr, epi, subj>» transition charging_standBy
                        first charging
                        accept SigStopCharging
                        then standBy {
                            «IndeterminacySpecification» ref constraint chargingInterfaceOperational ::> battery.chargingInterface.chargingInterfaceOperational;
                            «IndeterminacySpecification» ref constraint firmwareFunctioning ::> battery.firmware.firmwareFunctioning;
                            «IndeterminacySpecification» constraint overallSpecification {
                                chargingInterfaceOperational and firmwareFunctioning
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    «Uncertainty<ocr, epi, subj>» transition failToStopCharging
                        first charging
                        accept SigStopCharging
                        then charging {
                            «IndeterminacySpecification» ref constraint chargingInterfaceNotOperational ::> battery.chargingInterface.chargingInterfaceNotOperational;
                            «IndeterminacySpecification» ref constraint firmwareNotFunctioning ::> battery.firmware.firmwareNotFunctioning;
                            «IndeterminacySpecification» constraint overallSpecification {
                                chargingInterfaceNotOperational or firmwareNotFunctioning
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }
                            
                    state ready;
                    «Uncertainty<ocr, epi, subj>» accept SigDeactivate then standBy {
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }
                    «Uncertainty<ocr, epi, subj>» accept SigDeactivate then ready {
                        // Fail to deactivate
                        «IndeterminacySpecification» ref ::> droneControlUnit.droneControlUnitNotOperational;

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }

                    }

                    «Uncertainty<ocr, epi, subj>» transition ready_flying
                        first ready
                        accept SigStartFlying 
                        then flying {
                            «IndeterminacySpecification» ref constraint controlUnitOperational ::> droneControlUnit.droneControlUnitOperational;
                            «IndeterminacySpecification» ref constraint flightControlOperational ::> flightControl.flightControlOperational;
                            «IndeterminacySpecification» constraint overallSpecification {
                                controlUnitOperational and flightControlOperational
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    «Uncertainty<ocr, epi, subj>» transition failToStartFlying
                        first ready
                        accept SigStartFlying 
                        then ready {
                            «IndeterminacySpecification» ref constraint controlUnitNotOperational ::> droneControlUnit.droneControlUnitNotOperational;
                            «IndeterminacySpecification» ref constraint flightControlNotOperational ::> flightControl.flightControlNotOperational;
                            «IndeterminacySpecification» constraint overallSpecification {
                                controlUnitNotOperational or flightControlNotOperational
                            }

                            // To measure the probability of the uncertainty
                            measurement {
                                m_degree = "TODO";
                            }
                        }

                    state flying;    
                    «Uncertainty<ocr, epi, subj>» accept SigStopFlying then ready {
                        «IndeterminacySpecification» ref constraint controlUnitOperational ::> droneControlUnit.droneControlUnitOperational;
                        «IndeterminacySpecification» ref constraint flightControlOperational ::> flightControl.flightControlOperational;
                        «IndeterminacySpecification» constraint overallSpecification {
                            controlUnitOperational and flightControlOperational
                        }

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }
                    «Uncertainty<ocr, epi, subj>» accept SigStopFlying then flying {
                        // Fail to stop flying
                        «IndeterminacySpecification» ref constraint controlUnitNotOperational ::> droneControlUnit.droneControlUnitNotOperational;
                        «IndeterminacySpecification» ref constraint flightControlNotOperational ::> flightControl.flightControlNotOperational;
                        «IndeterminacySpecification» constraint overallSpecification {
                            controlUnitNotOperational or flightControlNotOperational
                        }

                        metadata lossOfControlRisk : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::medium;
                            }
                        }

                        metadata collisionRisk : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::high;
                            }
                        }

                        // To measure the probability of the uncertainty
                        measurement {
                            m_degree = "TODO";
                        }
                    }
                }

                // Signals
                attribute def SigStartCharging;
                attribute def SigStopCharging;
                attribute def SigSwitchOn;
                attribute def SigSwitchOff;
                attribute def SigActivate;
                attribute def SigDeactivate;
                attribute def SigStartFlying;
                attribute def SigStopFlying;

                // Power
                part battery : DroneBatteryVariation;
                message notifyBatteryLow of SigBatteryLow from battery.batteryManagementSystem to flightControl;

                «IndeterminacySource<nd>» part charger {
                    // To indicate the operational status of charger
                    attribute isOperational : ScalarValues::Boolean;

                    «IndeterminacySpecification» constraint chargerOperational {
                        isOperational == true
                    }

                    «IndeterminacySpecification» constraint chargerNotOperational {
                        isOperational == false
                    }
                }
                part powerManagementModule {
                    port ctrlPort {
                        out attribute status : BatteryCapacityKind;
                    }

                    perform action checkStatus {
                        out attribute status : BatteryCapacityKind;

                        first start;
                        then action getBatteryStatus;
                        then action analyseStatus;
                        then done;
                    } 
                }

                // Engines
                variation attribute numberOfEnginesVariation : ScalarValues::Integer {
                    variant attribute fourEngines = 4;
                    variant attribute sixEngines = 6;
                }
                part engines[numberOfEnginesVariation] : DroneEngine_Parts::DroneEngine;

                // Body
                part body : DroneBodyVariation;

                // Flight Control System
                «IndeterminacySource<nd>» part flightControl : FlightControlVariation {
                    // To indicate the operational status of flightControlSystem
                    attribute isOperational : ScalarValues::Boolean;

                    «IndeterminacySpecification» constraint flightControlOperational {
                        isOperational == true
                    }

                    «IndeterminacySpecification» constraint flightControlNotOperational {
                        isOperational == false
                    }
                }

                «IndeterminacySource<nd>» part droneControlUnit {
                    // To indicate the operational status of droneControlUnit
                    attribute isOperational : ScalarValues::Boolean;
                    port powerCtrlPort {
                        in attribute batteryStatus : BatteryCapacityKind;
                    }

                    «IndeterminacySpecification» constraint droneControlUnitOperational {
                        isOperational == true
                    }

                    «IndeterminacySpecification» constraint droneControlUnitNotOperational {
                        isOperational == false
                    }

                }

                part safetyModule[*];
                part autonomousFlightModules[*];

                part gpsModule;
                part inertialMeasurementUnit;
                part barometer;         

                // Communication System
                part radioTransmitter;
                part radioReceiver;
                part antenna;

                // Sensors
                part camera;
                part obstacleAvoidanceSensor;

                // Connections
                connect droneControlUnit.powerCtrlPort to powerManagementModule.ctrlPort;
                connect battery to powerManagementModule;
            }


        }

        //
        // Drone Engine Shared Assets
        //
        package DroneEngine {

            package DroneEngine_StakeholderRequirements {

                private import DroneEngine_Parts::*;

                variation requirement droneEngineStakeholderRequirements {
                    variant requirement droneEngineStandardStakeholderRequirements {

                        subject engine : DroneEngine;

                        requirement power : Power;
                        requirement efficiency : Efficiency;
                        requirement durability : Durability;
                        requirement reliability : Reliability;
                        requirement lightweight : Lightweight;
                        requirement control : Control;
                        requirement compatibility : Compatibility;
                        requirement safety : Safety;
                        requirement costEffective : CostEffective;
                    }
                    variant requirement droneEngineLowNoiseStakeholderRequirements :> droneEngineStandardStakeholderRequirements {
                        requirement lowNoise : LowNoise;
                    }
                }

                requirement def <'DE-REQ-1'> Power {
                    doc /*
                        * The engine shall provide enough power to lift the drone off the ground and keep it in the air. 
                        * The power output shall be appropriate for the size and weight of the drone.
                        */
                }
                requirement def <'DE-REQ-2'> Efficiency {
                    doc /*
                        * The engine shall be efficient, allowing the drone to fly for an extended period on a single charge. 
                        * The engine shall be designed to minimize energy loss through friction and heat.
                        */
                }
                requirement def <'DE-REQ-3'> Durability {
                    doc /*
                        * The engine shall be able to withstand the stress of continuous use and exposure to the elements. 
                        * It shall be able to operate in a wide range of temperatures and weather conditions.
                        */
                }
                requirement def <'DE-REQ-4'> Reliability {
                    doc /*
                        * The engine shall be reliable, with minimal downtime or maintenance requirements. 
                        * It shall be designed with high-quality components and undergo rigorous testing before deployment.
                        */
                }
                requirement def <'DE-REQ-5'> LowNoise {
                    doc /*
                        * The engine shall produce minimal noise to avoid disturbing the environment or attracting unwanted attention.
                        */
                }
                requirement def <'DE-REQ-6'> Lightweight {
                    doc /*
                        * The engine shall be lightweight, allowing for maximum payload capacity and longer flight times.
                        */
                }
                requirement def <'DE-REQ-7'> Control {
                    doc /*
                        * The engine shall be easy to control, allowing for precise maneuverability and responsiveness to commands.
                        */
                }
                requirement def <'DE-REQ-8'> Compatibility {
                    doc /*
                        * The engine shall be compatible with the drone's power supply and electronic components.
                        */
                }
                requirement def <'DE-REQ-9'> Safety {
                    doc /*
                        * The engine should be designed with safety in mind, minimizing the risk of injury or damage in case of malfunction. 
                        * It should have fail-safe mechanisms to prevent accidents and minimize damage in case of emergency.
                        */
                }
                requirement def <'DE-REQ-10'> CostEffective {
                    doc /*
                        * The engine shall be cost-effective, balancing performance and quality with affordability. 
                        * It shall provide value for money, with a low cost of ownership and maintenance.            
                        */
                }            
            }

            package DroneEngine_Parts {
                part def DroneEngine {
                    enum propKind : PropKind;

                    enum def PropKind {
                        enum clockwise;
                        enum counterclockwise;
                    }            
                }
            }                        
        }

        //
        // Drone Body Shared Assets
        //
        package DroneBody {

            package DroneBody_Parts {

                private import DroneBody_Domain::*;

                variation part def DroneBodyVariation :> DroneBody {
                    variant part droneBody4Engines : DroneBody {
                        // to be done: redefines size
                        :>> rotors[4];
                        :>> arms[4];
                    }
                    variant part droneBody6Engines : DroneBody {
                        // to be done: redefines size
                        :>> rotors[6];
                        :>> arms[6];
                    }
                }            

                abstract part def DroneBody {
                    // Spatial extent
                    item :>> shape : ShapeItems::Cylinder {
                        :>> height = 20 [SI::cm];
                        :>> base.shape : ShapeItems::Circle {
                            :>> radius = 60 [SI::cm];
                        }
                    }
                    item boundingBox : ShapeItems::Box [1] :> boundingShapes {
                        :>> length = 120 [SI::cm];
                        :>> width  = 120 [SI::cm];
                        :>> height = 20 [SI::cm];
                    }            

                    // BodyColorKind is an enumeration definition which is already a kind of variation
                    attribute bodyColor : BodyColorKind {
                        enum redColor redefines red {
                        }
                        enum whiteColor redefines white {
                        }
                        enum blueColor redefines blue {
                        }
                        enum blackColor redefines black {
                        }
                    }    

                    part rotors[*];
                    part arms[*];
                    part landingGear;
                }
            }

            package DroneBody_Domain {            
                enum def BodyColorKind {
                    enum red;
                    enum white;
                    enum blue;
                    enum black;
                }
            }
        }


        //
        // Drone Flight Control Software Shared Assets
        //
        package DroneFlightControl {

            variation part def FlightControlVariation :> DroneFlightControl {
                variant part droneFlightControl4Engines : DroneFlightControl {
                }
                variant part droneFlightControl6Engines : DroneFlightControl {
                }
            }
            abstract part def DroneFlightControl;
        }

        //
        // Drone Battery Shared Assets
        //     
        package DroneBattery {

            package DroneBattery_Domain {
                attribute def SigBatteryLow {
                    attribute capacity : ISQElectromagnetism::ElectricChargeValue;
                }
            }

            package DroneBattery_Parts {

                variation part def DroneBatteryVariation :> DroneBattery {
                    variant part standardBattery : StandardDroneBattery {
                    }
                    variant part longDistanceBattery : LongDistanceDroneBattery {
                    }
                }            

                abstract part def DroneBattery {
                    // Attributes
                    attribute weight : ISQBase::MassValue; 
                    attribute maxCapacity : ISQElectromagnetism::ElectricChargeValue;
                    enum currentCapacityLevel : BatteryCapacityKind;
                    enum def BatteryCapacityKind :> ScalarValues::Integer {
                        enum full = 100;
                        enum medium = 50;
                        enum low = 30;
                        enum critical = 15;
                    }

                    // Parts
                    part batteryCells {
                        doc /* The battery cells are the main components of the drone battery 
                             * that store the electrical energy. These cells are usually Lithium Polymer (LiPo) 
                             * or Lithium-Ion (Li-Ion) cells.
                            */
                    }
                    part batteryManagementSystem {
                        doc /* The Battery Management System (BMS) is a control unit that manages the charging and 
                             * discharging of the battery cells. It ensures that the cells are charged and discharged 
                             * correctly and safely.
                             */
                    }
                    «IndeterminacySource<nd>» part protectionCircuit {
                        doc /* The protection circuit is a safety mechanism that protects the battery from overcharging, 
                             * over-discharging, and short circuits.
                            */
                        // To indicate the operational status of protectionCircuit
                        attribute isOperational : ScalarValues::Boolean;

                        «IndeterminacySpecification» constraint protectionCircuitOperational {
                            isOperational == true
                        }

                        «IndeterminacySpecification» constraint protectionCircuitNotOperational {
                            isOperational == false
                        }


                    }
                    «IndeterminacySource<nd>» part powerConnector {
                        doc /* The power connector is the interface that connects the battery to the drone's power system. 
                            * It delivers the electrical energy from the battery to the drone.
                            */
                        // To indicate the operational status of powerConnector
                        attribute isOperational : ScalarValues::Boolean;

                        «IndeterminacySpecification» constraint powerConnectorOperational {
                            isOperational == true
                        }

                        «IndeterminacySpecification» constraint powerConnectorNotOperational {
                            isOperational == false
                        }
                    }
                    «IndeterminacySource<nd>» part chargingInterface {
                        doc /* The charging interface is the interface that connects the battery to the charger. 
                             * It allows the battery to be charged safely and efficiently.
                            */
                        // To indicate the operational status of chargingInterface
                        attribute isOperational : ScalarValues::Boolean;

                        «IndeterminacySpecification» constraint chargingInterfaceOperational {
                            isOperational == true
                        }

                        «IndeterminacySpecification» constraint chargingInterfaceNotOperational {
                            isOperational == false
                        }
                    }

                    part batteryIndicator {
                        doc /* The battery indicator is a component that displays the remaining battery charge. 
                             * It allows the pilot to monitor the battery level and plan flight time accordingly.
                            */
                    }
                    «IndeterminacySource<nd>» part communicationInterface {
                        doc /* The communication interface is a component that allows the battery to communicate 
                             * with the drone's flight controller. It provides important battery information such 
                             * as voltage, current, and temperature to the flight controller.
                            */
                        // To indicate the operational status of communicationInterface
                        attribute isOperational : ScalarValues::Boolean;

                        «IndeterminacySpecification» constraint communicationInterfaceOperational {
                            isOperational == true
                        }

                        «IndeterminacySpecification» constraint communicationInterfaceNotOperational {
                            isOperational == false
                        }
                        
                    }
                    «IndeterminacySource<nd>» part firmware {
                        doc /* The firmware is the software that runs on the battery management system. 
                             * It controls the charging and discharging of the battery cells and ensures 
                             * that the battery operates safely and efficiently.
                            */

                        // To indicate the functioning status of chargingInterface
                        attribute isFunctioning : ScalarValues::Boolean;

                        «IndeterminacySpecification» constraint firmwareFunctioning {
                            isFunctioning == true
                        }

                        «IndeterminacySpecification» constraint firmwareNotFunctioning {
                            isFunctioning == false
                        }
                    }
                }

                part def StandardDroneBattery :> DroneBattery {
                    :>> weight = 275[SI::g];
                    :>> maxCapacity = 13680[SI::'C'];
                }
                part def LongDistanceDroneBattery :> DroneBattery {
                    :>> weight = 315[SI::g];
                    :>> maxCapacity = 18000[SI::'C'];
                }
            }

        }    
    }
}

