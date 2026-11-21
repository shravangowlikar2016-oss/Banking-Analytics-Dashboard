-- Data fix: one Delhi loan had no state name in the source file
USE banking_data;
UPDATE loan_data SET State_Name = 'DELHI' WHERE State_Abbr = 'DL';
SELECT State_Abbr, State_Name, COUNT(*) FROM loan_data WHERE State_Abbr = 'DL' GROUP BY State_Abbr, State_Name;
