-- When the user provides a value of 1, then the output will return all sales data, otherwise all purchase data will be present as the output
ALTER   PROCEDURE [Sales].[OrdersAboveThreshold](@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT) AS
IF @OrderType = 1
	BEGIN
		SELECT *
		FROM [Sales].[SalesOrderHeader] 
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
	END
ELSE
	BEGIN
		SELECT *
		FROM [Purchasing].[PurchaseOrderHeader]
		WHERE TotalDue > @Threshold 
		AND YEAR(OrderDate) BETWEEN @StartYear AND @EndYear
	END
GO

-- Sales Order Data
EXEC [Sales].[OrdersAboveThreshold] 10000, 2011, 2012, 1

-- Purchase Order Date
EXEC [Sales].[OrdersAboveThreshold] 10000, 2011, 2012, 2
