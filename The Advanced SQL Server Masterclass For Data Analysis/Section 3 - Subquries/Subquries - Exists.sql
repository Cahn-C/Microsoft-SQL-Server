-- Exercise 1
--
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
--
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
--
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