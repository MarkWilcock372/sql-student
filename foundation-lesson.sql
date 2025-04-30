
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
AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'


