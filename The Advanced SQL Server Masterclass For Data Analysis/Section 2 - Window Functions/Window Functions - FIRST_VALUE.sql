USE [AdventureWorks2019]

-- Exercise 1
SELECT EmployeeID = BusinessEntityID,
	   JobTitle,
	   HireDate,
	   VacationHours,
	   FirstHireVacationHours = FIRST_VALUE(VacationHours) OVER(PARTITION BY JobTitle ORDER BY HireDate)
FROM [HumanResources].[Employee]
ORDER BY JobTitle, HireDate



-- Exercise 2
SELECT PP.ProductID,
	   ProductName = PP.Name,
	   PH.ListPrice,
	   PH.ModifiedDate,
	   HighestPrice = FIRST_VALUE(PH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PH.ListPrice DESC),
	   LowestCost = FIRST_VALUE(PH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PH.ListPrice),
	   PriceRange = FIRST_VALUE(PH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PH.ListPrice DESC) - FIRST_VALUE(PH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PH.ListPrice)
FROM [Production].[ProductListPriceHistory] PH
JOIN [Production].[Product] PP
ON PH.ProductID = PP.ProductID
ORDER BY ProductID, ModifiedDate