USE [PortfolioProject]

select * from dbo.CovidDeaths order by location
select * from dbo.CovidVaccinations order by location


-- Checking the records that I will be using
select location, 
       date, 
       total_cases,
       new_cases,
       total_deaths,
       population
from dbo.CovidDeaths
order by 1, 2


-- Check the percentage death rate for the United States
select location, 
       date, 
       total_cases,
       total_deaths,
       death_percentage = cast(total_deaths AS decimal) / cast(total_cases AS decimal) * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2


-- Check the percentage of the population that received COVID in the United States
select location, 
       date, 
       total_cases,
       population,
       infected_population_percentage = cast(total_cases AS decimal) / population * 100
from dbo.CovidDeaths
where location like '%states%'
order by 1, 2


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


-- Check the countries with the highest death count per population
select location,
       population,
       total_deaths = max(cast(total_deaths as int)),
       max_death_percentage = max((cast(total_deaths as decimal) / population) * 100)
from dbo.CovidDeaths
-- where continent = 'North America'
group by location,
	 population
order by total_deaths desc


-- Break things down by continent
select continent, 
       max_deaths = max(cast(total_deaths as int)) 
from dbo.CovidDeaths
where continent is not null
group by continent


-- Gloabl number of deaths
select total_cases = sum(new_cases),
       total_deaths = sum(new_deaths),
       death_rate_percentage = sum(new_deaths) / sum(new_cases) * 100
from dbo.CovidDeaths
GO

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

-- Total Population vs the total of Vaccinations with CTE
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


-- Creating views to use consistently, and connect the views to Tableau or Power BI
-- Create a view that calculates the max death percentage world wide 
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


-- Create a view that calculates the death rate percentage in the United States
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


-- 
sp_help 'dbo.CovidDeaths'
sp_help 'dbo.CovidVaccinations'
