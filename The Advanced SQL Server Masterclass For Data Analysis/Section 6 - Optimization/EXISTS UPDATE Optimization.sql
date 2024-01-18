USE [AdventureWorks2019]

SELECT
       A.PurchaseOrderID,
       A.OrderDate,
       A.TotalDue

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

WHERE EXISTS (
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	AND B.RejectedQty > 5
)

ORDER BY 1


CREATE TABLE #Purchases (
	PurchaseOrderID INT,
	OrderDate DATE,
        TotalDue MONEY,
	RejectedQTY INT
)

INSERT INTO #Purchases (
	PurchaseOrderID,
	OrderDate,
        TotalDue
)
SELECT PurchaseOrderID,
       OrderDate,
       TotalDue
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

UPDATE #Purchases 
SET RejectedQTY = B.RejectedQty
FROM #Purchases A
JOIN Purchasing.PurchaseOrderDetail B
ON A.PurchaseOrderID = B.PurchaseOrderID
WHERE B.RejectedQty > 5


SELECT * FROM #Purchases WHERE RejectedQTY IS NOT NULL ORDER BY 1


DROP TABLE #Purchases
