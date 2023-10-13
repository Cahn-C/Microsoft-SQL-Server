-- 
with Odds as (
		
	select 1 as OddNumbers

	union all

	select OddNumbers + 1
	from Odds
	where OddNumbers < 100

)
select * from Odds where OddNumbers % 2 <> 0


-- 
with Dates as (

	select cast('01-01-2020' as date) as FirstOfMonth

	union all

	select dateadd(month, 1, FirstOfMonth) 
	from Dates
	where FirstOfMonth < cast('12-01-2029' as date)

)
select * from Dates option(maxrecursion 365)