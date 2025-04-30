
-- SELECT * FROM airports

SELECT 
    ps.PatientId
    , ps.Hospital
    , PS.Ward
    , ps.AdmittedDate
    , ps.DischargeDate  
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) as LengthOfStay
    , DATEADD(WEEK, -2, ps.AdmittedDate) as ReminderDate
    , ps.Tariff
    , ps.Ethnicity
FROM PatientStay ps
WHERE ps.Hospital IN ('PRUH', 'Oxleas')
AND ps.Ward LIKE '%Surgery'
-- AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
ORDER BY ps.AdmittedDate DESC, ps.PatientId DESC


SELECT 
    ps.Hospital
    , ps.Ward
    , COUNT(*) as NumberOfPatients
    , SUM(ps.Tariff) as TotalTariff
    , MAX(ps.Tariff) as MaxTariff
    , MIN(ps.Tariff) as MinTariff
    , AVG(ps.Tariff) as AvgTariff
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
-- ORDER BY ps.Hospital, ps.Ward
order by NumberOfPatients desc


SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps LEFT JOIN DimHospitalBad dh ON ps.Hospital = dh.Hospital





