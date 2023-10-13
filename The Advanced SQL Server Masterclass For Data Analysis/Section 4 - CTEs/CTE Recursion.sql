with NumberSeries as (
	-- Anchor Member
	select 1 as MyNumber

	-- UNION ALL
	union all

	-- Recursive Member - references the definition of the virtual table itself
	-- Will also increments the anchor member by a certain amount: In this case, by 1
	select MyNumber + 1 
	from NumberSeries

	-- Termination condition, it will stop executing at a certain point
	where MyNumber < 100
)
select * from NumberSeries


with DateSeries as (
	select cast('01-01-2021' as date) as MyDate

	union all

	select dateadd(day, 1, MyDate) 
	from DateSeries
	where MyDate < cast('12-31-2021' as date)
)
select * from DateSeries option(maxrecursion 365)