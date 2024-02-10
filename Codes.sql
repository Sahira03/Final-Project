Use capstone;
select *
from customer_churn_dataset;


-- 1 Identify the total number of customers and the churn rate; 
select count(customer_id)
from customer_churn_dataset;


select churn_status,count(churn_status)
from customer_churn_dataset
group by churn_status;

-- 2.	Find the average age of churned customers

select avg(age)
from customer_churn_dataset
where churn_status = 'yes' ;

-- 3. Discover the most common contract types among churned customers
select  contract_type, count(contract_type)
from customer_churn_dataset
where churn_status = 'yes'
group by contract_type;

-- 4.	Analyze the distribution of monthly charges among churned customers
select min(monthly_charges), max(monthly_charges), round(avg(monthly_charges),2), round(stddev(monthly_charges),2)
from customer_churn_dataset
where churn_status = 'yes';

-- 5.	Create a query to identify the contract types that are most prone to churn
select contract_type, churn_status,
case when contract_type = 'Monthly' then count(1)
when  contract_type = 'Yearly' then count(2)
 else null end as contract 
from customer_churn_dataset 
group by contract_type, churn_status;

-- 6.	Identify customers with high total charges who have churned
select customer_id,total_charges
from customer_churn_dataset
where churn_status = 'yes'
order by total_charges desc;

-- 7.	Calculate the total charges distribution for churned and non-churned customers
select customer_id, total_charges, churn_status
from customer_churn_dataset
order by churn_status;

-- 8.Calculate the average monthly charges for different contract types among churned customers
select contract_type, round(avg(monthly_charges),2)
from customer_churn_dataset
where churn_status = 'yes'
group by contract_type;

-- 9.	Identify customers who have both online security and online backup services and have not churned
select customer_id, churn_status, online_security, online_backup
from customer_churn_dataset
where churn_status = 'no'and  online_security = 'yes' and online_backup = 'yes';

-- 10.	Determine the most common combinations of services among churned customers
select internet_service, phone_service, multiple_lines, online_security, online_backup, device_protection, tech_support, streaming_tv, streaming_movies,
count(customer_id) as Combo_count
from customer_churn_dataset
where churn_status = 'yes'
group by  internet_service,phone_service, multiple_lines, online_security, online_backup, device_protection, tech_support, streaming_tv, streaming_movies
order by Combo_count desc;

-- 11.	Identify the average total charges for customers grouped by gender and marital status
select gender,marital_status,count(marital_status),round(sum(monthly_charges),2)
from customer_churn_dataset
where churn_status = 'yes'
group by gender,marital_status;

-- 12.	Calculate the average monthly charges for different age groups among churned customers
select round(avg(monthly_charges),2) as Avg_Mon_Charges,
case when age between 18 and 25 then '18-25'
 when age between 25 and 35 then '25-35'
when age between 35 and 45 then '35-45'
when age between 45 and 60 then '45-60'
when age >60  then '>60'
else null
end as age_dist
from customer_churn_dataset
group by age_dist;

-- 13.	Determine the average age and total charges for customers with multiple lines and online backup
select avg(age), sum(total_charges)
from customer_churn_dataset
where multiple_lines = 'yes' and online_backup = 'yes';

-- 14.	Identify the contract types with the highest churn rate among senior citizens (age 65 and over)
select distinct age, contract_type
from customer_churn_dataset
where churn_status = 'yes' and age >65;

-- 15.Calculate the average monthly charges for customers who have multiple lines and streaming TV
select customer_id,avg(monthly_charges) 
from customer_churn_dataset
where multiple_lines = 'yes' and streaming_tv = 'yes'
group by customer_id;

-- 16.	Identify the customers who have churned and used the most online services
select customer_id,internet_service, phone_service, multiple_lines, online_security, online_backup, device_protection, tech_support, streaming_tv, streaming_movies
from customer_churn_dataset
where churn_status = 'yes';

-- 17.	Calculate the average age and total charges for customers with different combinations of streaming services
select count(customer_id) ,streaming_tv, streaming_movies, round(avg(age),2), round(sum(total_charges),2)
from customer_churn_dataset
group by streaming_tv, streaming_movies;

-- 18.	Identify the gender distribution among customers who have churned and are on yearly contracts
select gender, count(gender)
from customer_churn_dataset
where churn_status = 'yes' and contract_type = 'yearly'
group by  gender;

-- 19.	Calculate the average monthly charges and total charges for customers who have churned, grouped by contract type and internet service type
select avg(monthly_charges), avg(total_charges), contract_type, internet_service
from customer_churn_dataset
where churn_status = 'yes'
group by contract_type, internet_service;

-- 20.	Find the customers who have churned and are not using online services, and their average total charges
select customer_id,  online_security, online_backup, avg(total_charges)
from customer_churn_dataset
where churn_status = 'yes' and online_security= 'no' and online_backup = 'no'
group by  customer_id,online_security, online_backup;

-- 21.	Calculate the average monthly charges and total charges for customers who have churned, grouped by the number of dependents
select avg(monthly_charges), avg(total_charges), dependents
from customer_churn_dataset
where churn_status = 'yes'
group by dependents;

-- 22.	Identify the customers who have churned, and their contract duration in months (for monthly contracts)
-- no adequate data

-- 23.	Determine the average age and total charges for customers who have churned, grouped by internet service and phone service
select avg(age), avg(total_charges), internet_service, phone_service
from customer_churn_dataset
where churn_status = 'yes'
group by internet_service, phone_service;

-- 24.	Create a view to find the customers with the highest monthly charges in each contract type
create view Sahi as 
select customer_id ,max(monthly_charges), contract_type
from customer_churn_dataset
group by customer_id, contract_type;

-- 25.	Create a view to identify customers who have churned and the average monthly charges compared to the overall average
create view sahi1 as
select avg(monthly_charges)
from customer_churn_dataset
union
select avg(monthly_charges)
from customer_churn_dataset
where churn_status = 'yes';

-- 26.	Create a view to find the customers who have churned and their cumulative total charges over time
create view sahi2 as
select customer_id, sum(total_charges)
from customer_churn_dataset
group by customer_id;


-- 27.	Stored Procedure to Calculate Churn Rate
create procedure Rate()
select churn_status,count(churn_status)
from customer_churn_dataset
group by churn_status;



-- 28.	Stored Procedure to Identify High-Value Customers at Risk of Churning
create procedure High()
select monthly_charges, total_charges
from customer_churn_dataset
where churn_status = 'no'
order by monthly_charges desc ,total_charges desc;
