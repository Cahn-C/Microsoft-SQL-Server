-- Compare the total amount of sales and purchases at the start of each month
with RankingSales as (
	select OrderDate,
	       TotalDue,
	       OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
	       OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
	from Sales.SalesOrderHeader
),
OrderMonthlySales as (
	select OrderMonth, 
	       TotalSales = sum(TotalDue) 
	from RankingSales
	where OrderRank <= 10
	group by OrderMonth
),
RankingPurchases as (
	select OrderDate,
	       TotalDue,
	       OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
	       OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
	from Purchasing.PurchaseOrderHeader
),
OrderMonthlyPurchases as (
	select OrderMonth,
	       TotalPurchases = sum(TotalDue)
	from RankingPurchases
	group by OrderMonth
),
TotalSalesAndPurchases as (
	select oms.OrderMonth,
	       oms.TotalSales,
	       omp.TotalPurchases
	from OrderMonthlySales oms
	left join OrderMonthlyPurchases omp
	on oms.OrderMonth = omp.OrderMonth
)
select * from TotalSalesAndPurchases order by 1 asc


-- Create a temporary table for each of the CTEs
-- 
CREATE TABLE #RankingSales (
	OrderDate DATE,
	TotalDue INT,
	OrderMonth DATE,
	OrderRank INT
)
-- 
INSERT INTO #RankingSales
	select OrderDate,
	       TotalDue,
	       OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
	       OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
	from Sales.SalesOrderHeader

-- 
select * from #RankingSales


-- 
CREATE TABLE #OrderMonthlySales (
	OrderMonth DATE, 
	TotalSales INT
)
-- 
INSERT INTO #OrderMonthlySales
	select OrderMonth,
	       TotalSales = sum(TotalDue) 
	from #RankingSales
	where OrderRank <= 10
	group by OrderMonth

--
select * from #OrderMonthlySales


-- 
CREATE TABLE #RankingPurchases (
	OrderDate DATE,
	TotalDue INT,
	OrderMonth DATE,
	OrderRank INT
)
-- 
INSERT INTO #RankingPurchases
	select OrderDate,
	       TotalDue,
	       OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
	       OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
	from Purchasing.PurchaseOrderHeader

-- 
select * from #RankingPurchases


-- 
CREATE TABLE #OrderMonthlyPurchases (
	OrderMonth DATE,
	TotalPurchases INT
)
-- 
INSERT INTO #OrderMonthlyPurchases
	select OrderMonth,
	       TotalPurchases = sum(TotalDue)
	from #RankingPurchases
	group by OrderMonth

-- 
select * from #OrderMonthlyPurchases


-- 
CREATE TABLE #TotalSalesAndPurchases (
	OrderMonth DATE,
	TotalSales INT,
	TotalPurchases INT
)
-- 
INSERT INTO #TotalSalesAndPurchases
	select oms.OrderMonth,
	       oms.TotalSales,
	       omp.TotalPurchases
	from #OrderMonthlySales oms
	left join #OrderMonthlyPurchases omp
	on oms.OrderMonth = omp.OrderMonth

-- 
select * from #TotalSalesAndPurchases
