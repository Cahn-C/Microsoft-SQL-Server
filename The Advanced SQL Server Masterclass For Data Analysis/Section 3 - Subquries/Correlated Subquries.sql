-- Exercise 1
-- View the total amount of orders for each purchase order id that has NO rejected quantity
select PurchaseOrderID,
       VendorID,
       OrderDate,
       TotalDue,
       NonRejectedItems = (select count(*) from Purchasing.PurchaseOrderDetail d
			   where d.PurchaseOrderID = h.PurchaseOrderID
	                   and d.RejectedQty = 0)
from Purchasing.PurchaseOrderHeader h


-- Exercise 2
-- View the total amount of orders that has NO rejected quantity along with the most expensive unit price for each purchase order id
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

-- Confirms the results from the above query
select PurchaseOrderID, UnitPrice from Purchasing.PurchaseOrderDetail
