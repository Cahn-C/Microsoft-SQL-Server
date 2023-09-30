-- Exercise 1
-- Compare the max vacation hours to all of the employee's regular vacation hours
select BusinessEntityID,
       JobTitle,
       VacationHours,
       MaxVacationHours = (select max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee


-- Exercise 2
-- Compare the percentage of maximum vacation hours for every employee
select BusinessEntityID,
       JobTitle,
       VacationHours,  
       MaxVacationHours = (select max(VacationHours) from HumanResources.Employee),
       PercentOfVactionHours = (VacationHours * 1.0) / (select max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee


-- Exercise 3
-- Get all employees who have at least 80% as much vacation time as the employee with the most vacation time. 
select * from (
	select BusinessEntityID,
	       JobTitle,
	       VacationHours,
	       MaxVacationHours = (select max(VacationHours) from HumanResources.Employee),
	       PercentOfVactionHours = (VacationHours * 1.0) / (select max(VacationHours) from HumanResources.Employee)
	from HumanResources.Employee
) X
where PercentOfVactionHours >= 0.8
