-- TX_CURR Trend (Monthly)
SELECT
    t.YearName,
    t.MonthID,
    t.MonthName,
    SUM(d.Value) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Time t ON d.TimeKey = t.TimeKey
WHERE de.DataElement = 'TX_CURR'
GROUP BY
    t.YearName,
    t.MonthID,
    t.MonthName
ORDER BY
    t.YearName,
    t.MonthID;

-- TX_NEW vs TX_CURR Comparison
SELECT
    t.YearName,
    t.MonthID,
    SUM(CASE WHEN de.DataElement = 'TX_NEW' THEN d.Value ELSE 0 END) AS TX_NEW,
    SUM(CASE WHEN de.DataElement = 'TX_CURR' THEN d.Value ELSE 0 END) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Time t ON d.TimeKey = t.TimeKey
GROUP BY
    t.YearName,
    t.MonthID
ORDER BY
    t.YearName,
    t.MonthID;

-- TX_CURR by Age Group and Gender
SELECT
    g.Gender,
    ag.AgeGroupName,
    SUM(d.Value) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Gender g ON d.GenderID = g.GenderID
JOIN dbo.AgeGroup ag ON d.AgeGroupID = ag.AgeGroupID
WHERE de.DataElement = 'TX_CURR'
GROUP BY
    g.Gender,
    ag.AgeGroupName
ORDER BY
    g.Gender,
    ag.AgeGroupName;


-- TX_CURR by Province
SELECT
    p.Province,
    SUM(d.Value) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Facility f ON d.FacilityID = f.FacilityID
JOIN dbo.District di ON f.DistrictID = di.DistrictID
JOIN dbo.Province p ON di.ProvinceID = p.ProvinceID
WHERE de.DataElement = 'TX_CURR'
GROUP BY
    p.Province
ORDER BY
    TX_CURR DESC;


-- Top 10 Facilities by TX_CURR
SELECT TOP 10
    f.Facility,
    SUM(d.Value) AS TX_CURR
FROM dbo.Data d
JOIN dbo.DataElement de ON d.DataElementID = de.DataElementID
JOIN dbo.Facility f ON d.FacilityID = f.FacilityID
WHERE de.DataElement = 'TX_CURR'
GROUP BY
    f.Facility
ORDER BY
    TX_CURR DESC;
    
                    