USE [SQLTrainingCourse]
/*
=============================================================================================================================================
								DDL
=============================================================================================================================================
*/

CREATE TABLE Customer (
	CustomerID INT NOT NULL,
	CustomerName NVARCHAR(100) NOT NULL,
	CustomerAddress VARCHAR(150) NOT NULL
)
GO


ALTER TABLE Customer ADD PhoneNumber NVARCHAR(15)
ALTER TABLE Customer ADD Gender CHAR(1)
ALTER TABLE Customer ALTER COLUMN PhoneNumber NVARCHAR(25)

TRUNCATE TABLE Customer

DROP TABLE Customer


/*
=============================================================================================================================================
								DML
=============================================================================================================================================
*/

INSERT INTO Customer (CustomerID, CustomerName, CustomerAddress) VALUES (1, 'John', 'London')

INSERT INTO Customer (CustomerId, CustomerName, CustomerAddress) VALUES 
(2, 'Kumar', 'Bangalore'),
(3, 'Abdulia', 'Kuwait')

INSERT INTO Customer (CustomerId, CustomerName, CustomerAddress, PhoneNumber) VALUES 
(4, 'Jessica', 'France', '+1 (770) 321-2984'),
(5, 'Dante', 'Paris', '+1 (770) 321-2984'),
(6, 'Mathew', 'Egypt', '+1 (770) 321-2984'),
(7, 'Rebecca', 'Bangelore', '+1 (770) 321-2984'),
(8, 'Alex', 'New York', '+1 (770) 321-2984'),
(9, 'David', 'New Jersey', '+1 (770) 321-2984'),
(10, 'Moeses', 'California', '+1 (770) 321-2984')						


UPDATE Customer SET Gender = 'M' WHERE CustomerID IN (1, 2, 3, 5, 6, 8, 9, 10)
UPDATE Customer SET Gender = 'F' WHERE CustomerID NOT IN (1, 2, 3, 5, 6, 8, 9, 10)
UPDATE Customer SET PhoneNumber = '+1 (678) 440-2034' WHERE CustomerID = 1
UPDATE Customer SET PhoneNumber = '+1 (678) 382-1173' WHERE CustomerID = 2
UPDATE Customer SET PhoneNumber = '+1 (770) 421-3234' WHERE CustomerID = 3
UPDATE Customer SET PhoneNumber = '+1 (404) 323-3718' WHERE CustomerID = 4
UPDATE Customer SET PhoneNumber = '+1 (679) 198-1222' WHERE CustomerID = 5
UPDATE Customer SET PhoneNumber = '+1 (770) 251-1255' WHERE CustomerID = 6
UPDATE Customer SET PhoneNumber = '+1 (678) 327-4771' WHERE CustomerID = 7
UPDATE Customer SET PhoneNumber = '+1 (404) 392-1033' WHERE CustomerID = 8
UPDATE Customer SET PhoneNumber = '+1 (678) 120-3742' WHERE CustomerID = 9
UPDATE Customer SET PhoneNumber = '+1 (770) 463-3911' WHERE CustomerID = 10

DELETE FROM Customer

/*
=============================================================================================================================================
							      DQL/DRL
=============================================================================================================================================
*/

select * from Customer


/*
=============================================================================================================================================
								DCL
=============================================================================================================================================
*/
