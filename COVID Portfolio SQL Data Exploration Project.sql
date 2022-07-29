SELECT * 
From PortfolioProject..['Covid Deaths$']
WHERE continent is not null
order by 3,4

SELECT * 
From PortfolioProject..['Covid Vaccinations$']
WHERE continent is not null
order by 3,4

--- Select Data that we are going to be using

Select Location, Date, total_cases, new_cases, total_deaths, population
From PortfolioProject..['Covid Deaths$']
WHERE continent is not null
order by 1,2;


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..['Covid Deaths$']
WHERE location like '%states%' and continent is not null
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

Select Location, Date, population, total_cases, (total_cases/population)*100 as 'Percentage Population Infected'
From PortfolioProject..['Covid Deaths$']
WHERE  continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate Compared to Population

Select Location, population, MAX(total_cases) as 'Highest Infection Count', MAX((total_cases/population))*100 as 'Percent Population Infected'
From PortfolioProject..['Covid Deaths$']
--WHERE location like '%states%'
WHERE continent is not null
Group by Location, population
order by [Percent Population Infected] desc

-- Showing Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_Deaths as int)) as 'Total Death Count'
From PortfolioProject..['Covid Deaths$']
--WHERE location like '%states%'
WHERE continent is not null
Group by Location
order by [Total Death Count] desc

-- BREAKING THINGS DOWN BY CONTINENT



-- Showing continents with highest death count per population

Select continent, MAX(cast(Total_Deaths as int)) as 'Total Death Count'
From PortfolioProject..['Covid Deaths$']
--WHERE location like '%states%'
WHERE Continent is not null
Group by Continent
order by [Total Death Count] desc


-- Global Numbers

Select SUM(new_cases) as 'Total Cases', SUM(CAST(New_deaths as int)) AS 'Total Deaths', 
	SUM(CAST(New_deaths as int))/Sum(New_Cases)*100 as 'Death Percentage'
From PortfolioProject..['Covid Deaths$']
WHERE continent is not null
--Group by total_cases
order by 1,2;

--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.Location, dea.Date) 
	as RollingPeopleVaccinated
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3


-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.Location, dea.Date) 
	as RollingPeopleVaccinated
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

-- TEMP TABLE

Drop Table if Exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric, 
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.Location, 
	dea.Date) as RollingPeopleVaccinated
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by location

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.Location, 
	dea.Date) as RollingPeopleVaccinated
From PortfolioProject..['Covid Deaths$'] dea
Join PortfolioProject..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3

Select * 
From PercentPopulationVaccinated