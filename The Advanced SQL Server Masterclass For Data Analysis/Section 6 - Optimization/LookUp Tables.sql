-- Create a Calender Lookup Table
CREATE TABLE [AdventureWorks2017].[dbo].[CalenderLookUp] (
	[Date] DATE,
	DayofWeekNumber INT,
	DayofWeekName VARCHAR(20),
	DayofMonthNumber INT,
	MonthNumber INT,
	YearNumber INT,
	WeekendFlag INT,
	HolidayFlag INT
)
GO

-- Insert values from the January 1st 2011 to December 31st 2030
WITH Dates AS (

	SELECT CAST('01-01-2011' AS DATE) AS DateValues

	union all

	select DATEADD(DAY, 1, DateValues)
	from Dates
	where DateValues < CAST('12-31-2030' AS DATE)

)
INSERT INTO [AdventureWorks2017].[dbo].[CalenderLookUp] (
	[Date]
)
SELECT * FROM Dates OPTION(MAXRECURSION 10000)


-- Update the columns in the Calender table
UPDATE [AdventureWorks2017].[dbo].[CalenderLookUp]
SET DayofMonthNumber = DATEPART(WEEKDAY, Date),
	DayofWeekName = FORMAT(Date, 'dddd'),
	DayofWeekNumber = DAY(Date),
	MonthNumber = MONTH(Date),
	YearNumber = YEAR(Date)


-- Update the weekend column with 1 indicating a weekend and 0 indicationg a weekday
UPDATE [AdventureWorks2017].[dbo].[CalenderLookUp]
SET WeekendFlag = CASE WHEN DayofWeekName in ('Saturday', 'Sunday') THEN 1 ELSE 0 END


-- Update the holiday column with 1 indicating a holdiay in the United States and 0 indicating no holiday
UPDATE [AdventureWorks2017].[dbo].[CalenderLookUp]
SET HolidayFlag = CASE WHEN DayofWeekNumber = 1 AND MonthNumber = 1 THEN 1
					   WHEN DayofWeekNumber = 23 AND MonthNumber = 11 THEN 1 
					   WHEN DayofWeekNumber = 25 AND MonthNumber = 12 THEN 1
					   WHEN DayofWeekNumber = 16 AND MonthNumber = 1 THEN 1
					   WHEN DayofWeekNumber = 20 AND MonthNumber = 2 THEN 1
					   WHEN DayofWeekNumber = 29 AND MonthNumber = 5 THEN 1
					   WHEN DayofWeekNumber = 16 AND MonthNumber = 6 THEN 1
					   WHEN DayofWeekNumber = 4 AND MonthNumber = 7 THEN 1
					   WHEN DayofWeekNumber = 4 AND MonthNumber = 9 THEN 1
					   ELSE 0 
				  END


-- Check the results
select * from dbo.CalenderLookUp where HolidayFlag = 1

-- Get the Week day names for every order date
select distinct
       B.OrderDate, 
       A.DayofWeekName 
from dbo.CalenderLookUp A
join Purchasing.PurchaseOrderHeader B
on A.Date = b.OrderDate
