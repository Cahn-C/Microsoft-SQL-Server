-- Exercise 1
SELECT PurchaseOrderID,
       OrderDate,
       SubTotal,
       TaxAmt
FROM [Purchasing].[PurchaseOrderHeader] POH
WHERE EXISTS (SELECT 1 FROM [Purchasing].[PurchaseOrderDetail] POD 
	      WHERE POD.PurchaseOrderID = POH.PurchaseOrderID 
	      AND OrderQty > 500)
ORDER BY PurchaseOrderID

SELECT POH.PurchaseOrderID,
       OrderDate,
       SubTotal,
       TaxAmt
FROM [Purchasing].[PurchaseOrderHeader] POH
JOIN [Purchasing].[PurchaseOrderDetail] POD
ON POH.PurchaseOrderID = POD.PurchaseOrderID
WHERE POD.OrderQty > 500



-- Exercise 2
SELECT * FROM [Purchasing].[PurchaseOrderHeader] POH
WHERE EXISTS (SELECT 1 FROM [Purchasing].[PurchaseOrderDetail] POD 
	      WHERE POD.PurchaseOrderID = POH.PurchaseOrderID 
              AND OrderQty > 500 
	      AND UnitPrice > 50)
ORDER BY 1

SELECT POH.*
FROM [Purchasing].[PurchaseOrderHeader] POH
JOIN [Purchasing].[PurchaseOrderDetail] POD
ON POH.PurchaseOrderID = POD.PurchaseOrderID
WHERE POD.OrderQty > 500
AND UnitPrice > 50
ORDER BY 1



-- Exercise 3
SELECT * FROM [Purchasing].[PurchaseOrderHeader] POH
WHERE NOT EXISTS (SELECT 1 FROM [Purchasing].[PurchaseOrderDetail] POD 
                  WHERE POD.PurchaseOrderID = POH.PurchaseOrderID 
		  AND RejectedQty > 0)
ORDER BY 1

SELECT POH.*
FROM [Purchasing].[PurchaseOrderHeader] POH
JOIN [Purchasing].[PurchaseOrderDetail] POD
ON POH.PurchaseOrderID = POD.PurchaseOrderID
WHERE RejectedQty <= 0
ORDER BY 1
