# Bank Loan & Debit/Credit Analytics Dashboard

End-to-end analysis of **65,535 bank loan accounts** and **1,00,000 branch transactions**. I built it in **Excel, MySQL, Tableau and Power BI** as part of the Certificate Program in Data Analyst (ExcelR), and the headline KPIs match across all four tools.

---

## Business questions
1. How much has the bank lent and collected, and how much of it comes from interest?
2. How risky is the loan book? What are the default and delinquency rates?
3. Which states, products and branches drive lending?
4. How balanced are credits and debits across branches, and how many transactions look high-risk?

## Datasets
| Dataset | Size | Period |
| --- | --- | --- |
| Bank Loan Analytics | 65,535 loan accounts · 52 raw columns | 2016-Q4 to 2020-Q1 |
| Debit & Credit Banking Data | 1,00,000 transactions · 11 raw columns | Jan 2024 to Dec 2024 |

The two datasets share no common key, so they are presented as two separate dashboards.

## Tools and skills
| Tool | What I did |
| --- | --- |
| **Excel** | Cleaned both datasets (duplicate column names, blanks, data types). Built interactive dashboards on PivotTables with a shared PivotCache, GETPIVOTDATA-driven KPI cards, slicers and a timeline |
| **MySQL 8** | Designed the `banking_data` schema (2 typed tables), loaded about 1.65 lakh rows, and wrote a KPI query library using conditional aggregation, TOP-10 rankings, CTEs and window functions (`LAG()`, `SUM() OVER`) |
| **Tableau** | Bank Loan Analytics and Bank Debit & Credit dashboards (33 worksheets) with interactive filters |
| **Power BI** | Report pages with DAX measures such as Default Rate %, Delinquent Clients and Branch MoM Growth % |
| **QA** | Cross-checked the headline KPIs across Excel, MySQL, Tableau and Power BI. All matched. |

## Data cleaning highlights
- Fixed duplicate column names, blank values and incorrect data types
- Added derived fields: disbursement year, quarter and month, total revenue, loan maturity, active status and a transaction risk flag
- Defined **30 KPIs**: 18 for loans and 12 for debit & credit

## Key KPIs – Loan dashboard
| KPI | Value |
| --- | --- |
| Total loans | 65,535 |
| Total funded amount | ₹73.27 Cr |
| Total collection (principal + interest) | ₹80.83 Cr |
| Interest received | ₹15.53 Cr |
| Default loan rate | 1.56% |
| Delinquent loan rate | 10.84% |

## Key insights
**Loans**
1. **Delinquency is the real risk, not default.** Only 1.56% of loans defaulted, but **10.8% are delinquent**, about 7× higher. That points to an early-warning and collections opportunity.
2. **Lending is concentrated in three states.** Uttar Pradesh, Punjab and Bihar account for **49%** of the total loan amount.
3. **Home loans dominate the portfolio** at **37%** of the loan amount, followed by Services (21%) and Business (11%).
4. **This is a women-focused microfinance book.** Over **99.9%** of borrowers are female.
5. **Disbursements peaked in 2018** at ₹28.9 Cr, then slowed in 2019. **55%** of loans are still active.

**Debit & Credit**
1. **Inflows and outflows are almost perfectly balanced.** The credit-to-debit ratio is **100.25%**, with each side at about 12.7 crore.
2. **Payment methods are evenly split.** Debit card, bank transfer and credit card each carry about **33%** of transactions.
3. **The risk rule needs tuning.** The "> 2,500" high-risk threshold flags **51%** of all transactions, which is too broad to be useful for fraud review.
4. **December is partial.** The data ends on 1 Dec 2024, so the December dip is a data gap, not a real decline.

## Repository contents
| File | Description |
| --- | --- |
| `Bank_Loan_Analytics_Dashboard_GitHub.xlsx` | Loan dashboard: cleaned data, KPI calculations, pivot analysis, interactive dashboard, cleaning log |
| `Bank_Debit_Credit_Dashboard_GitHub.xlsx` | Debit & Credit dashboard: data, KPI sheets, dashboard, cleaning log |
| `SQL/` | `01_create_schema.sql`, data load scripts (`02_…`, `03_…`) and `04_kpi_queries.sql` |
| `DA_Banking_Dashboards.twbx` | Packaged Tableau workbook (data included) |
| `DA_Banking_Dashboards.pbix` | Power BI report |
| `DA_Banking_Final_Presentation.pptx` | Final project presentation |

The Excel files are compressed copies made to fit GitHub's 25 MB upload limit. The pivot tables refresh automatically from the data sheet when the file is opened; click **Enable Content** if Excel asks.

## How to open
- **Excel:** open either `_GitHub.xlsx` file and use the slicers on the Dashboard sheet
- **MySQL:** run the scripts in the `SQL` folder in order: `01` → `02` → `03` → `04`
- **Tableau:** open the `.twbx` in Tableau Desktop or Tableau Public
- **Power BI:** open the `.pbix` in Power BI Desktop

---
**Author:** Gowlikar Shravan Kumar · Data Analyst · Hyderabad, India
