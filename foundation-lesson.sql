SELECT 
    ps.PatientId
    , ps.AdmittedDate
    , ps.DischargeDate
    , ps.Hospital 
    , ps.Ward
    , ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ( 'Kingston', 'PRUH')
-- AND ps.Ward LIKE '%Surgery'
AND ps.AdmittedDate >= '2024-03-01'
AND ps.DischargeDate BETWEEN '2024-03-03' AND '2024-03-05'
AND ps.Tariff > 7
ORDER BY 
    ps.AdmittedDate
    , ps.DischargeDate
