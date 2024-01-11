USE [DatabaseFundamentals]

ALTER TABLE [dbo].[tblStampNames] ADD CONSTRAINT PK_tblStampNames_StampID PRIMARY KEY ([StampID])

ALTER TABLE [dbo].[tblStampPurchases] WITH NOCHECK ADD CONSTRAINT FK_tblStampPurchases_StampID
FOREIGN KEY ([StampID]) REFERENCES [dbo].[tblStampNames] ([StampID]) 
ON DELETE CASCADE 
ON UPDATE CASCADE


SELECT * FROM [dbo].[tblStampNames]
SELECT * FROM [dbo].[tblStampPurchases]


BEGIN TRANSACTION
INSERT INTO [dbo].[tblStampNames] VALUES (10, 'Queen Victoria', 'USA', 1976)
UPDATE [dbo].[tblStampPurchases] SET StampID = 10 WHERE [PurchaseID] = 5
SELECT * FROM [dbo].[tblStampNames]
SELECT * FROM [dbo].[tblStampPurchases]
ROLLBACK TRANSACTION

ALTER TABLE [dbo].[tblStampNames] ADD [Rarity] VARCHAR(20) NULL
ALTER TABLE [dbo].[tblStampNames] ALTER COLUMN [Rarity] VARCHAR(30)
ALTER TABLE [dbo].[tblStampNames] DROP COLUMN [Rarity]
ALTER TABLE [dbo].[tblStampNames] ADD CONSTRAINT DF_tblStampNames_StampCountry DEFAULT 'Unknown' FOR [StampCountry]
ALTER TABLE [dbo].[tblStampNames] ADD CONSTRAINT UQ_tblStampNames_StampName_StampYear UNIQUE ([StampName], [StampYear])
ALTER TABLE [dbo].[tblStampNames] WITH NOCHECK ADD CONSTRAINT CK_tblStampNames_StampYear CHECK ([StampYear] > 1800)

INSERT INTO [dbo].[tblStampNames]([StampID], [StampName], [StampYear]) VALUES (11, 'Chaanyah', 1999)
INSERT INTO [dbo].[tblStampNames]([StampID], [StampName], [StampYear], [StampCountry]) VALUES (12, 'Saint Luis', 1999, 'USA')
INSERT INTO [dbo].[tblStampNames]([StampID], [StampName], [StampYear], [StampCountry]) VALUES (13, 'Saint Luis', 1989, 'USA')
INSERT INTO [dbo].[tblStampNames]([StampID], [StampName], [StampYear], [StampCountry]) VALUES(14, 'Wills IV', 1820, 'UK')
INSERT INTO [dbo].[tblStampNames]([StampID], [StampName], [StampYear]) VALUES(15, 'Wills III', 1820)


SELECT * FROM [dbo].[tblStampNames]

EXEC SP_HELP '[dbo].[tblStampNames]'


SELECT * FROM [dbo].[tblStampNames]

ALTER TABLE [dbo].[tblStampPurchases] ADD [PurchaseID] INT IDENTITY(1,1)
ALTER TABLE [dbo].[tblStampPurchases] ADD [PurchaseID] INT PRIMARY KEY IDENTITY(1,1)
ALTER TABLE [dbo].[tblStampPurchases] ADD CONSTRAINT PK_tblStampPurchases_PurchaseID PRIMARY KEY ([PurchaseID])
ALTER TABLE [dbo].[tblStampPurchases] DROP COLUMN [PurchaseID]
ALTER TABLE [dbo].[tblStampPurchases] DROP CONSTRAINT PK_tblStampPurchases_PurchaseID
ALTER TABLE [dbo].[tblStampPurchases] DROP CONSTRAINT [PK__tblStamp__6B0A6BDE4C44F754]

EXEC SP_HELP '[dbo].[tblStampPurchases]'
	

SELECT * FROM [dbo].[tblStampPurchases]


CREATE TABLE [dbo].[tblStampAnalysis] (
	[StampCountry] VARCHAR(50) NOT NULL,
	[PurchasePrice] SMALLMONEY
)

DROP TABLE [dbo].[tblStampAnalysis]

INSERT INTO [dbo].[tblStampAnalysis]
SELECT [StampCountry], 
	   [PurchasePrice]
FROM [dbo].[tblStampNames] sn INNER JOIN [dbo].[tblStampPurchases] sp
ON sn.[StampID] = sp.[StampID]

SELECT [StampCountry], 
	   [PurchasePrice]
INTO [dbo].[tblStampAnalysis]
FROM [dbo].[tblStampNames] sn  
JOIN [dbo].[tblStampPurchases] sp
ON sn.[StampID] = sp.[StampID]

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



ALTER TABLE [dbo].[tblTransaction] ADD [TransactionID] INT IDENTITY(1, 1)
ALTER TABLE [dbo].[tblTransaction] DROP COLUMN [TransactionID]

ALTER TABLE [dbo].[tblTransaction] ADD CONSTRAINT PK_tblTransactions_TransactionID PRIMARY KEY ([TransactionID])

ALTER TABLE [dbo].[tblTransaction] WITH NOCHECK ADD CONSTRAINT FK_tblTransactions_EmployeeNumber
FOREIGN KEY ([EmployeeNumber]) REFERENCES [dbo].[tblEmployee] ([EmployeeNumber])
ON DELETE CASCADE
ON UPDATE CASCADE

ALTER TABLE [dbo].[tblTransaction] DROP CONSTRAINT [FK_tblTransactions_TransactionID]
ALTER TABLE [dbo].[tblTransaction] DROP CONSTRAINT [PK_tblTransaction_Amount_DateOfTransaction]


SELECT * FROM [dbo].[tblTransaction]
SELECT * FROM [dbo].[tblEmployee]


-- Stamps

CREATE TABLE [dbo].[tblStampNamesUpdate] (
	StampID TINYINT NOT NULL,
	StampName VARCHAR(12) NOT NULL
)

ALTER TABLE [dbo].[tblStampNamesUpdate] ALTER COLUMN [StampName] VARCHAR(17)

INSERT INTO [dbo].[tblStampNamesUpdate] VALUES (2, 'John Quincy Adams'), (8, 'William III')

TRUNCATE TABLE [dbo].[tblStampNamesUpdate]
GO

SELECT * FROM [dbo].[tblStampNames]
SELECT * FROM [dbo].[tblStampNamesUpdate]
GO


BEGIN TRANSACTION

	SELECT * FROM [dbo].[tblStampNames]

	UPDATE [dbo].[tblStampNames]
	SET [StampName] = SU.[StampName]
	FROM [dbo].[tblStampNames] SN
	LEFT JOIN [dbo].[tblStampNamesUpdate] SU
	ON SN.StampID = SU.StampID
	WHERE SN.[StampID] = SU.[StampID]

	SELECT * FROM [dbo].[tblStampNames]

	SELECT * INTO [dbo].[tblStampNamesDeleted] FROM [dbo].[tblStampNamesUpdate] WHERE [StampName] LIKE '%a%'

	SELECT * FROM [dbo].[tblStampNamesDeleted]

	DELETE FROM [dbo].[tblStampNamesUpdate] WHERE [StampName] LIKE '%a%'

ROLLBACK TRANSACTION

EXEC SP_HELP '[dbo].[tblStampNames]'
EXEC SP_HELP '[dbo].[tblStampNamesUpdate]'


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


ALTER VIEW vw_Stamps WITH SCHEMABINDING AS
SELECT SN.StampID,
	   SN.StampName,
	   SN.StampCountry,
	   SN.StampYear,
	   SP.PurchaseDate, 
	   SP.PurchasePrice 
FROM [dbo].[tblStampPurchases] SP RIGHT JOIN [dbo].[tblStampNames] SN
ON SN.[StampID] = SP.[StampID]
WHERE SN.[StampID] BETWEEN 1 AND 5
--AND [StampName] = 'Inverted Alison'
WITH CHECK OPTION

GO

BEGIN TRANSACTION

	--UPDATE [dbo].[vw_Stamps]
	--SET [StampName] = 'Chaanyah Laborde'
	--WHERE [StampName] = 'Inverted Alison'

	UPDATE [dbo].[vw_Stamps]
	SET [StampID] = [StampID] - 1
	WHERE [StampID] = 2

	--SELECT * FROM [dbo].[vw_Stamps]
	SELECT * FROM [dbo].[tblStampNames]

ROLLBACK TRANSACTION

BEGIN TRANSACTION

	DROP TABLE [dbo].[tblStampPurchases]

ROLLBACK TRANSACTION

SELECT * FROM vw_Stamps WHERE [StampID] IN (2, 4)
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
