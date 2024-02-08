USE [AdventureWorks2019]
GO

CREATE OR ALTER PROCEDURE Sales.OrdersAboveThreshold(@Threshold MONEY, @StartYear INT, @EndYear INT) AS
BEGIN
	SELECT SalesOrderID,
		   SalesOrderNumber,
		   PurchaseOrderNumber,
		   TotalDue,
		   OrderDate
	FROM [Sales].[SalesOrderHeader] 
	WHERE TotalDue > @Threshold 
	AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
END

EXEC Sales.OrdersAboveThreshold 110000, 2011, 2013
