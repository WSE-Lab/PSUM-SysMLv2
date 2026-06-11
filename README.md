# Integrating PSUM-Based Uncertainty Modeling into SysML v2

This repository provides supporting materials for the paper titled  **Integrating PSUM-Based Uncertainty Modeling into SysML v2**.

- The [realization](realization) directory contains the realization artifacts for PSUM-SysMLv2, including **the implemented profile**, **the semantic metadata library**, and **the complete set of constraints**.

  - [realization/profile](realization/profile) contains the MOF XMI specification of the PSUM-SysMLv2 profile abstract syntax as well as the concrete syntax.
    > **Note:** `KerML_only_xmi.uml` and `SysML_only_xmi.uml` are sourced from the
    > official SysML v2 Pilot Implementation repository:
    > https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation

  - [realization/semantic-metadata](realization/semantic-metadata) contains the type-specific SysML v2 semantic metadata library.

  - [realization/Constraints.md](realization/Constraints.md) contains the complete OCL constraint specification of PSUM-SysMLv2.


- The [case-studies](case-studies) directory contains the raw results of the case studies, including the original SysML v2 models and the corresponding models extended with PSUM-SysMLv2.
