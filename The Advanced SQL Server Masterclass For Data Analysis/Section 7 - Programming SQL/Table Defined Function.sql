yUSE [AdventureWorks2019]
GO

CREATE FUNCTION Production.ufnProductsByPriceRange(@MinPrice MONEY, @MaxPrice MONEY) RETURNS TABLE
AS
RETURN (
	SELECT ProductID,
		   Name,
		   ListPrice
	FROM [Production].[Product]
	WHERE ListPrice BETWEEN @MinPrice AND @MaxPrice
)
GO

SELECT * FROM Production.ufnProductsByPriceRange(1.99, 20.99)
