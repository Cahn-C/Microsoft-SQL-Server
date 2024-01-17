USE [AdventureWorks2019]

-- Exercise 1
SELECT SubcategoryName = PS.Name,
	   Products = (SELECT STUFF (
					(SELECT '; ' + PP.Name 
					 FROM [Production].[Product] PP 
					 WHERE PS.ProductSubcategoryID = PP.ProductSubcategoryID
					 FOR XML PATH('')), 1, 1, ''))
FROM [Production].[ProductSubcategory] PS



-- Exercise 2
SELECT SubcategoryName = PS.Name,
	   Products = (SELECT STUFF (
					(SELECT '; ' + PP.Name 
					 FROM [Production].[Product] PP 
					 WHERE PS.ProductSubcategoryID = PP.ProductSubcategoryID
					 AND ListPrice > 50
					 FOR XML PATH('')), 1, 1, ''))
FROM [Production].[ProductSubcategory] PS