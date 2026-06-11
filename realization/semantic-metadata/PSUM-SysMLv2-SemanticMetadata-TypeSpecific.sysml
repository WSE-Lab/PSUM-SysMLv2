library package 'PSUM-SysMLv2-TypeSpecific' {
    public import Belief::*;
    public import Uncertainty::*;
    public import Measurement::*;

    abstract attribute def PSUMAttribute {
        attribute id : ScalarValues::String [1];
        attribute description : ScalarValues::String [0..1];
        attribute timeStamp : Time::Iso8601DateTime [0..1];
    }

    abstract occurrence def PSUMOccurrence {
        attribute id : ScalarValues::String [1];
        attribute description : ScalarValues::String [0..1];
        attribute timeStamp : Time::Iso8601DateTime [0..1];
    }

    package Belief {
        abstract attribute def BasisAttribute :> PSUMAttribute;

        abstract occurrence def BasisOccurrence :> PSUMOccurrence;

        attribute def BeliefStatementAttribute :> MeasurableAttribute {
            attribute duration : ISQ::DurationValue [0..1];
            ref basis : BasisAttribute, BasisOccurrence [0..*];

            ref uncertaintyTopic : UncertaintyTopicAttribute, UncertaintyTopicOccurrence [0..*];
            derived ref containedUncertainty : UncertainAttribute, UncertainOccurrence [0..*];
        }
        attribute beliefStatementAttributes : BeliefStatementAttribute [*];

        enum def BeliefStatementEnum :> BeliefStatementAttribute;
        enum beliefStatementEnums : BeliefStatementEnum [*];

        occurrence def BeliefStatementOccurrence :> MeasurableOccurrence {
            attribute duration : ISQ::DurationValue;
            ref basis : BasisAttribute, BasisOccurrence [0..*];

            ref uncertaintyTopic : UncertaintyTopicAttribute, UncertaintyTopicOccurrence [0..*];
            derived ref containedUncertainty : UncertainAttribute, UncertainOccurrence [0..*];
        }
        occurrence beliefStatementOccurrences : BeliefStatementOccurrence [*];

        item def BeliefStatementItem :> BeliefStatementOccurrence;
        item beliefStatementItems : BeliefStatementItem [*];

        part def BeliefStatementPart :> BeliefStatementItem;
        part beliefStatementParts : BeliefStatementPart [*];

        port def BeliefStatementPort :> BeliefStatementOccurrence;
        port beliefStatementPorts : BeliefStatementPort [*];

        action def BeliefStatementAction :> BeliefStatementOccurrence;
        action beliefStatementActions : BeliefStatementAction [*];

        state def BeliefStatementState :> BeliefStatementAction;
        state beliefStatementStates : BeliefStatementState [*];

        calc def BeliefStatementCalculation :> BeliefStatementAction;
        calc beliefStatementCalculations : BeliefStatementCalculation [*];

        analysis def BeliefStatementAnalysis :> BeliefStatementCalculation;
        analysis beliefStatementAnalyses : BeliefStatementAnalysis [*];

        constraint def BeliefStatementConstraint :> BeliefStatementOccurrence;
        constraint beliefStatementConstraints : BeliefStatementConstraint [*];

        requirement def BeliefStatementRequirement :> BeliefStatementConstraint;
        requirement beliefStatementRequirements : BeliefStatementRequirement [*];

        abstract connection def BeliefStatementConnection :> BeliefStatementPart;
        abstract connection beliefStatementConnections : BeliefStatementConnection [*];

        abstract interface def BeliefStatementInterface :> BeliefStatementConnection;
        abstract interface beliefStatementInterfaces : BeliefStatementInterface [*];

        abstract allocation def BeliefStatementAllocation :> BeliefStatementConnection;
        abstract allocation beliefStatementAllocations : BeliefStatementAllocation [*];

        rendering def BeliefStatementRendering :> BeliefStatementPart;
        rendering beliefStatementRenderings : BeliefStatementRendering [*];

        view def BeliefStatementView :> BeliefStatementPart;
        view beliefStatementViews : BeliefStatementView [*];

        abstract flow def BeliefStatementFlow :> BeliefStatementAction;
        abstract flow beliefStatementFlows : BeliefStatementFlow [*];

        case def BeliefStatementCase :> BeliefStatementCalculation;
        case beliefStatementCases : BeliefStatementCase [*];

        use case def BeliefStatementUseCase :> BeliefStatementCase;
        use case beliefStatementUseCases : BeliefStatementUseCase [*];

        verification def BeliefStatementVerificationCase :> BeliefStatementCase;
        verification beliefStatementVerificationCases : BeliefStatementVerificationCase [*];

        concern def BeliefStatementConcern :> BeliefStatementRequirement;
        concern beliefStatementConcerns : BeliefStatementConcern [*];

        viewpoint def BeliefStatementViewpoint :> BeliefStatementRequirement;
        viewpoint beliefStatementViewpoints : BeliefStatementViewpoint [*];

        attribute def IndeterminacySourceAttribute :> MeasurableAttribute {
            attribute nature : IndeterminacyNature;
            content : IndeterminacySpecification [1..*];
        }
        attribute indeterminacySourceAttributes : IndeterminacySourceAttribute [*];

        enum def IndeterminacySourceEnum :> IndeterminacySourceAttribute;
        enum indeterminacySourceEnums : IndeterminacySourceEnum [*];

        occurrence def IndeterminacySourceOccurrence :> MeasurableOccurrence {
            attribute nature : IndeterminacyNature;
            content : IndeterminacySpecification [1..*];
        }
        occurrence indeterminacySourceOccurrences : IndeterminacySourceOccurrence [*];

        item def IndeterminacySourceItem :> IndeterminacySourceOccurrence;
        item indeterminacySourceItems : IndeterminacySourceItem [*];

        part def IndeterminacySourcePart :> IndeterminacySourceItem;
        part indeterminacySourceParts : IndeterminacySourcePart [*];

        port def IndeterminacySourcePort :> IndeterminacySourceOccurrence;
        port indeterminacySourcePorts : IndeterminacySourcePort [*];

        action def IndeterminacySourceAction :> IndeterminacySourceOccurrence;
        action indeterminacySourceActions : IndeterminacySourceAction [*];

        state def IndeterminacySourceState :> IndeterminacySourceAction;
        state indeterminacySourceStates : IndeterminacySourceState [*];

        constraint def IndeterminacySourceConstraint :> IndeterminacySourceOccurrence;
        constraint indeterminacySourceConstraints : IndeterminacySourceConstraint [*];

        requirement def IndeterminacySourceRequirement :> IndeterminacySourceConstraint;
        requirement indeterminacySourceRequirements : IndeterminacySourceRequirement [*];

        abstract connection def IndeterminacySourceConnection :> IndeterminacySourcePart;
        abstract connection indeterminacySourceConnections : IndeterminacySourceConnection [*];

        abstract allocation def IndeterminacySourceAllocation :> IndeterminacySourceConnection;
        abstract allocation indeterminacySourceAllocations : IndeterminacySourceAllocation [*];

        abstract interface def IndeterminacySourceInterface :> IndeterminacySourceConnection;
        abstract interface indeterminacySourceInterfaces : IndeterminacySourceInterface [*];

        rendering def IndeterminacySourceRendering :> IndeterminacySourcePart;
        rendering indeterminacySourceRenderings : IndeterminacySourceRendering [*];

        view def IndeterminacySourceView :> IndeterminacySourcePart;
        view indeterminacySourceViews : IndeterminacySourceView [*];

        abstract flow def IndeterminacySourceFlow :> IndeterminacySourceAction;
        abstract flow indeterminacySourceFlows : IndeterminacySourceFlow [*];

        calc def IndeterminacySourceCalculation :> IndeterminacySourceAction;
        calc indeterminacySourceCalculations : IndeterminacySourceCalculation [*];

        case def IndeterminacySourceCase :> IndeterminacySourceCalculation;
        case indeterminacySourceCases : IndeterminacySourceCase [*];

        analysis def IndeterminacySourceAnalysis :> IndeterminacySourceCase;
        analysis indeterminacySourceAnalyses : IndeterminacySourceAnalysis [*];

        use case def IndeterminacySourceUseCase :> IndeterminacySourceCase;
        use case indeterminacySourceUseCases : IndeterminacySourceUseCase [*];

        verification def IndeterminacySourceVerificationCase :> IndeterminacySourceCase;
        verification indeterminacySourceVerificationCases : IndeterminacySourceVerificationCase [*];

        concern def IndeterminacySourceConcern :> IndeterminacySourceRequirement;
        concern indeterminacySourceConcerns : IndeterminacySourceConcern [*];

        viewpoint def IndeterminacySourceViewpoint :> IndeterminacySourceRequirement;
        viewpoint indeterminacySourceViewpoints : IndeterminacySourceViewpoint [*];

        constraint def IndeterminacySpecification :> BeliefStatementOccurrence;
        constraint indeterminacySpecifications : IndeterminacySpecification [*];

        attribute def PersonalExperienceAttribute :> BasisAttribute;
        attribute personalExperienceAttributes : PersonalExperienceAttribute [*];

        enum def PersonalExperienceEnum :> PersonalExperienceAttribute;
        enum personalExperienceEnums : PersonalExperienceEnum [*];

        occurrence def PersonalExperienceOccurrence :> BasisOccurrence;
        occurrence personalExperienceOccurrences : PersonalExperienceOccurrence [*];

        item def PersonalExperienceItem :> PersonalExperienceOccurrence;
        item personalExperienceItems : PersonalExperienceItem [*];

        part def PersonalExperiencePart :> PersonalExperienceItem;
        part personalExperienceParts : PersonalExperiencePart [*];

        port def PersonalExperiencePort :> PersonalExperienceOccurrence;
        port personalExperiencePorts : PersonalExperiencePort [*];

        action def PersonalExperienceAction :> PersonalExperienceOccurrence;
        action personalExperienceActions : PersonalExperienceAction [*];

        state def PersonalExperienceState :> PersonalExperienceAction;
        state personalExperienceStates : PersonalExperienceState [*];

        constraint def PersonalExperienceConstraint :> PersonalExperienceOccurrence;
        constraint personalExperienceConstraints : PersonalExperienceConstraint [*];

        requirement def PersonalExperienceRequirement :> PersonalExperienceConstraint;
        requirement personalExperienceRequirements : PersonalExperienceRequirement [*];

        abstract connection def PersonalExperienceConnection :> PersonalExperiencePart;
        abstract connection personalExperienceConnections : PersonalExperienceConnection [*];

        abstract allocation def PersonalExperienceAllocation :> PersonalExperienceConnection;
        abstract allocation personalExperienceAllocations : PersonalExperienceAllocation [*];

        abstract interface def PersonalExperienceInterface :> PersonalExperienceConnection;
        abstract interface personalExperienceInterfaces : PersonalExperienceInterface [*];

        rendering def PersonalExperienceRendering :> PersonalExperiencePart;
        rendering personalExperienceRenderings : PersonalExperienceRendering [*];

        view def PersonalExperienceView :> PersonalExperiencePart;
        view personalExperienceViews : PersonalExperienceView [*];

        abstract flow def PersonalExperienceFlow :> PersonalExperienceAction;
        abstract flow personalExperienceFlows : PersonalExperienceFlow [*];

        calc def PersonalExperienceCalculation :> PersonalExperienceAction;
        calc personalExperienceCalculations : PersonalExperienceCalculation [*];

        case def PersonalExperienceCase :> PersonalExperienceCalculation;
        case personalExperienceCases : PersonalExperienceCase [*];

        analysis def PersonalExperienceAnalysis :> PersonalExperienceCase;
        analysis personalExperienceAnalyses : PersonalExperienceAnalysis [*];

        use case def PersonalExperienceUseCase :> PersonalExperienceCase;
        use case personalExperienceUseCases : PersonalExperienceUseCase [*];

        verification def PersonalExperienceVerificationCase :> PersonalExperienceCase;
        verification personalExperienceVerificationCases : PersonalExperienceVerificationCase [*];

        concern def PersonalExperienceConcern :> PersonalExperienceRequirement;
        concern personalExperienceConcerns : PersonalExperienceConcern [*];

        viewpoint def PersonalExperienceViewpoint :> PersonalExperienceRequirement;
        viewpoint personalExperienceViewpoints : PersonalExperienceViewpoint [*];

        attribute def EvidenceAttribute :> BasisAttribute {
            attribute type : EvidenceType [1];
        }
        attribute evidenceAttributes : EvidenceAttribute [*];

        enum def EvidenceEnum :> EvidenceAttribute;
        enum evidenceEnums : EvidenceEnum [*];

        occurrence def EvidenceOccurrence :> BasisOccurrence {
            attribute type : EvidenceType [1];
        }
        occurrence evidenceOccurrences : EvidenceOccurrence [*];

        item def EvidenceItem :> EvidenceOccurrence;
        item evidenceItems : EvidenceItem [*];

        part def EvidencePart :> EvidenceItem;
        part evidenceParts : EvidencePart [*];

        port def EvidencePort :> EvidenceOccurrence;
        port evidencePorts : EvidencePort [*];

        action def EvidenceAction :> EvidenceOccurrence;
        action evidenceActions : EvidenceAction [*];

        state def EvidenceState :> EvidenceAction;
        state evidenceStates : EvidenceState [*];

        constraint def EvidenceConstraint :> EvidenceOccurrence;
        constraint evidenceConstraints : EvidenceConstraint [*];

        requirement def EvidenceRequirement :> EvidenceConstraint;
        requirement evidenceRequirements : EvidenceRequirement [*];

        abstract connection def EvidenceConnection :> EvidencePart;
        abstract connection evidenceConnections : EvidenceConnection [*];

        abstract allocation def EvidenceAllocation :> EvidenceConnection;
        abstract allocation evidenceAllocations : EvidenceAllocation [*];

        abstract interface def EvidenceInterface :> EvidenceConnection;
        abstract interface evidenceInterfaces : EvidenceInterface [*];

        rendering def EvidenceRendering :> EvidencePart;
        rendering evidenceRenderings : EvidenceRendering [*];

        view def EvidenceView :> EvidencePart;
        view evidenceViews : EvidenceView [*];

        abstract flow def EvidenceFlow :> EvidenceAction;
        abstract flow evidenceFlows : EvidenceFlow [*];

        calc def EvidenceCalculation :> EvidenceAction;
        calc evidenceCalculations : EvidenceCalculation [*];

        case def EvidenceCase :> EvidenceCalculation;
        case evidenceCases : EvidenceCase [*];

        analysis def EvidenceAnalysis :> EvidenceCase;
        analysis evidenceAnalyses : EvidenceAnalysis [*];

        use case def EvidenceUseCase :> EvidenceCase;
        use case evidenceUseCases : EvidenceUseCase [*];

        verification def EvidenceVerificationCase :> EvidenceCase;
        verification evidenceVerificationCases : EvidenceVerificationCase [*];

        concern def EvidenceConcern :> EvidenceRequirement;
        concern evidenceConcerns : EvidenceConcern [*];

        viewpoint def EvidenceViewpoint :> EvidenceRequirement;
        viewpoint evidenceViewpoints : EvidenceViewpoint [*];

        enum def IndeterminacyNature {
            InsufficientResolution;
            MissingInfo;
            NonDeterminism;
            Unclassified;
            Custom;
        }

        enum def EvidenceType {
            EmpiricalEvidence;
            TheoremProvingResults;
            InferenceBasedOnEmpiricalData;
            CommonKnowledge;
        }
    }

    package Uncertainty {
        abstract attribute def UncertaintyCharacteristicAttribute :> PSUMAttribute;

        abstract occurrence def UncertaintyCharacteristicOccurrence :> PSUMOccurrence;

        attribute def UncertainAttribute :> MeasurableAttribute {
            attribute kind : UncertaintyKind [0..1];
            attribute nature : UncertaintyNature [0..1];
            attribute reducibility : ReducibilityLevel [0..1];

            uncertaintyCharacteristic : UncertaintyCharacteristicAttribute, UncertaintyCharacteristicOccurrence [0..*];
            ref beliefStatement : BeliefStatementAttribute, BeliefStatementOccurrence [1..*];
            ref uncertaintyTopic : UncertaintyTopicAttribute, UncertaintyTopicOccurrence [1];
            ref sources : IndeterminacySourceAttribute, IndeterminacySourceOccurrence [0..*];
            ref indeterminacySpecifications : IndeterminacySpecification [0..*];
        }
        attribute uncertainAttributes : UncertainAttribute [*];

        enum def UncertainEnum :> UncertainAttribute;
        enum uncertainEnums : UncertainEnum [*];

        occurrence def UncertainOccurrence :> MeasurableOccurrence {
            attribute kind : UncertaintyKind [0..1];
            attribute nature : UncertaintyNature [0..1];
            attribute reducibility : ReducibilityLevel [0..1];

            uncertaintyCharacteristic : UncertaintyCharacteristicAttribute, UncertaintyCharacteristicOccurrence [0..*];
            ref beliefStatement : BeliefStatementAttribute, BeliefStatementOccurrence [1..*];
            ref uncertaintyTopic : UncertaintyTopicAttribute, UncertaintyTopicOccurrence [1];
            ref sources : IndeterminacySourceAttribute, IndeterminacySourceOccurrence [0..*];
            ref indeterminacySpecifications : IndeterminacySpecification [0..*];
        }
        occurrence uncertainOccurrences : UncertainOccurrence [*];

        item def UncertainItem :> UncertainOccurrence;
        item uncertainItems : UncertainItem [*];

        part def UncertainPart :> UncertainItem;
        part uncertainParts : UncertainPart [*];

        port def UncertainPort :> UncertainOccurrence;
        port uncertainPorts : UncertainPort [*];

        action def UncertainAction :> UncertainOccurrence;
        action uncertainActions : UncertainAction [*];

        state def UncertainState :> UncertainAction;
        state uncertainStates : UncertainState [*];

        calc def UncertainCalculation :> UncertainAction;
        calc uncertainCalculations : UncertainCalculation [*];

        analysis def UncertainAnalysis :> UncertainCalculation;
        analysis uncertainAnalyses : UncertainAnalysis [*];

        constraint def UncertainConstraint :> UncertainOccurrence;
        constraint uncertainConstraints : UncertainConstraint [*];

        requirement def UncertainRequirement :> UncertainConstraint;
        requirement uncertainRequirements : UncertainRequirement [*];

        abstract connection def UncertainConnection :> UncertainPart;
        abstract connection uncertainConnections : UncertainConnection [*];

        abstract interface def UncertainInterface :> UncertainConnection;
        abstract interface uncertainInterfaces : UncertainInterface [*];

        abstract allocation def UncertainAllocation :> UncertainConnection;
        abstract allocation uncertainAllocations : UncertainAllocation [*];

        rendering def UncertainRendering :> UncertainPart;
        rendering uncertainRenderings : UncertainRendering [*];

        view def UncertainView :> UncertainPart;
        view uncertainViews : UncertainView [*];

        abstract flow def UncertainFlow :> UncertainAction;
        abstract flow uncertainFlows : UncertainFlow [*];

        case def UncertainCase :> UncertainCalculation;
        case uncertainCases : UncertainCase [*];

        use case def UncertainUseCase :> UncertainCase;
        use case uncertainUseCases : UncertainUseCase [*];

        verification def UncertainVerificationCase :> UncertainCase;
        verification uncertainVerificationCases : UncertainVerificationCase [*];

        concern def UncertainConcern :> UncertainRequirement;
        concern uncertainConcerns : UncertainConcern [*];

        viewpoint def UncertainViewpoint :> UncertainRequirement;
        viewpoint uncertainViewpoints : UncertainViewpoint [*];

        attribute def UncertaintyPerspectiveAttribute :> UncertaintyCharacteristicAttribute {
            attribute perspectiveType : UncertaintyPerspectiveType;
        }
        attribute uncertaintyPerspectiveAttributes : UncertaintyPerspectiveAttribute [*];

        enum def UncertaintyPerspectiveEnum :> UncertaintyPerspectiveAttribute;
        enum uncertaintyPerspectiveEnums : UncertaintyPerspectiveEnum [*];

        occurrence def UncertaintyPerspectiveOccurrence :> UncertaintyCharacteristicOccurrence {
            attribute perspectiveType : UncertaintyPerspectiveType;
        }
        occurrence uncertaintyPerspectiveOccurrences : UncertaintyPerspectiveOccurrence [*];

        item def UncertaintyPerspectiveItem :> UncertaintyPerspectiveOccurrence;
        item uncertaintyPerspectiveItems : UncertaintyPerspectiveItem [*];

        part def UncertaintyPerspectivePart :> UncertaintyPerspectiveItem;
        part uncertaintyPerspectiveParts : UncertaintyPerspectivePart [*];

        action def UncertaintyPerspectiveAction :> UncertaintyPerspectiveOccurrence;
        action uncertaintyPerspectiveActions : UncertaintyPerspectiveAction [*];

        state def UncertaintyPerspectiveState :> UncertaintyPerspectiveAction;
        state uncertaintyPerspectiveStates : UncertaintyPerspectiveState [*];

        port def UncertaintyPerspectivePort :> UncertaintyPerspectiveOccurrence;
        port uncertaintyPerspectivePorts : UncertaintyPerspectivePort [*];

        abstract connection def UncertaintyPerspectiveConnection :> UncertaintyPerspectivePart;
        abstract connection uncertaintyPerspectiveConnections : UncertaintyPerspectiveConnection [*];

        abstract allocation def UncertaintyPerspectiveAllocation :> UncertaintyPerspectiveConnection;
        abstract allocation uncertaintyPerspectiveAllocations : UncertaintyPerspectiveAllocation [*];

        abstract interface def UncertaintyPerspectiveInterface :> UncertaintyPerspectiveConnection;
        abstract interface uncertaintyPerspectiveInterfaces : UncertaintyPerspectiveInterface [*];

        rendering def UncertaintyPerspectiveRendering :> UncertaintyPerspectivePart;
        rendering uncertaintyPerspectiveRenderings : UncertaintyPerspectiveRendering [*];

        view def UncertaintyPerspectiveView :> UncertaintyPerspectivePart;
        view uncertaintyPerspectiveViews : UncertaintyPerspectiveView [*];

        abstract flow def UncertaintyPerspectiveFlow :> UncertaintyPerspectiveAction;
        abstract flow uncertaintyPerspectiveFlows : UncertaintyPerspectiveFlow [*];

        calc def UncertaintyPerspectiveCalculation :> UncertaintyPerspectiveAction;
        calc uncertaintyPerspectiveCalculations : UncertaintyPerspectiveCalculation [*];

        case def UncertaintyPerspectiveCase :> UncertaintyPerspectiveCalculation;
        case uncertaintyPerspectiveCases : UncertaintyPerspectiveCase [*];

        analysis def UncertaintyPerspectiveAnalysis :> UncertaintyPerspectiveCase;
        analysis uncertaintyPerspectiveAnalyses : UncertaintyPerspectiveAnalysis [*];

        use case def UncertaintyPerspectiveUseCase :> UncertaintyPerspectiveCase;
        use case uncertaintyPerspectiveUseCases : UncertaintyPerspectiveUseCase [*];

        verification def UncertaintyPerspectiveVerificationCase :> UncertaintyPerspectiveCase;
        verification uncertaintyPerspectiveVerificationCases : UncertaintyPerspectiveVerificationCase [*];

        constraint def UncertaintyPerspectiveConstraint :> UncertaintyPerspectiveOccurrence;
        constraint uncertaintyPerspectiveConstraints : UncertaintyPerspectiveConstraint [*];

        requirement def UncertaintyPerspectiveRequirement :> UncertaintyPerspectiveConstraint;
        requirement uncertaintyPerspectiveRequirements : UncertaintyPerspectiveRequirement [*];

        concern def UncertaintyPerspectiveConcern :> UncertaintyPerspectiveRequirement;
        concern uncertaintyPerspectiveConcerns : UncertaintyPerspectiveConcern [*];

        viewpoint def UncertaintyPerspectiveViewpoint :> UncertaintyPerspectiveRequirement;
        viewpoint uncertaintyPerspectiveViewpoints : UncertaintyPerspectiveViewpoint [*];

        attribute def PatternAttribute :> UncertaintyCharacteristicAttribute {
            attribute patternType : PatternType [1];
        }
        attribute patternAttributes : PatternAttribute [*];

        enum def PatternEnum :> PatternAttribute;
        enum patternEnums : PatternEnum [*];

        occurrence def PatternOccurrence :> UncertaintyCharacteristicOccurrence {
            attribute patternType : PatternType [1];
        }
        occurrence patternOccurrences : PatternOccurrence [*];

        item def PatternItem :> PatternOccurrence;
        item patternItems : PatternItem [*];

        part def PatternPart :> PatternItem;
        part patternParts : PatternPart [*];

        action def PatternAction :> PatternOccurrence;
        action patternActions : PatternAction [*];

        state def PatternState :> PatternAction;
        state patternStates : PatternState [*];

        port def PatternPort :> PatternOccurrence;
        port patternPorts : PatternPort [*];

        abstract connection def PatternConnection :> PatternPart;
        abstract connection patternConnections : PatternConnection [*];

        abstract allocation def PatternAllocation :> PatternConnection;
        abstract allocation patternAllocations : PatternAllocation [*];

        abstract interface def PatternInterface :> PatternConnection;
        abstract interface patternInterfaces : PatternInterface [*];

        rendering def PatternRendering :> PatternPart;
        rendering patternRenderings : PatternRendering [*];

        view def PatternView :> PatternPart;
        view patternViews : PatternView [*];

        abstract flow def PatternFlow :> PatternAction;
        abstract flow patternFlows : PatternFlow [*];

        calc def PatternCalculation :> PatternAction;
        calc patternCalculations : PatternCalculation [*];

        case def PatternCase :> PatternCalculation;
        case patternCases : PatternCase [*];

        analysis def PatternAnalysis :> PatternCase;
        analysis patternAnalyses : PatternAnalysis [*];

        use case def PatternUseCase :> PatternCase;
        use case patternUseCases : PatternUseCase [*];

        verification def PatternVerificationCase :> PatternCase;
        verification patternVerificationCases : PatternVerificationCase [*];

        constraint def PatternConstraint :> PatternOccurrence;
        constraint patternConstraints : PatternConstraint [*];

        requirement def PatternRequirement :> PatternConstraint;
        requirement patternRequirements : PatternRequirement [*];

        concern def PatternConcern :> PatternRequirement;
        concern patternConcerns : PatternConcern [*];

        viewpoint def PatternViewpoint :> PatternRequirement;
        viewpoint patternViewpoints : PatternViewpoint [*];

        attribute def EffectAttribute :> UncertainAttribute, UncertaintyCharacteristicAttribute {
            ref origin : UncertainAttribute, UncertainOccurrence [1];
        }
        attribute effectAttributes : EffectAttribute [*];

        enum def EffectEnum :> EffectAttribute;
        enum effectEnums : EffectEnum [*];

        occurrence def EffectOccurrence :> UncertainOccurrence, UncertaintyCharacteristicOccurrence {
            ref origin : UncertainAttribute, UncertainOccurrence [1];
        }
        occurrence effectOccurrences : EffectOccurrence [*];

        item def EffectItem :> UncertainItem, EffectOccurrence;
        item effectItems : EffectItem [*];

        part def EffectPart :> UncertainPart, EffectItem;
        part effectParts : EffectPart [*];

        port def EffectPort :> UncertainPort, EffectOccurrence;
        port effectPorts : EffectPort [*];

        action def EffectAction :> UncertainAction, EffectOccurrence;
        action effectActions : EffectAction [*];

        state def EffectState :> UncertainState, EffectAction;
        state effectStates : EffectState [*];

        calc def EffectCalculation :> UncertainCalculation, EffectAction;
        calc effectCalculations : EffectCalculation [*];

        analysis def EffectAnalysis :> UncertainAnalysis, EffectCalculation;
        analysis effectAnalyses : EffectAnalysis [*];

        constraint def EffectConstraint :> UncertainConstraint, EffectOccurrence;
        constraint effectConstraints : EffectConstraint [*];

        requirement def EffectRequirement :> UncertainRequirement, EffectConstraint;
        requirement effectRequirements : EffectRequirement [*];

        abstract connection def EffectConnection :> UncertainConnection, EffectPart;
        abstract connection effectConnections : EffectConnection [*];

        abstract allocation def EffectAllocation :> UncertainAllocation, EffectConnection;
        abstract allocation effectAllocations : EffectAllocation [*];

        abstract interface def EffectInterface :> UncertainInterface, EffectConnection;
        abstract interface effectInterfaces : EffectInterface [*];

        rendering def EffectRendering :> UncertainRendering, EffectPart;
        rendering effectRenderings : EffectRendering [*];

        view def EffectView :> UncertainView, EffectPart;
        view effectViews : EffectView [*];

        abstract flow def EffectFlow :> UncertainFlow, EffectAction;
        abstract flow effectFlows : EffectFlow [*];

        case def EffectCase :> UncertainCase, EffectCalculation;
        case effectCases : EffectCase [*];

        use case def EffectUseCase :> UncertainUseCase, EffectCase;
        use case effectUseCases : EffectUseCase [*];

        verification def EffectVerificationCase :> UncertainVerificationCase, EffectCase;
        verification effectVerificationCases : EffectVerificationCase [*];

        concern def EffectConcern :> UncertainConcern, EffectRequirement;
        concern effectConcerns : EffectConcern [*];

        viewpoint def EffectViewpoint :> UncertainViewpoint, EffectRequirement;
        viewpoint effectViewpoints : EffectViewpoint [*];

        attribute def UncertaintyTopicAttribute :> PSUMAttribute {
            ref beliefStatement : BeliefStatementAttribute, BeliefStatementOccurrence [1..*];
            ref associatedUncertainty : UncertainAttribute, UncertainOccurrence [1..*];
        }
        attribute uncertaintyTopicAttributes : UncertaintyTopicAttribute [*];

        enum def UncertaintyTopicEnum :> UncertaintyTopicAttribute;
        enum uncertaintyTopicEnums : UncertaintyTopicEnum [*];

        occurrence def UncertaintyTopicOccurrence :> PSUMOccurrence {
            ref beliefStatement : BeliefStatementAttribute, BeliefStatementOccurrence [1..*];
            ref associatedUncertainty : UncertainAttribute, UncertainOccurrence [1..*];
        }
        occurrence uncertaintyTopicOccurrences : UncertaintyTopicOccurrence [*];

        item def UncertaintyTopicItem :> UncertaintyTopicOccurrence;
        item uncertaintyTopicItems : UncertaintyTopicItem [*];

        part def UncertaintyTopicPart :> UncertaintyTopicItem;
        part uncertaintyTopicParts : UncertaintyTopicPart [*];

        port def UncertaintyTopicPort :> UncertaintyTopicOccurrence;
        port uncertaintyTopicPorts : UncertaintyTopicPort [*];

        action def UncertaintyTopicAction :> UncertaintyTopicOccurrence;
        action uncertaintyTopicActions : UncertaintyTopicAction [*];

        state def UncertaintyTopicState :> UncertaintyTopicAction;
        state uncertaintyTopicStates : UncertaintyTopicState [*];

        constraint def UncertaintyTopicConstraint :> UncertaintyTopicOccurrence;
        constraint uncertaintyTopicConstraints : UncertaintyTopicConstraint [*];

        requirement def UncertaintyTopicRequirement :> UncertaintyTopicConstraint;
        requirement uncertaintyTopicRequirements : UncertaintyTopicRequirement [*];

        abstract connection def UncertaintyTopicConnection :> UncertaintyTopicPart;
        abstract connection uncertaintyTopicConnections : UncertaintyTopicConnection [*];

        abstract allocation def UncertaintyTopicAllocation :> UncertaintyTopicConnection;
        abstract allocation uncertaintyTopicAllocations : UncertaintyTopicAllocation [*];

        abstract interface def UncertaintyTopicInterface :> UncertaintyTopicConnection;
        abstract interface uncertaintyTopicInterfaces : UncertaintyTopicInterface [*];

        rendering def UncertaintyTopicRendering :> UncertaintyTopicPart;
        rendering uncertaintyTopicRenderings : UncertaintyTopicRendering [*];

        view def UncertaintyTopicView :> UncertaintyTopicPart;
        view uncertaintyTopicViews : UncertaintyTopicView [*];

        abstract flow def UncertaintyTopicFlow :> UncertaintyTopicAction;
        abstract flow uncertaintyTopicFlows : UncertaintyTopicFlow [*];

        calc def UncertaintyTopicCalculation :> UncertaintyTopicAction;
        calc uncertaintyTopicCalculations : UncertaintyTopicCalculation [*];

        case def UncertaintyTopicCase :> UncertaintyTopicCalculation;
        case uncertaintyTopicCases : UncertaintyTopicCase [*];

        analysis def UncertaintyTopicAnalysis :> UncertaintyTopicCase;
        analysis uncertaintyTopicAnalyses : UncertaintyTopicAnalysis [*];

        use case def UncertaintyTopicUseCase :> UncertaintyTopicCase;
        use case uncertaintyTopicUseCases : UncertaintyTopicUseCase [*];

        verification def UncertaintyTopicVerificationCase :> UncertaintyTopicCase;
        verification uncertaintyTopicVerificationCases : UncertaintyTopicVerificationCase [*];

        concern def UncertaintyTopicConcern :> UncertaintyTopicRequirement;
        concern uncertaintyTopicConcerns : UncertaintyTopicConcern [*];

        viewpoint def UncertaintyTopicViewpoint :> UncertaintyTopicRequirement;
        viewpoint uncertaintyTopicViewpoints : UncertaintyTopicViewpoint [*];

        enum def UncertaintyKind {
            OccurrenceUncertainty;
            ContentUncertainty;
            TimeUncertainty;
            LocationUncertainty;
            EnvironmentUncertainty;
        }

        enum def UncertaintyNature {
            Aleatory;
            Epistemic;
        }

        enum def ReducibilityLevel {
            FullyReducible;
            PartiallyReducible;
            Irreducible;
        }

        enum def UncertaintyPerspectiveType {
            Subjective;
            Objective;
        }

        enum def PatternType {
            Periodic;
            Persistent;
            Sporadic;
            Transient;
            Random;
        }
    }

    package Measurement {
        abstract attribute def MeasurableAttribute :> PSUMAttribute {
            measurableFeature : MeasurableFeatureAttribute, MeasurableFeatureOccurrence [0..*];
        }

        abstract occurrence def MeasurableOccurrence :> PSUMOccurrence {
            measurableFeature : MeasurableFeatureAttribute, MeasurableFeatureOccurrence [0..*];
        }

        abstract attribute def MeasurableFeatureAttribute :> MeasurableAttribute {
            ref measurableElement : MeasurableAttribute, MeasurableOccurrence [1];
            ref measurement : KerML::Expression [0..*];
        }

        abstract occurrence def MeasurableFeatureOccurrence :> MeasurableOccurrence {
            ref measurableElement : MeasurableAttribute, MeasurableOccurrence [1];
            ref measurement : KerML::Expression [0..*];
        }

        attribute def AccuracyAttribute :> MeasurableFeatureAttribute;
        attribute accuracyAttributes : AccuracyAttribute [*];

        occurrence def AccuracyOccurrence :> MeasurableFeatureOccurrence;
        occurrence accuracyOccurrences : AccuracyOccurrence [*];

        enum def AccuracyEnum :> AccuracyAttribute;
        enum accuracyEnums : AccuracyEnum [*];

        item def AccuracyItem :> AccuracyOccurrence;
        item accuracyItems : AccuracyItem [*];

        part def AccuracyPart :> AccuracyItem;
        part accuracyParts : AccuracyPart [*];

        abstract connection def AccuracyConnection :> AccuracyPart;
        abstract connection accuracyConnections : AccuracyConnection [*];

        abstract allocation def AccuracyAllocation :> AccuracyConnection;
        abstract allocation accuracyAllocations : AccuracyAllocation [*];

        abstract interface def AccuracyInterface :> AccuracyConnection;
        abstract interface accuracyInterfaces : AccuracyInterface [*];

        rendering def AccuracyRendering :> AccuracyPart;
        rendering accuracyRenderings : AccuracyRendering [*];

        view def AccuracyView :> AccuracyPart;
        view accuracyViews : AccuracyView [*];

        port def AccuracyPort :> AccuracyOccurrence;
        port accuracyPorts : AccuracyPort [*];

        action def AccuracyAction :> AccuracyOccurrence;
        action accuracyActions : AccuracyAction [*];

        abstract flow def AccuracyFlow :> AccuracyAction;
        abstract flow accuracyFlows : AccuracyFlow [*];

        calc def AccuracyCalculation :> AccuracyAction;
        calc accuracyCalculations : AccuracyCalculation [*];

        case def AccuracyCase :> AccuracyCalculation;
        case accuracyCases : AccuracyCase [*];

        analysis def AccuracyAnalysis :> AccuracyCase;
        analysis accuracyAnalyses : AccuracyAnalysis [*];

        use case def AccuracyUseCase :> AccuracyCase;
        use case accuracyUseCases : AccuracyUseCase [*];

        verification def AccuracyVerificationCase :> AccuracyCase;
        verification accuracyVerificationCases : AccuracyVerificationCase [*];

        state def AccuracyState :> AccuracyAction;
        state accuracyStates : AccuracyState [*];

        constraint def AccuracyConstraint :> AccuracyOccurrence;
        constraint accuracyConstraints : AccuracyConstraint [*];

        requirement def AccuracyRequirement :> AccuracyConstraint;
        requirement accuracyRequirements : AccuracyRequirement [*];

        concern def AccuracyConcern :> AccuracyRequirement;
        concern accuracyConcerns : AccuracyConcern [*];

        viewpoint def AccuracyViewpoint :> AccuracyRequirement;
        viewpoint accuracyViewpoints : AccuracyViewpoint [*];

        attribute def SensitivityAttribute :> MeasurableFeatureAttribute;
        attribute sensitivityAttributes : SensitivityAttribute [*];

        occurrence def SensitivityOccurrence :> MeasurableFeatureOccurrence;
        occurrence sensitivityOccurrences : SensitivityOccurrence [*];

        enum def SensitivityEnum :> SensitivityAttribute;
        enum sensitivityEnums : SensitivityEnum [*];

        item def SensitivityItem :> SensitivityOccurrence;
        item sensitivityItems : SensitivityItem [*];

        part def SensitivityPart :> SensitivityItem;
        part sensitivityParts : SensitivityPart [*];

        abstract connection def SensitivityConnection :> SensitivityPart;
        abstract connection sensitivityConnections : SensitivityConnection [*];

        abstract allocation def SensitivityAllocation :> SensitivityConnection;
        abstract allocation sensitivityAllocations : SensitivityAllocation [*];

        abstract interface def SensitivityInterface :> SensitivityConnection;
        abstract interface sensitivityInterfaces : SensitivityInterface [*];

        rendering def SensitivityRendering :> SensitivityPart;
        rendering sensitivityRenderings : SensitivityRendering [*];

        view def SensitivityView :> SensitivityPart;
        view sensitivityViews : SensitivityView [*];

        port def SensitivityPort :> SensitivityOccurrence;
        port sensitivityPorts : SensitivityPort [*];

        action def SensitivityAction :> SensitivityOccurrence;
        action sensitivityActions : SensitivityAction [*];

        abstract flow def SensitivityFlow :> SensitivityAction;
        abstract flow sensitivityFlows : SensitivityFlow [*];

        calc def SensitivityCalculation :> SensitivityAction;
        calc sensitivityCalculations : SensitivityCalculation [*];

        case def SensitivityCase :> SensitivityCalculation;
        case sensitivityCases : SensitivityCase [*];

        analysis def SensitivityAnalysis :> SensitivityCase;
        analysis sensitivityAnalyses : SensitivityAnalysis [*];

        use case def SensitivityUseCase :> SensitivityCase;
        use case sensitivityUseCases : SensitivityUseCase [*];

        verification def SensitivityVerificationCase :> SensitivityCase;
        verification sensitivityVerificationCases : SensitivityVerificationCase [*];

        state def SensitivityState :> SensitivityAction;
        state sensitivityStates : SensitivityState [*];

        constraint def SensitivityConstraint :> SensitivityOccurrence;
        constraint sensitivityConstraints : SensitivityConstraint [*];

        requirement def SensitivityRequirement :> SensitivityConstraint;
        requirement sensitivityRequirements : SensitivityRequirement [*];

        concern def SensitivityConcern :> SensitivityRequirement;
        concern sensitivityConcerns : SensitivityConcern [*];

        viewpoint def SensitivityViewpoint :> SensitivityRequirement;
        viewpoint sensitivityViewpoints : SensitivityViewpoint [*];

        attribute def MeasurementErrorAttribute :> MeasurableFeatureAttribute;
        attribute measurementErrorAttributes : MeasurementErrorAttribute [*];

        occurrence def MeasurementErrorOccurrence :> MeasurableFeatureOccurrence;
        occurrence measurementErrorOccurrences : MeasurementErrorOccurrence [*];

        enum def MeasurementErrorEnum :> MeasurementErrorAttribute;
        enum measurementErrorEnums : MeasurementErrorEnum [*];

        item def MeasurementErrorItem :> MeasurementErrorOccurrence;
        item measurementErrorItems : MeasurementErrorItem [*];

        part def MeasurementErrorPart :> MeasurementErrorItem;
        part measurementErrorParts : MeasurementErrorPart [*];

        abstract connection def MeasurementErrorConnection :> MeasurementErrorPart;
        abstract connection measurementErrorConnections : MeasurementErrorConnection [*];

        abstract allocation def MeasurementErrorAllocation :> MeasurementErrorConnection;
        abstract allocation measurementErrorAllocations : MeasurementErrorAllocation [*];

        abstract interface def MeasurementErrorInterface :> MeasurementErrorConnection;
        abstract interface measurementErrorInterfaces : MeasurementErrorInterface [*];

        rendering def MeasurementErrorRendering :> MeasurementErrorPart;
        rendering measurementErrorRenderings : MeasurementErrorRendering [*];

        view def MeasurementErrorView :> MeasurementErrorPart;
        view measurementErrorViews : MeasurementErrorView [*];

        port def MeasurementErrorPort :> MeasurementErrorOccurrence;
        port measurementErrorPorts : MeasurementErrorPort [*];

        action def MeasurementErrorAction :> MeasurementErrorOccurrence;
        action measurementErrorActions : MeasurementErrorAction [*];

        abstract flow def MeasurementErrorFlow :> MeasurementErrorAction;
        abstract flow measurementErrorFlows : MeasurementErrorFlow [*];

        calc def MeasurementErrorCalculation :> MeasurementErrorAction;
        calc measurementErrorCalculations : MeasurementErrorCalculation [*];

        case def MeasurementErrorCase :> MeasurementErrorCalculation;
        case measurementErrorCases : MeasurementErrorCase [*];

        analysis def MeasurementErrorAnalysis :> MeasurementErrorCase;
        analysis measurementErrorAnalyses : MeasurementErrorAnalysis [*];

        use case def MeasurementErrorUseCase :> MeasurementErrorCase;
        use case measurementErrorUseCases : MeasurementErrorUseCase [*];

        verification def MeasurementErrorVerificationCase :> MeasurementErrorCase;
        verification measurementErrorVerificationCases : MeasurementErrorVerificationCase [*];

        state def MeasurementErrorState :> MeasurementErrorAction;
        state measurementErrorStates : MeasurementErrorState [*];

        constraint def MeasurementErrorConstraint :> MeasurementErrorOccurrence;
        constraint measurementErrorConstraints : MeasurementErrorConstraint [*];

        requirement def MeasurementErrorRequirement :> MeasurementErrorConstraint;
        requirement measurementErrorRequirements : MeasurementErrorRequirement [*];

        concern def MeasurementErrorConcern :> MeasurementErrorRequirement;
        concern measurementErrorConcerns : MeasurementErrorConcern [*];

        viewpoint def MeasurementErrorViewpoint :> MeasurementErrorRequirement;
        viewpoint measurementErrorViewpoints : MeasurementErrorViewpoint [*];

        attribute def PrecisionAttribute :> MeasurableFeatureAttribute;
        attribute precisionAttributes : PrecisionAttribute [*];

        occurrence def PrecisionOccurrence :> MeasurableFeatureOccurrence;
        occurrence precisionOccurrences : PrecisionOccurrence [*];

        enum def PrecisionEnum :> PrecisionAttribute;
        enum precisionEnums : PrecisionEnum [*];

        item def PrecisionItem :> PrecisionOccurrence;
        item precisionItems : PrecisionItem [*];

        part def PrecisionPart :> PrecisionItem;
        part precisionParts : PrecisionPart [*];

        abstract connection def PrecisionConnection :> PrecisionPart;
        abstract connection precisionConnections : PrecisionConnection [*];

        abstract allocation def PrecisionAllocation :> PrecisionConnection;
        abstract allocation precisionAllocations : PrecisionAllocation [*];

        abstract interface def PrecisionInterface :> PrecisionConnection;
        abstract interface precisionInterfaces : PrecisionInterface [*];

        rendering def PrecisionRendering :> PrecisionPart;
        rendering precisionRenderings : PrecisionRendering [*];

        view def PrecisionView :> PrecisionPart;
        view precisionViews : PrecisionView [*];

        port def PrecisionPort :> PrecisionOccurrence;
        port precisionPorts : PrecisionPort [*];

        action def PrecisionAction :> PrecisionOccurrence;
        action precisionActions : PrecisionAction [*];

        abstract flow def PrecisionFlow :> PrecisionAction;
        abstract flow precisionFlows : PrecisionFlow [*];

        calc def PrecisionCalculation :> PrecisionAction;
        calc precisionCalculations : PrecisionCalculation [*];

        case def PrecisionCase :> PrecisionCalculation;
        case precisionCases : PrecisionCase [*];

        analysis def PrecisionAnalysis :> PrecisionCase;
        analysis precisionAnalyses : PrecisionAnalysis [*];

        use case def PrecisionUseCase :> PrecisionCase;
        use case precisionUseCases : PrecisionUseCase [*];

        verification def PrecisionVerificationCase :> PrecisionCase;
        verification precisionVerificationCases : PrecisionVerificationCase [*];

        state def PrecisionState :> PrecisionAction;
        state precisionStates : PrecisionState [*];

        constraint def PrecisionConstraint :> PrecisionOccurrence;
        constraint precisionConstraints : PrecisionConstraint [*];

        requirement def PrecisionRequirement :> PrecisionConstraint;
        requirement precisionRequirements : PrecisionRequirement [*];

        concern def PrecisionConcern :> PrecisionRequirement;
        concern precisionConcerns : PrecisionConcern [*];

        viewpoint def PrecisionViewpoint :> PrecisionRequirement;
        viewpoint precisionViewpoints : PrecisionViewpoint [*];

        attribute def DegreeAttribute :> MeasurableFeatureAttribute;
        attribute degreeAttributes : DegreeAttribute [*];

        occurrence def DegreeOccurrence :> MeasurableFeatureOccurrence;
        occurrence degreeOccurrences : DegreeOccurrence [*];

        enum def DegreeEnum :> DegreeAttribute;
        enum degreeEnums : DegreeEnum [*];

        item def DegreeItem :> DegreeOccurrence;
        item degreeItems : DegreeItem [*];

        part def DegreePart :> DegreeItem;
        part degreeParts : DegreePart [*];

        abstract connection def DegreeConnection :> DegreePart;
        abstract connection degreeConnections : DegreeConnection [*];

        abstract allocation def DegreeAllocation :> DegreeConnection;
        abstract allocation degreeAllocations : DegreeAllocation [*];

        abstract interface def DegreeInterface :> DegreeConnection;
        abstract interface degreeInterfaces : DegreeInterface [*];

        rendering def DegreeRendering :> DegreePart;
        rendering degreeRenderings : DegreeRendering [*];

        view def DegreeView :> DegreePart;
        view degreeViews : DegreeView [*];

        port def DegreePort :> DegreeOccurrence;
        port degreePorts : DegreePort [*];

        action def DegreeAction :> DegreeOccurrence;
        action degreeActions : DegreeAction [*];

        abstract flow def DegreeFlow :> DegreeAction;
        abstract flow degreeFlows : DegreeFlow [*];

        calc def DegreeCalculation :> DegreeAction;
        calc degreeCalculations : DegreeCalculation [*];

        case def DegreeCase :> DegreeCalculation;
        case degreeCases : DegreeCase [*];

        analysis def DegreeAnalysis :> DegreeCase;
        analysis degreeAnalyses : DegreeAnalysis [*];

        use case def DegreeUseCase :> DegreeCase;
        use case degreeUseCases : DegreeUseCase [*];

        verification def DegreeVerificationCase :> DegreeCase;
        verification degreeVerificationCases : DegreeVerificationCase [*];

        state def DegreeState :> DegreeAction;
        state degreeStates : DegreeState [*];

        constraint def DegreeConstraint :> DegreeOccurrence;
        constraint degreeConstraints : DegreeConstraint [*];

        requirement def DegreeRequirement :> DegreeConstraint;
        requirement degreeRequirements : DegreeRequirement [*];

        concern def DegreeConcern :> DegreeRequirement;
        concern degreeConcerns : DegreeConcern [*];

        viewpoint def DegreeViewpoint :> DegreeRequirement;
        viewpoint degreeViewpoints : DegreeViewpoint [*];
    }
}

library package 'PSUM-SysMLv2-TypeSpecific-Metadata' {
    private import 'PSUM-SysMLv2-TypeSpecific'::*;
    private import Metaobjects::SemanticMetadata;

    public import Belief::*;
    public import Uncertainty::*;
    public import Measurement::*;

    package Belief {
        metadata def <beliefStmtAttribute> beliefStatementAttribute :> SemanticMetadata {
            :>> baseType = beliefStatementAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <beliefStmtEnum> beliefStatementEnum :> SemanticMetadata {
            :>> baseType = beliefStatementEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <beliefStmtOccurrence> beliefStatementOccurrence :> SemanticMetadata {
            :>> baseType = beliefStatementOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <beliefStmtItem> beliefStatementItem :> SemanticMetadata {
            :>> baseType = beliefStatementItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <beliefStmtPart> beliefStatementPart :> SemanticMetadata {
            :>> baseType = beliefStatementParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <beliefStmtPort> beliefStatementPort :> SemanticMetadata {
            :>> baseType = beliefStatementPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <beliefStmtAction> beliefStatementAction :> SemanticMetadata {
            :>> baseType = beliefStatementActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <beliefStmtState> beliefStatementState :> SemanticMetadata {
            :>> baseType = beliefStatementStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <beliefStmtCalculation> beliefStatementCalculation :> SemanticMetadata {
            :>> baseType = beliefStatementCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <beliefStmtAnalysis> beliefStatementAnalysis :> SemanticMetadata {
            :>> baseType = beliefStatementAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <beliefStmtConstraint> beliefStatementConstraint :> SemanticMetadata {
            :>> baseType = beliefStatementConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <beliefStmtRequirement> beliefStatementRequirement :> SemanticMetadata {
            :>> baseType = beliefStatementRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <beliefStmtConnection> beliefStatementConnection :> SemanticMetadata {
            :>> baseType = beliefStatementConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <beliefStmtInterface> beliefStatementInterface :> SemanticMetadata {
            :>> baseType = beliefStatementInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <beliefStmtAllocation> beliefStatementAllocation :> SemanticMetadata {
            :>> baseType = beliefStatementAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <beliefStmtRendering> beliefStatementRendering :> SemanticMetadata {
            :>> baseType = beliefStatementRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <beliefStmtView> beliefStatementView :> SemanticMetadata {
            :>> baseType = beliefStatementViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <beliefStmtFlow> beliefStatementFlow :> SemanticMetadata {
            :>> baseType = beliefStatementFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <beliefStmtCase> beliefStatementCase :> SemanticMetadata {
            :>> baseType = beliefStatementCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <beliefStmtUseCase> beliefStatementUseCase :> SemanticMetadata {
            :>> baseType = beliefStatementUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <beliefStmtVerificationCase> beliefStatementVerificationCase :> SemanticMetadata {
            :>> baseType = beliefStatementVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <beliefStmtConcern> beliefStatementConcern :> SemanticMetadata {
            :>> baseType = beliefStatementConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <beliefStmtViewpoint> beliefStatementViewpoint :> SemanticMetadata {
            :>> baseType = beliefStatementViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def <indSourceAttribute> indeterminacySourceAttribute :> SemanticMetadata {
            :>> baseType = indeterminacySourceAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <indSourceEnum> indeterminacySourceEnum :> SemanticMetadata {
            :>> baseType = indeterminacySourceEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <indSourceOccurrence> indeterminacySourceOccurrence :> SemanticMetadata {
            :>> baseType = indeterminacySourceOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <indSourceItem> indeterminacySourceItem :> SemanticMetadata {
            :>> baseType = indeterminacySourceItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <indSourcePart> indeterminacySourcePart :> SemanticMetadata {
            :>> baseType = indeterminacySourceParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <indSourcePort> indeterminacySourcePort :> SemanticMetadata {
            :>> baseType = indeterminacySourcePorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <indSourceAction> indeterminacySourceAction :> SemanticMetadata {
            :>> baseType = indeterminacySourceActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <indSourceState> indeterminacySourceState :> SemanticMetadata {
            :>> baseType = indeterminacySourceStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <indSourceConstraint> indeterminacySourceConstraint :> SemanticMetadata {
            :>> baseType = indeterminacySourceConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <indSourceRequirement> indeterminacySourceRequirement :> SemanticMetadata {
            :>> baseType = indeterminacySourceRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <indSourceConnection> indeterminacySourceConnection :> SemanticMetadata {
            :>> baseType = indeterminacySourceConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <indSourceAllocation> indeterminacySourceAllocation :> SemanticMetadata {
            :>> baseType = indeterminacySourceAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <indSourceInterface> indeterminacySourceInterface :> SemanticMetadata {
            :>> baseType = indeterminacySourceInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <indSourceRendering> indeterminacySourceRendering :> SemanticMetadata {
            :>> baseType = indeterminacySourceRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <indSourceView> indeterminacySourceView :> SemanticMetadata {
            :>> baseType = indeterminacySourceViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <indSourceFlow> indeterminacySourceFlow :> SemanticMetadata {
            :>> baseType = indeterminacySourceFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <indSourceCalculation> indeterminacySourceCalculation :> SemanticMetadata {
            :>> baseType = indeterminacySourceCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <indSourceCase> indeterminacySourceCase :> SemanticMetadata {
            :>> baseType = indeterminacySourceCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <indSourceAnalysis> indeterminacySourceAnalysis :> SemanticMetadata {
            :>> baseType = indeterminacySourceAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <indSourceUseCase> indeterminacySourceUseCase :> SemanticMetadata {
            :>> baseType = indeterminacySourceUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <indSourceVerificationCase> indeterminacySourceVerificationCase :> SemanticMetadata {
            :>> baseType = indeterminacySourceVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <indSourceConcern> indeterminacySourceConcern :> SemanticMetadata {
            :>> baseType = indeterminacySourceConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <indSourceViewpoint> indeterminacySourceViewpoint :> SemanticMetadata {
            :>> baseType = indeterminacySourceViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def <indSpec> indeterminacySpecification :> SemanticMetadata {
            :>> baseType = indeterminacySpecifications meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <persExpAttribute> personalExperienceAttribute :> SemanticMetadata {
            :>> baseType = personalExperienceAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <persExpEnum> personalExperienceEnum :> SemanticMetadata {
            :>> baseType = personalExperienceEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <persExpOccurrence> personalExperienceOccurrence :> SemanticMetadata {
            :>> baseType = personalExperienceOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <persExpItem> personalExperienceItem :> SemanticMetadata {
            :>> baseType = personalExperienceItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <persExpPart> personalExperiencePart :> SemanticMetadata {
            :>> baseType = personalExperienceParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <persExpPort> personalExperiencePort :> SemanticMetadata {
            :>> baseType = personalExperiencePorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <persExpAction> personalExperienceAction :> SemanticMetadata {
            :>> baseType = personalExperienceActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <persExpState> personalExperienceState :> SemanticMetadata {
            :>> baseType = personalExperienceStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <persExpConstraint> personalExperienceConstraint :> SemanticMetadata {
            :>> baseType = personalExperienceConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <persExpRequirement> personalExperienceRequirement :> SemanticMetadata {
            :>> baseType = personalExperienceRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <persExpConnection> personalExperienceConnection :> SemanticMetadata {
            :>> baseType = personalExperienceConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <persExpAllocation> personalExperienceAllocation :> SemanticMetadata {
            :>> baseType = personalExperienceAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <persExpInterface> personalExperienceInterface :> SemanticMetadata {
            :>> baseType = personalExperienceInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <persExpRendering> personalExperienceRendering :> SemanticMetadata {
            :>> baseType = personalExperienceRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <persExpView> personalExperienceView :> SemanticMetadata {
            :>> baseType = personalExperienceViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <persExpFlow> personalExperienceFlow :> SemanticMetadata {
            :>> baseType = personalExperienceFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <persExpCalculation> personalExperienceCalculation :> SemanticMetadata {
            :>> baseType = personalExperienceCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <persExpCase> personalExperienceCase :> SemanticMetadata {
            :>> baseType = personalExperienceCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <persExpAnalysis> personalExperienceAnalysis :> SemanticMetadata {
            :>> baseType = personalExperienceAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <persExpUseCase> personalExperienceUseCase :> SemanticMetadata {
            :>> baseType = personalExperienceUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <persExpVerificationCase> personalExperienceVerificationCase :> SemanticMetadata {
            :>> baseType = personalExperienceVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <persExpConcern> personalExperienceConcern :> SemanticMetadata {
            :>> baseType = personalExperienceConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <persExpViewpoint> personalExperienceViewpoint :> SemanticMetadata {
            :>> baseType = personalExperienceViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def evidenceAttribute :> SemanticMetadata {
            :>> baseType = evidenceAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def evidenceEnum :> SemanticMetadata {
            :>> baseType = evidenceEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def evidenceOccurrence :> SemanticMetadata {
            :>> baseType = evidenceOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def evidenceItem :> SemanticMetadata {
            :>> baseType = evidenceItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def evidencePart :> SemanticMetadata {
            :>> baseType = evidenceParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def evidencePort :> SemanticMetadata {
            :>> baseType = evidencePorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def evidenceAction :> SemanticMetadata {
            :>> baseType = evidenceActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def evidenceState :> SemanticMetadata {
            :>> baseType = evidenceStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def evidenceConstraint :> SemanticMetadata {
            :>> baseType = evidenceConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def evidenceRequirement :> SemanticMetadata {
            :>> baseType = evidenceRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def evidenceConnection :> SemanticMetadata {
            :>> baseType = evidenceConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def evidenceAllocation :> SemanticMetadata {
            :>> baseType = evidenceAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def evidenceInterface :> SemanticMetadata {
            :>> baseType = evidenceInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def evidenceRendering :> SemanticMetadata {
            :>> baseType = evidenceRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def evidenceView :> SemanticMetadata {
            :>> baseType = evidenceViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def evidenceFlow :> SemanticMetadata {
            :>> baseType = evidenceFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def evidenceCalculation :> SemanticMetadata {
            :>> baseType = evidenceCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def evidenceCase :> SemanticMetadata {
            :>> baseType = evidenceCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def evidenceAnalysis :> SemanticMetadata {
            :>> baseType = evidenceAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def evidenceUseCase :> SemanticMetadata {
            :>> baseType = evidenceUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def evidenceVerificationCase :> SemanticMetadata {
            :>> baseType = evidenceVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def evidenceConcern :> SemanticMetadata {
            :>> baseType = evidenceConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def evidenceViewpoint :> SemanticMetadata {
            :>> baseType = evidenceViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }
    }

    package Uncertainty {
        metadata def <uncertainAttribute> uncertaintyAttribute :> SemanticMetadata {
            :>> baseType = uncertainAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <uncertainEnum> uncertaintyEnum :> SemanticMetadata {
            :>> baseType = uncertainEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <uncertainOccurrence> uncertaintyOccurrence :> SemanticMetadata {
            :>> baseType = uncertainOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <uncertainItem> uncertaintyItem :> SemanticMetadata {
            :>> baseType = uncertainItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <uncertainPart> uncertaintyPart :> SemanticMetadata {
            :>> baseType = uncertainParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <uncertainPort> uncertaintyPort :> SemanticMetadata {
            :>> baseType = uncertainPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <uncertainAction> uncertaintyAction :> SemanticMetadata {
            :>> baseType = uncertainActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <uncertainState> uncertaintyState :> SemanticMetadata {
            :>> baseType = uncertainStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <uncertainCalculation> uncertaintyCalculation :> SemanticMetadata {
            :>> baseType = uncertainCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <uncertainAnalysis> uncertaintyAnalysis :> SemanticMetadata {
            :>> baseType = uncertainAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <uncertainConstraint> uncertaintyConstraint :> SemanticMetadata {
            :>> baseType = uncertainConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <uncertainRequirement> uncertaintyRequirement :> SemanticMetadata {
            :>> baseType = uncertainRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <uncertainConnection> uncertaintyConnection :> SemanticMetadata {
            :>> baseType = uncertainConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <uncertainInterface> uncertaintyInterface :> SemanticMetadata {
            :>> baseType = uncertainInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <uncertainAllocation> uncertaintyAllocation :> SemanticMetadata {
            :>> baseType = uncertainAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <uncertainRendering> uncertaintyRendering :> SemanticMetadata {
            :>> baseType = uncertainRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <uncertainView> uncertaintyView :> SemanticMetadata {
            :>> baseType = uncertainViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <uncertainFlow> uncertaintyFlow :> SemanticMetadata {
            :>> baseType = uncertainFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <uncertainCase> uncertaintyCase :> SemanticMetadata {
            :>> baseType = uncertainCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <uncertainUseCase> uncertaintyUseCase :> SemanticMetadata {
            :>> baseType = uncertainUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <uncertainVerificationCase> uncertaintyVerificationCase :> SemanticMetadata {
            :>> baseType = uncertainVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <uncertainConcern> uncertaintyConcern :> SemanticMetadata {
            :>> baseType = uncertainConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <uncertainViewpoint> uncertaintyViewpoint :> SemanticMetadata {
            :>> baseType = uncertainViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def <uncerPersAttribute> uncertaintyPerspectiveAttribute :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <uncerPersEnum> uncertaintyPerspectiveEnum :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <uncerPersOccurrence> uncertaintyPerspectiveOccurrence :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <uncerPersItem> uncertaintyPerspectiveItem :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <uncerPersPart> uncertaintyPerspectivePart :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <uncerPersAction> uncertaintyPerspectiveAction :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <uncerPersState> uncertaintyPerspectiveState :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <uncerPersPort> uncertaintyPerspectivePort :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectivePorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <uncerPersConnection> uncertaintyPerspectiveConnection :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <uncerPersAllocation> uncertaintyPerspectiveAllocation :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <uncerPersInterface> uncertaintyPerspectiveInterface :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <uncerPersRendering> uncertaintyPerspectiveRendering :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <uncerPersView> uncertaintyPerspectiveView :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <uncerPersFlow> uncertaintyPerspectiveFlow :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <uncerPersCalculation> uncertaintyPerspectiveCalculation :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <uncerPersCase> uncertaintyPerspectiveCase :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <uncerPersAnalysis> uncertaintyPerspectiveAnalysis :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <uncerPersUseCase> uncertaintyPerspectiveUseCase :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <uncerPersVerificationCase> uncertaintyPerspectiveVerificationCase :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <uncerPersConstraint> uncertaintyPerspectiveConstraint :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <uncerPersRequirement> uncertaintyPerspectiveRequirement :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <uncerPersConcern> uncertaintyPerspectiveConcern :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <uncerPersViewpoint> uncertaintyPerspectiveViewpoint :> SemanticMetadata {
            :>> baseType = uncertaintyPerspectiveViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def patternAttribute :> SemanticMetadata {
            :>> baseType = patternAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def patternEnum :> SemanticMetadata {
            :>> baseType = patternEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def patternOccurrence :> SemanticMetadata {
            :>> baseType = patternOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def patternItem :> SemanticMetadata {
            :>> baseType = patternItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def patternPart :> SemanticMetadata {
            :>> baseType = patternParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def patternAction :> SemanticMetadata {
            :>> baseType = patternActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def patternState :> SemanticMetadata {
            :>> baseType = patternStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def patternPort :> SemanticMetadata {
            :>> baseType = patternPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def patternConnection :> SemanticMetadata {
            :>> baseType = patternConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def patternAllocation :> SemanticMetadata {
            :>> baseType = patternAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def patternInterface :> SemanticMetadata {
            :>> baseType = patternInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def patternRendering :> SemanticMetadata {
            :>> baseType = patternRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def patternView :> SemanticMetadata {
            :>> baseType = patternViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def patternFlow :> SemanticMetadata {
            :>> baseType = patternFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def patternCalculation :> SemanticMetadata {
            :>> baseType = patternCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def patternCase :> SemanticMetadata {
            :>> baseType = patternCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def patternAnalysis :> SemanticMetadata {
            :>> baseType = patternAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def patternUseCase :> SemanticMetadata {
            :>> baseType = patternUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def patternVerificationCase :> SemanticMetadata {
            :>> baseType = patternVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def patternConstraint :> SemanticMetadata {
            :>> baseType = patternConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def patternRequirement :> SemanticMetadata {
            :>> baseType = patternRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def patternConcern :> SemanticMetadata {
            :>> baseType = patternConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def patternViewpoint :> SemanticMetadata {
            :>> baseType = patternViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def effectAttribute :> SemanticMetadata {
            :>> baseType = effectAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def effectEnum :> SemanticMetadata {
            :>> baseType = effectEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def effectOccurrence :> SemanticMetadata {
            :>> baseType = effectOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def effectItem :> SemanticMetadata {
            :>> baseType = effectItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def effectPart :> SemanticMetadata {
            :>> baseType = effectParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def effectPort :> SemanticMetadata {
            :>> baseType = effectPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def effectAction :> SemanticMetadata {
            :>> baseType = effectActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def effectState :> SemanticMetadata {
            :>> baseType = effectStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def effectCalculation :> SemanticMetadata {
            :>> baseType = effectCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def effectAnalysis :> SemanticMetadata {
            :>> baseType = effectAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def effectConstraint :> SemanticMetadata {
            :>> baseType = effectConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def effectRequirement :> SemanticMetadata {
            :>> baseType = effectRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def effectConnection :> SemanticMetadata {
            :>> baseType = effectConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def effectAllocation :> SemanticMetadata {
            :>> baseType = effectAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def effectInterface :> SemanticMetadata {
            :>> baseType = effectInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def effectRendering :> SemanticMetadata {
            :>> baseType = effectRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def effectView :> SemanticMetadata {
            :>> baseType = effectViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def effectFlow :> SemanticMetadata {
            :>> baseType = effectFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def effectCase :> SemanticMetadata {
            :>> baseType = effectCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def effectUseCase :> SemanticMetadata {
            :>> baseType = effectUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def effectVerificationCase :> SemanticMetadata {
            :>> baseType = effectVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def effectConcern :> SemanticMetadata {
            :>> baseType = effectConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def effectViewpoint :> SemanticMetadata {
            :>> baseType = effectViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def <uncerTopicAttribute> uncertaintyTopicAttribute :> SemanticMetadata {
            :>> baseType = uncertaintyTopicAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <uncerTopicEnum> uncertaintyTopicEnum :> SemanticMetadata {
            :>> baseType = uncertaintyTopicEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <uncerTopicOccurrence> uncertaintyTopicOccurrence :> SemanticMetadata {
            :>> baseType = uncertaintyTopicOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <uncerTopicItem> uncertaintyTopicItem :> SemanticMetadata {
            :>> baseType = uncertaintyTopicItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <uncerTopicPart> uncertaintyTopicPart :> SemanticMetadata {
            :>> baseType = uncertaintyTopicParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <uncerTopicPort> uncertaintyTopicPort :> SemanticMetadata {
            :>> baseType = uncertaintyTopicPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <uncerTopicAction> uncertaintyTopicAction :> SemanticMetadata {
            :>> baseType = uncertaintyTopicActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <uncerTopicState> uncertaintyTopicState :> SemanticMetadata {
            :>> baseType = uncertaintyTopicStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <uncerTopicConstraint> uncertaintyTopicConstraint :> SemanticMetadata {
            :>> baseType = uncertaintyTopicConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <uncerTopicRequirement> uncertaintyTopicRequirement :> SemanticMetadata {
            :>> baseType = uncertaintyTopicRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <uncerTopicConnection> uncertaintyTopicConnection :> SemanticMetadata {
            :>> baseType = uncertaintyTopicConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <uncerTopicAllocation> uncertaintyTopicAllocation :> SemanticMetadata {
            :>> baseType = uncertaintyTopicAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <uncerTopicInterface> uncertaintyTopicInterface :> SemanticMetadata {
            :>> baseType = uncertaintyTopicInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <uncerTopicRendering> uncertaintyTopicRendering :> SemanticMetadata {
            :>> baseType = uncertaintyTopicRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <uncerTopicView> uncertaintyTopicView :> SemanticMetadata {
            :>> baseType = uncertaintyTopicViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <uncerTopicFlow> uncertaintyTopicFlow :> SemanticMetadata {
            :>> baseType = uncertaintyTopicFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <uncerTopicCalculation> uncertaintyTopicCalculation :> SemanticMetadata {
            :>> baseType = uncertaintyTopicCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <uncerTopicCase> uncertaintyTopicCase :> SemanticMetadata {
            :>> baseType = uncertaintyTopicCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <uncerTopicAnalysis> uncertaintyTopicAnalysis :> SemanticMetadata {
            :>> baseType = uncertaintyTopicAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <uncerTopicUseCase> uncertaintyTopicUseCase :> SemanticMetadata {
            :>> baseType = uncertaintyTopicUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <uncerTopicVerificationCase> uncertaintyTopicVerificationCase :> SemanticMetadata {
            :>> baseType = uncertaintyTopicVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <uncerTopicConcern> uncertaintyTopicConcern :> SemanticMetadata {
            :>> baseType = uncertaintyTopicConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <uncerTopicViewpoint> uncertaintyTopicViewpoint :> SemanticMetadata {
            :>> baseType = uncertaintyTopicViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }
    }

    package Measurement {
        metadata def accuracyAttribute :> SemanticMetadata {
            :>> baseType = accuracyAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def accuracyOccurrence :> SemanticMetadata {
            :>> baseType = accuracyOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def accuracyEnum :> SemanticMetadata {
            :>> baseType = accuracyEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def accuracyItem :> SemanticMetadata {
            :>> baseType = accuracyItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def accuracyPart :> SemanticMetadata {
            :>> baseType = accuracyParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def accuracyConnection :> SemanticMetadata {
            :>> baseType = accuracyConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def accuracyAllocation :> SemanticMetadata {
            :>> baseType = accuracyAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def accuracyInterface :> SemanticMetadata {
            :>> baseType = accuracyInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def accuracyRendering :> SemanticMetadata {
            :>> baseType = accuracyRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def accuracyView :> SemanticMetadata {
            :>> baseType = accuracyViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def accuracyPort :> SemanticMetadata {
            :>> baseType = accuracyPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def accuracyAction :> SemanticMetadata {
            :>> baseType = accuracyActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def accuracyFlow :> SemanticMetadata {
            :>> baseType = accuracyFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def accuracyCalculation :> SemanticMetadata {
            :>> baseType = accuracyCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def accuracyCase :> SemanticMetadata {
            :>> baseType = accuracyCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def accuracyAnalysis :> SemanticMetadata {
            :>> baseType = accuracyAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def accuracyUseCase :> SemanticMetadata {
            :>> baseType = accuracyUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def accuracyVerificationCase :> SemanticMetadata {
            :>> baseType = accuracyVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def accuracyState :> SemanticMetadata {
            :>> baseType = accuracyStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def accuracyConstraint :> SemanticMetadata {
            :>> baseType = accuracyConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def accuracyRequirement :> SemanticMetadata {
            :>> baseType = accuracyRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def accuracyConcern :> SemanticMetadata {
            :>> baseType = accuracyConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def accuracyViewpoint :> SemanticMetadata {
            :>> baseType = accuracyViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def sensitivityAttribute :> SemanticMetadata {
            :>> baseType = sensitivityAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def sensitivityOccurrence :> SemanticMetadata {
            :>> baseType = sensitivityOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def sensitivityEnum :> SemanticMetadata {
            :>> baseType = sensitivityEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def sensitivityItem :> SemanticMetadata {
            :>> baseType = sensitivityItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def sensitivityPart :> SemanticMetadata {
            :>> baseType = sensitivityParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def sensitivityConnection :> SemanticMetadata {
            :>> baseType = sensitivityConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def sensitivityAllocation :> SemanticMetadata {
            :>> baseType = sensitivityAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def sensitivityInterface :> SemanticMetadata {
            :>> baseType = sensitivityInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def sensitivityRendering :> SemanticMetadata {
            :>> baseType = sensitivityRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def sensitivityView :> SemanticMetadata {
            :>> baseType = sensitivityViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def sensitivityPort :> SemanticMetadata {
            :>> baseType = sensitivityPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def sensitivityAction :> SemanticMetadata {
            :>> baseType = sensitivityActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def sensitivityFlow :> SemanticMetadata {
            :>> baseType = sensitivityFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def sensitivityCalculation :> SemanticMetadata {
            :>> baseType = sensitivityCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def sensitivityCase :> SemanticMetadata {
            :>> baseType = sensitivityCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def sensitivityAnalysis :> SemanticMetadata {
            :>> baseType = sensitivityAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def sensitivityUseCase :> SemanticMetadata {
            :>> baseType = sensitivityUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def sensitivityVerificationCase :> SemanticMetadata {
            :>> baseType = sensitivityVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def sensitivityState :> SemanticMetadata {
            :>> baseType = sensitivityStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def sensitivityConstraint :> SemanticMetadata {
            :>> baseType = sensitivityConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def sensitivityRequirement :> SemanticMetadata {
            :>> baseType = sensitivityRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def sensitivityConcern :> SemanticMetadata {
            :>> baseType = sensitivityConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def sensitivityViewpoint :> SemanticMetadata {
            :>> baseType = sensitivityViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def <measErrAttribute> measurementErrorAttribute :> SemanticMetadata {
            :>> baseType = measurementErrorAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def <measErrOccurrence> measurementErrorOccurrence :> SemanticMetadata {
            :>> baseType = measurementErrorOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def <measErrEnum> measurementErrorEnum :> SemanticMetadata {
            :>> baseType = measurementErrorEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def <measErrItem> measurementErrorItem :> SemanticMetadata {
            :>> baseType = measurementErrorItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def <measErrPart> measurementErrorPart :> SemanticMetadata {
            :>> baseType = measurementErrorParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def <measErrConnection> measurementErrorConnection :> SemanticMetadata {
            :>> baseType = measurementErrorConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def <measErrAllocation> measurementErrorAllocation :> SemanticMetadata {
            :>> baseType = measurementErrorAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def <measErrInterface> measurementErrorInterface :> SemanticMetadata {
            :>> baseType = measurementErrorInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def <measErrRendering> measurementErrorRendering :> SemanticMetadata {
            :>> baseType = measurementErrorRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def <measErrView> measurementErrorView :> SemanticMetadata {
            :>> baseType = measurementErrorViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def <measErrPort> measurementErrorPort :> SemanticMetadata {
            :>> baseType = measurementErrorPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def <measErrAction> measurementErrorAction :> SemanticMetadata {
            :>> baseType = measurementErrorActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def <measErrFlow> measurementErrorFlow :> SemanticMetadata {
            :>> baseType = measurementErrorFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def <measErrCalculation> measurementErrorCalculation :> SemanticMetadata {
            :>> baseType = measurementErrorCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def <measErrCase> measurementErrorCase :> SemanticMetadata {
            :>> baseType = measurementErrorCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def <measErrAnalysis> measurementErrorAnalysis :> SemanticMetadata {
            :>> baseType = measurementErrorAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def <measErrUseCase> measurementErrorUseCase :> SemanticMetadata {
            :>> baseType = measurementErrorUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def <measErrVerificationCase> measurementErrorVerificationCase :> SemanticMetadata {
            :>> baseType = measurementErrorVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def <measErrState> measurementErrorState :> SemanticMetadata {
            :>> baseType = measurementErrorStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def <measErrConstraint> measurementErrorConstraint :> SemanticMetadata {
            :>> baseType = measurementErrorConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def <measErrRequirement> measurementErrorRequirement :> SemanticMetadata {
            :>> baseType = measurementErrorRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def <measErrConcern> measurementErrorConcern :> SemanticMetadata {
            :>> baseType = measurementErrorConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def <measErrViewpoint> measurementErrorViewpoint :> SemanticMetadata {
            :>> baseType = measurementErrorViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def precisionAttribute :> SemanticMetadata {
            :>> baseType = precisionAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def precisionOccurrence :> SemanticMetadata {
            :>> baseType = precisionOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def precisionEnum :> SemanticMetadata {
            :>> baseType = precisionEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def precisionItem :> SemanticMetadata {
            :>> baseType = precisionItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def precisionPart :> SemanticMetadata {
            :>> baseType = precisionParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def precisionConnection :> SemanticMetadata {
            :>> baseType = precisionConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def precisionAllocation :> SemanticMetadata {
            :>> baseType = precisionAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def precisionInterface :> SemanticMetadata {
            :>> baseType = precisionInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def precisionRendering :> SemanticMetadata {
            :>> baseType = precisionRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def precisionView :> SemanticMetadata {
            :>> baseType = precisionViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def precisionPort :> SemanticMetadata {
            :>> baseType = precisionPorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def precisionAction :> SemanticMetadata {
            :>> baseType = precisionActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def precisionFlow :> SemanticMetadata {
            :>> baseType = precisionFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def precisionCalculation :> SemanticMetadata {
            :>> baseType = precisionCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def precisionCase :> SemanticMetadata {
            :>> baseType = precisionCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def precisionAnalysis :> SemanticMetadata {
            :>> baseType = precisionAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def precisionUseCase :> SemanticMetadata {
            :>> baseType = precisionUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def precisionVerificationCase :> SemanticMetadata {
            :>> baseType = precisionVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def precisionState :> SemanticMetadata {
            :>> baseType = precisionStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def precisionConstraint :> SemanticMetadata {
            :>> baseType = precisionConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def precisionRequirement :> SemanticMetadata {
            :>> baseType = precisionRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def precisionConcern :> SemanticMetadata {
            :>> baseType = precisionConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def precisionViewpoint :> SemanticMetadata {
            :>> baseType = precisionViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }

        metadata def degreeAttribute :> SemanticMetadata {
            :>> baseType = degreeAttributes meta SysML::Usage;
            :> annotatedElement : SysML::AttributeDefinition;
            :> annotatedElement : SysML::AttributeUsage;
        }

        metadata def degreeOccurrence :> SemanticMetadata {
            :>> baseType = degreeOccurrences meta SysML::Usage;
            :> annotatedElement : SysML::OccurrenceDefinition;
            :> annotatedElement : SysML::OccurrenceUsage;
        }

        metadata def degreeEnum :> SemanticMetadata {
            :>> baseType = degreeEnums meta SysML::Usage;
            :> annotatedElement : SysML::EnumerationDefinition;
            :> annotatedElement : SysML::EnumerationUsage;
        }

        metadata def degreeItem :> SemanticMetadata {
            :>> baseType = degreeItems meta SysML::Usage;
            :> annotatedElement : SysML::ItemDefinition;
            :> annotatedElement : SysML::ItemUsage;
        }

        metadata def degreePart :> SemanticMetadata {
            :>> baseType = degreeParts meta SysML::Usage;
            :> annotatedElement : SysML::PartDefinition;
            :> annotatedElement : SysML::PartUsage;
        }

        metadata def degreeConnection :> SemanticMetadata {
            :>> baseType = degreeConnections meta SysML::Usage;
            :> annotatedElement : SysML::ConnectionDefinition;
            :> annotatedElement : SysML::ConnectionUsage;
        }

        metadata def degreeAllocation :> SemanticMetadata {
            :>> baseType = degreeAllocations meta SysML::Usage;
            :> annotatedElement : SysML::AllocationDefinition;
            :> annotatedElement : SysML::AllocationUsage;
        }

        metadata def degreeInterface :> SemanticMetadata {
            :>> baseType = degreeInterfaces meta SysML::Usage;
            :> annotatedElement : SysML::InterfaceDefinition;
            :> annotatedElement : SysML::InterfaceUsage;
        }

        metadata def degreeRendering :> SemanticMetadata {
            :>> baseType = degreeRenderings meta SysML::Usage;
            :> annotatedElement : SysML::RenderingDefinition;
            :> annotatedElement : SysML::RenderingUsage;
        }

        metadata def degreeView :> SemanticMetadata {
            :>> baseType = degreeViews meta SysML::Usage;
            :> annotatedElement : SysML::ViewDefinition;
            :> annotatedElement : SysML::ViewUsage;
        }

        metadata def degreePort :> SemanticMetadata {
            :>> baseType = degreePorts meta SysML::Usage;
            :> annotatedElement : SysML::PortDefinition;
            :> annotatedElement : SysML::PortUsage;
        }

        metadata def degreeAction :> SemanticMetadata {
            :>> baseType = degreeActions meta SysML::Usage;
            :> annotatedElement : SysML::ActionDefinition;
            :> annotatedElement : SysML::ActionUsage;
        }

        metadata def degreeFlow :> SemanticMetadata {
            :>> baseType = degreeFlows meta SysML::Usage;
            :> annotatedElement : SysML::FlowDefinition;
            :> annotatedElement : SysML::FlowUsage;
        }

        metadata def degreeCalculation :> SemanticMetadata {
            :>> baseType = degreeCalculations meta SysML::Usage;
            :> annotatedElement : SysML::CalculationDefinition;
            :> annotatedElement : SysML::CalculationUsage;
        }

        metadata def degreeCase :> SemanticMetadata {
            :>> baseType = degreeCases meta SysML::Usage;
            :> annotatedElement : SysML::CaseDefinition;
            :> annotatedElement : SysML::CaseUsage;
        }

        metadata def degreeAnalysis :> SemanticMetadata {
            :>> baseType = degreeAnalyses meta SysML::Usage;
            :> annotatedElement : SysML::AnalysisCaseDefinition;
            :> annotatedElement : SysML::AnalysisCaseUsage;
        }

        metadata def degreeUseCase :> SemanticMetadata {
            :>> baseType = degreeUseCases meta SysML::Usage;
            :> annotatedElement : SysML::UseCaseDefinition;
            :> annotatedElement : SysML::UseCaseUsage;
        }

        metadata def degreeVerificationCase :> SemanticMetadata {
            :>> baseType = degreeVerificationCases meta SysML::Usage;
            :> annotatedElement : SysML::VerificationCaseDefinition;
            :> annotatedElement : SysML::VerificationCaseUsage;
        }

        metadata def degreeState :> SemanticMetadata {
            :>> baseType = degreeStates meta SysML::Usage;
            :> annotatedElement : SysML::StateDefinition;
            :> annotatedElement : SysML::StateUsage;
        }

        metadata def degreeConstraint :> SemanticMetadata {
            :>> baseType = degreeConstraints meta SysML::Usage;
            :> annotatedElement : SysML::ConstraintDefinition;
            :> annotatedElement : SysML::ConstraintUsage;
        }

        metadata def degreeRequirement :> SemanticMetadata {
            :>> baseType = degreeRequirements meta SysML::Usage;
            :> annotatedElement : SysML::RequirementDefinition;
            :> annotatedElement : SysML::RequirementUsage;
        }

        metadata def degreeConcern :> SemanticMetadata {
            :>> baseType = degreeConcerns meta SysML::Usage;
            :> annotatedElement : SysML::ConcernDefinition;
            :> annotatedElement : SysML::ConcernUsage;
        }

        metadata def degreeViewpoint :> SemanticMetadata {
            :>> baseType = degreeViewpoints meta SysML::Usage;
            :> annotatedElement : SysML::ViewpointDefinition;
            :> annotatedElement : SysML::ViewpointUsage;
        }
    }
}
