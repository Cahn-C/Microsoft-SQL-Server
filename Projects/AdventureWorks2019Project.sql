USE [AdventureWorks2019]
GO

-- Get the data from the following tables
SELECT * FROM [Person].[Person]
SELECT * FROM [HumanResources].[Employee]
SELECT * FROM [HumanResources].[EmployeePayHistory]

-- 
SELECT A.FirstName,
	   A.LastName,
	   B.JobTitle,
	   C.Rate,
	   AverageRate = AVG(C.Rate) OVER()
FROM [Person].[Person] A
JOIN [HumanResources].[Employee] B
ON A.BusinessEntityID = B.BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] C
ON B.BusinessEntityID = C.BusinessEntityID


--
SELECT A.FirstName,
	   A.LastName,
	   B.JobTitle,
	   C.Rate,
	   AverageRate = AVG(C.Rate) OVER(),
	   MaximunRate = MAX(C.Rate) OVER()
FROM [Person].[Person] A
JOIN [HumanResources].[Employee] B
ON A.BusinessEntityID = B.BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] C
ON B.BusinessEntityID = C.BusinessEntityID


--
SELECT A.FirstName,
	   A.LastName,
	   B.JobTitle,
	   C.Rate,
	   AverageRate = AVG(C.Rate) OVER(),
	   MaximunRate = MAX(C.Rate) OVER(),
	   DiffFromAvgRate = C.Rate - AVG(C.Rate) OVER()
FROM [Person].[Person] A
JOIN [HumanResources].[Employee] B
ON A.BusinessEntityID = B.BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] C
ON B.BusinessEntityID = C.BusinessEntityID


-- 
SELECT A.FirstName,
	   A.LastName,
	   B.JobTitle,
	   C.Rate,
	   AverageRate = AVG(C.Rate) OVER(),
	   MaximunRate = MAX(C.Rate) OVER(),
	   DiffFromAvgRate = C.Rate - AVG(C.Rate) OVER(),
	   PercentageofMaxRate = (C.Rate / MAX(C.Rate) OVER()) * 100
FROM [Person].[Person] A
JOIN [HumanResources].[Employee] B
ON A.BusinessEntityID = B.BusinessEntityID
JOIN [HumanResources].[EmployeePayHistory] C
ON B.BusinessEntityID = C.BusinessEntityID
