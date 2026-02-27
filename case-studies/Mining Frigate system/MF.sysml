package Domain {
	
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalUseCaseActions::*;
	private import MiningFrigate::*;
	private import CauseAndEffect::*;
    private import CausationConnections::*;
	

    // Root object for the domain
    part def Domain {
        part pilotPod : PilotPod;
        part asteroidBelt : AsteroidBelt;
        part asteroid : Asteroid [1..*];
        part hostileShip : HostileShip [0..*];
        part station : Station [0..*];
        part miningCorporation: MiningCorporation;
        part drone : Drone[1..*];
    }
    
    part def Spaceship {
    	#mop cargoCapacity : Real;       // Maximum ore cargo capacity (m³)
        #mop survivalProbability : Real; // Probability of surviving an operation (%)
    	attribute mass : Real;
    	attribute status : String;
    	attribute warpSpeed : Real; // AU/s, the warp speed of the frigate (STRQ06)
        attribute warpBubbleEnd : Boolean;
        attribute alignTime : Real; // seconds, the time required to align for warp (STRQ06)
        attribute lockedTargets : Integer; // Number, the maximum number of locked asteroid targets (STRQ07)
        attribute dockingTime : Real; // seconds, the time required to dock and offload ore (STRQ08)
        attribute shieldStrength : Real ; //Strength of the core shield (STRQ03)
    }

    // Definitions of domain objects
  
    part def MiningCorporation {
         #moe minimumProfit : Real {
            doc /* Definition: Total ISK/hour earned after deducting operational costs 
             * (e.g., ship losses, resupply, and maintenance). 
             * Relevance: Profitability is the ultimate measure of success for the corporation. 
             * Optimization: Operate in areas with the best risk-reward balance 
             * (e.g., High Sec for safety, Wormholes or Null Sec for high-value ores). 
             * Avoid overfitting ships in areas with high loss probability 
             * (e.g., Ventures in Wormholes or Low Sec).
             */
        }          // ISK/hour

        #moe fleetUtilization : Real {
            doc /* Definition: The percentage of operational mining frigates deployed per cycle.
             * Relevance: Higher fleet utilization ensures better efficiency and revenue. 
             * Optimization: Maintain an 80%+ utilization rate by minimizing downtime 
             * (e.g., ensure refitting cycles do not overlap with peak mining hours).
             */
        }          // %

        #moe oreExtractionEfficiency : Real {
            doc /* Definition: The amount of ore extracted per operational cycle (m³/cycle). 
             * Relevance: High extraction rates correlate with overall profitability. 
             * Optimization: Use appropriate mining lasers, max fleet bonuses, and optimize asteroid selection.
             */
        }          // m³/cycle

        #moe oreDeliveryEfficiency : Real {
            doc /* Definition: The average delivery time per batch of ore transported (seconds). 
             * Relevance: Faster deliveries reduce market price exposure and downtime. 
             * Optimization: Optimize mining locations closer to station hubs or Rorquals for compression.
             */
        }          // seconds

        #moe storageCapacityUtilization : Real {
            doc /* Definition: The percentage of ore storage capacity currently utilized.
             * Relevance: Ensures effective planning of mining operations to avoid overloading or idling. 
             * Optimization: Expand storage or increase delivery frequency based on utilization rates.
             */
        }          // %

        #moe fleetSizeEffectiveness : Real {
            doc /* Definition: Measures how effectively fleet size contributes to mining efficiency.
             * Relevance: Avoids over-scaling, which could increase operational costs.
             * Optimization: Balance fleet size with profit margins, avoiding unnecessary ship deployment.
             */
        }          // Fleet utilization metric

        #moe securityCoverageEffectiveness : Real {
            doc /* Definition: The percentage of mining operations that have security escort coverage.
             * Relevance: Essential for safe mining in Low Sec, Null Sec, and Wormholes. 
             * Optimization: Maintain at least 30% security coverage in high-risk areas.
             */
        }          // %

        #moe threatResponseEffectiveness : Real {
            doc /* Definition: The average response time to threats during mining operations (seconds).
             * Relevance: Faster response times improve fleet survivability. 
             * Optimization: Deploy scouts and maintain emergency warp-out procedures.
             */
        }          // seconds

        #moe operationalUptime : Real {
            doc /* Definition: The percentage of time the corporation is actively mining and generating revenue.
             * Relevance: Maximizing uptime directly increases profitability.
             * Optimization: Reduce transition times between mining and logistics.
             */
        }          // %

        #moe deploymentEfficiency : Real {
            doc /* Definition: The percentage of planned mining deployments that are executed successfully.
             * Relevance: Higher efficiency reduces logistical delays and improves ROI.
             * Optimization: Standardize deployment protocols and improve scheduling coordination.
             */
        }          // %

        #moe costEfficiency : Real {
            doc /* Definition: The ratio of ISK spent per ISK earned in mining operations.
             * Relevance: Determines operational sustainability and long-term growth. 
             * Optimization: Reduce unnecessary ship/module expenditures while maximizing income sources.
             */
        }          // ISK spent per ISK earned

        #moe marketAdaptability : Real {
            doc /* Definition: The corporation's ability to adapt mining operations to fluctuating ore market prices.
             * Relevance: Avoids mining low-value ores and improves revenue optimization.
             * Optimization: Adjust operations dynamically based on real-time market data.
             */
        }          // %
        
        //exhibits a predefined state
        part miningFrigate : MiningFrigate [1..*] {
        	exhibit miningFrigatesStates {
    			in miningFrigates = miningFrigate; 
    		}
    		// Cause and Effect Occurrences
	        event occurrence MiningRateIncreases;
	        event occurrence CargoCapacityIncreases;
	        event occurrence ShieldStrengthIncreases;
	        event occurrence ThreatDetectionImproves;
	        event occurrence DroneOperationsImprove;
	        event occurrence WarpSpeedIncreases;
	        event occurrence FleetCoordinationImproves;
	
	        event occurrence OreYieldIncreases;
	        event occurrence DowntimeReduces;
	        event occurrence SurvivabilityEnhances;
	        event occurrence ThreatResponseImproves;
	        event occurrence OperationalEfficiencyIncreases;
	        event occurrence OreExtractionEfficiencyIncreases;
	        event occurrence ProfitabilityMaximizes;
        }
        part rorqual : Rorqual [1..*];
        ref part pilotPod : PilotPod [1..*] ;
        part fleet : Fleet [1..*];
        
        //interactions at the enterprise level
        «BeliefStatement» occurrence def MiningAsteroid {
        	doc /* Interaction from Main Use Case: Mining Asteroid */
     	    	
        	«Uncertainty<ocr, epi, subj>» message targetSignature of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message destinationReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message miningCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message miningReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        }
        
        «BeliefStatement» occurrence def PlotCourseAndNavigate {
        	doc /* Interaction from Main Use Case definition : Plot Course and Navigate */
        	
        	«Uncertainty<ocr, epi, subj>» message undockCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message targetSignature of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message destinationReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message warpCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        	then «Uncertainty<ocr, epi, subj>» message warpReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
        }
        
	    «BeliefStatement» occurrence def DeployDrones {
	        doc /* Interaction from Main Use Case: Deploy Drones */
	
	        «Uncertainty<ocr, epi, subj>» message droneSelectionCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message droneSelectionReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message droneDeploymentCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message droneStatusReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message engageDefenseCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message defenseStatusReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	    }
	
	    «BeliefStatement» occurrence def OffloadOreAndResupply {
	        doc /* Interaction from Main Use Case: Offload Ore and Resupply */
	
	        «Uncertainty<ocr, epi, subj>» message dockCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message dockingReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message unloadCommand of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message storageReport of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message warehouseStatusCommand of StationCommand from pilotPod.controlPort to miningFrigate.controlPort {
                //Station comms are relayerd through the ship
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            } 
        	then «Uncertainty<ocr, epi, subj>» message warehouseReport of StationReport from miningFrigate.controlPort to pilotPod.controlPort {
                //Station comms are relayerd through the ship
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            } 
	        then «Uncertainty<ocr, epi, subj>» message resupplyRequest of ShipCommand from pilotPod.controlPort to miningFrigate.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	        then «Uncertainty<ocr, epi, subj>» message resupplyConfirmation of ShipReport from miningFrigate.controlPort to pilotPod.controlPort {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint pilotPodControlportOperational ::> pilotPod.controlPort.Operational;
                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigate.controlPort.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    pilotPodControlportOperational and miningFrigateControlportOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }
	    }      
    }
    // Basic non-deterministic occurrence component of the domain
    «IndeterminacySource<nd>» occurrence def NonDeterministicComponent {
        attribute operationalStatus : Boolean;

        «IndeterminacySpecification» constraint Operational {
            operationalStatus
        }

        «IndeterminacySpecification» constraint NotOperational {
            not operationalStatus
        }
    }
    
    // parts of the domain
    part def PilotPod {
        attribute experienceLevel : String;
        attribute controlEfficiency : Real;         // Efficiency of command execution (%)
        #mop situationalAwareness : Real;      // Ability to detect threats and manage operations (%)
        attribute fleetSize: Real ;
        part controlConsole: ControlConsole;
        part lifeSupportSystem: LifeSupportSystem;
        port controlPort: PodPort;
    }

    part def ControlConsole {
        attribute interfaceType: String;
    }
    
    part def Fleet {
        ref part fleetCommander : PilotPod [1..*];
    }
    
    part def LifeSupportSystem {
        attribute oxygenLevel: Real;
        attribute temperatureControl: Boolean;
    }
    
    part def Rorqual :> Spaceship {
        #mop oreStorageCapacity : Real; //Rorquals can tractor and store storage containers
        part oreCompressionUnit : OreCompressionUnit; //Module used to compress Ores
    }
    
    part def OreCompressionUnit {
    	attribute compressionFactor : Real;      // Compression factor
    }
    
    
    part def AsteroidBelt {
    	#mop resourceAvailability : Real;      // Total available ore in the belt (m³)
        part asteroids : Asteroid [1..*];
    }

    part def Asteroid {
    	#mop oreContent : Real;                // Quantity of ore available (m³)
        #mop depletionRate : Real;             // Rate at which ore is extracted (m³/hour)
        port asteroidOrePort : AsteroidOrePort;
    }

    part def HostileShip {
    	#mop attackProbability : Real;         // Probability of engaging the mining frigate (%)
        #mop weaponStrength : Real;            // Damage potential of weapons (DPS)
        attribute threatLevel : String;
        attribute weaponType : String;
        port weaponPort : ThreatPort;
    }

    part def Station {
        attribute dockingCapacity : Integer;
        attribute location : String;
        port dockingPort: ~DockingPort;
    }
    
    part def Drone {
        attribute type : String;
        attribute size : String;
        port droneControlPort: DroneControllerPort;
    }
	
	// Port definitions
	port def PodPort :> NonDeterministicComponent {
		in item shipReport : ShipReport;
		out item command : ShipCommand;
	}
	
	port def DockingPort :> NonDeterministicComponent
     {
		in item charge : Power;
		out item cargo : CargoContainer;
	}
	
	port def AsteroidOrePort :> NonDeterministicComponent {
		out item ore : Ore;
	}

	port def ThreatPort :> NonDeterministicComponent {
		out item firePower : FirePower;
	}
	
	port def DroneControllerPort :> NonDeterministicComponent {
		in item droneCommand : DroneCommand;
		out item droneReport : DroneReport;
	}	

	// Interface definition
    interface def CommandIF {
        end controlSend : PodPort;
        end controlReceive : ~PodPort;
        //flows are defined within the interface
        flow of ShipCommand from controlSend.command to controlReceive.command;
        flow of ShipReport from controlReceive.shipReport to controlSend.shipReport;
    }
    
	interface def PowerDockIF {
        end shipDockingPort : DockingPort;
        end stationDockingPort : ~DockingPort;
        flow of Power from stationDockingPort.charge to shipDockingPort.charge;
        flow of CargoContainer from shipDockingPort.cargo to stationDockingPort.cargo;      
    }
	interface def AsteroidOreIF {
        end shipOrePort : ~AsteroidOrePort;
        end asteroidOrePort : AsteroidOrePort;
        flow of Ore from asteroidOrePort.ore to shipOrePort.ore;     
    }    
	interface def ThreatIF {
        end threadIncomingPort : ~ThreatPort;
        end threatOutgoingPort : ThreatPort;
        flow of FirePower from threatOutgoingPort.firePower to threadIncomingPort.firePower;     
    }
    interface def DroneIF {
        end droneControllerPort : ~DroneControllerPort;
        end droneControllPort : DroneControllerPort;
        flow of DroneCommand from droneControllerPort.droneCommand to droneControllPort.droneCommand;
        flow of DroneReport from droneControllPort.droneReport to droneControllerPort.droneReport;     
    }     
    
    
    // Items that Flow Between Domain Objects
    item def ShipCommand {
        attribute type: String;
    }
    
    item def StationCommand {
        attribute type: String;
    }
    
    item def DroneCommand :> ShipCommand {
        attribute droneID: String;
    }    

    item def Ore {
        attribute purity : Real;
        attribute quantity : Real;
    }

    item def FirePower {
        attribute type : String;
        attribute strenght : String;
    }

    item def CargoContainer {
        attribute type : String;
        attribute weight : Real;
    }

    item def Power {
        attribute type : String;
        attribute quantity : Real;
    }
    
    item def ShipReport{
    	attribute type: String;
    }
    
    item def StationReport{
    	attribute type: String;
    }
    
    item def DroneReport :> ShipReport {
    	attribute DroneID: String;
    }
    
    item def Course {
        attribute waypoints: String;
        attribute distance: Real;
    }

    item def ScanSignature {
        attribute type: String;
        attribute priority: String;
    }   
}

package MiningFrigate {
 
	private import ScalarValues::*;
	private import ISQ::*;
	private import SI::*;
	private import ParametersOfInterestMetadata::*;
	private import OperationalUseCaseActions::*;
	 
	part def MiningFrigate :> Domain::Spaceship {

        attribute miningRate : Real;          // Volume of ore mined per second (m³/s)
        attribute droneCapacity : Integer; // Number, the maximum number of drones deployable (STRQ04)
        attribute threatDetectionRange : Real; // AU, the range for detecting threats (STRQ0)
        attribute fleetSize : Integer; // Number, the maximum size of a mining fleet the frigate can coordinate (STRQ09)
        
        // Consolidated Non-Configurable System*
        part coreSystem: CoreSystem; 
        
        //parts declaration
        // Configurable mining module
        part miningLaser: MiningLaser [1..2]; 
        // Configurable shield generator
        part shieldModule: ShieldModule;
        // Configurable propulsion system
        part propulsionModule: PropulsionModule;
        // Configurable sensor array
        part sensorModule: SensorModule;
        part oreHoldExpander: OreHoldExpander [0..2]; // Optional cargo expander module
        part capacitorBooster: CapacitorBooster [0..1]; // Configurable capacitor booster
        // Optional defense modules
        part defenseTurret: DefenseTurret [0..*];
        // Configurable drone bay
        part droneBay : DroneBay;
        // Configurable navigation module  
        part navigationModule : NavigationModule;

        ref part cargo : Domain::CargoContainer [0..*];
        ref part charge : Domain::Power;
        ref part drone : Domain::Drone [0..5];
        
        port controlPort : ~Domain::PodPort;
        port dockingPort : ~Domain::DockingPort;
        port threatPort : ~Domain::ThreatPort;
        port asteroidOrePort : ~Domain::AsteroidOrePort;
        port droneControlPort: ~Domain::DroneControllerPort;
        
        //actions declaration
	    action activateMiningLaser : ActivateMiningLaser {
	    }
           	
	}
	// State Definition for the Mining Frigate
    «BeliefStatement» state miningFrigatesStates {
    	in miningFrigates : MiningFrigate;
        
    	entry;
    	then Docked; //boarding a ship is not modeled.

	 	state Packaged {
	 		doc /* The mining frigate is packaged inside a station and can be cargoed. */
	 	}	 	
	 	state Parked {
	 		doc /* The mining frigate is parked inside a station, but not boarded by a pod. */
	 	}	 	
	 	state Docked {
	    	doc /* The mining frigate is inside a station, available for refitting, resupply, or cargo transfer. */
	    }
	    state InGrid {
	        doc /* The mining frigate is in open space, near asteroids, stations, or other celestial objects. */
	    }
	 	state OnWarp {
	        doc /* The mining frigate is in warp, traveling between locations. */
	    }
 		
 		«Uncertainty<ocr, epi, subj>» transition docked_to_inGrid
	    	first Docked
	    	accept pilotPodUndockCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	do action undockFromStation : UndockFromStation {in undockCommand = pilotPodUndockCommand;}
	    	then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failed_docked_to_inGrid
	    	first Docked
	    	accept pilotPodUndockCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata undockCommandFailureRisk : RiskMetadata::Risk {
                    /**
                    * The mining frigate fails to undock due to a non-operational control port, 
                    * causing the undock command from the pilot pod to be ignored or rejected. 
                    * This may lead to mission delay, pilot confusion, 
                    * or repeated command attempts that could trigger unintended system behavior.
                    */

                    totalRisk {
                        impact = RiskMetadata::LevelEnum::medium;
                    }
                }
            }
	                
	    «Uncertainty<ocr, epi, subj>» transition inGrid_to_docked
	    	first InGrid
	    	accept pilotPodDockCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	do action dockToStation : DockToStation {in dockCommand = pilotPodDockCommand;}
	    	then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failed_inGrid_to_docked
	    	first InGrid
	    	accept pilotPodDockCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata dockCommandFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to initiate docking due to a non-operational control port, 
                     * causing the pilot pod's dock command to be ignored. This may result in prolonged 
                     * exposure in open space, missed resupply opportunities, or unsafe proximity to 
                     * station structures.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }
	        
		«Uncertainty<ocr, epi, subj>» transition inGrid_to_onWarp
	    	first InGrid
	    	accept warpCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	do action executeWarpDrive : ExecuteWarpDrive
	    	then OnWarp {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failed_inGrid_to_onWarp
	    	first InGrid
	    	accept warpCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata warpActivationFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to engage warp drive due to a non-operational control port, 
                     * causing the pilot's warp command to be ignored or unacknowledged. This may lead to 
                     * mission delay, extended vulnerability in hazardous regions (e.g., asteroid fields), 
                     * or inability to evade threats or reach critical destinations in time.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }
	
	    transition onWarp_to_inGrid
	    	first OnWarp
	    	accept when miningFrigates.warpBubbleEnd
	    	then InGrid;     	
   		
   		//Internal transitions
   	    «Uncertainty<ocr, epi, subj>» transition unloadCargo 
	    	first Docked
	    	accept unloadCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	do action transferOre : TransferOre
	    	then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToUnloadCargo 
	    	first Docked
	    	accept unloadCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata cargoUnloadingFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to unload its cargo due to a non-operational control port, 
                     * causing the unload command from the pilot or station system to be ignored. This may 
                     * result in delayed cargo turnover, blocked docking bay usage, reduced mining efficiency, 
                     * or inability to accept new missions until manual intervention occurs.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::medium;
                    }
                }
            }
	    
	    «Uncertainty<ocr, epi, subj>» transition cycleMining 
	    	first InGrid
	    	accept miningCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	do action activateMiningLaser : ActivateMiningLaser
	    	then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint laserOperational ::> miningFrigates.miningLaser.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and laserOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToCycleMining 
	    	first InGrid
	    	accept miningCommand : Domain::ShipCommand via miningFrigates.controlPort
	    	then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint laserNotOperational ::> miningFrigates.miningLaser.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or laserNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata miningCycleFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to initiate or complete a mining cycle due to a non-operational 
                     * control port or failed mining lasers, causing the mining command from the pilot to be ignored. This results in 
                     * lost operational time, reduced resource yield, and potential mission inefficiency, 
                     * especially in time-sensitive or competitive mining zones.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::medium;
                    }
                }
            }
	    	
		«Uncertainty<ocr, epi, subj>» transition scanThreats
            first InGrid
            accept scanCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action scanForThreats : ScanForThreats
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint sensorOperational ::> miningFrigates.sensorModule.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and sensorOperational
                }

                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToScanThreats
            first InGrid
            accept scanCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint sensorNotOperational ::> miningFrigates.sensorModule.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or sensorNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata threatScanningFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to execute a threat scan due to a non-operational control port or failed sensor module,
                     * causing the scan command from the pilot to be ignored. As a result, the vessel remains 
                     * unaware of nearby hostile entities, asteroids, or environmental hazards, increasing the 
                     * risk of surprise attacks, collisions, or mission compromise in contested or high-risk zones.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition prioritizeThreat
            first InGrid
            accept threatSignature : Domain::ScanSignature via miningFrigates.controlPort
            do action prioritizeThreats : PrioritizeThreats
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToPrioritizeThreat
            first InGrid
            accept threatSignature : Domain::ScanSignature via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata threatPrioritizationFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives threat signatures but fails to prioritize them due to a 
                     * non-operational control port, preventing the PrioritizeThreats action from executing. 
                     * This may lead to inappropriate or delayed defensive responses, such as engaging low-priority 
                     * threats while ignoring imminent dangers, thereby increasing vulnerability to hostile actions 
                     * or mission-critical damage.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition deployDrones
            first InGrid
            accept droneCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action selectDronesForDeployment : SelectDronesForDeployment
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint droneBayOperational ::> miningFrigates.droneBay.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and droneBayOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToDeployDrones
            first InGrid
            accept droneCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint droneBayNotOperational ::> miningFrigates.droneBay.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or droneBayNotOperational
                }


                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata droneDeploymentFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to deploy drones due to a non-operational control port, 
                     * preventing the SelectDronesForDeployment action from executing, or failure in drone bay. 
                     * Since drones are critical for both mining operations (e.g., asteroid extraction) and defensive 
                     * functions (e.g., threat interception or perimeter monitoring), this failure can 
                     * lead to reduced resource yield, prolonged exposure to hostile threats, or inability 
                     * to respond to dynamic mission demands, significantly degrading both operational 
                     * effectiveness and survivability.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition navigation
            first InGrid
            accept destinationCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action acceptDestination : AcceptDestination
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint navigationModuleOperational ::> miningFrigates.navigationModule.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and navigationModuleOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failedNavigation
            first InGrid
            accept destinationCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint navigationModuleNotOperational ::> miningFrigates.navigationModule.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or navigationModuleNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata navigationFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to accept or process a destination command due to a 
                     * non-operational control port, preventing the AcceptDestination action from executing, 
                     * or failure in the navigation module. 
                     * As a result, the vessel cannot update its navigation target, leading to mission drift, 
                     * inability to reach mining zones or safe havens, prolonged exposure to hazardous areas 
                     * (e.g., asteroid fields or hostile territories), or failure to rendezvous with support 
                     * assets. This compromises both operational continuity and crew/asset safety.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::medium;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition coursePlot
            first InGrid
            accept courseCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action plotOptimalCourse : PlotOptimalCourse
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint navigationModuleOperational ::> miningFrigates.navigationModule.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and navigationModuleOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToCoursePlot
            first InGrid
            accept courseCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint navigationModuleNotOperational ::> miningFrigates.navigationModule.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or navigationModuleNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata coursePlottingFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives a course command but fails to plot an optimal navigation 
                     * path due to a non-operational control port, preventing the PlotOptimalCourse action 
                     * from executing, or failure in the navigation module. 
                     * This leaves the vessel unable to determine a safe or efficient route 
                     * through complex environments (e.g., asteroid fields, gravitational anomalies, or 
                     * contested zones), potentially resulting in collision hazards, extended transit times, 
                     * fuel inefficiency, or exposure to threats. In dynamic scenarios, this may critically 
                     * impair mission responsiveness and survivability.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition engagePropulsion
            first InGrid
            accept propulsionCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action engagePropulsion : EngagePropulsion
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint propulsionModuleOperational ::> miningFrigates.propulsionModule.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and propulsionModuleOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToEngagePropulsion
            first InGrid
            accept propulsionCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint propulsionModuleNotOperational ::> miningFrigates.propulsionModule.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or propulsionModuleNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata propulsionEngagementFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives a propulsion command but fails to engage its propulsion 
                     * system due to a non-operational control port, preventing the EngagePropulsion action 
                     * from executing, or failure in propulsion module. 
                     * As a result, the vessel cannot maneuver—rendering it unable to avoid 
                     * collisions (e.g., with asteroids or debris), escape threats, adjust orbit, or follow 
                     * planned trajectories. This complete loss of thrust response in open space poses an 
                     * immediate and severe risk to asset integrity and mission continuity.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition adjustCourse
            first InGrid
            accept courseCorrection : Domain::ShipCommand via miningFrigates.controlPort
            do action monitorAndAdjustCourse : MonitorAndAdjustCourse
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToAdjustCourse
            first InGrid
            accept courseCorrection : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata courseAdjustmentFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives a course correction command but fails to monitor or adjust 
                     * its current trajectory due to a non-operational control port, preventing the 
                     * MonitorAndAdjustCourse action from executing. As a result, the vessel cannot perform 
                     * real-time corrections for drift, obstacle avoidance, or threat evasion—increasing the 
                     * risk of collision with asteroids, space debris, or hostile entities. In dynamic or 
                     * congested operational zones, this loss of adaptive navigation significantly elevates 
                     * mission hazard and may lead to catastrophic damage.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition cargoVerification
            first Docked
            accept warehouseStatusCommand : Domain::StationCommand via miningFrigates.controlPort
            do action verifyCargoTransfer : VerifyCargoTransfer
            then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failedCargoVerification
            first Docked
            accept warehouseStatusCommand : Domain::StationCommand via miningFrigates.controlPort
            then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata cargoVerificationFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to verify cargo transfer status with the station due to a 
                     * non-operational control port, preventing the VerifyCargoTransfer action from executing. 
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::low;
                    }
                }
            }    

        «Uncertainty<ocr, epi, subj>» transition detectThreat
            first InGrid
            accept threatScanCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action detectThreat : DetectThreat
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint sensorOperational ::> miningFrigates.sensorModule.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and sensorOperational
                }
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToDetectThreat
            first InGrid
            accept threatScanCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint sensorNotOperational ::> miningFrigates.sensorModule.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or sensorNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata threatDetectionFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives a threat scan command but fails to execute the DetectThreat 
                     * action due to a non-operational control port or failed sensor module, 
                     * resulting in a complete inability to detect 
                     * nearby hostile entities, stealth vessels, missile launches, or anomalous energy signatures. 
                     * Without early threat awareness, the vessel cannot initiate defensive measures, deploy drones, 
                     * or maneuver evasively—leaving it exposed to surprise attacks, ambushes, or kinetic strikes. 
                     * In contested or high-risk zones, this blind spot constitutes a critical vulnerability with 
                     * potentially catastrophic consequences.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition engageDefense
            first InGrid
            accept defenseCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action engageDefenses : EngageDefenses
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportOperational ::> miningFrigates.controlPort.Operational;
                «IndeterminacySpecification» ref constraint shieldModuleOperational ::> miningFrigates.shieldModule.Operational;
                «IndeterminacySpecification» ref constraint droneBayOperational ::> miningFrigates.droneBay.Operational;
                «IndeterminacySpecification» ref constraint defenseTurretOperational ::> miningFrigates.defenseTurret.Operational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportOperational and shieldModuleOperational and droneBayOperational and defenseTurretOperational
                }

                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToEngageDefense
            first InGrid
            accept defenseCommand : Domain::ShipCommand via miningFrigates.controlPort
            then InGrid {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref constraint miningFrigateControlportNotOperational ::> miningFrigates.controlPort.NotOperational;
                «IndeterminacySpecification» ref constraint shieldModuleNotOperational ::> miningFrigates.shieldModule.NotOperational;
                «IndeterminacySpecification» ref constraint droneBayNotOperational ::> miningFrigates.droneBay.NotOperational;
                «IndeterminacySpecification» ref constraint defenseTurretNotOperational ::> miningFrigates.defenseTurret.NotOperational;
                «IndeterminacySpecification» constraint overallSpecification {
                    miningFrigateControlportNotOperational or shieldModuleNotOperational or droneBayNotOperational or defenseTurretNotOperational
                }

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata defenseEngagementFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate receives a defense command but fails to activate its defensive systems 
                     * due to a non-operational control port, preventing the EngageDefenses action 
                     * from executing, or a failure in the defense module, including shiled module, drone bay or defense bay. 
                     * As a result, the vessel remains vulnerable to incoming threats—even when 
                     * threats are correctly detected and prioritized. This inability to respond in hostile 
                     * environments may lead to hull breaches, system destruction, cargo loss, or total mission 
                     * failure, especially during ambushes or coordinated attacks.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::high;
                    }
                }
            }

        «Uncertainty<ocr, epi, subj>» transition resupply
            first Docked
            accept shipStatusCommand : Domain::ShipCommand via miningFrigates.controlPort
            do action verifyResupply : VerifyResupply
            then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.Operational;
                
                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }
            }

        «Uncertainty<ocr, epi, subj>» transition failToResupply
            first Docked
            accept shipStatusCommand : Domain::ShipCommand via miningFrigates.controlPort
            then Docked {
                u_reducibility = PartiallyReducible;
                u_pattern = Random;

                «IndeterminacySpecification» ref ::> miningFrigates.controlPort.NotOperational;

                // To measure the the probability of the uncertainty
                measurement {
                    m_degree = "TODO";
                }

                metadata resupplyVerificationFailureRisk : RiskMetadata::Risk {
                    /**
                     * The mining frigate fails to verify the completion or status of a resupply operation 
                     * due to a non-operational control port, preventing the VerifyResupply action from executing,
                     * which may result in delay of further missions.
                     */
                    totalRisk {
                        impact = RiskMetadata::LevelEnum::medium;
                    }
                }
            }
	}
    
     // Definitions for individual parts of the mining frigate
    part def SpaceshipModule {
    	attribute mass : Real;
    	attribute powerGrid : Integer;
    	attribute capacitorSurge : Integer;
    }
    

    // **Consolidated Core System (Non-Configurable)**
    part def CoreSystem {
        
    }

    // **Configurable Modules**

    // Constraint definition
    constraint def Operational {
        attribute status : Boolean;

        status == true
    }

    constraint def NotOperational {
        attribute status : Boolean;

        status == false
    }

    part def MiningLaser :> Domain::NonDeterministicComponent {
        attribute miningPower : Real; // Mining power of the laser
        attribute cycleTime : Real; // Time per mining cycle
        attribute operationalStatus : Boolean;
    }

    part def ShieldModule :> Domain::NonDeterministicComponent {
        attribute shieldStrength : Real; // Hitpoints of the shield
        attribute rechargeRate : Real; // Recharge rate of the shield
        attribute operationalStatus : Boolean;
    }

    part def PropulsionModule :> Domain::NonDeterministicComponent {
        attribute maxVelocity : Real; // Speed of the ship
        attribute warpSpeed : Real; // Warp speed in AU/s
        attribute operationalStatus : Boolean;
    }

    part def SensorModule :> Domain::NonDeterministicComponent {
        attribute scanResolution : Real; // Locking speed
        attribute targetingRange : Real; // Max target range
        attribute operationalStatus : Boolean;
    }

    part def OreHoldExpander :> Domain::NonDeterministicComponent {
        attribute capacityBonus : Real; // Increase in cargo capacity
    }

    part def CapacitorBooster :> Domain::NonDeterministicComponent {
        attribute capacitorRecharge : Real; // Boost to capacitor energy
    }

    part def DefenseTurret :> Domain::NonDeterministicComponent {
        attribute firepower : Real; // DPS output
        attribute optimalRange : Real; // Optimal engagement range
        attribute operationalStatus : Boolean;
    }

    part def DroneBay :> Domain::NonDeterministicComponent {
        attribute maxDrones : Integer; // Maximum drones stored
        attribute operationalStatus : Boolean;
    }

    part def NavigationModule :> Domain::NonDeterministicComponent {
        attribute agilityBonus : Real; // Improves ship align time
        attribute warpSpeedBonus : Real; // Boost to warp speed
        attribute operationalStatus : Boolean;
    } 
}	    

package OperationalUseCaseActions {
	
	// private import Domain::*;
	private import ScalarValues::*;
	private import MiningFrigate::*; 
	
	// Operational Action Definitions for the Mining Frigate

    // Main Use Case definition : Mine Asteroids
    
    action def IdentifyDestination {
        doc /* Identify an asteroid belt or a target asteroid. */
        out targetSignature : Domain::ScanSignature;
    }
    
    action def ActivateMiningLaser {
        doc /* 
         * Main Flow:
         * 1. Receive mining command from the pilot.
         * 2. Activate mining laser on the selected asteroid.
         * 3. Extract ore and transfer it to the ship's ore hold.
         * 4. Generate a mining report and notify the pilot.
         *
         * Alternative Flows:
         * - If multiple asteroids are in range, mining lasers distribute across different targets.
         * - If mining boosts (e.g., from Orca/Rorqual) are active, adjust extraction efficiency.
         * - If the ore hold is nearly full, notify the pilot before proceeding with further extraction.
         *
         * Exception Flows:
         * - If the asteroid is depleted mid-cycle, halt mining and prompt pilot for new target.
         * - If mining lasers overheat, disable temporarily until cooldown completes.
         * - If capacitor energy is insufficient, fail to activate laser and notify the pilot.
         * - If ECM interference disrupts target lock, pause extraction until lock is re-established.
         */
    }  

    // Main Use Case definition : Detect Threats and Engage Defenses
    
    action def ScanForThreats {
        doc /* Scan the surrounding space for potential threats. */
        in scanCommand : Domain::ShipCommand;
        out detectedThreats : Domain::ScanSignature;
        out scanReport : Domain::ShipReport;
    }

    action def PrioritizeThreats {
        doc /* Evaluate detected threats and prioritize response actions. */
        in detectedThreats : Domain::ScanSignature;
        out threatPriority : String;
    }

    // Main Use Case definition : Plot Course and Navigate
    
    action def UndockFromStation {
		doc /*Undock from a station.*/
        in undockCommand : Domain::ShipCommand;
    }
    
    action def ExecuteWarpDrive {
        doc /* Engage the warp drive to travel to the destination. */
        in warpCommand : Domain::ShipCommand;
        out warpStatusReport : Domain::ShipReport;
    }

    // Main Use Case definition : Offload Ore and Resupply
    
    action def DockToStation {
      doc /*Dock into a station to make repairs, resupply capacitor and support systems.*/
          in dockCommand : Domain::ShipCommand;
      in charge : Domain::Power;
      out dockingReport : Domain::ShipReport;
    }


    // Main Use Case definition : Deploy Drones
    
    action def SelectDronesForDeployment {
        doc /* Select drones for deployment based on operational needs (mining or defense). */
        in droneCommand : Domain::ShipCommand;
        out selectedDrones : Domain::Drone;
    }

    // Included Use Case definition : Navigate to Destination
    
    action def AcceptDestination {
      doc /*Accept a destination from the pilot. */
      in destinationCommand : Domain::ShipCommand;
      out destinationReport : Domain::ShipReport;
    }

    action def PlotOptimalCourse {
      doc /*Plot the optimal course using the navigation system.*/
      out optimalCourseReport : Domain::ShipReport;
    }

    action def EngagePropulsion {
      doc /*Engage the propulsion system to travel along the plotted course.
      * Propulsion does not use items (fuel, power) in Eve Online.
      */
      in engagePropulsion : Domain::ShipCommand;
      out propulsionEngagedReport : Domain::ShipReport;    	
    }

    action def MonitorAndAdjustCourse {
      doc /*Continuously monitor progress and adjust the course as needed.*/
      out selectedCourseReport : Domain::ShipReport;
    }
    	
	// Included Use Case definition : Transfer Cargo	
    
    action def TransferOre {
      doc /*Transfer ore or other cargo to the appropriate storage location.*/
        in unloadCommand : Domain::ShipCommand;
      out oreCargo : Domain::CargoContainer;
      out storageReport : Domain::ShipReport;
    }

    action def VerifyCargoTransfer {
		  doc /*Verify the transfer has been completed successfully.*/
    	in warehouseStatusCommand : Domain::StationCommand;
		  out warehouseReport : Domain::StationReport;    
    }
	
	// Included Use Case definition : Engage Defense Systems

    action def DetectThreat {
      doc /*Detect and classify threats using the sensor array.*/
      in scanCommand : Domain::ShipCommand;
      in threatSignature : Domain::ScanSignature;
      out scanReport : Domain::ShipReport;    
    }

    action def EngageDefenses {
      doc /*Activate defense turrets and deploy drones to neutralize threats.*/
      in engageCommand : Domain::ShipCommand;
      out firePower: Domain::Power;
      out damageReport : Domain::ShipReport;    
    }
	
	// Included Use Case definition : Resupply Systems
	
    action def VerifyResupply {
		  doc /*Verify the resupply is completed successfully.*/
      in shipStatusCommand : Domain::ShipCommand;
		  out shipStatusReport : Domain::ShipReport;    
    }
}
