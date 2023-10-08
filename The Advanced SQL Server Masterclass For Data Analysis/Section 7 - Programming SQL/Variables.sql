USE [AdventureWorks2017]

DECLARE @vacationHours INT

SELECT @vacationHours = (SELECT MAX(VacationHours) FROM AdventureWorks2017.HumanResources.Employee)

--Starter code:

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = @vacationHours
	  ,PercentOfMaxVacationHours = (VacationHours * 1.0) / @vacationHours
FROM AdventureWorks2017.HumanResources.Employee
WHERE (VacationHours * 1.0) / @vacationHours >= 0.8

