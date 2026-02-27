package ServerSequenceModel {
	private import ScalarValues::String;
	public import SignalDefinitions::*;

	package SignalDefinitions {
		private import ServerSequenceRealization_2::Configuration::*;
	    «UncertaintyTopic» item def Subscribe {
	    	attribute topic : String;
	    	ref part subscriber;

			«Uncertainty» ref ::> server_2.serverBehavior.subscribing;
			«Uncertainty» ref ::> server_2.serverBehavior.failToSubscribe;
			«Uncertainty» ref ::> consumer_2.consumerBehavior.subscribe;
	    }
	    
		«UncertaintyTopic» item def Publish {
			attribute topic : String;
			ref publication;

			«Uncertainty» ref ::> producer_2.producerBehavior.publish;
			«Uncertainty» ref ::> server_2.serverBehavior.delivering;
			«Uncertainty» ref ::> server_2.serverBehavior.failToDeliver;
		}
		
		«UncertaintyTopic» item def Deliver {
			ref publication;

			«Uncertainty» ref ::> server_2.serverBehavior.delivering;
			«Uncertainty» ref ::> consumer_2.consumerBehavior.delivery;
		}
	}

	part def PubSubSequence {
		part producer[1] {
			event occurrence publish_source_event;
		}
		
		message publish_message from producer.publish_source_event to server.publish_target_event;
		
		part server[1] {
			event occurrence subscribe_target_event;
			then event occurrence publish_target_event;
			then event occurrence deliver_source_event;
		}
		
		message subscribe_message from consumer.subscribe_source_event to server.subscribe_target_event;
		message deliver_message from server.deliver_source_event to consumer.deliver_target_event;
		
		part consumer {
			event occurrence subscribe_source_event;
			then event occurrence deliver_target_event;
		}
	}
}

package ServerSequenceRealization_2 {
	private import ScalarValues::*;
	private import ServerSequenceModel::*;
	private import Configuration::*;
	
	package Configuration {
		constraint def Operational {
			in status : Boolean;
			status == true
		}

		constraint def NotOperational {
			in status : Boolean;
			status == false
		}
		
		«IndeterminacySource<nd>» port def PublicationPort {
			attribute operationalStatus : Boolean;
			// IndeterminacySpecification
			«IndeterminacySpecification» constraint publicationPortOperational : Operational {
				in status = operationalStatus;
			}

			«IndeterminacySpecification» constraint publicationPortNotOperational : NotOperational {
				in status = operationalStatus;
			}

		}
		
		«IndeterminacySource<nd>» port def SubscriptionPort {
			attribute operationalStatus : Boolean;
			// IndeterminacySpecification
			«IndeterminacySpecification» constraint subscriptionPortOperational : Operational {
				in status = operationalStatus;
			}

			«IndeterminacySpecification» constraint subscriptionPortNotOperational : NotOperational {
				in status = operationalStatus;
			}

		}
		
		part producer_2[1] {
			attribute someTopic : String;
			private item somePublication;
			
			// Inherit indeterminacySpecification from port definition
			port publicationPort : ~PublicationPort;
			
			«BeliefStatement» perform action producerBehavior {	
				«Uncertainty<ocr, epi, subj>» action publish send Publish(someTopic, somePublication) via publicationPort {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> publicationPort.publicationPortOperational;

					«Effect» ref ::> server_2.serverBehavior.delivering;

					// To measure the the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
			}
		}
		
		interface producer_2.publicationPort to server_2.publicationPort;
		
		part server_2[1] {
			// Inherit indeterminacySpecification from port def 
			port publicationPort : PublicationPort;
			// Inherit indeterminacySpecification from port def 
			port subscriptionPort : SubscriptionPort;
			
			«BeliefStatement» exhibit state serverBehavior {
				entry; then waitForSubscription;
				
				state waitForSubscription;

				«Uncertainty<ocr, epi, subj>, Effect» transition subscribing
					first waitForSubscription
					accept sub : Subscribe via subscriptionPort
					then waitForPublication {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint sendPortOperational ::> consumer_2.subscriptionPort.subscriptionPortOperational;
						«IndeterminacySpecification» ref constraint acceptPortOperational ::> subscriptionPort.subscriptionPortOperational;
						«IndeterminacySpecification» constraint overallSpecification {
							sendPortOperational and acceptPortOperational
						}

						// To measure the the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>» transition failToSubscribe
					first waitForSubscription
					accept sub : Subscribe via subscriptionPort
					then waitForSubscription {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint sendPortNotOperational ::> consumer_2.subscriptionPort.subscriptionPortNotOperational;
						«IndeterminacySpecification» ref constraint acceptPortNotOperational ::> subscriptionPort.subscriptionPortNotOperational;
						«IndeterminacySpecification» constraint overallSpecification {
							sendPortNotOperational or acceptPortNotOperational
						}

						metadata lossOfSubscribeRisk : RiskMetadata::Risk {
							totalRisk {
                                impact = RiskMetadata::LevelEnum::high;
                            }
						}

						// To measure the the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}
					
				state waitForPublication;
				
				«Uncertainty<ocr, epi, subj>, Effect» transition delivering
					first waitForPublication
					accept pub : Publish via publicationPort
					if pub.topic == subscribing.sub.topic
					do send Deliver(pub.publication) to subscribing.sub.subscriber
					then waitForPublication {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint sendPortOperational ::> producer_2.publicationPort.publicationPortOperational;
						«IndeterminacySpecification» ref constraint acceptPortOperational ::> publicationPort.publicationPortOperational;
						«IndeterminacySpecification» constraint overallSpecification {
							sendPortOperational and acceptPortOperational
						}

						«Effect» ref ::> consumer_2.consumerBehavior.delivery;

						// To measure the the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}

				«Uncertainty<ocr, epi, subj>» transition failToDeliver
					first waitForPublication
					accept pub : Publish via publicationPort
					then waitForPublication {
						u_reducibility = PartiallyReducible;
						u_pattern = Random;

						«IndeterminacySpecification» ref constraint sendPortNotOperational ::> producer_2.publicationPort.publicationPortNotOperational;
						«IndeterminacySpecification» ref constraint acceptPortNotOperational ::> publicationPort.publicationPortNotOperational;
						«IndeterminacySpecification» constraint overallSpecification {
							sendPortNotOperational or acceptPortNotOperational
						}

						metadata lossOfDeliverRisk : RiskMetadata::Risk {
							totalRisk {
                                impact = RiskMetadata::LevelEnum::medium;
                            }
						}

						// To measure the the probability of the uncertainty
						measurement {
							m_degree = "TODO";
						}
					}
			}
		}
		
		interface consumer_2.subscriptionPort to server_2.subscriptionPort;
		
		part consumer_2[1] {
			attribute myTopic : String;

			// Inherit indeterminacySpecification from port def 
			port subscriptionPort : ~SubscriptionPort;
			
			«BeliefStatement» perform action consumerBehavior {
				«Uncertainty<ocr, epi, subj>» action subscribe send Subscribe(myTopic, consumer_2) via subscriptionPort to server_2{
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref ::> subscriptionPort.subscriptionPortOperational;

					«Effect» ref ::> server_2.serverBehavior.subscribing;

					// To measure the the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
				then «Uncertainty<ocr, epi, subj>, Effect» action delivery accept Deliver via consumer_2 {
					u_reducibility = PartiallyReducible;
					u_pattern = Random;

					«IndeterminacySpecification» ref constraint producerPublicationPortOperational ::> producer_2.publicationPort.publicationPortOperational;
					«IndeterminacySpecification» ref constraint serverPublicationPortOperational ::> server_2.publicationPort.publicationPortOperational;
					«IndeterminacySpecification» constraint overallSpecification {
						producerPublicationPortOperational and serverPublicationPortOperational
					}

					// To measure the the probability of the uncertainty
					measurement {
						m_degree = "TODO";
					}
				}
			}
		}
		
	}
	
	«BeliefStatement» part realization_2 : PubSubSequence {
		part :>> producer :> producer_2 {
			event producerBehavior.publish[1] :>> publish_source_event;
		}

		part :>> server :> server_2 {
			event serverBehavior.subscribing.accepter[1] :>> subscribe_target_event;
			event serverBehavior.delivering.accepter[1] :>> publish_target_event;
			event serverBehavior.delivering.effect[1] :>> deliver_source_event;
		}
		
		part :>> consumer :> consumer_2 {
			event consumerBehavior.subscribe[1] :>> subscribe_source_event;
			event consumerBehavior.delivery[1] :>> deliver_target_event;
		}

		«Uncertainty<ocr, epi, subj>» message :>> publish_message: Transfers::MessageTransfer {
 			end :>> source = producer.publicationPort;
 			end :>> target = server.publicationPort;

			u_reducibility = PartiallyReducible;
			u_pattern = Random;

			«IndeterminacySpecification» ref constraint producerPublicationPortOperational ::> producer.publicationPort.publicationPortOperational;
			«IndeterminacySpecification» ref constraint serverPublicationPortOperational ::> server.publicationPort.publicationPortOperational;
			«IndeterminacySpecification» constraint overallSpecification {
				producerPublicationPortOperational and serverPublicationPortOperational
			}

			// To measure the the probability of the uncertainty
			measurement {
				m_degree = "TODO";
			}
 		}
		«Uncertainty<ocr, epi, subj>» message :>> subscribe_message: Transfers::MessageTransfer {
 			end :>> source = consumer.subscriptionPort;
 			end :>> target = server.subscriptionPort;

			u_reducibility = PartiallyReducible;
			u_pattern = Random;

			«IndeterminacySpecification» ref constraint consumerSubscriptionPortOperational ::> consumer.subscriptionPort.subscriptionPortOperational;
			«IndeterminacySpecification» ref constraint serverSubscriptionPortOperational ::> server.subscriptionPort.subscriptionPortOperational;
			«IndeterminacySpecification» constraint overallSpecification {
				consumerSubscriptionPortOperational and serverSubscriptionPortOperational
			}

			// To measure the the probability of the uncertainty
			measurement {
				m_degree = "TODO";
			}
 		}
		message :>> deliver_message: Transfers::MessageTransfer {
 			end :>> source = server;
 			end :>> target = consumer;
 		}
 		
 		/* Binding sent/accept messages to specification model messages. */
		  /* Sends */
 		bind producer_2.producerBehavior.publish.sentMessage = publish_message;
 		bind consumer_2.consumerBehavior.subscribe.sentMessage = subscribe_message;
 		bind server_2.serverBehavior.delivering.effect.sentMessage = deliver_message;
 		  /* Accepts */
 		bind consumer_2.consumerBehavior.delivery.acceptedMessage = subscribe_message;
 		bind server_2.serverBehavior.subscribing.accepter.acceptedMessage = subscribe_message;
 		bind server_2.serverBehavior.delivering.accepter.acceptedMessage = publish_message;
	}
}