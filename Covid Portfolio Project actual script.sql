SELECT *
FROM [Portfolio Project]..CovidDeaths
ORDER BY 3,4

SELECT *
FROM [Portfolio Project]..CovidVaccinations
--where continent is not null
ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [Portfolio Project]..CovidDeaths
ORDER BY 1,2

--We want to compare the Total cases with the Total Deaths
--This shows the likelihood of dying if you contact the virus per country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [Portfolio Project]..CovidDeaths
Where location like '%Nigeria%'
ORDER BY 1,2

--We want to compare the Total cases with the population
--This shows the percentage of the population that contacted covid

SELECT location, date, population,  total_cases,(total_deaths/population)*100 AS PercentagePopulationInfected
FROM [Portfolio Project]..CovidDeaths
Where location like '%Nigeria%'
ORDER BY 1,2

--Looking at countries with highest infection rate compared to population

SELECT location, population,  MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS 
PercentagePopulationInfected
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
Group By location, Population
ORDER BY PercentagePopulationInfected DESC

--Showing countries with Highest Death Count

SELECT location, MAX(cast(Total_Deaths as int)) AS TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
where continent is not null
Group By location
ORDER BY TotalDeathCount DESC

--Showing continent with Highest Death Count (This particular data is not perfect, North America seems to be only America)

SELECT location,MaX(cast(Total_deaths as int)) AS TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
where continent is null
Group By location
ORDER BY TotalDeathCount DESC

--showing continent with the highest DeathCount

SELECT continent,MaX(cast(Total_deaths as int)) AS TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
where continent is not null
Group By continent
ORDER BY TotalDeathCount DESC

--Global Numbers (By date)

SELECT date,SUM(new_cases) AS Total_cases,SUM(cast(new_deaths as int)) AS Total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) *100 AS DeathPercentage
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
where continent is not null
GROUP BY date 
ORDER BY 1,2

--Glabal Numbers (aggregate)
SELECT SUM(new_cases) AS Total_cases,SUM(cast(new_deaths as int)) AS Total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) *100 AS DeathPercentage
FROM [Portfolio Project]..CovidDeaths
--Where location like '%Nigeria%'
where continent is not null
--GROUP BY date 
ORDER BY 1,2

 --Total population vs vaccinations
 --TEMP TABLE

 DROP Table if exists #PerecentPopulationVaccinated
 Create Table #PerecentPopulationVaccinated
 (
 Continent nvarchar (255),
 Location nvarchar  (255),
 Date datetime,
 Population numeric,
 New_vaccinations numerics,
 RollingPeopleVaccinated numeric
 )

 Insert into #PerecentPopulationVaccinated
  --With PopvsVac (Continent,Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
  --as
  (

  Create View  PerecentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
dea.Date) as RollingPeopleVaccinated
--, ( RollingPeopleVaccinated/Population)*100
FROM [Portfolio Project]..CovidDeaths dea
JOIN [Portfolio Project]..CovidVaccinations vac
     ON dea.location = vac.location
	 and dea.date =vac.date
where dea.continent is not null
--ORDER BY 2,3

Select *
From PerecentPopulationVaccinated 

	 )
	 Select *, (RollingPeopleVaccinated/Population)*100
	 From PopvsVac

	 --Creating view to store dta for later visualization

	 
 --USE CTE

