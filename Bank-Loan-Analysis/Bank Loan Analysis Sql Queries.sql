create database bank_loan;
use bank_loan;
select * from financial_loan;

--  KPI's

----
select count(id) as TotalLoanApplications from financial_loan;

select count(id) as Total_Applications from financial_loan where month(issue_date) = 12;

select count(id) as Total_Applications from financial_loan where month(issue_date) = 11;

----
select sum(loan_amount) as Total_Funded_Amount from financial_loan;

select sum(loan_amount) as MTD_Total_Funded_Amount from financial_loan where month(issue_date) = 12 and year(issue_date) = 2021;

select sum(loan_amount) as PMTD_Total_Funded_Amount from financial_loan where month(issue_date) = 11 and year(issue_date) = 2021;

----
select sum(total_payment) as Total_Received_Amount from financial_loan;

select sum(total_payment) as MTD_Total_Received_Amount from financial_loan where month(issue_date) = 12 and year(issue_date) = 2021;

select sum(total_payment) as PMTD_Total_Received_Amount from financial_loan where month(issue_date) = 11 and year(issue_date) = 2021;

----
select round(avg(int_rate)*100,2) as Avg_Interest_Rate from financial_loan;

select round(avg(int_rate)*100,2) as MTD_Avg_Interest_Rate from financial_loan where month(issue_date) = 12 and year(issue_date) = 2021;

select round(avg(int_rate)*100,2) as PMTD_Avg_Interest_Rate from financial_loan where month(issue_date) = 11 and year(issue_date) = 2021;

----
select round(avg(dti)*100,2) as Avg_DTI from financial_loan;

select round(avg(dti)*100,2) as MTD_Avg_DTI from financial_loan where month(issue_date) = 12 and year(issue_date) = 2021;

select round(avg(dti)*100,2) as PMTD_Avg_DTI from financial_loan where month(issue_date) = 11 and year(issue_date) = 2021;


----
-- Good loan Application
select count(id) as Good_Loan_Application from financial_loan where loan_status in ('Fully Paid', 'Current ');

-- Good loan application percentage
select round((count(case when loan_status in ('Fully Paid', 'Current ') then id end)*100) /
count(id),2) as Good_Loan_Percentage
from financial_loan;

-- Good loan funded amount
select sum(loan_amount) as Good_Loan_Funded_Amount from financial_loan where loan_status in ('Fully Paid', 'Current ');

-- Good laon total received amount
select sum(total_payment) as Good_Loan_Received_Amount from financial_loan where loan_status in ('Fully Paid', 'Current ');

----
-- Bad loan Application
select count(id) as Bad_Loan_Application from financial_loan where loan_status = 'Charged Off';

-- Bad loan application percentage
select round((count(case when loan_status = 'Charged Off' then id end)*100) /
count(id),2) as Bad_Loan_Percentage
from financial_loan;

-- Bad loan funded amount
select sum(loan_amount) as Bad_Loan_Funded_Amount from financial_loan where loan_status = 'Charged Off';

-- Bad laon total received amount
select sum(total_payment) as Bad_Loan_Received_Amount from financial_loan where loan_status = 'Charged Off';


----

select 
loan_status,
count(id) as Total_Loan_Application,
sum(total_payment) as Total_Amount_Received,
sum(loan_amount) as Total_Funded_Amount,
avg(int_rate*100) as Iterest_Rate,
avg(dti*100) as Avg_DTI
from financial_loan group by loan_status; 

----

select 
loan_status,
sum(total_payment) as MTD_Total_Amount_Received,
sum(loan_amount) as MTD_Total_Funded_Amount
from financial_loan  where month(issue_date) = 12 group by loan_status; 

----

select 
month(issue_date) as Month_Number,
datename(month,issue_date)as Month_Name,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by month(issue_date), datename(month,issue_date)
order by month(issue_date);

----

select 
address_state,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by address_state
order by address_state;

----

select 
address_state,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by address_state
order by sum(loan_amount) desc;

----

select 
address_state,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by address_state
order by count(id);

----

select 
term,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by term
order by term;

----

select 
emp_length,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by emp_length
order by count(id) desc;

----

select 
purpose,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by purpose
order by count(id) desc;

----

select 
home_ownership,
count(id) as Total_Loan_Application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Received
from financial_loan group by home_ownership
order by count(id) desc;