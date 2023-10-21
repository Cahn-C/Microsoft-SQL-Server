CREATE TABLE #PersonContactInfo
(
       BusinessEntityID INT
      ,Title VARCHAR(8)
      ,FirstName VARCHAR(50)
      ,MiddleName VARCHAR(50)
      ,LastName VARCHAR(50)
      ,PhoneNumber VARCHAR(25)
      ,PhoneNumberTypeID VARCHAR(25)
      ,PhoneNumberType VARCHAR(25)
      ,EmailAddress VARCHAR(50)
)

INSERT INTO #PersonContactInfo
(
       BusinessEntityID
      ,Title
      ,FirstName
      ,MiddleName
      ,LastName
)

SELECT
       BusinessEntityID
      ,Title
      ,FirstName
      ,MiddleName
      ,LastName

FROM AdventureWorks2017.Person.Person

select * from #PersonContactInfo


CREATE NONCLUSTERED INDEX PersonPhoneNumber_idx ON Person.PersonPhone (BusinessEntityID)

UPDATE A
SET
	PhoneNumber = B.PhoneNumber,
	PhoneNumberTypeID = B.PhoneNumberTypeID

FROM #PersonContactInfo A
	JOIN AdventureWorks2017.Person.PersonPhone B
		ON A.BusinessEntityID = B.BusinessEntityID


CREATE NONCLUSTERED INDEX PersonPhoneNumber_idx2 ON Person.PersonPhone (PhoneNumberTypeID)

UPDATE A
SET	PhoneNumberType = B.Name

FROM #PersonContactInfo A
	JOIN AdventureWorks2017.Person.PhoneNumberType B
		ON A.PhoneNumberTypeID = B.PhoneNumberTypeID


CREATE NONCLUSTERED INDEX PersonPhoneNumber_idx3 ON Person.PersonPhone (PhoneNumberTypeID)
DROP INDEX PersonPhoneNumber_idx3 ON Person.PersonPhone 

UPDATE A
SET	EmailAddress = B.EmailAddress

FROM #PersonContactInfo A
	JOIN AdventureWorks2017.Person.EmailAddress B
		ON A.BusinessEntityID = B.BusinessEntityID


SELECT * FROM #PersonContactInfo
