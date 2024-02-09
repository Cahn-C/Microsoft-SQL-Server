USE [DBase]
GO

-- Creat the products table
CREATE TABLE [dbo].[ProductsTable](
	ProductID INT NOT NULL,
	ProductCategoryID INT NOT NULL,
	ProductName VARCHAR(85) NOT NULL,
	SellingPrice MONEY NOT NULL,
CONSTRAINT PK_ProductsTable_ProductID PRIMARY KEY (ProductID)
)


-- Create the product category table
CREATE TABLE [dbo].[ProductCategoryTable](
	ProductCategoryID INT NOT NULL,
	ProductCategoryName VARCHAR(85) NOT NULL,
CONSTRAINT FK_ProductCategoryTable_ProductCategoryID FOREIGN KEY (ProductCategoryID) REFERENCES ProductsTable(ProductID)
)


-- Create the product quantity sold table
CREATE TABLE [dbo].[ProductQuantitySold](
	ProductID INT NOT NULL,
	Quantity INT NOT NULL
CONSTRAINT FK_ProductCategoryTable_ProdcutID FOREIGN KEY (ProductID) REFERENCES ProductsTable(ProductID)
) 


-- Create the product stock bby year table
CREATE TABLE [dbo].[ProductStockByYear](
	ProductCategoryName VARCHAR(85) NOT NULL,
	ProductName VARCHAR(85) NOT NULL,
	StockYear VARCHAR(8) NOT NULL,
	EndStock INT NOT NULL
)

-- Delete data inside of the tables
TRUNCATE TABLE [dbo].[ProductsTable]
TRUNCATE TABLE [dbo].[ProductCategoryTable]
TRUNCATE TABLE [dbo].[ProductQuantitySold]
TRUNCATE TABLE [dbo].[ProductStockByYear]


-- Delete the entire tables
DROP TABLE [dbo].[ProductsTable]
DROP TABLE [dbo].[ProductCategoryTable]
DROP TABLE [dbo].[ProductQuantitySold]
DROP TABLE [dbo].[ProductStockByYear]


-- Retrieve the data for all tables
SELECT * FROM [dbo].[ProductsTable]
SELECT * FROM [dbo].[ProductCategoryTable]
SELECT * FROM [dbo].[ProductQuantitySold]
SELECT * FROM [dbo].[ProductStockByYear]


-- Compare the average selling price between the average difference price for each product category
SELECT B.ProductCategoryID,
	   B.ProductCategoryName,
	   A.ProductName,
	   A.SellingPrice,
	   AveragePricePerCategory = AVG(SellingPrice) OVER(PARTITION BY B.ProductCategoryName),
	   DifferenceAveragePriceByCategory = AVG(SellingPrice) OVER(PARTITION BY B.ProductCategoryName) - SellingPrice
FROM [dbo].[ProductsTable] A
JOIN [dbo].[ProductCategoryTable] B
ON A.ProductCategoryID = B.ProductCategoryID
ORDER BY B.ProductCategoryID


-- Get the running total for each product category for every product
SELECT *,
	   RunningTotal = SUM(Total) OVER(PARTITION BY ProductCategoryName ORDER BY Total 
									  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM (
	SELECT B.ProductCategoryName,
		   A.ProductName,
		   Total = SUM(C.Quantity * A.SellingPrice)
	FROM [dbo].[ProductsTable] A
	JOIN [dbo].[ProductCategoryTable] B
	ON A.ProductCategoryID = B.ProductCategoryID
	JOIN [dbo].[ProductQuantitySold] C
	ON A.ProductID = C.ProductID
	GROUP BY B.ProductCategoryName,
			 A.ProductName	
) X
ORDER BY ProductCategoryName, Total


-- Compare the current year stock with the prevoiuse stock
SELECT ProductCategoryName,
	   ProductName,
	   StockYear,
	   EndStock,
	   PreviousYearStock = LAG(EndStock, 1, 0) OVER(PARTITION BY ProductCategoryName, ProductName ORDER BY StockYear)
FROM [dbo].[ProductStockByYear]


-- Find the current year stock with the first year stock based on every product for each category
SELECT ProductCategoryName,
	   ProductName,
	   StockYear,
	   EndStock,
	   StockDifference = EndStock - FIRST_VALUE(EndStock) OVER(PARTITION BY ProductCategoryName, ProductName ORDER BY StockYear)
FROM [dbo].[ProductStockByYear]