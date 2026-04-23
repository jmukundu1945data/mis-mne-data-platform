# Data Model Explanation

## Introduction

This document provides a detailed explanation of the dimensional data model used in the MIS platform.

The model is designed to support indicator-based reporting commonly required in Monitoring & Evaluation (M&E) systems, particularly in health and development programmes.

---

## Modelling Approach

A star schema design is used, consisting of:

- A central fact table capturing measured values
- Surrounding dimension tables providing analytical context

This approach is widely used in data warehousing due to its simplicity, performance, and suitability for reporting and analytics.

---

## Fact Table: Data

The `Data` table stores all reported indicator values at the lowest level of granularity.

### Grain

Each record represents:


One indicator value
for one facility
for one reporting period
for one age group
for one gender


This clearly defined grain is critical for ensuring consistency in aggregation and reporting.

---

## Dimension Tables

### Time Dimension

The Time dimension supports both standard calendar reporting and programme-specific reporting cycles.

Key features:
- Month and year hierarchy
- Support for PEPFAR financial year
- Enables trend analysis and period comparisons

---

### Geographic Dimensions

The geographic hierarchy is modeled as:

Facility → District → Province


This structure allows:

- Facility-level reporting (operational view)
- District-level aggregation (management view)
- Provincial/national summaries (strategic view)

---

### Data Element (Indicator Dimension)

The DataElement table defines all indicators captured in the system.

Examples include:
- TX_CURR (patients currently on treatment)
- TX_NEW (new patients initiated on treatment)
- HTS_TST (HIV tests conducted)

Key characteristics:
- Indicator definitions are decoupled from the fact table
- New indicators can be added without schema changes
- Indicators are linked to programme areas

---

### Program Dimension

The Program dimension groups indicators into logical programme areas such as:

- HIV Treatment
- HIV Testing Services
- PMTCT

This enables reporting at programme level without duplicating logic.

---

### Demographic Dimensions

#### Gender

Supports standard gender disaggregation required for reporting and analysis.

#### Age Group

Supports analysis across age bands, which is critical for:

- Target population tracking
- Programme performance monitoring

---

## Design Considerations

### 1. Indicator-Driven Design

The model supports multiple indicators within a single fact table, reducing redundancy and improving consistency.

---

### 2. Disaggregation at Source

Age and gender are captured at the lowest level, ensuring that:

- Disaggregated reporting is always possible
- No post-aggregation assumptions are required

---

### 3. Scalability

The model allows:

- Addition of new indicators
- Expansion of geographic coverage
- Integration with other programme areas

without structural changes.

---

### 4. Performance

The model is optimized for:

- Aggregation queries
- Time-based analysis
- Filtering across multiple dimensions

---

## Analytical Use Cases Supported

The model enables:

- Monthly trend analysis (e.g. TX_CURR over time)
- Indicator comparisons (e.g. TX_NEW vs TX_CURR)
- Disaggregated reporting (age, gender)
- Geographic performance analysis
- Data quality validation across indicators

---

## Summary

This dimensional model provides a flexible and scalable foundation for MIS systems that must support complex, multi-dimensional reporting requirements in M&E environments.

