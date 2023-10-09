-- Exercise 1
-- Check to make sure that there is at least one item in the order with an order quabtity greater than 500
select PurchaseOrderID,
       OrderDate,
       SubTotal,
       TaxAmt
from Purchasing.PurchaseOrderHeader h
where exists (select 1 from Purchasing.PurchaseOrderDetail d 
	      where OrderQty > 500 
	      and d.PurchaseOrderID = h.PurchaseOrderID)
order by PurchaseOrderID

-- Confirm that the records in the above query is correct
select PurchaseOrderID, OrderQty from Purchasing.PurchaseOrderDetail where OrderQty > 500


-- Exercise 2
-- Check to make sure that there is at least one item in the order with an order quabtity greater than 500 and the unit price is greater than 50
select PurchaseOrderID,
       OrderDate,
       SubTotal,
       TaxAmt
from Purchasing.PurchaseOrderHeader h
where exists (select 1 from Purchasing.PurchaseOrderDetail d 
	      where OrderQty > 500 
	      and UnitPrice > 50
	      and d.PurchaseOrderID = h.PurchaseOrderID)
order by PurchaseOrderID

-- Confirm that the records in the above query is correct
select PurchaseOrderID, OrderQty from Purchasing.PurchaseOrderDetail where OrderQty > 500 and UnitPrice > 50


-- Exercise 3
-- Check to make sure that there are NO items within an order that does not have a rejected quantity 
select PurchaseOrderID,
       OrderDate,
       SubTotal,
       TaxAmt
from Purchasing.PurchaseOrderHeader h
where not exists (select 1 from Purchasing.PurchaseOrderDetail d 
		  where RejectedQty > 0
		  and d.PurchaseOrderID = h.PurchaseOrderID)
order by PurchaseOrderID

-- Confirm that the records in the above query is correct
select PurchaseOrderID, RejectedQty from Purchasing.PurchaseOrderDetail where RejectedQty = 0
