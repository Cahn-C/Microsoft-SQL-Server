-- Exercise 1
-- Compare the average rate to each rate of the employees
select pp.FirstName, 
	   pp.LastName, 
	   he.JobTitle, 
	   hh.Rate, 
	   avg(hh.Rate) over() as AverageRate
from Person.Person pp
join HumanResources.Employee he
on pp.BusinessEntityID = he.BusinessEntityID
join HumanResources.EmployeePayHistory hh
on he.BusinessEntityID = hh.BusinessEntityID


-- Exercise 2
-- Compare the largest rate of all values from every employees rate
select pp.FirstName, 
	   pp.LastName, 
	   he.JobTitle, 
	   hh.Rate, 
	   avg(hh.Rate) over() as AverageRate,
	   max(hh.Rate) over() as MaximumRate
from Person.Person pp
join HumanResources.Employee he
on pp.BusinessEntityID = he.BusinessEntityID
join HumanResources.EmployeePayHistory hh
on he.BusinessEntityID = hh.BusinessEntityID


-- Exercise 3
-- Returns the employee's pay rate minus the average of all values for every employee
select pp.FirstName, 
	   pp.LastName, 
	   he.JobTitle, 
	   hh.Rate, 
	   avg(hh.Rate) over() as AverageRate,
	   max(hh.Rate) over() as MaximumRate,
	   hh.Rate - avg(hh.Rate) over() as DiffFromAvgRate
from Person.Person pp
join HumanResources.Employee he
on pp.BusinessEntityID = he.BusinessEntityID
join HumanResources.EmployeePayHistory hh
on he.BusinessEntityID = hh.BusinessEntityID


-- Exercise 4
-- Compare the pertenage of all employees to each employee pay rate
select pp.FirstName, 
	   pp.LastName, 
	   he.JobTitle, 
	   hh.Rate, 
	   avg(hh.Rate) over() as AverageRate,
	   max(hh.Rate) over() as MaximumRate,
	   hh.Rate - avg(hh.Rate) over() as DiffFromAvgRate,
	   hh.Rate / (max(hh.Rate) over() * 100) as PercentofMaxRate
from Person.Person pp
join HumanResources.Employee he
on pp.BusinessEntityID = he.BusinessEntityID
join HumanResources.EmployeePayHistory hh
on he.BusinessEntityID = hh.BusinessEntityID
