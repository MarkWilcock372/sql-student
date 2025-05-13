-- This SQL query counts the number of patients in each hospital
SELECT Hospital, COUNT(*) FROM PatientStay GROUP by Hospital