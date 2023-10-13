 USE [AdventureWorks2017]
 
 
 -- 
 CREATE VIEW Sales.vTop10MonthOverMonth AS
 WITH Sales AS
(
SELECT
OrderDate
,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2017.Sales.SalesOrderHeader
)
 
,Top10Sales AS
(
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM Sales
WHERE OrderRank <= 10
GROUP BY OrderMonth
)
 
 
SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total
 
FROM Top10Sales A
LEFT JOIN Top10Sales B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)


-- Check the view
select * from [Sales].[vTop10MonthOverMonth] order by 1



-- 
CREATE TABLE #Sales (
	OrderDate DATE,
	OrderMonth DATE,
	TotalDue MONEY,
	OrderRank INT
)
 
INSERT INTO #Sales
SELECT
OrderDate
,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2017.Sales.SalesOrderHeader
 

-- 
CREATE TABLE #Top10Sales (
	OrderMonth DATE,
	Top10Total MONEY
)
INSERT INTO #Top10Sales
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM #Sales
WHERE OrderRank <= 10
GROUP BY OrderMonth
 
 
-- You can not create a view that has a temporary table
CREATE VIEW vTop10MonthOverMonth2 AS
SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total
FROM #Top10Sales A
LEFT JOIN #Top10Sales B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)