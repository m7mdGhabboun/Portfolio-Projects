
/*
Covid 19 Data Exploration

Skills Used: Joins, CTE's, Temp Tables,
Window Functions, Aggregate Functions,
Creating Views, Converting Data Types
*/



SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4
;
--------------------------------------------------
-- Data we will be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--------------------------------------------------
-- Total Cases vs Total Deaths
-- Shows Death likelihood of contracting covid in Jordan
SELECT Location, date, total_cases, total_deaths, population, (total_deaths/total_cases) * 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE 'Jordan'
AND continent IS NOT NULL
ORDER BY 1,2


--------------------------------------------------
-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT Location, date, population, total_cases, (total_cases/population) * 100 as InfectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE 'Jordan'
ORDER BY 1,2

--------------------------------------------------
-- Countries with the Highest Infection Rate compared to Population

SELECT Location, population, MAX(total_cases) AS Total_Cases, MAX((total_cases/population)) * 100 as InfectionRate
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY InfectionRate DESC

--------------------------------------------------
-- Countries with the Highest Deaths per Population

SELECT Location, MAX(cast(total_deaths as int)) AS Total_Deaths
FROM PortfolioProject..CovidDeaths
WHERE Continent IS NOT NULL
GROUP BY location
ORDER BY Total_Deaths DESC



--BREAKING THINGS DOWN BY CONTINENT


--------------------------------------------------
-- Shows continents with the highest deaths per Population

SELECT continent, SUM(CAST(new_deaths AS INT)) AS total_deaths
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC

--------------------------------------------------



--GLOBAL NUMBERS

-- Total Cases and Deaths Globally

SELECT SUM(CAST(new_cases AS INT)) AS Global_Cases, SUM(CAST(new_deaths AS INT)) AS Global_Deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Global_Infection_Rate
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL

--------------------------------------------------

-- Cases and Deaths per Day
SELECT date, SUM(CAST(new_cases AS INT)) AS cases, SUM(CAST(new_deaths AS INT)) AS deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Infection_Rate
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date

--------------------------------------------------
-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population,
vac.new_vaccinations, SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY
dea.location ORDER BY dea.location, dea.date) AS Rolling_Vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- Using CTE to perform Calculation on Partition By in previous query
-- Vaccination Percentage
WITH PopvsVac ( Continent, Location, Date, Population, New_Vaccinations, Rolling_Vaccination) AS
(
	SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY
	dea.location ORDER BY dea.location, dea.date) AS Rolling_Vaccinations
	FROM PortfolioProject..CovidDeaths dea
	JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL
	--ORDER BY 2,3
)
SELECT * , (Rolling_Vaccination / Population) * 100 AS Vaccination_Percentage
FROM PopvsVac

-------------------------------------------------
--Using Temp Table to perform Calculation on Partition By in pervious query


DROP TABLE IF EXISTS #VaccinationPercentage
CREATE TABLE #VaccinationPercentage
(
	Continent NVARCHAR(255),
	Location NVARCHAR(255),
	Date Datetime,
	Population NUMERIC,
	New_Vaccinations NUMERIC,
	Rolling_Vaccinations NUMERIC
)
INSERT INTO #VaccinationPercentage
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY
	dea.location ORDER BY dea.location, dea.date) AS Rolling_Vaccinations
	FROM PortfolioProject..CovidDeaths dea
	JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL
	--ORDER BY 2,3

SELECT * , (Rolling_Vaccinations / Population) * 100 AS Vaccinations_Percentage
FROM #VaccinationPercentage

-------------------------------------------------

-- Creating View to store data for later Visualization
CREATE VIEW VaccinationPercentage AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY
dea.location ORDER BY dea.location, dea.date) AS Rolling_Vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3



