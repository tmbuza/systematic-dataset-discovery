# CDI Systematic Dataset Discovery

A reproducible framework for identifying, screening,
evaluating, and prioritizing public omics studies
before data acquisition.

## CDI Systematic Dataset Discovery Workflow

```mermaid
flowchart TD

    A[Research Question]
    --> B[Search Strategy]

    B --> C[Study Discovery]

    C --> D[Eligibility Criteria]

    D --> E[Dataset Screening]

    E --> F[Study Prioritization]

    F --> G[Included Studies]

    G --> H["CDI Data Acquisition System<br/>(Backend)"]

    H --> I[Reference Dataset Package]
```
