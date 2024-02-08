USE [AdventureWorks2019]
GO

-- Pulls all orders with a threshold that is greater than the total due along with specified order dates
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
