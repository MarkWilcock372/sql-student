-- Sample script for learning SQL
/*
multi line comment
This is a sample SQL script to demonstrate the use of comments,
variables, and basic SQL commands.
This script selects patient stay information from a table called PatientStay.
It filters the results based on the hospital name and ward type.
*/

SELECT 
    ps.PatientId
    , ps.Hospital
    , PS.Ward
    , ps.AdmittedDate
    , ps.DischargeDate
    , ps.Tariff
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    , DATEADD(MONTH, -1, ps.AdmittedDate) AS ReminderDate
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
--AND ps.Tariff BETWEEN 3 AND 6
order by 
    ps.AdmittedDate DESC, 
    ps.PatientId DESC

--SELECT DATEDIFF(DAY, '2025-03-12', '2025-04-08')    

