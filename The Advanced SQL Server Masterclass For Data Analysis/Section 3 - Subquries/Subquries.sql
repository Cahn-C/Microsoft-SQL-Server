-- Exercise 1
-- Display the three most expensive orders for each vendor
select * from (
	select PurchaseOrderID, 
		   VendorID, 
		   OrderDate, 
		   TaxAmt, 
		   Freight,
		   TotalDue,
		   row_number() over(partition by VendorID order by TotalDue desc) as PurchaseOrderRank
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
		   dense_rank() over(partition by VendorID order by TotalDue desc) as PurchaseOrderRank
	from Purchasing.PurchaseOrderHeader
) A
where PurchaseOrderRank <= 3