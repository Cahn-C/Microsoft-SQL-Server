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
	   total_cases,
	   total_deaths,
	   death_percentage = cast(total_deaths AS decimal) / cast(total_cases AS decimal) * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2
```

```sql
-- Check the percentage of the population that received COVID in the United States
select location, 
	   date, 
	   total_cases,
	   population,
	   infected_population_percentage = cast(total_cases AS decimal) / population * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2
```

```sql
-- Get the largest total cases along with the largest percentage of people that were infected by COVID for each country
select location,
	   population,
	   total_cases = max(cast(total_cases as int)),
	   max_infected_percentage = max((cast(total_cases as decimal) / population) * 100)
from dbo.CovidDeaths
where continent is not null
-- and location like '%states%'
group by location,
	     population
order by total_cases desc
```

```sql
-- Check the countries with the highest death count per population
select location,
	   population,
	   total_deaths = max(cast(total_deaths as int)),
	   max_death_percentage = max((cast(total_deaths as decimal) / population) * 100)
from dbo.CovidDeaths
where continent is not null
group by location,
	     population
order by total_deaths desc
```

```sql
-- Break things down by continent
select continent, 
	   max_deaths = max(cast(total_deaths as int)) 
from dbo.CovidDeaths
where continent is not null
group by continent
```
