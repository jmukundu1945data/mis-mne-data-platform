# Data Flow

## Introduction

This document describes how data moves through the MIS platform, from source systems to analytical outputs.

The data flow reflects a practical ETL/ELT approach commonly used in public sector M&E systems, where data originates from multiple sources and must be standardized, validated, and transformed for reporting.

---

## Overview of Data Flow
Data Collection → Staging → Transformation → Data Warehouse → Reporting


Each stage plays a specific role in ensuring data quality, consistency, and usability.

---

## 1. Data Collection (Source Systems)

Data is collected at facility or programme level through:

- Routine reporting tools
- National systems (e.g. DHIS2 or similar)
- Programme-specific data collection platforms

Characteristics of source data:

- Often incomplete or inconsistent
- Stored in normalized (transactional) structures
- Optimized for data entry, not analysis

---

## 2. Data Ingestion / Staging Layer

Raw data is ingested into staging tables with minimal transformation.

Purpose of staging:

- Preserve original data for traceability
- Provide a controlled environment for transformation
- Isolate source system inconsistencies

Typical activities:

- Data extraction (manual uploads, API, database replication)
- Basic type validation
- Initial data profiling

---

## 3. Transformation Layer

The transformation layer prepares data for analytical use.

Key processes include:

- Standardization of field names and formats
- Mapping of indicators to DataElement dimension
- Assignment of surrogate keys
- Joining of reference data (e.g. facility hierarchy)
- Application of business rules

This layer can be implemented using:

- SQL scripts
- dbt models (recommended for modularity and version control)

---

## 4. Data Quality Validation

Data quality checks are applied during and after transformation.

Examples include:

- Indicator consistency checks (e.g. TX_NEW ≤ TX_CURR)
- Completeness checks (missing age or gender)
- Detection of outliers or anomalies

Outputs:

- Validation reports
- Exception tables
- Flags used in reporting tools

---

## 5. Data Warehouse (Star Schema)

Validated data is loaded into the dimensional model.

Characteristics:

- Structured for analytical queries
- Optimized for aggregation
- Supports multi-dimensional reporting

This layer serves as the single source of truth for reporting.

---

## 6. Semantic Layer

The semantic layer defines business logic and metrics.

Examples:

- Indicator totals (e.g. TX_CURR)
- Trends (e.g. month-on-month growth)
- Ratios and performance indicators

This layer is typically implemented in reporting tools such as Power BI.

---

## 7. Reporting & Analytics

Final outputs include:

- Dashboards for programme monitoring
- Routine reports for stakeholders
- Analytical views for decision support

These outputs are used by:

- Programme managers
- M&E teams
- Government stakeholders
- Development partners

---

## Data Flow Characteristics

The data flow is designed to be:

- **Traceable**: Data can be tracked from source to report
- **Auditable**: Transformations and validations are documented
- **Scalable**: Additional data sources can be integrated
- **Flexible**: Supports evolving reporting requirements

---

## Summary

The data flow ensures that raw operational data is transformed into reliable, structured, and actionable information that supports effective Monitoring & Evaluation processes.


Each stage plays a specific role in ensuring data quality, consistency, and usability.

---

## 1. Data Collection (Source Systems)

Data is collected at facility or programme level through:

- Routine reporting tools
- National systems (e.g. DHIS2 or similar)
- Programme-specific data collection platforms

Characteristics of source data:

- Often incomplete or inconsistent
- Stored in normalized (transactional) structures
- Optimized for data entry, not analysis

---

## 2. Data Ingestion / Staging Layer

Raw data is ingested into staging tables with minimal transformation.

Purpose of staging:

- Preserve original data for traceability
- Provide a controlled environment for transformation
- Isolate source system inconsistencies

Typical activities:

- Data extraction (manual uploads, API, database replication)
- Basic type validation
- Initial data profiling

---

## 3. Transformation Layer

The transformation layer prepares data for analytical use.

Key processes include:

- Standardization of field names and formats
- Mapping of indicators to DataElement dimension
- Assignment of surrogate keys
- Joining of reference data (e.g. facility hierarchy)
- Application of business rules

This layer can be implemented using:

- SQL scripts
- dbt models (recommended for modularity and version control)

---

## 4. Data Quality Validation

Data quality checks are applied during and after transformation.

Examples include:

- Indicator consistency checks (e.g. TX_NEW ≤ TX_CURR)
- Completeness checks (missing age or gender)
- Detection of outliers or anomalies

Outputs:

- Validation reports
- Exception tables
- Flags used in reporting tools

---

## 5. Data Warehouse (Star Schema)

Validated data is loaded into the dimensional model.

Characteristics:

- Structured for analytical queries
- Optimized for aggregation
- Supports multi-dimensional reporting

This layer serves as the single source of truth for reporting.

---

## 6. Semantic Layer

The semantic layer defines business logic and metrics.

Examples:

- Indicator totals (e.g. TX_CURR)
- Trends (e.g. month-on-month growth)
- Ratios and performance indicators

This layer is typically implemented in reporting tools such as Power BI.

---

## 7. Reporting & Analytics

Final outputs include:

- Dashboards for programme monitoring
- Routine reports for stakeholders
- Analytical views for decision support

These outputs are used by:

- Programme managers
- M&E teams
- Government stakeholders
- Development partners

---

## Data Flow Characteristics

The data flow is designed to be:

- **Traceable**: Data can be tracked from source to report
- **Auditable**: Transformations and validations are documented
- **Scalable**: Additional data sources can be integrated
- **Flexible**: Supports evolving reporting requirements

---

## Summary

The data flow ensures that raw operational data is transformed into reliable, structured, and actionable information that supports effective Monitoring & Evaluation processes.

