// /** Mandatory Services and Systems */
library package AHFCoreLib {
	private import AHFProfileLib::*;
	private import ScalarValues::*;
	private import AHFProfileMetadata::*;

	#service port def ServiceDiscovery {
		// The functionalities as Requests (Operations) cannot be defined yet
		// We could consider using flows to designate the functionalities
	}
	
	#service port def ServiceDiscoveryDD :> ServiceDiscovery{
	}
		
	#service port def Authorisation {
		attribute publickey:String; // just as examples
	}

	#service port def AuthorisationDD :> Authorisation{
	}

	
	#clouddd ArrowheadCore{
		// /** Design Level */
		// First the system definitions (SysD) of core systems
		
		#system service_registry {
			#service serviceDiscovery : ServiceDiscovery ;
		}
		
		#system authorization{
			#service authorisation : Authorisation;
			attribute protocol:String = "HTTP";
		}
		
		#system orchestrationDesign; // just indicated for now
		
		// /** Design Description level */		
		#systemdd service_registry_DD :> service_registry{
			#servicedd :>> serviceDiscovery:ServiceDiscoveryDD {
				#idd serviceDiscovery_HTTP ;// nested port for HTTP protocol
				// here we refer the functionalities like operation Register etc.
				#idd serviceDiscovery_MQTT ; // nested port for MQTT protocol
			}
		}
		
		#systemdd authorization_DD :> authorization{
			#servicedd :>> authorisation {
				#idd authorisation_HTTP ; // nested port for HTTP protocol
				#idd authorisation_MQTT ; // nested port for MQTT protocol
			}
			action Echo_behavior :> ServiceMethod;
		}
	}
}

library package AHFProfileLib {
	// Systems and Services and their functionalities
	private import ScalarValues::*;
	
	// Design level
	port def SD{
		doc /* Service definition */
		
		attribute serviceDefinition:String;
		attribute serviceURL:String;
		attribute intrfce_protocol:String; // which may be "REST" or "MQTT" etc.		 
	}	
		
	part def SysLocalCloudsDesign {
		doc /* System of Systems Definition */	

		// System of Local Clouds 
		part locclouds:LocalCloudDesign[1..*];
	}
	
	part system_of_systems:SysLocalCloudsDD; // defining a top level usage
	
	part def LocalCloudDesign {
		doc /* Local Cloud definition */

		part systems:SysD[1..*];	
	}

	part def SysD {
		doc /* System definitions */	

		port services: SD[1..*];
		attribute systemname: String;
		attribute address: String;
		attribute portno: Integer;
	}	

	// Design Description level
	port def IDD :> SD{
		doc /* Interface Design Description of services */
		
		attribute encoding_kind:String;
	}
	
	port def SDDD :> SD{
		doc /* Service Definition Design Description */
		
		port idds:IDD[*]; // nested protocol-specific services
	}	

	part def SysLocalCloudsDD :> SysLocalCloudsDesign {
		doc /* System of Systems Detailed Description */	

		part :>> locclouds:LocalCloudDD[1..*]; // the descriptions
	}

	part def LocalCloudDD :> LocalCloudDesign {
		part :>> systems:SysDD[1..*];
	}

	part def SysDD :> SysD{
		doc /* System Detailed Description */

		port :>> services:SDDD;
		action ServiceMethod[1..*]; //means general behaviors
	}
}

library package AHFProfileMetadata{
	private import Metaobjects::SemanticMetadata;
	private import AHFProfileLib::*;

	port global_sd:SD;
	metadata def <service> SDMetadata :> SemanticMetadata{
		// :>> baseType = system_of_systems.locclouds.systems.services meta SysML::PortUsage;
		// :>> baseType = SysD::services meta SysML::PortUsage;
		:>> baseType default global_sd meta SysML::PortUsage;
	}
	
	metadata def <sos> SysLocalCloudsMetadata :> SemanticMetadata{
		:>> baseType = system_of_systems meta SysML::PartUsage;
	}
	
	metadata def <cloud> LocalCloudsMetadata :> SemanticMetadata{
		:>> baseType default system_of_systems::locclouds meta SysML::PartUsage;
	}
	
	metadata def <system> SysDMetadata :> SemanticMetadata{
		:>> baseType default system_of_systems::locclouds::systems meta SysML::PartUsage;
		// :>> baseType default LocalCloudDesign::systems meta SysML::PartUsage;
	}

	metadata def <idd> IDDMetadata :> SDMetadata{
		// :>> baseType = system_of_systems.locclouds.systems.services.idd meta SysML::PortUsage;
		:>> baseType = SDDD::idds meta SysML::PortUsage;
		// :>> global_sddd.idd;
	}

	port global_sddd:SDDD;
	metadata def <servicedd> SDDDMetadata :> SDMetadata {
		// :>> baseType = system_of_systems.locclouds.systems.services meta SysML::PortUsage;
		:>> baseType = global_sddd meta SysML::PortUsage;
	}
	
	metadata def <clouddd> LocalCloudsDDMetadata :> LocalCloudsMetadata{
		:>> baseType = system_of_systems::locclouds meta SysML::PartUsage;
	}
	
	part global_clouddd:LocalCloudDD;
	part global_systemsdd:SysDD;
	metadata def <systemdd> SysDDMetadata :> SysDMetadata{
		// :>> baseType = system_of_systems.locclouds.systems meta SysML::PartUsage;
		//:>> baseType = LocalCloudDD::systems meta SysML::PartUsage;
		:>> baseType = global_systemsdd meta SysML::PartUsage;
	}	
	
}


package AHFNorway {
	doc /* This is the Norwegian use-case for Arrowhead Framework */
	// The use-case is for Productive4.0 and Arrowhead Tools
	// The system is taken from a chemical factory
	// This is focusing on the monitoring of products when delivered
	private import AHFProfileLib::*;
	private import AHFProfileMetadata::*;
	private import AHFCoreLib::**;
	private import ScalarValues::*;

	#service def APISService {
		doc /* Service design */		

		attribute :>> serviceDefinition = "APISPullService";
		attribute :>> intrfce_protocol = "{JSON}";
		attribute :>> serviceURL = "pull";
	}


	#servicedd port def APIS_DD :> APISService {
		doc /* Service design description with nested protocol-specific ports */	

		«IndeterminacySource<nd>» #idd port APIS_HTTP {
			attribute operationalStatus : Boolean;
			// the asynch implementation of synchronous remote calls
			out cll:CallGiveItems;
			in retrn:ResultGiveItems;

			«IndeterminacySpecification» ref constraint APIS_HTTP_Operational : Operational {
				in status = operationalStatus;
			}

			«IndeterminacySpecification» ref constraint APIS_HTTP_Not_Operational : NotOperational {
				in status = operationalStatus;
			}
		}
		
		«IndeterminacySource<nd>» #idd port APIS_MQTT  {
			attribute operationalStatus : Boolean;
			// GetAllItems functionality
			out pub:Publish;
			out retall:Return_AllItems;
			in subscr:Subscribe;

			«IndeterminacySpecification» ref constraint APIS_MQTT_Operational : Operational {
				in status = operationalStatus;
			}

			«IndeterminacySpecification» ref constraint APIS_MQTT_Not_Operational : NotOperational {
				in status = operationalStatus;
			}
		}
	}

	// Constraint definition
	constraint def Operational {
		in status : Boolean;
		status == true
	}
	
	constraint def NotOperational {
		in status : Boolean;
		status == false
	}
	
	// Asynchronous signals
	attribute def Publish {nametopic:String;}
	attribute def Subscribe{nametopic:String;}
	attribute def Return_AllItems {itms:String;}
	attribute def Subscribe_giveItems{itms:String;}
	attribute def Return_Ack{ack:Boolean;}
	
	// Signals for implementing the remote procedure call by asynch signals
	attribute def CallGiveItems{itms:String; } 
	attribute def ResultGiveItems{ack:Boolean;}

	// UncertaintyTopic declarations for grouping related uncertainties in AF
	«UncertaintyTopic» item def PublishTopic {
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.APISProducer.APISPbehavior.sendPublish;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.MQTTServer.Serve.acceptPublish;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.MQTTServer.Serve.failToAcceptPublish;
	}

	«UncertaintyTopic» item def SubscribeTopic {
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.APISConsumer.MQTT_APISP.sendSubsribe;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.MQTTServer.Serve.acceptSubsribe;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.MQTTServer.Serve.failToAcceptSubsribe;
	}

	«UncertaintyTopic» item def RemoteCallTopic {
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.TellUConsumer.TellUbehavior.sendCallGiveItems;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.APISProducer.APISPbehavior.acceptCallGiveItems;
		«Uncertainty» ref ::> AHFNorway_LocalCloudDD.APISProducer.APISPbehavior.failToAcceptCallGiveItems;
	}

	#clouddd AHFNorway_LocalCloudDD :> ArrowheadCore {	
		#systemdd TellUConsumer {
			#servicedd serviceDiscovery:~ServiceDiscoveryDD ; // communicating with ServiceRegistry
			#servicedd apisp:APIS_DD ;
			
			attribute :>> systemname = "UngerApisClient";
			attribute :>> address = "Unger_network_ip";
			attribute :>> portno = 0;
						
			// We want an operation call to GiveItems, and actually sending the payload
			// Call apisp::APIS_HTTP::giveItems(in allitems: String = "All the items", out ackback:Boolean);
			
			«BeliefStatement» state TellUbehavior{
				entry «Uncertainty<ocr, epi, subj>» action sendCallGiveItems send CallGiveItems("All the items") via apisp.APIS_HTTP {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> apisp.APIS_HTTP.APIS_HTTP_Operational;

					«Effect» ref ::> APISProducer.APISPbehavior.acceptCallGiveItems

					// To measure the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
				then Wait;

				state Wait;
					//accept rs:ResultGiveItems
					// Here do whatever about the result rs.ret 
				//then Wait;

				// The declared name of the transition has been added for reference
				«Uncertainty<ocr, epi, subj>, Effect» transition acceptResultGiveItems
					first Wait
					accept rs:ResultGiveItems
					// Here do whatever about the result rs.ret 
					do action 'processResult'
					then Wait {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portOperational ::> apisp.APIS_HTTP.APIS_HTTP_Operational;
						«IndeterminacySpecification» ref constraint producerPortOperational ::> APISProducer.tellu.APIS_HTTP.APIS_HTTP_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portOperational and producerPortOperational
						}

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>, Effect» transition failToAcceptResultGiveItems
					first Wait
					accept rs:ResultGiveItems
					// No action performed with failed reception of ResultGiveItems
					then Wait {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portNotOperational ::> apisp.APIS_HTTP.APIS_HTTP_Not_Operational;
						«IndeterminacySpecification» ref constraint producerPortNotOperational ::> APISProducer.tellu.APIS_HTTP.APIS_HTTP_Not_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portNotOperational or producerPortNotOperational
						}

						metadata resultReceptionFailureRisk : RiskMetadata::Risk {
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
						
		}
		
		#systemdd APISProducer {
			#servicedd serviceDiscovery:~ServiceDiscoveryDD ; // communicating with ServiceRegistry
			#servicedd tellu:~APIS_DD; // providing the APISService
			#servicedd apisc:APIS_DD ; // talking to APISConsumer
			
			:>> systemname = "PrediktorApisServer";
			:>> address = "Prediktor_network_ip";
			:>> portno = 6565;
			attribute x:Boolean;
			
			«BeliefStatement» action giveItems :> ServiceMethod
			 {  in itms:String; out ack:Boolean;
			 	/* Forward itms and return an ack */

			 	first start;
				// The declared name of the sendAcitonUsage has been added for reference 
			 	then «Uncertainty<ocr, epi, subj>» action sendReturnAllItems send Return_AllItems(itms) via apisc.APIS_MQTT {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> apisc.APIS_MQTT.APIS_MQTT_Operational;

					«Effect» ref ::> MQTTServer.Serve.acceptReturn_AllItems;

					// To measure the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
			 	success = true;
			 	bind ack = success;
			 }
			
			«BeliefStatement» state APISPbehavior{
				entry «Uncertainty<ocr, epi, subj>» action sendPublish send Publish("Return_AllItems") via apisc.APIS_MQTT {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> apisc.APIS_MQTT.APIS_MQTT_Operational;

					«Effect» ref ::> MQTTServer.Serve.acceptPublish;

					// To measure the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
				then WaitOnData; 
				
				state WaitOnData;
				// 	accept cl:CallGiveItems via tellu.APIS_HTTP
				// 	do action {
				// 		first start;
				// 		then action giveItems{ in itms=cl.itms; out ack=x; }
				// 		then send ResultGiveItems(x) via tellu.APIS_HTTP;
				// 	}
				// then WaitOnData;	

				// The declared name of the transition has been added for reference

				«Uncertainty<ocr, epi, subj>, Effect» transition acceptCallGiveItems
					first WaitOnData
					accept cl:CallGiveItems via tellu.APIS_HTTP
					do action {
						first start;
						then action giveItems{ in itms=cl.itms; out ack=x; }
						then send ResultGiveItems(x) via tellu.APIS_HTTP;
					}		
					then WaitOnData {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portOperational ::> tellu.APIS_HTTP.APIS_HTTP_Operational;
						«IndeterminacySpecification» ref constraint consumerPortOperational ::> TellUConsumer.apisp.APIS_HTTP.APIS_HTTP_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portOperational and consumerPortOperational
						}

						«Effect» ref ::> TellUConsumer.TellUbehavior.acceptResultGiveItems;

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>» transition failToAcceptCallGiveItems
					first WaitOnData
					accept cl:CallGiveItems via tellu.APIS_HTTP
					// Effect action to send the ResultGiveItems is not performed due to failure in accepting call give items
					then WaitOnData {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portNotOperational ::> tellu.APIS_HTTP.APIS_HTTP_Not_Operational;
						«IndeterminacySpecification» ref constraint consumerPortNotOperational ::> TellUConsumer.apisp.APIS_HTTP.APIS_HTTP_Not_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portNotOperational or consumerPortNotOperational
						}

						«Effect» ref ::> TellUConsumer.TellUbehavior.failToAcceptResultGiveItems;

						metadata lossOfCallGiveItemsRisk : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::medium;
                            }
                        }

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}


			}
		}
		
		#systemdd APISConsumer {
			#servicedd serviceDiscovery:~ServiceDiscovery ; // communicating with ServiceRegistry
			#servicedd apisp:~APIS_DD ;
			:>> systemname = "TellUClient";
			:>> address = "Prediktor_network_ip";
			:>> portno = 1;
			
			// Now sending signal to the remote behavior through the port functionality
			«BeliefStatement» state MQTT_APISP {
				entry «Uncertainty<ocr, epi, subj>» action sendSubsribe send Subscribe("Return_AllItems") via apisp.APIS_MQTT {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> apisp.APIS_MQTT.APIS_MQTT_Operational;

					«Effect» ref ::> MQTTServer.Serve.acceptSubsribe;

					// To measure the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
				then Idle;		
				state Idle;
					// accept Return_AllItems via apisp.APIS_MQTT
					//  Get the stuff and do something with them
					// then Idle;

				// The declared name of the transition has been added for reference
				«Uncertainty<ocr, epi, subj>, Effect» transition acceptReturn_AllItems
					first Idle
					accept Return_AllItems via apisp.APIS_MQTT
					// Get the stuff and do something with them
					then Idle {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portOperational ::> apisp.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint producerPortOperational ::> APISProducer.apisc.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint serverGiveTopicPortOperational ::> MQTTServer.giveTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint serverGetTopicPortOperational ::> MQTTServer.getTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portOperational and producerPortOperational and serverGiveTopicPortOperational and serverGetTopicPortOperational
						}

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}
			}
		}
 		
 		part MQTTServer {
 			port getTopic:~APIS_DD;
 			port giveTopic:APIS_DD;
 			
 			«BeliefStatement» state Serve{				
 				entry;
 				then Publ;
 				state Publ;
 					// accept pub:Publish via getTopic.APIS_MQTT
 					// store information about who will provide "Publish::nametopic"
 				// then Subsr;

				// The declared name of the transition has been added for reference
				«Uncertainty<ocr, epi, subj>, Effect» transition acceptPublish
					first Publ
					accept pub:Publish via getTopic.APIS_MQTT
 					// store information about who will provide "Publish::nametopic"
					then Subsr {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portOperational ::> getTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint producerPortOperational ::> APISProducer.apisc.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portOperational and producerPortOperational
						}

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>» transition failToAcceptPublish
					first Publ
					accept pub:Publish via getTopic.APIS_MQTT
					then Publ {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portNotOperational ::> getTopic.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» ref constraint producerPortNotOperational ::> APISProducer.apisc.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portNotOperational or producerPortNotOperational
						}

						metadata publishReceptionFailureRisk : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::high;
                            }
                        }

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}
 				
 				state Subsr;
 					// accept Subscribe via giveTopic.APIS_MQTT
 					// store information about who want to receive "Subscribe::nametopic"
 				// then Idle;

				// The declared name of the transition has been added for reference
				«Uncertainty<ocr, epi, subj>, Effect» transition acceptSubsribe
					first Subsr
					accept Subscribe via giveTopic.APIS_MQTT
 					// store information about who want to receive "Subscribe::nametopic"
					then Idle {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portOperational ::> giveTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint consumerPortOperational ::> APISConsumer.apisp.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portOperational and consumerPortOperational
						}

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}

					}

				«Uncertainty<ocr, epi, subj>» transition failToAcceptSubsribe
					first Subsr
					accept Subscribe via giveTopic.APIS_MQTT
					then Subsr {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint portNotOperational ::> giveTopic.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» ref constraint consumerPortNotOperational ::> APISConsumer.apisp.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							portNotOperational or consumerPortNotOperational
						}

						metadata subscribeReceptionFailureRisk : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::high;
                            }
                        }

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}

					}
 				
 				state Idle;
 				// 	accept retrnall:Return_AllItems via getTopic.APIS_MQTT
 				// 	do send retrnall via giveTopic.APIS_MQTT
 				// then Idle;

				// The declared name of the transition has been added for reference
				«Uncertainty<ocr, epi, subj>, Effect» transition acceptReturn_AllItems
					first Idle
					accept retrnall:Return_AllItems via getTopic.APIS_MQTT
 					do send retrnall via giveTopic.APIS_MQTT
					then Idle {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint getTopicPortOperational ::> getTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint giveTopicPortOperational ::> giveTopic.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» ref constraint producerPortOperational ::> APISProducer.apisc.APIS_MQTT.APIS_MQTT_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							getTopicPortOperational and giveTopicPortOperational and producerPortOperational
						}

						«Effect» ref ::> APISConsumer.MQTT_APISP.acceptReturn_AllItems;

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>» transition failToAcceptReturn_AllItems
					first Idle
					accept retrnall:Return_AllItems via getTopic.APIS_MQTT
					then Idle {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint getTopicPortNotOperational ::> getTopic.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» ref constraint giveTopicPortNotOperational ::> giveTopic.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» ref constraint producerPortNotOperational ::> APISProducer.apisc.APIS_MQTT.APIS_MQTT_Not_Operational;
						«IndeterminacySpecification» constraint overallSpecification {
							getTopicPortNotOperational or giveTopicPortNotOperational or producerPortNotOperational
						}

						metadata lossOfReturn_AllItems : RiskMetadata::Risk {
                            totalRisk {
                                impact = RiskMetadata::LevelEnum::medium;
                            }
                        }

						// To measure the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}
 			} 			
 		}
 				
 		connect APISProducer.apisc to MQTTServer.getTopic; 
 		connect MQTTServer.giveTopic to APISConsumer.apisp; 
		
 		connect TellUConsumer.apisp to APISProducer.tellu; 
 		
 		// Then we need to connect the application systems to the mandatory systems
 		connect APISProducer.serviceDiscovery to service_registry.serviceDiscovery;
 		connect TellUConsumer.serviceDiscovery to service_registry.serviceDiscovery;
 		connect APISConsumer.serviceDiscovery to service_registry.serviceDiscovery;
 		
 		// Same procedure for the other mandatory services
		
	}
	
}