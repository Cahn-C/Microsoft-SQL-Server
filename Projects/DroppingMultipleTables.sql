--How to drop multiple tables starting with a fixed pattern

CREATE DATABASE DBase
GO

USE DBase
GO

--The following commands are creating multiple tables

CREATE TABLE temp_DATA(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 

GO

CREATE TABLE temp_ABC(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 


GO

CREATE TABLE temp_PQR(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 


GO

CREATE TABLE temp_Test(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 

GO

CREATE TABLE temp_Sales(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 


GO

CREATE TABLE temparature(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 


GO


CREATE TABLE tempotraveller(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 

GO

CREATE TABLE students_DATA(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 

GO

CREATE TABLE employee_DATA(
	[DeptID] [int] NULL,
	[Name] [varchar](50) NULL
) 

GO


-- Drop multiple tables


--sys.tables will display all the tables details of a particular database
SELECT * FROM sys.tables

-- I want to delete all temporary tables so I will write a query that will get all tables that start with 'temp_'
SELECT * FROM sys.tables WHERE name LIKE 'temp_%'

/* 
	The above query will not work, this is due to other tables that start with 'temp_' but the underscore 
	repersents a substituions of a single character in an expression, alomg with the percentage whcih repersents
	0 or more characters or get the rest of the characters
*/

/* 
	To solve the issue, I will surround the underscore(_) with sqaure brackets([]), the underscore will now be repersented
	as a character instead of a wildcard
*/
SELECT * FROM sys.tables WHERE name LIKE 'temp[_]%'

/* 
	Add the 'DROP TABLE ' string to query then concatinate the string with the name of the tables that needs to be 
	dropped

	Copy the query results then paste it inside of the query editor
*/
SELECT 'DROP TABLE ' + name FROM sys.tables WHERE name LIKE 'temp[_]%'

-- Pasted results
DROP TABLE temp_ABC
DROP TABLE temp_DATA
DROP TABLE temp_PQR
DROP TABLE temp_Sales
DROP TABLE temp_Test
