-- Exercise 1
-- 
select PurchaseOrderID,
	   VendorID,
	   OrderDate,
	   TotalDue,
	   NonRejectedItems = (select count(*) from Purchasing.PurchaseOrderDetail d
						   where d.PurchaseOrderID = h.PurchaseOrderID
						   and d.RejectedQty = 0)
from Purchasing.PurchaseOrderHeader h


-- Exercise 2
-- 
select PurchaseOrderID,
	   VendorID,
	   OrderDate,
	   TotalDue,
	   NonRejectedItems = (select count(*) from Purchasing.PurchaseOrderDetail d
						   where d.PurchaseOrderID = h.PurchaseOrderID
						   and d.RejectedQty = 0),
	   MostExpensiveItem = (select max(UnitPrice) from Purchasing.PurchaseOrderDetail d
							where d.PurchaseOrderID = h.PurchaseOrderID)
from Purchasing.PurchaseOrderHeader h

select PurchaseOrderID, UnitPrice from Purchasing.PurchaseOrderDetail