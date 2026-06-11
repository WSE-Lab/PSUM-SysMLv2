# Integrating PSUM-Based Uncertainty Modeling into SysML v2

This repository provides supporting materials for the paper titled  **Integrating PSUM-Based Uncertainty Modeling into SysML v2**.

- The [realization](realization) directory provides the realization artifacts for PSUM-SysMLv2, including **the implemented profile**, **the semantic metadata library**, and **the complete set of constraints**.

  - [realization/profile](realization/profile) contains the MOF XMI specification of the PSUM-SysMLv2 profile abstract syntax.
    > **Note:** `KerML_only_xmi.uml` and `SysML_only_xmi.uml` are sourced from the
    > official SysML v2 Pilot Implementation repository:
    > https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation

  - [realization/semantic-metadata](realization/semantic-metadata) contains the type-specific SysML v2 semantic metadata library.

  - [realization/Constraints.md](realization/Constraints.md) contains the complete OCL constraint specification of PSUM-SysMLv2.

- The [case-studies](case-studies) directory contains the raw results of the case studies, including the original SysML v2 models and the corresponding models extended with PSUM-SysMLv2.
  
We are currently developing dedicated tool support for PSUM-SysMLv2, built on the [**ModelCopilot**](https://www.modelcopilot.org/model-copilot.html) platform.

## PSUM-SysMLv2 Profile

### Stereotypes and extended metaclasses

The following table contains the non-abstract stereotypes defined by [`PSUM-SysMLv2.profile.uml`](realization/profile/PSUM-SysMLv2.profile.uml) and the metaclasses they extend.

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

### Enumerations

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

### Concrete Syntax

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

### How to use
Integrating PSUM-SysMLv2 profile into SysMLv2 requires dedicated tool support for stereotype definition and application, stereotype propagation through specializations, and constraint validation.

## PSUM-SysMLv2 Semantic Metadata Library

### The library file

[`PSUM-SysMLv2-SemanticMetadata-TypeSpecific.sysml`](realization\semantic-metadata\PSUM-SysMLv2-SemanticMetadata-TypeSpecific.sysml) defines two library packages:

- `PSUM-SysMLv2-TypeSpecific`: defines the PSUM-SysMLv2 concepts as type-specific SysMLv2 definitions/usages.
- `PSUM-SysMLv2-TypeSpecific-Metadata`: defines semantic metadata constructs that can be applied to SysMLv2 definitions/usages.

### How To Use

To use this library in a SysMLv2 model, import both packages:

```sysml
private import 'PSUM-SysMLv2-TypeSpecific'::*;
private import 'PSUM-SysMLv2-TypeSpecific-Metadata'::*;
```

- **The first import** provides access to the PSUM-SysMLv2 enumerations.

- **The second import** provides access to the semantic metadata constructs, such as `#beliefStatementState`, `#indeterminacySourcePart`, and `#indeterminacySpecification`.

Semantic metadata can be applied to compatible SysML v2 definitions or usages by placing the `#metadataName` keyword before the element declaration, or by attaching it within the element’s namespace using `@metadataName`.

Each metadata definition is type-specific. In other words, a metadata construct can only be applied to the SysMLv2 types declared by its `annotatedElement`, including their subtypes. For example `#indeterminacySourcePart` is defined as follows:

```sysml
metadata def <indSourcePart> indeterminacySourcePart :> SemanticMetadata {
    :>> baseType = indeterminacySourceParts meta SysML::Usage;
    :> annotatedElement : SysML::PartDefinition;
    :> annotatedElement : SysML::PartUsage;
}
```

Therefore, `#indeterminacySourcePart` can be applied only to part definitions and part usages. Other metadata definitions follow the same pattern, e.g., port-specific metadata is restricted to port definitions/usages, and action-specific metadata is restricted to action definitions/usages.

### Example

```sysml
package 'Illustrative-Example' {
    private import 'PSUM-SysMLv2-TypeSpecific'::*;
    private import 'PSUM-SysMLv2-TypeSpecific-Metadata'::*;

    package SecuritySystemExample {
        item def EnableMonitoring;

        part def SecuritySystem {
            part button : Button [1..*];
        }

        #indeterminacySourcePart part def Button {
            :>> nature = IndeterminacyNature::NonDeterminism;

            attribute isBrokenDown : ScalarValues::Boolean;

            #indeterminacySpecification constraint normalButton {
                isBrokenDown
            }

            #indeterminacySpecification constraint brokenDownButton {
                not isBrokenDown
            }
        }

        #beliefStatementState state securitySystemState {
            :>> duration = 30[SI::day];
            :>> containedUncertainty = (idleToMonitoring, idleToFailedMonitoring);

            part securitySystem : SecuritySystem;

            state idle;
            state monitoring;
            state failedToEnableMonitoring;
                then done;
            entry;
            then idle;

            transition idleToMonitoring
                first idle
                accept EnableMonitoring
                then monitoring {
                    @uncertaintyAction;
                    @uncertaintyPerspectiveAction;
                    @patternAction;

                    :>> kind = UncertaintyKind::OccurrenceUncertainty;
                    :>> nature = UncertaintyNature::Epistemic;
                    :>> reducibility = ReducibilityLevel::PartiallyReducible;
                    :>> perspectiveType = UncertaintyPerspectiveType::Subjective;
                    :>> patternType = PatternType::Random;
                    :>> beliefStatement = securitySystemState;
                    :>> sources = securitySystem.button;
                    :>> indeterminacySpecifications = securitySystem.button.normalButton;
                }

            transition idleToFailedMonitoring
                first idle
                accept EnableMonitoring
                then failedToEnableMonitoring {
                    @uncertaintyAction;
                    @uncertaintyPerspectiveAction;
                    @patternAction;

                    :>> kind = UncertaintyKind::OccurrenceUncertainty;
                    :>> nature = UncertaintyNature::Epistemic;
                    :>> reducibility = ReducibilityLevel::PartiallyReducible;
                    :>> perspectiveType = UncertaintyPerspectiveType::Subjective;
                    :>> patternType = PatternType::Random;
                    :>> beliefStatement = securitySystemState;
                    :>> sources = securitySystem.button;
                    :>> indeterminacySpecifications = securitySystem.button.brokenDownButton;
                }
        }
    }
}
```

In this example, `Button` is marked as an indeterminacy source, the two constraints specify its possible conditions, and the transitions `idleToMonitoring` and `idleToFailedMonitoring` are specified as uncertainties associated with the belief statement `securitySystemState`.


