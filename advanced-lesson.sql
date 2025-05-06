SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    , ps.Tariff
    , (SELECT SUM(subq.Tariff) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId AND subq.Hospital = ps.Hospital) as CumulativeTariff
    , (SELECT COUNT(*) FROM PatientStay subq WHERE subq.PatientId <= ps.PatientId AND subq.Hospital = ps.Hospital) As PatientIndex
FROM
    PatientStay ps
ORDER BY ps.Hospital, ps.PatientId



SELECT Hospital, COUNT(*) FROM PatientStay GROUP by Hospital