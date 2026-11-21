-- =====================================================
-- DA Banking Project | Step 1: create schema and tables
-- =====================================================
CREATE DATABASE IF NOT EXISTS banking_data;
USE banking_data;

DROP TABLE IF EXISTS loan_data;
CREATE TABLE loan_data (
  Account_ID VARCHAR(20) PRIMARY KEY,
  Client_ID INT,
  Client_Name VARCHAR(60),
  Age_Group VARCHAR(10),
  Age INT,
  Date_of_Birth DATE,
  Gender VARCHAR(10),
  Caste VARCHAR(20),
  Religion VARCHAR(20),
  Home_Ownership VARCHAR(20),
  Bank_Name VARCHAR(20),
  Branch_Name VARCHAR(60),
  BH_Name VARCHAR(80),
  Center_Id INT,
  City VARCHAR(60),
  Region_Name VARCHAR(40),
  State_Abbr VARCHAR(5),
  State_Name VARCHAR(40),
  Credit_Officer_Name VARCHAR(80),
  Disb_By VARCHAR(80),
  Disbursement_Date DATE,
  Disbursement_FY VARCHAR(10),
  Close_Client VARCHAR(5),
  Closed_Date DATE,
  Next_Meeting_Date DATE,
  Loan_Status VARCHAR(30),
  Transfer_Logic VARCHAR(30),
  Product_Code VARCHAR(10),
  Product_ID VARCHAR(20),
  Purpose_Category VARCHAR(40),
  Grade VARCHAR(15),
  Sub_Grade VARCHAR(15),
  Verification_Status VARCHAR(20),
  Is_Delinquent_Loan CHAR(1),
  Is_Default_Loan CHAR(1),
  Delinq_2_Yrs INT,
  Application_Type VARCHAR(15),
  Loan_Amount DECIMAL(12,2),
  Funded_Amount DECIMAL(12,2),
  Funded_Amount_Inv DECIMAL(12,2),
  Term_Months INT,
  Int_Rate DECIMAL(6,4),
  Total_Pymnt DECIMAL(14,4),
  Total_Pymnt_Inv DECIMAL(14,4),
  Total_Rec_Prncp DECIMAL(14,4),
  Total_Fees DECIMAL(12,4),
  Total_Rec_Int DECIMAL(14,4),
  Total_Rec_Late_Fee DECIMAL(12,6),
  Recoveries DECIMAL(12,4),
  Collection_Recovery_Fee DECIMAL(12,4),
  Loan_Maturity VARCHAR(10)
);

DROP TABLE IF EXISTS debit_credit;
CREATE TABLE debit_credit (
  Customer_ID VARCHAR(40) PRIMARY KEY,
  Customer_Name VARCHAR(60),
  Account_Number BIGINT,
  Transaction_Date DATE,
  Transaction_Type VARCHAR(10),
  Amount DECIMAL(12,2),
  Balance DECIMAL(12,2),
  Description VARCHAR(40),
  Branch VARCHAR(30),
  Transaction_Method VARCHAR(20),
  Currency VARCHAR(5),
  Bank_Name VARCHAR(40)
);
