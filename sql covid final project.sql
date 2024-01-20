-- Selecting all columns from CovidDeaths and ordering by the 3rd and 4th columns
SELECT *
FROM CovidDeaths
ORDER BY 3, 4;

-- Selecting all columns from CovidVaccinations and ordering by the 3rd and 4th columns
--SELECT *
--FROM CovidVaccinations
--ORDER BY 3, 4;

-- Selecting specific columns from CovidDeaths and ordering by the 1st and 2nd columns
-- Selecting data that we are going to be using
SELECT Location, Date, total_cases, new_cases, total_cases, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;

-- Looking at total cases vs total deaths
-- Shows the likelihood of dying if you get COVID in your country
SELECT Location, Date, total_cases, total_deaths,
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS DeathPercentage
FROM CovidDeaths
WHERE Location LIKE 'india'
ORDER BY 1, 2;

-- Table 6
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int)) / SUM(New_Cases) * 100 AS DeathPercentage
FROM CovidDeaths
-- WHERE location LIKE '%states%'
WHERE continent IS NOT NULL
-- GROUP BY date
ORDER BY 1, 2;

-- Looking at total cases vs population
-- Shows what percentage of the population got COVID
SELECT Location, Date, population, total_cases,
(total_cases / Population) * 100 AS PercentOfPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL
-- WHERE location LIKE 'india'
ORDER BY 1, 2;

-- Excluding entities not included in the above queries to stay consistent
-- European Union is part of Europe
-- This is table 2
SELECT Location, SUM(CAST(new_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
-- WHERE location LIKE '%states%'
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Looking at countries with the highest infection rate compared to population
-- This is table 3
SELECT Location, population, Date, MAX(total_cases) AS HighestInfectionCount,
MAX((total_cases / population)) * 100 AS PercentOfPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, population, Date
ORDER BY PercentOfPopulationInfected DESC;

-- Showing countries with the highest death count per population
SELECT Location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Let's break things by continent
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global Numbers
-- Table 1
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths,
CASE 
    WHEN SUM(new_cases) > 0 
    THEN (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 
    ELSE NULL -- Depending on your preference
END AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
-- GROUP BY date
ORDER BY 1, 2;

-- Looking at total population vs vaccinations
SELECT death.continent, death.location, death.population, death.date,
MAX(vac.total_vaccinations) AS PeopleVaccinated
FROM CovidDeaths death
JOIN CovidVaccinations vac ON death.date = vac.date AND death.location = vac.location
WHERE death.continent IS NOT NULL
GROUP BY death.continent, death.location, death.date, death.population
ORDER BY 1, 2, 4;

-- Using CTE
WITH populationVSvaccination (continent, location, date, population, new_vaccinations, peoplevaccinated)
AS (
    SELECT death.continent, death.location, death.date, death.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS bigint)) OVER (PARTITION BY death.location ORDER BY death.date, death.location) AS peoplevaccinated
    FROM CovidDeaths death
    JOIN CovidVaccinations vac ON death.date = vac.date AND death.location = vac.location
    WHERE death.continent IS NOT NULL
    -- ORDER BY 2, 4
)
SELECT *, (CAST(peoplevaccinated AS FLOAT) / CAST(population AS FLOAT)) * 100 AS VaccinationPercentage
FROM populationVSvaccination;

-- Using Temp Table to perform Calculation on Partition By in the previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    PeopleVaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(BIGINT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
FROM CovidDeaths dea
JOIN CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
-- WHERE dea.continent IS NOT NULL 
-- ORDER BY 2, 3;

SELECT *, (CAST(PeopleVaccinated AS FLOAT) / CAST(Population AS FLOAT)) * 100 AS VaccinationPercentage
FROM #PercentPopulationVaccinated;

-- Creating a view to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT death.continent, death.location, death.population, death.date, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY death.location ORDER BY death.date, death.location) AS PeopleVaccinated
FROM CovidDeaths death
JOIN CovidVaccinations vac ON death.date = vac.date AND death.location = vac.location
WHERE death.continent IS NOT NULL;
-- ORDER BY 2, 4;
