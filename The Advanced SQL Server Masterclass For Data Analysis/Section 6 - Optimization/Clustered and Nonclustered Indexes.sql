USE [AdventureWorks2017]


-- 1) Create filtered temp table of sales order header table where year is equal to 2012
CREATE TABLE #Sales2012 (
	SalesOrderID INT,
	OrderDate DATE
)

INSERT INTO #Sales2012
SELECT SalesOrderID,
       OrderDate
FROM Sales.SalesOrderHeader
WHERE year(OrderDate) = 2012


select * from #Sales2012


CREATE CLUSTERED INDEX Sales2012_ix ON #Sales2012(SalesOrderID)


-- 2) Create a new temp table joining in SalesOrderDetail table
CREATE TABLE #ProductsSold2012 (
	SalesOrderID INT,
	SalesOrderDetailID INT,
	OrderDate DATE,
	LineTotal MONEY,
	ProductID INT,
	ProductName VARCHAR(64),
	ProductSubcategoryID INT,
	ProductSubcategory VARCHAR(64),
	ProductCategoryID INT,
	ProductCategory VARCHAR(64)
)

INSERT INTO #ProductsSold2012 (
	SalesOrderID,
	SalesOrderDetailID,
	OrderDate,
	LineTotal,
	ProductID
)
SELECT h.SalesOrderID,
       d.SalesOrderDetailID,
       h.OrderDate,
       d.LineTotal,
       d.ProductID
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID
WHERE YEAR(OrderDate) = 2012


CREATE CLUSTERED INDEX ProductsSold2012_idx ON #ProductsSold2012(SalesOrderID, SalesOrderDetailID)

CREATE NONCLUSTERED INDEX ProductsSold2012_idx2 ON #ProductsSold2012(ProductID)

CREATE NONCLUSTERED INDEX ProductsSold2012_idx3 ON #ProductsSold2012(ProductSubcategoryID)

CREATE NONCLUSTERED INDEX ProductsSold2012_idx4 ON #ProductsSold2012(ProductCategoryID)

select * from #ProductsSold2012


-- 3) Add product data
UPDATE #ProductsSold2012
SET ProductName = B.Name
FROM #ProductsSold2012 A
JOIN Production.Product B
ON A.ProductID = B.ProductID


-- 4) Add Subcategory identification data
UPDATE #ProductsSold2012
SET ProductSubcategoryID = C.ProductSubcategoryID
FROM #ProductsSold2012 A
JOIN Production.Product B
ON A.ProductID = B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID


-- 5) Add Subcategory names data 
UPDATE #ProductsSold2012
SET ProductSubcategory = C.Name
FROM #ProductsSold2012 A
JOIN Production.Product B
ON A.ProductID = B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID


-- 6) Add Category identification data
UPDATE #ProductsSold2012
SET ProductCategoryID = D.ProductCategoryID
FROM #ProductsSold2012 A
JOIN Production.Product B
ON A.ProductID = B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID
JOIN Production.ProductCategory D
ON C.ProductCategoryID = D.ProductCategoryID


-- 7) Add Category names data
UPDATE #ProductsSold2012
SET ProductCategory = D.Name
FROM #ProductsSold2012 A
JOIN Production.Product B
ON A.ProductID = B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID
JOIN Production.ProductCategory D
ON C.ProductCategoryID = D.ProductCategoryID

select * from #ProductsSold2012
