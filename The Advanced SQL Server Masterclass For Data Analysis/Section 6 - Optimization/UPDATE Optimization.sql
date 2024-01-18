USE [AdventureWorks2019]

SELECT A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
      ,B.PhoneNumber
      ,PhoneNumberType = C.Name
      ,D.EmailAddress

FROM AdventureWorks2019.Person.Person A
	LEFT JOIN AdventureWorks2019.Person.PersonPhone B
		ON A.BusinessEntityID = B.BusinessEntityID
	LEFT JOIN AdventureWorks2019.Person.PhoneNumberType C
		ON B.PhoneNumberTypeID = C.PhoneNumberTypeID
	LEFT JOIN AdventureWorks2019.Person.EmailAddress D
		ON A.BusinessEntityID = D.BusinessEntityID



CREATE TABLE #Employees (
	BusinessEntityID INT,
	Title VARCHAR(5),
	FirstName VARCHAR(50),
	MiddleName VARCHAR(50),
	LastName VARCHAR(50),
	PhoneNumberTypeID INT,
	PhoneNumber VARCHAR(19),
	PhoneNumberType VARCHAR(4),
	EmailAddress VARCHAR(100)
)

INSERT INTO #Employees (
	BusinessEntityID,
	Title,
	FirstName,
	MiddleName,
	LastName
)
SELECT A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
FROM AdventureWorks2019.Person.Person A


UPDATE #Employees 
SET PhoneNumber = B.PhoneNumber,
    PhoneNumberTypeID = B.PhoneNumberTypeID
FROM #Employees A 
JOIN Person.PersonPhone B
ON A.BusinessEntityID = B.BusinessEntityID

UPDATE #Employees
SET PhoneNumberType = B.Name
FROM #Employees A
JOIN Person.PhoneNumberType B
ON A.PhoneNumberTypeID = B.PhoneNumberTypeID


UPDATE #Employees 
SET EmailAddress = B.EmailAddress
FROM #Employees A 
JOIN Person.EmailAddress B
ON A.BusinessEntityID = B.BusinessEntityID


SELECT * FROM #Employees

DROP TABLE #Employees
