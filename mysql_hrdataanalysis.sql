use hr_analysis;
set sql_safe_updates = 0;

select * from hr_data;

#1 clean the table, making appropriate changes where needed

alter table hr_data change column ï»¿Employee_Name Employee_name varchar(30) not null;

describe hr_data;

update hr_data 
set DateofTermination = case
	when DateofTermination like '%/%' then date_format(str_to_date(DateofTermination, '%m/%d/%Y'), '%Y-%m-%d')
end;

update hr_data 
set DateofHire = date_format(str_to_date(DateofHire, '%m/%d/%Y'), '%Y-%m-%d')
where DateofHire like '%/%';

update hr_data 
set LastPerformanceReview_Date = date_format(str_to_date(LastPerformanceReview_Date, '%m/%d/%Y'), '%Y-%m-%d')
where LastPerformanceReview_Date like '%/%';

update hr_data 
set DOB = date_format(str_to_date(DOB, '%m/%d/%Y'), '%Y-%m-%d')
where DOB like '%/%';

alter table hr_data modify column DateofHire date;
alter table hr_data modify column DateofTermination date;
alter table hr_data modify column LastPerformanceReview_Date date;
alter table hr_data modify column DOB date;

#2 add age column

alter table hr_data add column age int not null;

update hr_data 
set age = year(curdate()) - year(DOB);

#3 what is the gender breakdown of employees in the company

select sex, count(*) as count from hr_data
group by sex;

#4 what is the race/ethnicity breakdown in the company

select RaceDesc, count(*) as count 
from hr_data
group by RaceDesc
order by count desc;

#5 what is the age distribution of employees in the company

select 
case
when age >= 26 and age <= 35 then '26-35'
when age >= 36 and age <= 45 then '36-45'
when age >= 46 and age <= 55 then '46-55'
when age >= 56 and age <= 65 then '56-65'
else '66+' 
end as age_distribution,
count(*) as count
from hr_data
group by age_distribution
order by count desc;

#5 what is the age distribution for each gender of employees in the company

select 
case
when age >= 26 and age <= 35 then '26-35'
when age >= 36 and age <= 45 then '36-45'
when age >= 46 and age <= 55 then '46-55'
when age >= 56 and age <= 65 then '56-65'
else '66+' 
end as age_distribution, sex,
count(*) as count
from hr_data
group by age_distribution, sex
order by count desc;

#6 what are the number of employees per department

select Department, count(*) as count
from hr_data
group by Department
order by count desc;

#7 what department has the hightest number of terminations

select department, count(*) as count
from hr_data
where DateofTermination is not null
group by department
order by count desc;

#8 what is the average length of employment for employees that have been terminated

select round(avg(year(DateofTermination) - year(DateofHire))) as avg_length_emp
from hr_data
where DateofTermination is not null;

#9 how does sex distribution vary across departments

select department, sex, count(*) as count
from hr_data
group by department, sex
order by count desc;

#10 what department has the highest termination rate

select department, total_count, termination_count, round(total_count/termination_count) as termination_rate
from(
	select department,
    count(*) as total_count,
    count(DateofTermination) as termination_count
    from hr_data
    group by department
) as subquery
order by termination_rate desc;

#11 what department has the highest number of ascences

select department, absences as count
from hr_data
group by department
order by count desc;

#12 what department has the highest average salary

update hr_data set
salary = replace(salary, '$', ' ');

update hr_data set
salary = replace(salary, ',', '');
 
 alter table hr_data modify column salary int;
 
select department, round(avg(salary)) as avg_salary
from hr_data
group by department
order by avg_salary desc;

#12 what position has the highest average salary

select position, round(avg(salary)) as avg_salary
from hr_data
group by position
order by avg_salary desc;




