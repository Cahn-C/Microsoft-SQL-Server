-- Compare the total amount of all sales and purchases at the start of each month
-- Starting code for CTE
select A.OrderMonth,
	   A.TotalSales,
	   B.TotalPurchases
from (
	select OrderMonth,
		   sum(TotalDue) as TotalSales
	from (
		select OrderDate,
			   TotalDue,
			   OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
			   OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
		from Sales.SalesOrderHeader
	) TopTenOrders
	where OrderRank <= 10
	group by OrderMonth
) A
left join (
	select OrderMonth,
		   sum(TotalDue) as TotalPurchases
	from (
		select OrderDate,
			   TotalDue,
			   OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
			   OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
		from Purchasing.PurchaseOrderHeader
	) TopTenOrders
	where OrderRank <= 10
	group by OrderMonth
) B
on A.OrderMonth = B.OrderMonth
order by 1 asc
GO

-- Same code as the subquery above, but in a CTE
with RankingSales as (
	select OrderDate,
			   TotalDue,
			   OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
			   OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
		from Sales.SalesOrderHeader
),
OrderMonthlySales as (
	select OrderMonth, 
		   sum(TotalDue) as TotalSales 
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
		   sum(TotalDue) as TotalPurchases
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
