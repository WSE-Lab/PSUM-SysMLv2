# PSUM-SysMLv2 Semantic Metadata Library

This directory provides the semantic metadata library of PSUM-SysMLv2.

## The library file
`PSUM-SysMLv2-SemanticMetadata-TypeSpecific.sysml` defines two library packages:

- `PSUM-SysMLv2-TypeSpecific`: defines the PSUM-SysMLv2 concepts as type-specific SysMLv2 definitions/usages.
- `PSUM-SysMLv2-TypeSpecific-Metadata`: defines semantic metadata constructs that can be applied to SysMLv2 definitions/usages.

## How To Use

To use this library in a SysMLv2 model, import both packages:

```sysml
private import 'PSUM-SysMLv2-TypeSpecific'::*;
private import 'PSUM-SysMLv2-TypeSpecific-Metadata'::*;
```

- **The first import** provides access to the PSUM-SysMLv2 enumerations.

  The enumerations include:

  | Enumeration | Literals |
  | --- | --- |
  | `IndeterminacyNature` | `InsufficientResolution`, `MissingInfo`, `NonDeterminism`, `Unclassified`, `Custom` |
  | `EvidenceType` | `EmpiricalEvidence`, `TheoremProvingResults`, `InferenceBasedOnEmpiricalData`, `CommonKnowledge` |
  | `UncertaintyKind` | `OccurrenceUncertainty`, `ContentUncertainty`, `TimeUncertainty`, `LocationUncertainty`, `EnvironmentUncertainty` |
  | `UncertaintyNature` | `Aleatory`, `Epistemic` |
  | `ReducibilityLevel` | `FullyReducible`, `PartiallyReducible`, `Irreducible` |
  | `UncertaintyPerspectiveType` | `Subjective`, `Objective` |
  | `PatternType` | `Periodic`, `Persistent`, `Sporadic`, `Transient`, `Random` |

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

## Example

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
