USE [AdventureWorks2017]

-- Starter Code
SELECT
       A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue

FROM AdventureWorks2017.Purchasing.PurchaseOrderHeader A

WHERE EXISTS (
	SELECT
	1
	FROM AdventureWorks2017.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
		AND B.RejectedQty > 5
)

ORDER BY 1


-- Code that provides query performance when searching for an existing record
CREATE TABLE #PurchaseOrders2017 (
	PurchaseOrderID INT,
	OrderDate DATE,
	TotalDue MONEY,
	RejectedQty INT
)
INSERT INTO #PurchaseOrders2017 (
	PurchaseOrderID,
	OrderDate,
	TotalDue
)
SELECT * FROM #PurchaseOrders2017

UPDATE #PurchaseOrders2017 SET RejectedQty = B.RejectedQty
FROM #PurchaseOrders2017 A
JOIN Purchasing.PurchaseOrderDetail B
ON A.PurchaseOrderID = B.PurchaseOrderID
AND B.RejectedQty > 5