#for this project a table billing consists of the following columns 
#customer_id, customer_name, billing_id, billing_creation_date, $billing_amount.
#we are tasked with displaying the average billing amount for each customer between 2019 to 2021, 
#assume $0 billing amount if nothing is billed for a particular year but include it in the count of billings to compute average for that year

with cte as
	(select customer_id, customer_name,
	sum(case when year(billing_creation_date) = '2019' then $billing_amount else 0 end) as bill_2019,
	sum(case when year(billing_creation_date) = '2020' then $billing_amount else 0 end) as bill_2020,
	sum(case when year(billing_creation_date) = '2021' then $billing_amount else 0 end) as bill_2021,
	count(case when year(billing_creation_date) = '2019' then $billing_amount end) as count_2019,
	count(case when year(billing_creation_date) = '2020' then $billing_amount end) as count_2020,
	count(case when year(billing_creation_date) = '2021' then $billing_amount end) as count_2021
	from billing
	group by customer_id, customer_name)

select customer_id, customer_name,
round((bill_2019 + bill_2020 + bill_2021) /
(case when count_2019 = 0 then 1 else count_2019 end
 + case when count_2020 = 0 then 1 else count_2020 end
 + case when count_2021 = 0 then 1 else count_2021 end), 2) as avg_billing
from cte
