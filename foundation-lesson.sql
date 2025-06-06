SELECT 
    ps.PatientId
    , ps.AdmittedDate
    , ps.DischargeDate
    , ps.Hospital 
    , ps.Ward
FROM PatientStay ps
WHERE ps.Hospital IN ( 'Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
