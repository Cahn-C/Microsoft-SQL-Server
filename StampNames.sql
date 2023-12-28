USE [AdventureWorks2019]

SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[SalesOrderDetail]
GO

CREATE OR ALTER FUNCTION fn_TotalSalesAmount (@SalesOrderID INT) RETURNS MONEY AS
BEGIN

	DECLARE @TotalSales MONEY
	SELECT  @TotalSales = SUM(TotalDue)
	FROM [Sales].[SalesOrderHeader]
	WHERE SalesOrderID = @SalesOrderID
	RETURN (@TotalSales)

END
GO

CREATE OR ALTER PROC proc_SalesOrders (@ProductID INT) AS
SELECT *, [dbo].[fn_TotalSalesAmount] (LineTotal) AS TotalAmount
FROM [Sales].[SalesOrderDetail]
WHERE ProductID = @ProductID
GO

EXEC proc_SalesOrders 771
GO


SELECT * FROM [Purchasing].[PurchaseOrderDetail]
SELECT * FROM [Purchasing].[PurchaseOrderHeader]
GO

CREATE OR ALTER FUNCTION fn_TotalPurchasesAmount (@PurchaseOrderID INT) RETURNS MONEY AS
BEGIN

	DECLARE @TotalPurchases MONEY
	SELECT @TotalPurchases = SUM(TotalDue)
	FROM [Purchasing].[PurchaseOrderHeader]
	WHERE PurchaseOrderID = @PurchaseOrderID
	RETURN (@TotalPurchases)

END
GO

CREATE OR ALTER PROC proc_PurchaseOrders (@ProductID INT) AS
SELECT *, [dbo].[fn_TotalPurchasesAmount] (OrderQty) AS TotalOrders
FROM [Purchasing].[PurchaseOrderDetail]
WHERE ProductID = @ProductID
GO

EXEC proc_PurchaseOrders 359