-- Validation: TX_NEW should not exceed TX_CURR
SELECT
    t.YearName,
    t.MonthName,
    f.Facility,
    SUM(CASE WHEN de.DataElement = 'TX_NEW' THEN d.Value ELSE 0 END) AS TX_NEW,
    SUM(CASE WHEN de.DataElement = 'TX_CURR' THEN d.Value ELSE 0 END) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Facility f ON d.FacilityID = f.FacilityID
JOIN dbo.Time t ON d.TimeKey = t.TimeKey
GROUP BY
    t.YearName,
    t.MonthName,
    f.Facility
HAVING
    SUM(CASE WHEN de.DataElement = 'TX_NEW' THEN d.Value ELSE 0 END) >
    SUM(CASE WHEN de.DataElement = 'TX_CURR' THEN d.Value ELSE 0 END);
 -- Validation: HTS_POS should not exceed HTS_TST
SELECT
    t.YearName,
    t.MonthName,
    f.Facility,
    SUM(CASE WHEN de.DataElement = 'HTS_POS' THEN d.Value ELSE 0 END) AS HTS_POS,
    SUM(CASE WHEN de.DataElement = 'HTS_TST' THEN d.Value ELSE 0 END) AS HTS_TST
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Facility f ON d.FacilityID = f.FacilityID
JOIN dbo.Time t ON d.TimeKey = t.TimeKey
GROUP BY
    t.YearName,
    t.MonthName,
    f.Facility
HAVING
    SUM(CASE WHEN de.DataElement = 'HTS_POS' THEN d.Value ELSE 0 END) >
    SUM(CASE WHEN de.DataElement = 'HTS_TST' THEN d.Value ELSE 0 END);


-- Missing Gender or Age Group
SELECT *
FROM dbo.Data
WHERE GenderID IS NULL
   OR AgeGroupID IS NULL;
   
          