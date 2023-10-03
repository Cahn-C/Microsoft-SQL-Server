-- Exercise 1
-- Display the three most expensive orders for each vendor
select * from (
	select PurchaseOrderID, 
               VendorID, 
	       OrderDate, 
	       TaxAmt, 
	       Freight,
	       TotalDue,
	       PurchaseOrderRank = row_number() over(partition by VendorID order by TotalDue desc) 
	from Purchasing.PurchaseOrderHeader
) A
where PurchaseOrderRank <= 3


-- Exercise 2
-- Display the three most expensive orders for each vendor
select * from (
	select PurchaseOrderID, 
	       VendorID, 
	       OrderDate, 
	       TaxAmt, 
	       Freight,
	       TotalDue,
	       PurchaseOrderRank = dense_rank() over(partition by VendorID order by TotalDue desc)
	from Purchasing.PurchaseOrderHeader
) A
where PurchaseOrderRank <= 3


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
