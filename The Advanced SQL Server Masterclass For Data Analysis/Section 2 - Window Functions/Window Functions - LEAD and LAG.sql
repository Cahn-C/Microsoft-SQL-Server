USE [AdventureWorks2019]

-- Exercise 1
SELECT PH.PurchaseOrderID,
	   PH.OrderDate,
	   PH.TotalDue,
	   VendorName = V.Name
FROM [Purchasing].[PurchaseOrderHeader] PH
INNER JOIN [Purchasing].[Vendor] V
ON PH.VendorID = V.BusinessEntityID
WHERE YEAR(PH.OrderDate) >= 2013
AND PH.TotalDue > 500



-- Exercise 2
SELECT PH.PurchaseOrderID,
	   PH.OrderDate,
	   PH.TotalDue,
	   VendorName = V.Name,
	   PrevOrderFromVendorAmt = LAG(TotalDue) OVER(PARTITION BY VendorID ORDER BY PH.OrderDate),
	   NextOrderByEmployeeVendor = LEAD(V.Name) OVER(PARTITION BY PH.EmployeeID ORDER BY PH.OrderDate)
FROM [Purchasing].[PurchaseOrderHeader] PH
INNER JOIN [Purchasing].[Vendor] V
ON PH.VendorID = V.BusinessEntityID
WHERE YEAR(PH.OrderDate) >= 2013
AND PH.TotalDue > 500


-- Exercise 3
SELECT PH.PurchaseOrderID,
	   PH.OrderDate,
	   PH.TotalDue,
	   VendorName = V.Name,
	   PrevOrderFromVendorAmt = LAG(TotalDue) OVER(PARTITION BY VendorID ORDER BY PH.OrderDate),
	   NextOrderByEmployeeVendor = LEAD(V.Name) OVER(PARTITION BY PH.EmployeeID ORDER BY PH.OrderDate)
FROM [Purchasing].[PurchaseOrderHeader] PH
INNER JOIN [Purchasing].[Vendor] V
ON PH.VendorID = V.BusinessEntityID
WHERE YEAR(PH.OrderDate) >= 2013
AND PH.TotalDue > 500


