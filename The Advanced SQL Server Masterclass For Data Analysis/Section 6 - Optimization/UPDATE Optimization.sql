USE [AdventureWorks2017]

-- Starter code
SELECT 
	   A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
	  ,B.PhoneNumber
	  ,PhoneNumberType = C.Name
	  ,D.EmailAddress

FROM AdventureWorks2017.Person.Person A
	LEFT JOIN AdventureWorks2017.Person.PersonPhone B
		ON A.BusinessEntityID = B.BusinessEntityID
	LEFT JOIN AdventureWorks2017.Person.PhoneNumberType C
		ON B.PhoneNumberTypeID = C.PhoneNumberTypeID
	LEFT JOIN AdventureWorks2017.Person.EmailAddress D
		ON A.BusinessEntityID = D.BusinessEntityID


-- Code to imporve query performance
CREATE TABLE #BusinessRecords2017 (
	BusinessEntityID INT,
	Title VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleName VARCHAR(100),
	LastName VARCHAR(100),
	PhoneNumber VARCHAR(19),
	PhoneNumberType VARCHAR(4),
	EmailAddress VARCHAR(100)
)
INSERT INTO #BusinessRecords2017 (
	BusinessEntityID,
	Title,
	FirstName,
	MiddleName,
	LastName
)
SELECT * FROM #BusinessRecords2017

-- 
UPDATE #BusinessRecords2017
SET PhoneNumber = B.PhoneNumber
FROM #BusinessRecords2017 A
JOIN Person.PersonPhone B
ON A.BusinessEntityID = B.BusinessEntityID

-- 
UPDATE #BusinessRecords2017
SET PhoneNumberType = C.Name
FROM #BusinessRecords2017 A
JOIN Person.PersonPhone B
ON A.BusinessEntityID = B.BusinessEntityID
JOIN Person.PhoneNumberType C
ON B.PhoneNumberTypeID = C.PhoneNumberTypeID


-- 
UPDATE #BusinessRecords2017
SET EmailAddress = B.EmailAddress
FROM #BusinessRecords2017 A
JOIN Person.EmailAddress B
ON A.BusinessEntityID = B.BusinessEntityID

