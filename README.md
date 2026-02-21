## Snowflake ELT & Data Quality Platform

Airflow-Orchestrated Modern Data Warehouse POC

## Overview

This repository implements a production-style ELT (Extract–Load–Transform) proof-of-concept using Apache Airflow and Snowflake to simulate a modern cloud-native data warehouse architecture.

The project demonstrates:

- Orchestrated ingestion of raw data
- Layered warehouse modeling (RAW → CURATED)
- Automated data quality validations
- Modular SQL-based transformations
- Infrastructure-as-code via Docker
- Executor-aware Airflow configuration

This POC is intentionally designed to mirror real-world enterprise data engineering workflows, while remaining modular and extensible.

## Architectural Philosophy

The system follows a control-plane / data-plane separation model:

- Control Plane → Apache Airflow (orchestration & scheduling)
- Data Plane → Snowflake (compute & storage)

This separation ensures:

- Loose coupling between orchestration and compute engine
- Swap-ready warehouse backend (e.g., Postgres → Snowflake)
- Clear ownership of metadata vs business data

## High-Level Flow
```
Source Data (CSV / API)
        │
        ▼
RAW Schema (Landing Layer)
        │
        ▼
CURATED Schema (Analytics Layer)
        │
        ▼
Data Quality Checks
        │
        ▼
Logging & Observability
```

## Layered Warehouse Design
### RAW Layer

Purpose:

- Immutable landing zone
- Minimal transformation
- Schema preservation
- Traceability via ingestion timestamp

Characteristics:

- Append-only pattern
- No business logic
- Optimized for auditability

### CURATED Layer

Purpose:

- Analytics-ready modeling
- Clean column naming
- Fact-style table design

Characteristics:

- Transformation inside warehouse (ELT pattern)
- Deterministic SQL logic
- Ready for BI / downstream modeling

### DQ (Data Quality) Layer

Purpose:

- Automated validation of critical assumptions

Checks include:

- Null primary keys
- Negative value validation
- Duplicate detection
- Row count verification
- Results are persisted for observability and pipeline auditability.

## Orchestration Strategy

The pipeline is orchestrated via Apache Airflow using:

- DAG-based task dependencies
- Explicit SQL execution operators
- Executor-aware configuration (LocalExecutor for dev; Celery-ready for scale)
- Metadata DB migration on startup

Design decisions:

- Tasks are atomic and idempotent
- SQL is externalized into version-controlled files
- Fail-fast approach for data quality violations
- Containerized runtime for reproducibility

## Snowflake Integration (Target Architecture)

When connected to Snowflake:

- Virtual warehouse handles compute isolation
- Schemas follow RAW / CURATED / DQ segregation
- Warehouse auto-suspend for cost control
- SQL-based transformations leverage Snowflake compute

The project intentionally avoids tight coupling to Snowflake-specific syntax to allow backend portability, while maintaining compatibility with advanced features (Streams, Tasks, incremental models) in future iterations.

## Project Structure
```
snowflake-elt-dq/
 ├ dags/
 │   └ snowflake_elt_dq.py
 ├ sql/
 │   ├ create_tables.sql
 │   ├ transform.sql
 │   └ dq_checks.sql
 ├ data/
 │   └ orders.csv
 ├ Dockerfile
 ├ docker-compose.yml
 └ entrypoint.sh
 ```

### Key Design Principle:

SQL logic is decoupled from orchestration logic.

## Engineering Concepts Demonstrated

This POC intentionally surfaces and solves:

- Metadata database initialization & migration
- Executor architecture differences (Local vs Celery)
- Volume mounting & containerized development
- Separation of orchestration from compute
- Environment-driven configuration
- Schema versioning awareness
- Failure handling in distributed workflows

## Extensibility Roadmap

Planned Enhancements:

- dbt-based transformation layer
- Incremental loading strategy
- Slowly Changing Dimensions (SCD Type 2)
- Snowflake Streams & Tasks
- Cloud object storage staging (S3 / GCS)
- CI/CD pipeline integration
- Observability & metrics dashboard

## Design Intent

This is not a toy pipeline.

It is a structured, extensible foundation intended to evolve into:
- A production-grade data warehouse simulation
- A Snowflake-native ELT reference implementation
- A demonstration of infrastructure fluency in data engineering

The goal is not to “use Snowflake,”
but to demonstrate architectural thinking around:

- Orchestration
- Modeling
- Data quality
- Cost-awareness
- Operational reliability

## Conclusion

This repository represents a deliberate step toward production-ready data engineering practices, emphasizing:

- System design clarity
- Reproducibility
- Modularity
- Observability
- Backend portability

It is built to be iterated upon — not discarded.