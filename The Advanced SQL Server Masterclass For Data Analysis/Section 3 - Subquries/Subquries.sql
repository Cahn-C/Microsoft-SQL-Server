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
