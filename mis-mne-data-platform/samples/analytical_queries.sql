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