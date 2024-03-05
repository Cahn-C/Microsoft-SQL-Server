USE [DatabaseFundamentals]

-- Create a table called stamp analysis
CREATE TABLE [dbo].[tblStampAnalysis] (
	[StampCountry] VARCHAR(50) NOT NULL,
	[PurchasePrice] SMALLMONEY
)

-- 
DROP TABLE [dbo].[tblStampAnalysis]

	
-- 
INSERT INTO [dbo].[tblStampAnalysis]
SELECT [StampCountry], 
       [PurchasePrice]
FROM [dbo].[tblStampNames] sn INNER JOIN [dbo].[tblStampPurchases] sp
ON sn.[StampID] = sp.[StampID]


-- 
SELECT [StampCountry], 
	   [PurchasePrice]
INTO [dbo].[tblStampAnalysis]
FROM [dbo].[tblStampNames] sn  
JOIN [dbo].[tblStampPurchases] sp
ON sn.[StampID] = sp.[StampID]

-- 
SELECT * FROM [dbo].[tblStampNames] 
SELECT * FROM [dbo].[tblStampPurchases]
SELECT * FROM [dbo].[tblStampAnalysis]



-- Transactions

BEGIN TRANSACTION

	SELECT T.*
	INTO [dbo].[tblDeletedTransactions]
	FROM [dbo].[tblTransaction] T
	LEFT JOIN [dbo].[tblEmployee] E
	ON T.[EmployeeNumber] = E.[EmployeeNumber]
	WHERE E.EmployeeNumber IS NULL

	DELETE FROM [dbo].[tblTransaction]
	FROM [dbo].[tblTransaction] T
	LEFT JOIN [dbo].[tblEmployee] E
	ON T.[EmployeeNumber] = E.[EmployeeNumber]
	WHERE E.EmployeeNumber IS NULL

	SELECT * FROM [dbo].[tblTransaction] T
	SELECT * FROM [dbo].[tblDeletedTransactions]

ROLLBACK TRANSACTION


-- 
ALTER TABLE [dbo].[tblTransaction] ADD [TransactionID] INT IDENTITY(1, 1)

-- 
ALTER TABLE [dbo].[tblTransaction] DROP COLUMN [TransactionID]

-- 
ALTER TABLE [dbo].[tblTransaction] ADD CONSTRAINT PK_tblTransactions_TransactionID PRIMARY KEY ([TransactionID])

-- 
ALTER TABLE [dbo].[tblTransaction] WITH NOCHECK ADD CONSTRAINT FK_tblTransactions_EmployeeNumber
FOREIGN KEY ([EmployeeNumber]) REFERENCES [dbo].[tblEmployee] ([EmployeeNumber])
ON DELETE CASCADE
ON UPDATE CASCADE

-- 
ALTER TABLE [dbo].[tblTransaction] DROP CONSTRAINT [FK_tblTransactions_TransactionID]
ALTER TABLE [dbo].[tblTransaction] DROP CONSTRAINT [PK_tblTransaction_Amount_DateOfTransaction]


-- 
SELECT * FROM [dbo].[tblTransaction]
SELECT * FROM [dbo].[tblEmployee]


-- Stamps

CREATE TABLE [dbo].[tblStampNameUpdate] (
	StampID TINYINT NOT NULL,
	StampName VARCHAR(17) NOT NULL,
)

INSERT INTO [dbo].[tblStampNameUpdate] VALUES (2, 'John Quincy Admas'), (8, 'William III')

BEGIN TRANSACTION

	UPDATE [dbo].[tblStampNames] 
	SET StampName = SU.StampName
	FROM [dbo].[tblStampNames] SN
	JOIN [dbo].[tblStampNameUpdate] SU
	ON SN.StampID = SU.StampID

	DELETE FROM [dbo].[tblStampNameUpdate] WHERE StampName LIKE '%a%'

	SELECT * FROM [dbo].[tblStampNames]
	SELECT * FROM [dbo].[tblStampNameUpdate]

ROLLBACK TRANSACTION


-- 
SELECT * FROM [dbo].[tblStampNames]
SELECT * FROM [dbo].[tblStampPurchases]
SELECT * FROM [dbo].[tblStampAnalysis]
SELECT * FROM [dbo].[tblStampNameUpdate]
GO


-- Views

CREATE VIEW vwMyView AS 
SELECT * FROM [dbo].[tblEmployee]
WHERE EmployeeNumber < 10
GO

SELECT * FROM vwMyView
GO


-- 
CREATE OR ALTER VIEW vwStamps WITH SCHEMABINDING AS
SELECT SN.[StampID]
      ,SN.[StampName]
      ,SN.[StampCountry]
      ,SN.[StampYear] 
	  ,SP.[PurchaseDate]
	  ,SP.[PurchasePrice] 
FROM [dbo].[tblStampNames] SN 
LEFT JOIN [dbo].[tblStampPurchases] SP
ON SN.StampID = SP.StampID
WHERE SN.StampID BETWEEN 1 AND 5
WITH CHECK OPTION
GO


-- 
SELECT * FROM [dbo].[vwStamps] WHERE StampID IN (2, 4)
GO

-- 
BEGIN TRANSACTION

UPDATE [dbo].[vwStamps]
SET StampID = StampID + 10
WHERE StampID = 2

DELETE FROM [dbo].[vwStamps] WHERE StampID = 2

SELECT * FROM [dbo].[tblStampNames]
SELECT * FROM [dbo].[tblStampPurchases]

ROLLBACK TRANSACTION
GO



-- Procedures

CREATE OR ALTER FUNCTION fn_StampPurchasePrice (@StampID INT) RETURNS INT AS
BEGIN

	DECLARE @TotalPurchasePrice INT
	SELECT @TotalPurchasePrice = SUM(PurchasePrice)
	FROM [dbo].[tblStampPurchases]
	WHERE StampID = @StampID
	RETURN (@TotalPurchasePrice)

END
GO

-- 
CREATE OR ALTER PROC proc_StampPurchasePrice (@StampIDFrom INT, @StampIDTo INT) AS
SELECT *, [dbo].[fn_StampPurchasePrice](StampID) AS NumberOfPurchases 
FROM [dbo].[tblStampNames]
WHERE StampID BETWEEN @StampIDFrom AND @StampIDTo
GO

EXEC proc_StampPurchasePrice @StampIDFrom = 2, @StampIDTo = 6



-- Set Operators

-- Union
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 2 = 0
UNION
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 3 = 0

-- Union All
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 2 = 0
UNION ALL
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 3 = 0

-- Intersect
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 2 = 0
INTERSECT
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 3 = 0

-- EXCEPT
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 2 = 0
EXCEPT
SELECT * FROM [dbo].[tblStampNames] WHERE StampID % 3 = 0


-- Indexes

CREATE NONCLUSTERED INDEX idx_tblStampNames_StampName ON
[tblStampNames] ([StampName])


-- This will not work due to the table already having a clustered index, which is the primary key
-- By default the primary key is a clustered index and is sorted, and the unique key is a non-clustered index unsorted
CREATE CLUSTERED INDEX idx_tblStampNames_StampName ON
[tblStampNames] ([StampName])
