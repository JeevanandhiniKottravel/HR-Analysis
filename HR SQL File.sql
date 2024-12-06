use hr_project;

create table hr_1(
Age int,
Attrition text,
BusinessTravel text,
DailyRate int,
Department text,
DistanceFromHome int,
Education int,
EducationField text,
EmployeeCount int,
EmployeeNumber int,
EnvironmentSatisfaction int,
Gender text,
HourlyRate int,
JobInvolvement int,
JobLevel int,
JobRole text,
JobSatisfaction int,
MaritalStatus text
);

load data infile 'E:/JEEVA/Project/Project4_HR/HRAnalytics/HR_1.csv' into table hr_1
fields terminated by ','
enclosed by ''''
lines terminated by '\n'
ignore 1 rows; 

create table hr_2(
EmployeeID int,
MonthlyIncome int,
MonthlyRate int,
NumCompaniesWorked int,
Over18 text,
OverTime text,
PercentSalaryHike int,
PerformanceRating int,
RelationshipSatisfaction int,
StandardHours int,
StockOptionLevel int,
TotalWorkingYears int,
TrainingTimesLastYear int,
WorkLifeBalance int,
YearsAtCompany int,
YearsInCurrentRole int,
YearsSinceLastPromotion int,
YearsWithCurrManager int
);

load data infile 'E:/JEEVA/Project/Project4_HR/HRAnalytics/HR_2.csv' into table hr_2
fields terminated by ','
enclosed by ''''
lines terminated by '\n'
ignore 1 rows;


--- Q-1 - Average Attrition rate for all Departments
select Department, round(((sum(case Attrition when 'yes' then 1 else 0 end) /count(*))*100),2)
as Avg_attrition
from hr_1 
group by department;

--- Q-2 -  Average Hourly rate of Male Research Scientist

select JobRole,round(Avg(HourlyRate),2) as Avg_Hourly_rate from hr_1
where JobRole = 'Research Scientist' and Gender = 'Male';

--- Q-3 - Attrition rate Vs Monthly income stats

select floor(monthlyincome/10000)*10000 as income_bin ,
round(sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100,2) as Atr_rate 
from  hr_1
inner join hr_2
on hr_1.EmployeeNumber = hr_2.EmployeeID
group by income_bin
order by income_bin ;

--- Q-4 - Average working years for each Department

select Department,round(avg(TotalWorkingYears),2) as Working_Years 
from hr_1
 join hr_2
on hr_1.EmployeeNumber = hr_2.EmployeeID
group by Department 
order by Working_Years desc;

-- Q 5.Job Role Vs Work life balance

select JobRole , round(avg(WorkLifeBalance),2) as WorkLifeBalance
 from hr_1 
 join hr_2
on hr_1.EmployeeNumber = hr_2.EmployeeID
 group by JobRole 
 order by WorkLifeBalance desc;
 
 -- 6.Attrition rate Vs Year since last promotion relation

select distinct YearsSinceLastPromotion, sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate 
 from hr_1
 join hr_2 
 on hr_1.EmployeeNumber= hr_2.EmployeeID
 group by YearsSinceLastPromotion
 order by YearsSinceLastPromotion;
 
 select 
case
when Age between 18 and 25 then '18-25'
when Age between 26 and 35 then '26-35'
when Age between 36 and 45 then '36-45'
when Age between 46 and 55 then '46-55'
Else '56+' 
End as Age_Group,
sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate from hr_1
group by 
case
when Age between 18 and 25 then '18-25'
when Age between 26 and 35 then '26-35'
when Age between 36 and 45 then '36-45'
when Age between 46 and 55 then '46-55'
Else '56+' 
End;

-- Q-8 - Gender vs Attrition rate
select Gender, sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate
from hr_1
group by Gender;

-- Q-9 - Travel Distance vs Attriiton Rate
select 
case
when DistanceFromHome between 1 and 10 then 'Near By'
when DistanceFromHome between 11 and 25 then 'Far'
else 'Very-far'
end as Distance_Status,
sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate
from hr_1
group by
case
when DistanceFromHome between 1 and 10 then 'Near By'
when DistanceFromHome between 11 and 25 then 'Far'
else 'Very-far'
end;

-- Q- 10 - Employee_Count
select count(EmployeeID) as Total_Employee_Count from hr_2;

-- Q- 11 - Avg_Percentage_hike
select concat(round(avg(PercentSalaryHike),2),'%') as Avg_Percentage_Hike from hr_2;

-- Q-11 - Avg Monthly Income
select round(avg(MonthlyIncome),0) as Avg_Monthly_Income from hr_2;

-- Q-12 - Avg Age
select round(avg(Age),0) as Avg_Age from hr_1;

-- Q-13 - Attrition rate
select sum(case attrition when 'yes' then 1 else 0 end)/count(employeecount)*100 as atr_rate from hr_1;


-- Q-14 - Avg Years at Company
select round(Avg(YearsAtCompany),0) as Avg_WorkingyearsatCompany from hr_2;

 



