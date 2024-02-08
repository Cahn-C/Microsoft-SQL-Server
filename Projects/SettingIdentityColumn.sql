-- Create the table DemoIdentityTable
CREATE TABLE [dbo].[DemoIdentityTable] (
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name VARCHAR(50),
	Address VARCHAR(50)
)

INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Vikas', '123 MN1')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('VikVarunas', '678 MN1')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Vikram', '156 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Roht', '678 MN2')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Puneet', '334 MN2')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Aalam', '156 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Sagar', '156 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Sagar', '156 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Sagar', '156 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Virkant', '556 RM')
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES ('Alibash', '777 VRM')

-- Will produce an errror
INSERT INTO [dbo].[DemoIdentityTable](ID, Name, Address) VALUES (3, 'Vikram', '156 RM')

DELETE FROM [dbo].[DemoIdentityTable] WHERE ID = 3

SET IDENTITY_INSERT [dbo].[DemoIdentityTable] ON
INSERT INTO [dbo].[DemoIdentityTable](ID, Name, Address) VALUES (3, 'Vikram', '156 RM')
SET IDENTITY_INSERT [dbo].[DemoIdentityTable] OFF

SELECT * FROM [dbo].[DemoIdentityTable]


-- How to reset Table Identity
INSERT INTO [dbo].[DemoIdentityTable](Name, Address) VALUES('Vikeant', '556 RM')

DELETE FROM [dbo].[DemoIdentityTable] WHERE ID >= 9

SELECT * FROM [dbo].[DemoIdentityTable]

DBCC CHECKIDENT(DemoIdentityTable, RESEED, 8)
