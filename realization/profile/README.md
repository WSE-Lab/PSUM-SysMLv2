# PSUM-SysMLv2 Profile

This directory contains the MOF XMI specification of the PSUM-SysMLv2 profile abstract syntax.
It also includes the concrete syntax (textual notation) of PSUM-SysMLv2 profile.

## Stereotypes and applicability

The following table (Table 1 in the paper) contains the non-abstract stereotypes defined by `PSUM-SysMLv2.profile.uml` and the metaclasses they extend.

| Package | Stereotype | Extended metaclass(es) |
| --- | --- | --- |
| Belief | `BeliefStatement` | `KerML::Element` |
| Belief | `Evidence` | `KerML::Element` |
| Belief | `PersonalExperience` | `KerML::Element` |
| Belief | `IndeterminacySource` | `SysML::AttributeDefinition`, `SysML::AttributeUsage`, `SysML::OccurrenceDefinition`, `SysML::OccurrenceUsage` |
| Belief | `IndeterminacySpecification` | `SysML::ConstraintUsage` |
| Uncertainty | `Uncertainty` | `SysML::AttributeDefinition`, `SysML::AttributeUsage`, `SysML::OccurrenceDefinition`, `SysML::OccurrenceUsage` |
| Uncertainty | `UncertaintyTopic` | `KerML::Element` |
| Uncertainty | `UncertaintyPerspective` | `KerML::Element` |
| Uncertainty | `Pattern` | `KerML::Element` |
| Uncertainty | `Effect` | `SysML::AttributeDefinition`, `SysML::AttributeUsage`, `SysML::OccurrenceDefinition`, `SysML::OccurrenceUsage` |
| Measurement | `Accuracy` | `KerML::Element` |
| Measurement | `Sensitivity` | `KerML::Element` |
| Measurement | `MeasurementError` | `KerML::Element` |
| Measurement | `Precision` | `KerML::Element` |
| Measurement | `Degree` | `KerML::Element` |

Abstract stereotypes including *PSUMElement*, *Basis*, *MeasurableElement*, *MeasurableFeature*, and *UncertaintyCharacteristic* are omitted from this table.

## Enumerations

The profile defines the following enumerations:

| Enumeration | Literals |
| --- | --- |
| `IndeterminacyNature` | `InsufficientResolution`, `MissingInfo`, `NonDeterminism`, `Unclassified`, `Custom` |
| `EvidenceType` | `EmpiricalEvidence`, `TheoremProvingResults`, `InferenceBasedOnEmpiricalData`, `CommonKnowledge` |
| `UncertaintyKind` | `OccurrenceUncertainty`, `ContentUncertainty`, `TimeUncertainty`, `LocationUncertainty`, `EnvironmentUncertainty` |
| `UncertaintyNature` | `Aleatory`, `Epistemic` |
| `ReducibilityLevel` | `FullyReducible`, `PartiallyReducible`, `Irreducible` |
| `UncertaintyPerspectiveType` | `Subjective`, `Objective` |
| `PatternType` | `Periodic`, `Persistent`, `Sporadic`, `Transient`, `Random` |

## Concrete Syntax

The following ANTLR4-style grammar fragments illustrate the customized textual notation of the PSUM-SysMLv2 profile used in the paper.
```g4
grammar PSUMSysMLv2;

import KerMLExpressions, SysmlLexer;

stereotypePrefix
    : '«' (stereotype ',')* stereotype '»'
    ;

stereotype
    : beliefStatement
    | indeterminacySource
    | indeterminacySpecification
    | evidence
    | personalExperience
    | uncertainty
    | uncertaintyTopic
    | effect
    ;

stereotypeBodyItem
    : beliefStatementBodyItem
    | uncertaintyBodyItem
    ;

beliefStatement
    : 'BeliefStatement'
    ;

beliefStatementBodyItem
    : durationDecl
    ;

// ownedExpression is from KerMLExpressions
durationDecl
    : 'b_duration' '=' ownedExpression ';'
    ;

indeterminacySource
    : 'IndeterminacySource' 
      ('<' indeterminacySourceAttribute '>')?
    ;

indeterminacySourceAttribute
    : indeterminacySourceNature
    ;

indeterminacySourceNature
    : 'InsufficientResolution'
    | 'isr'
    | 'MissingInfo'
    | 'mi'
    | 'NonDeterminism'
    | 'nd'
    | 'Unclassified'
    | 'uc'
    | 'Custom'
    | 'c'
    ;

indeterminacySpecification
    : 'IndeterminacySpecification'
    ;

uncertainty
    : 'Uncertainty'
      ('<' uncertaintyAttribute '>')?
    ;

uncertaintyAttribute
    : uncertaintyKind (',' uncertaintyNature)? (',' uncertaintyPerspective)?
    | uncertaintyNature (',' uncertaintyPerspective)?
    | uncertaintyPerspective
    ;

uncertaintyKind
    : 'Occurrence'
    | 'ocr'
    | 'Content'
    | 'con'
    | 'Time'
    | 'tim'
    | 'GeographicalLocation'
    | 'geo'
    | 'Environment'
    | 'env'
    | 'Measurement'
    | 'mea'
    ;

uncertaintyNature
    : 'Aleotory'
    | 'ale'
    | 'Epistemic'
    | 'epi'
    ;

uncertaintyPerspective
    : 'Subjective'
    | 'subj'
    | 'Objective'
    | 'obj'
    ;

uncertaintyReducibility
    : 'FullyReducible'
    | 'PartiallyReducible'
    | 'Irreducible'
    ;

uncertaintyPattern
    : 'Periodic'
    | 'Persistent'
    | 'Sporadic'
    | 'Transient'
    | 'Random'
    ;

uncertaintyBodyItem
    : reducibilityDecl
    | patternDecl
    | originDecl
    ;

reducibilityDecl
    : 'u_reducibility' '=' uncertaintyReducibility ';'
    ;

patternDecl
    : 'u_pattern' '=' uncertaintyPattern ';'
    ;

originDecl
    : 'origin' '=' referenceExpression
    ;

uncertaintyTopic
    : 'UncertaintyTopic'
    ;

measurement
    : measurableFeature '=' ownedExpression ';'
    ;

measurableFeature
    : 'm_probability'
    | 'm_accuracy'
    | 'm_sensitivity'
    | 'm_measurementError'
    | 'm_precision'
    | 'm_degree'
    ;

effect
    : 'Effect' ('<' effectAttribute '>')?
    ;

effectAttribute
    : uncertaintyAttribute
    ;

personalExperience
    : 'PersonalExperience'
    ;

evidence
    : 'Evidence' ('<' evidenceAttribute '>')?
    ;

evidenceAttribute
    : evidenceType
    ;

evidenceType
    : 'EmpiricalEvidence'
    | 'emp'
    | 'TheoremProvingResults'
    | 'tpr'
    | 'InferenceBasedOnEmpiricalData'
    | 'ied'
    | 'CommonKnowledge'
    | 'ckn'
    ;

// qualifiedName is from KerMLExpressions
referenceExpression
    : '(' (qualifiedName (',' qualifiedName)*)? ')' ';'
    | qualifiedName ';'
    ;
```
To integrate the customized grammar into SysML v2, several rules of the original SysML v2 grammar need to be extended. Here, we only show the extended notations.
```g4
grammar SysmlParser;

import SysmlLexer, KerMLExpressions, PSUMSysMLv2;

packageMember
    : memberPrefix stereotypePrefix? (definitionElement | usageElement)
    ;

definitionBodyItem
    : definitionMember
    | variantUsageMember
    | nonOccurrenceUsageMember
    | sourceSuccessionMember? occurrenceUsageMember
    | aliasMember
    | importRule
    | measurementBodyItem
    ;

definitionMember
    : memberPrefix stereotypePrefix? definitionElement
    ;

variantUsageMember
    : memberPrefix stereotypePrefix? VARIANT ownedVariantUsage = variantUsageElement
    ;

nonOccurrenceUsageMember
    : memberPrefix stereotypePrefix? nonOccurrenceUsageElement
    ;

occurrenceUsageMember
    : memberPrefix stereotypePrefix? occurrenceUsageElement
    ;

structureUsageMember
    : memberPrefix stereotypePrefix? structureUsageElement
    ;

behaviorUsageMember
    : memberPrefix stereotypePrefix? behaviorUsageElement
    ;

enumerationUsageMember
    : memberPrefix stereotypePrefix? enumeratedValue
    ;

interfaceBodyItem
    : definitionMember
    | variantUsageMember
    | interfaceNonOccurrenceUsageMember
    | sourceSuccessionMember? interfaceOccurrenceUsageMember
    | aliasMember
    | importRule
    | stereotypeBodyItem
    | measurementBodyItem
    ;

interfaceNonOccurrenceUsageMember
    : memberPrefix stereotypePrefix? interfaceNonOccurrenceUsageElement
    ;

interfaceOccurrenceUsageMember
    : memberPrefix  stereotypePrefix? interfaceOccurrenceUsageElement
    ;

actionBodyItem
    : nonBehaviorBodyItem
    | initialNodeMember actionTargetSuccessionMember*
    | sourceSuccessionMember? actionBehaviorMember actionTargetSuccessionMember*
    | guardedSuccessionMember
    | stereotypeBodyItem
    | measurementBodyItem
    ;

actionNodeMember
    : memberPrefix stereotypePrefix? actionNode
    ;

actionTargetSuccessionMember
    : memberPrefix stereotypePrefix? actionTargetSuccession
    ;

stateBodyItem
    : nonBehaviorBodyItem
    | sourceSuccessionMember? behaviorUsageMember targetTransitionUsageMember*
    | transitionUsageMember
    | entryActionMember entryTransitionMember*
    | doActionMember
    | exitActionMember
    | stereotypeBodyItem
    | measurementBodyItem
    ;

transitionUsageMember
    : memberPrefix stereotypePrefix? transitionUsage
    ;

targetTransitionUsageMember
    : memberPrefix stereotypePrefix? targetTransitionUsage
    ;

measurementBodyItem
    : 'measurement' '{' (definitionBodyItem | measurement)* '}'
    ;
```
> **Note:** `KerMLExpressions.g4`, `SysmlLexer.g4`, and `SysmlParser.g4` are sourced from the
> official SysML v2 Pilot Implementation repository:
> https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation

## How to use
Integrating PSUM-SysMLv2 profile into SysMLv2 requires dedicated tool support for stereotype definition and application, stereotype propagation through specializations, and constraint validation.

We are currently developing the tool support for PSUM-SysMLv2, built on the [ModelCopilot](https://www.modelcopilot.org/model-copilot.html) platform.
