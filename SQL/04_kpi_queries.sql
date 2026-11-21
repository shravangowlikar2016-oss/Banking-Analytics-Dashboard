-- =====================================================
-- DA Banking Project | Step 3: KPI queries (MySQL 8)
-- =====================================================
USE banking_data;

-- ---------- Row-count check (QA) ----------
SELECT 'loan_data' AS table_name, COUNT(*) AS row_count FROM loan_data
UNION ALL
SELECT 'debit_credit', COUNT(*) FROM debit_credit;

-- =====================================================
-- LOAN DASHBOARD KPIs
-- =====================================================

-- KPI 1-4, 11-14, 17: headline cards
SELECT
  ROUND(SUM(Funded_Amount)/1e7, 2)                              AS Total_Funded_Cr,
  COUNT(Account_ID)                                             AS Total_Loans,
  ROUND((SUM(Total_Rec_Prncp)+SUM(Total_Rec_Int))/1e7, 2)       AS Total_Collection_Cr,
  ROUND(SUM(Total_Rec_Int)/1e7, 2)                              AS Total_Interest_Cr,
  SUM(Is_Default_Loan = 'Y')                                    AS Default_Loan_Count,
  COUNT(DISTINCT CASE WHEN Is_Delinquent_Loan = 'Y' THEN Client_ID END) AS Delinquent_Client_Count,
  ROUND(AVG(Is_Delinquent_Loan = 'Y')*100, 2)                   AS Delinquent_Loan_Rate_Pct,
  ROUND(AVG(Is_Default_Loan = 'Y')*100, 2)                      AS Default_Loan_Rate_Pct,
  SUM(Verification_Status = 'Not Verified')                     AS Not_Verified_Loans
FROM loan_data;

-- KPI 5: Branch-wise revenue (top 10 by loan amount)
SELECT Branch_Name,
       ROUND(SUM(Total_Rec_Int), 2)                                   AS Interest,
       ROUND(SUM(Total_Fees), 2)                                      AS Fees,
       ROUND(SUM(Total_Rec_Int + Total_Fees + Total_Rec_Late_Fee), 2) AS Total_Revenue,
       SUM(Loan_Amount)                                               AS Loan_Amount
FROM loan_data
GROUP BY Branch_Name
ORDER BY Loan_Amount DESC
LIMIT 10;

-- KPI 6: State-wise loan
SELECT State_Name, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY State_Name ORDER BY Loan_Amount DESC;

-- KPI 7: Religion-wise loan
SELECT Religion, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY Religion ORDER BY Loan_Amount DESC;

-- KPI 8: Product group-wise loan
SELECT Purpose_Category, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY Purpose_Category ORDER BY Loan_Amount DESC;

-- KPI 9: Disbursement trend (year and quarter)
SELECT YEAR(Disbursement_Date) AS Disb_Year, QUARTER(Disbursement_Date) AS Qtr,
       COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data
GROUP BY Disb_Year, Qtr
ORDER BY Disb_Year, Qtr;

-- KPI 10: Grade-wise loan
SELECT Grade, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data WHERE Grade <> 'Not Available'
GROUP BY Grade ORDER BY Grade;

-- KPI 15: Loan status-wise loan
SELECT Loan_Status, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY Loan_Status ORDER BY Loans DESC;

-- KPI 16: Age group-wise loan
SELECT Age_Group, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY Age_Group ORDER BY Age_Group;

-- KPI 18: Loan maturity
SELECT Loan_Maturity, Term_Months, COUNT(*) AS Loans, SUM(Loan_Amount) AS Loan_Amount
FROM loan_data GROUP BY Loan_Maturity, Term_Months;

-- =====================================================
-- DEBIT & CREDIT DASHBOARD KPIs
-- =====================================================

-- KPI 1-5: headline cards
SELECT
  ROUND(SUM(CASE WHEN Transaction_Type='Credit' THEN Amount END)/1e3, 1)  AS Total_Credit_K,
  ROUND(SUM(CASE WHEN Transaction_Type='Debit'  THEN Amount END)/1e3, 1)  AS Total_Debit_K,
  ROUND(SUM(CASE WHEN Transaction_Type='Credit' THEN Amount END)
      / SUM(CASE WHEN Transaction_Type='Debit'  THEN Amount END)*100, 2) AS Credit_Debit_Ratio_Pct,
  ROUND((SUM(CASE WHEN Transaction_Type='Credit' THEN Amount ELSE 0 END)
       - SUM(CASE WHEN Transaction_Type='Debit'  THEN Amount ELSE 0 END))/1e3, 1) AS Net_Transaction_K,
  ROUND(COUNT(*)/SUM(Balance)*100, 4)                                     AS Account_Activity_Ratio_Pct
FROM debit_credit;

-- KPI 6: Transactions per month
SELECT MONTH(Transaction_Date) AS Month_No, DATE_FORMAT(Transaction_Date,'%b') AS Month,
       COUNT(*) AS Transactions, ROUND(SUM(Amount),2) AS Amount
FROM debit_credit
GROUP BY Month_No, Month ORDER BY Month_No;

-- KPI 7: Total transaction amount by branch
SELECT Branch, COUNT(*) AS Transactions, ROUND(SUM(Amount),2) AS Amount
FROM debit_credit GROUP BY Branch ORDER BY Amount DESC;

-- KPI 8: Transaction volume by bank
SELECT Bank_Name, ROUND(SUM(Amount),2) AS Amount
FROM debit_credit GROUP BY Bank_Name ORDER BY Amount DESC;

-- KPI 9: Transaction method distribution
SELECT Transaction_Method, COUNT(*) AS Transactions,
       ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER (), 2) AS Pct
FROM debit_credit GROUP BY Transaction_Method;

-- KPI 10: Branch transaction growth (month-over-month %)
WITH m AS (
  SELECT Branch, MONTH(Transaction_Date) AS Month_No, SUM(Amount) AS Amount
  FROM debit_credit GROUP BY Branch, Month_No
)
SELECT Branch, Month_No, ROUND(Amount,2) AS Amount,
       ROUND((Amount - LAG(Amount) OVER (PARTITION BY Branch ORDER BY Month_No))
             / LAG(Amount) OVER (PARTITION BY Branch ORDER BY Month_No)*100, 2) AS MoM_Growth_Pct
FROM m ORDER BY Branch, Month_No;

-- KPI 11: High-risk transaction flag (Amount > 2500)
SELECT CASE WHEN Amount > 2500 THEN 'High Risk' ELSE 'Normal' END AS Risk_Flag,
       COUNT(*) AS Transactions,
       ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER (), 2) AS Pct
FROM debit_credit GROUP BY Risk_Flag;

-- KPI 12: Suspicious transaction frequency by month
SELECT MONTH(Transaction_Date) AS Month_No, COUNT(*) AS High_Risk_Transactions
FROM debit_credit WHERE Amount > 2500
GROUP BY Month_No ORDER BY Month_No;

-- Data check: why is December low? (data ends on 1-Dec-2024)
SELECT MIN(Transaction_Date) AS First_Date, MAX(Transaction_Date) AS Last_Date FROM debit_credit;
