USE [AdventureWorks2019]
GO

-- Create a user
CREATE FUNCTION dbo.ufnPercentageReturn(@num1 INT, @num2 INT) RETURNS VARCHAR(8)
AS
BEGIN

	DECLARE	@Result DECIMAL(7, 2) = (@num1 * 1.0) / @num2
	RETURN FORMAT(@Result, 'P')

END
GO


-- Store the maximum vacation time for any individual employee in a variable
DECLARE @MaximumVacationHours DECIMAL(7, 2) = (SELECT MAX(VacationHours) FROM [HumanResources].[Employee])

SELECT BusinessEntityID,
	   JobTitle,
	   VacationHours,
	   PercentOfMaxVacations = dbo.ufnPercentageReturn(VacationHours, @MaximumVacationHours)
FROM [HumanResources].[Employee]
