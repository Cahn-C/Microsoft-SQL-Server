-- Exercise 1
-- Compare the max vacation hours to all of the employee's regular vacation hours
select BusinessEntityID,
	   JobTitle,
	   VacationHours,
	   MaxVacationHours = (select max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee


-- Exercise 2
-- 
select BusinessEntityID,
	   JobTitle,
	   VacationHours,
	   MaxVacationHours = (select max(VacationHours) from HumanResources.Employee),
	   PercentOfVactionHours = (VacationHours * 1.0) / (select max(VacationHours) from HumanResources.Employee)
from HumanResources.Employee


-- Exercise 3
-- 
select * from (
	select BusinessEntityID,
		   JobTitle,
		   VacationHours,
		   MaxVacationHours = (select max(VacationHours) from HumanResources.Employee),
		   PercentOfVactionHours = (VacationHours * 1.0) / (select max(VacationHours) from HumanResources.Employee)
	from HumanResources.Employee
) X
where PercentOfVactionHours >= 0.8