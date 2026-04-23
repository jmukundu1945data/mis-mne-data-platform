# Data Quality Framework

## Introduction

Data quality is a critical component of any Management Information System (MIS), particularly in Monitoring & Evaluation (M&E) environments where data is used for decision-making, reporting, and accountability.

This framework outlines a structured approach to ensuring data integrity, completeness, and reliability within the MIS platform.

---

## Principles of Data Quality

The framework is based on the following principles:

- **Accuracy**: Data correctly represents real-world values
- **Completeness**: Required fields and disaggregations are present
- **Consistency**: Related indicators follow logical rules
- **Timeliness**: Data is available for the required reporting periods
- **Traceability**: Data can be traced back to its source

---

## Data Quality Layers

Data quality is enforced across multiple layers of the system:

### 1. Source-Level Validation

Performed at data entry or collection stage:

- Mandatory fields enforced
- Basic range checks
- Controlled vocabularies (e.g. gender, age groups)

---

### 2. Transformation-Level Validation

Applied during ETL/ELT processes:

- Standardization of values
- Mapping to reference tables
- Enforcement of structural integrity

---

### 3. Indicator Logic Validation

Ensures consistency between related indicators.

#### Examples:

- **TX_NEW ≤ TX_CURR**
- **HTS_POS ≤ HTS_TST**

These rules are essential in health M&E systems and are aligned with standard reporting frameworks such as PEPFAR.

---

### 4. Completeness Checks

Ensures all required disaggregations are present:

- Age group
- Gender

Missing disaggregation reduces the usefulness of data for analysis and reporting.

---

### 5. Temporal Consistency

- No missing reporting periods
- Continuous monthly reporting
- Detection of gaps in time series

---

### 6. Anomaly Detection

Identifies unusual patterns such as:

- Sudden spikes or drops in indicator values
- Outliers at facility or district level

These may indicate:
- Data entry errors
- System issues
- Real operational changes

---

## Implementation Approach

Data quality checks can be implemented using:

### SQL Validation Queries

- Run post-load validation scripts
- Generate exception reports

### dbt Tests (Optional Extension)

- Define reusable validation tests
- Integrate into transformation pipelines

### Reporting Layer

- Highlight anomalies in dashboards
- Provide visibility to end users

---

## Example Validation Queries

### Indicator Consistency

```sql
SELECT
    t.YearName,
    t.MonthName,
    f.Facility,
    SUM(CASE WHEN de.DataElement = 'TX_NEW' THEN d.Value ELSE 0 END) AS TX_NEW,
    SUM(CASE WHEN de.DataElement = 'TX_CURR' THEN d.Value ELSE 0 END) AS TX_CURR
FROM Data d
JOIN DataElement de ON d.DataElementID = de.DataElementID
JOIN Facility f ON d.FacilityID = f.FacilityID
JOIN Time t ON d.TimeKey = t.TimeKey
GROUP BY t.YearName, t.MonthName, f.Facility
HAVING
    SUM(CASE WHEN de.DataElement = 'TX_NEW' THEN d.Value ELSE 0 END) >
    SUM(CASE WHEN de.DataElement = 'TX_CURR' THEN d.Value ELSE 0 END);


SELECT *
FROM Data
WHERE GenderID IS NULL
   OR AgeGroupID IS NULL;
   
       