-- Exercise 1
-- Display the three most expensive orders for each vendor
SELECT PurchaseOrderID,
       VendorID,
       OrderDate,
       TaxAmt,
       Freight,
       TotalDue 
FROM (
	SELECT PurchaseOrderID,
               VendorID,
	       OrderDate,
               TaxAmt,
               Freight,
               TotalDue,
	       PurchaseOrderRank = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
FROM [Purchasing].[PurchaseOrderHeader]
)Purchases
WHERE PurchaseOrderRank <= 3


-- Exercise 2
-- Display the three most expensive orders for each vendor
SELECT PurchaseOrderID,
       VendorID,
       OrderDate, 
       TaxAmt,
       Freight,
       TotalDue 
FROM (
	SELECT PurchaseOrderID,
	       VendorID,
	       OrderDate,
     	       TaxAmt,
	       Freight,
	       TotalDue,
	       PurchaseOrderRank = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
FROM [Purchasing].[PurchaseOrderHeader]
) Purchases
WHERE PurchaseOrderRank <= 3


-- Exercise 3
-- Get the total amount of the top ten orders for each month
select OrderMonth,
       sum(TotalDue) as TotalAmount
from (
	select OrderDate,
	       TotalDue,
	       OrderMonth = datefromparts(year(OrderDate), month(OrderDate), 1),
     	       OrderRank = row_number() over(partition by datefromparts(year(OrderDate), month(OrderDate), 1) order by TotalDue)
	from Sales.SalesOrderHeader
) TopTenOrders
where OrderRank <= 10
group by OrderMonth
order by 1 asc


-- Compare the total amount of sales and purchases at the start of each month
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
