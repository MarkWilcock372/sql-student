SELECT
    ps.PatientId
    , DATEADD(DAY, -14, ps.AdmittedDate) AS ReminderDate
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    , ps.AdmittedDate
    , ps.DischargeDate
    , ps.Hospital 
    , ps.Ward
    , ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ( 'Kingston', 'PRUH')
    -- AND ps.Ward LIKE '%Surgery'
    AND ps.AdmittedDate >= DATEFROMPARTS(2024, 2, 27)
    AND ps.DischargeDate BETWEEN '2024-03-03' AND '2024-03-05'
    AND ps.Tariff > 7
ORDER BY 
    ps.AdmittedDate
    , ps.DischargeDate


SELECT
    ps.Hospital
    , COUNT(*) AS NumberOfPatients 
    , SUM(ps.Tariff) AS TotalTariff
    , AVG(ps.Tariff) AS AverageTariff
FROM PatientStay ps
--where ps.Hospital in ('Oxleas', 'PRUH')
GROUP BY ps.Hospital
HAVING Count(*) > 10
ORDER BY NumberOfPatients DESC

SELECT *
FROM DimHospitalBad

SELECT
    ps.PatientId     
    ,h.Hospital     
    ,ps.AdmittedDate
    ,h.HospitalType
    ,h.HospitalSize
FROM
    PatientStay ps RIGHT JOIN DimHospitalBad h ON ps.Hospital = h.Hospital