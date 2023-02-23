SELECT * FROM portfolioproject.covid_deaths;
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioproject.covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2




--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From portfolioproject.covid_deaths
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2






Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From portfolioproject.covid_deaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc




Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolioproject.covid_deaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc





Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolioproject.covid_deaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc



Select dea.continent, dea.location, dea.date, dea.population
, MAX(vac.total_vaccinations) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinaions vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3





Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioproject.covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2




--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From portfolioproject.covid_deaths
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2



Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From portfolioproject.covid_deaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc




Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolioproject.covid_deaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc




--Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--From portfolioproject.covid_deaths
----Where location like '%states%'
--where continent is not null 
--order by 1,2

-- took the above query and added population
Select Location, date, population, total_cases, total_deaths
From portfolioproject.covid_deaths
--Where location like '%states%'
where continent is not null 
order by 1,2




With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinaions vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100 as PercentPeopleVaccinated
From PopvsVac


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolioproject.covid_deaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc



