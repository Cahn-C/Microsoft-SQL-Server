# COVID-19 Project

Ensure that I am using the correct database
```sql
USE [PortfolioProject]
```
<br>

I always check the data types of the tables that I am working with, this is due to certain columns that need to be converted into other data types when I perform certain scripts.
```sql
-- Check the data types and table structure
sp_help 'dbo.CovidDeaths'
sp_help 'dbo.CovidVaccinations'
```
<br>

I gave my self a blue brint of what I will be using throughout this project.
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
<br>

I was curious to see the amount of deaths that have occured in the United States from the start of covid to the current day, I took the total_deaths column and divied the column by the total_cases column then multiplied the results by 100 to get an accurate percentage.
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

```sql
-- Gloabl number of deaths
select total_cases = sum(new_cases),
       total_deaths = sum(new_deaths),
       death_rate_percentage = sum(new_deaths) / sum(new_cases) * 100
from dbo.CovidDeaths
GO
```

```sql
-- Total Population vs the total of Vaccinations with CTE
with vaccinations_cte as (
	select dea.continent,
               dea.location,
               dea.date,
               dea.population,
               vac.new_vaccinations,
               rolling_vaccination_count = sum(cast(vac.new_vaccinations as decimal)) over(partition by dea.location order by dea.date)
	from dbo.CovidDeaths dea
	join dbo.CovidVaccinations vac
	on dea.iso_code = vac.iso_code
	and dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
)
select *, 
       vaccinated_population_percentage = (rolling_vaccination_count / population) * 100
from vaccinations_cte
```

```sql
-- Total Population vs the total of Vaccinations with a Temp Table
DROP TABLE IF EXISTS #vaccinated_population
CREATE TABLE #vaccinated_population (
	continent VARCHAR(100),
	location VARCHAR(100),
	[date] DATE,
	[population] FLOAT,
	new_vaccinations INT,
	rolling_vaccination_count FLOAT
)

INSERT INTO #vaccinated_population
select dea.continent,
       dea.location,
       dea.date,
       dea.population,
       cast(vac.new_vaccinations as int),
       rolling_vaccination_count = sum(cast(vac.new_vaccinations as decimal)) over(partition by dea.location order by dea.date)
	from dbo.CovidDeaths dea
	join dbo.CovidVaccinations vac
	on dea.iso_code = vac.iso_code
	and dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null

select  *,
        vaccinated_population_percentage = (rolling_vaccination_count / population) * 100
from #vaccinated_population
```


```sql
-- Creating views to use consistently, and connect the views to Tableau or Power BI
-- 
CREATE VIEW vw_max_deaths AS
select location,
       population,
       total_deaths = max(cast(total_deaths as int)),
       max_death_percentage = max((cast(total_deaths as decimal) / population) * 100)
from dbo.CovidDeaths
-- where continent = 'North America'
group by location,
         population
-- order by total_deaths desc

select * from vw_max_deaths


-- 
CREATE VIEW vw_united_states_death_rate AS
select location, 
       date, 
       total_cases,
       total_deaths,
       death_percentage = cast(total_deaths AS decimal) / cast(total_cases AS decimal) * 100
from dbo.CovidDeaths
where location like '%states%'
--order by 1, 2

select * from vw_united_states_death_rate
```
