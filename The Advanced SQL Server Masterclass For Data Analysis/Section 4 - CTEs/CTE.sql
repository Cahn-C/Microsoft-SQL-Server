-- Compare the total amount of all sales and purchases at the start of each month
WITH Sales AS (
	SELECT OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	FROM AdventureWorks2019.Sales.SalesOrderHeader
),
MinusTop10Sales AS (
	SELECT OrderMonth,
		   TotalSales = SUM(TotalDue)
	FROM Sales
	WHERE OrderRank > 10
	GROUP BY OrderMonth
),
Purchases AS (
	SELECT OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
),
MiunsTop10Purchases AS (
	SELECT OrderMonth,
		   TotalPurchases = SUM(TotalDue)
	FROM Purchases
	WHERE OrderRank > 10
	GROUP BY OrderMonth
)
SELECT S.OrderMonth,
	   TotalSales,
	   TotalPurchases
FROM MinusTop10Sales S 
JOIN MiunsTop10Purchases P
ON S.OrderMonth = P.OrderMonth
ORDER BY 1
