USE [BikeStores]


-- 
CREATE TABLE [BikeStores].[dbo].[CalenderLookUp] (
	[Date] DATE,
	day_of_week_number INT,
	day_of_week_name VARCHAR(75),
	day_of_month_number INT,
	month_number INT,
	year_number INT,
	weekend_flag INT,
	holiday_flag INT
)
GO

WITH Dates AS (
	SELECT CAST('01-01-2011' AS DATE) AS AddDates

	UNION ALL

	SELECT DATEADD(DAY, 1, AddDates)
	FROM Dates
	WHERE AddDates < '12-31-2040'
)
-- 
INSERT INTO [BikeStores].[dbo].[CalenderLookUp] (Date)
SELECT * FROM Dates OPTION(MAXRECURSION 30000)


-- 
UPDATE [BikeStores].[dbo].[CalenderLookUp]
SET DayOfWeekNumber = DATEPART(DAY, Date),
	DayOfWeekName = FORMAT(Date, 'dddd'),
	DayOfMonthNumber = DAY(Date),
	MonthNumber = MONTH(Date),
	YearNumber = YEAR(Date)


-- 
UPDATE [BikeStores].[dbo].[CalenderLookUp]
SET WeekendFlag = CASE WHEN DayOfWeekName IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END

-- 
UPDATE [BikeStores].[dbo].[CalenderLookUp]
SET HolidayFlag = CASE WHEN MONTH(Date) = 1 AND DAY(Date) = 1 THEN 1 
					   WHEN MONTH(Date) = 1 AND DAY(Date) = 3 THEN 1
					   WHEN MONTH(Date) = 2 AND DAY(Date) = 3 THEN 1
					   WHEN MONTH(Date) = 5 AND DAY(Date) = 27 THEN 1
					   WHEN MONTH(Date) = 6 AND DAY(Date) = 19 THEN 1
					   WHEN MONTH(Date) = 7 AND DAY(Date) = 4 THEN 1
					   WHEN MONTH(Date) = 9 AND DAY(Date) = 1 THEN 1
					   WHEN MONTH(Date) = 10 AND DAY(Date) = 2 THEN 1
					   WHEN MONTH(Date) = 11 AND DAY(Date) = 11 THEN 1
					   WHEN MONTH(Date) = 11 AND DAY(Date) = 4 THEN 1
					   WHEN MONTH(Date) = 12 AND DAY(Date) = 25 THEN 1
					   ELSE 0 
				  END


SELECT * FROM CalenderLookUp


-- 
select * from production.brands
select * from production.categories
select * from production.products
select * from production.stocks

-- 
select * from sales.customers
select * from sales.order_items
select * from sales.orders
select * from sales.staffs
select * from sales.stores


-- 
select full_name = concat(c.first_name, ' ', c.last_name),
	   o.shipped_date,
	   clu.day_of_week_name,
	   total_List_price = format(sum(oi.list_price), 'c')
from sales.customers c
join sales.orders o
on c.customer_id = o.customer_id
join sales.order_items oi
on o.order_id = oi.order_id
join production.products p
on oi.product_id = p.product_id
join CalenderLookUp clu
on o.shipped_date = clu.Date
where year(o.shipped_date) = 2018
group by concat(c.first_name, ' ', c.last_name),
	     o.shipped_date,
	     clu.DayOfWeekName
