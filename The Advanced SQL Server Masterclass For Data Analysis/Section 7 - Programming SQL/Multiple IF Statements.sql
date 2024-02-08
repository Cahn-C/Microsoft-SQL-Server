USE [AdventureWorks2019]
GO

/****** Object:  StoredProcedure [Sales].[OrdersAboveThreshold]    Script Date: 2/8/2024 12:25:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [Sales].[OrdersAboveThreshold](@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT) AS
IF @OrderType = 1
	BEGIN
		SELECT SalesOrderID,
			   OrderDate,
			   TotalDue
		FROM [Sales].[SalesOrderHeader] 
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
	END
IF @OrderType = 2
	BEGIN
		SELECT PurchaseOrderID,
			   OrderDate,
			   TotalDue
		FROM [Purchasing].[PurchaseOrderHeader]
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
	END
IF @OrderType = 3
	BEGIN
		SELECT OrderID = SalesOrderID,
			   OrderDate,
			   TotalDue,
			   OrderTypes = 'Sales'
		FROM [Sales].[SalesOrderHeader] 
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
		UNION ALL
		SELECT OrderID = PurchaseOrderID,
			   OrderDate,
			   TotalDue,
			   OrderTypes = 'Purchases'
		FROM [Purchasing].[PurchaseOrderHeader] B
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
	END
GO

-- Sales Order Data
EXEC [Sales].[OrdersAboveThreshold] 10000, 2011, 2012, 1

-- Purchase Order Date
EXEC [Sales].[OrdersAboveThreshold] 10000, 2011, 2012, 2

-- Comparison of both Sales and Purchases Data
EXEC [Sales].[OrdersAboveThreshold] 10000, 2011, 2012, 3
