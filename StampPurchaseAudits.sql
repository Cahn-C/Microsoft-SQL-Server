CREATE TABLE [dbo].[tblStampPurchasesAudit] (
	[StampID] TINYINT NOT NULL,
	[PurchaseDate] DATE NOT NULL,
	[PurchasePrice] INT NOT NULL,
	[PurchaseID] INT NOT NULL,
	[TypeOfChange] VARCHAR(20) NOT NULL
)
GO


CREATE TRIGGER TR_tblStampPurchasesAudit_PurchaseAudits ON [dbo].[tblStampPurchases]
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	INSERT INTO [dbo].[tblStampPurchasesAudit]([StampID], [PurchaseDate], [PurchasePrice], [PurchaseID], [TypeOfChange])
	SELECT [StampID], [PurchaseDate], [PurchasePrice], [PurchaseID], 'Inserted' FROM INSERTED

END
GO

INSERT INTO [dbo].[tblStampPurchases]([StampID], [PurchaseDate], [PurchasePrice])
VALUES (7, '2030-01-01', 1234)

UPDATE [dbo].[tblStampPurchases] SET [PurchasePrice] = 1235 WHERE StampID = 7

DELETE FROM [dbo].[tblStampPurchases] WHERE StampID = 7


SELECT * FROM [dbo].[tblStampPurchases]
SELECT * FROM [dbo].[tblStampPurchasesAudit]