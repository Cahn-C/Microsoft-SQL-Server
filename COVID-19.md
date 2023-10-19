# COVID-19 Project

```sql
-- Checking the records that I will be using
select location, 
	   date, 
	   total_cases,
	   new_cases,
	   total_deaths,
	   population
from dbo.CovidDeaths
order by 1, 2
```

```sql
-- Check the percentage death rate for the United States
select location, 
	   date, 
	   total_cases = format(cast(total_cases as int), 'N0'),
	   total_deaths = format(cast(total_deaths as int), 'N0'),
	   infected_population_percentage = cast(total_deaths AS decimal) / cast(total_cases AS decimal) * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2
```

```sql
-- Check the percentage of the population that received COVID in the United States
select location, 
	   date, 
	   total_cases = format(cast(total_cases as int), 'N0'),
	   population = format(population, 'N0'),
	   death_percentage = cast(total_cases AS decimal) / population * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2
```

```sql
-- Get the largest total cases along with the largest percentage of people that were infected by COVID for each country
select location,
	   population = format(population, 'N0'),
	   total_cases = max(format(cast(total_cases as int), 'N0')),
	   max_infected_percentage = max((cast(total_cases as decimal) / population) * 100)
from dbo.CovidDeaths
where continent is not null
group by location,
	     format(population, 'N0')
order by max_infected_percentage desc
```

```sql
-- Check the countries with the highest death count per population
select location,
	   population = format(population, 'N0'),
	   total_deaths = max(format(cast(total_deaths as int), 'N0')),
	   max_death_percentage = max((cast(total_deaths as decimal) / population) * 100)
from dbo.CovidDeaths
where continent is not null
group by location,
	     format(population, 'N0')
order by total_deaths desc
```
