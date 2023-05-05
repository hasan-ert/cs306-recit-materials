Create View DeathRatio as
SELECT country_name,MAX(total_deaths) as total_deaths, Max(total_cases) as total_cases, (MAX(total_deaths)/MAX(total_cases) * 100) as DeathPercentage
FROM countries CT, cases C, deaths D
WHERE CT.iso_code = C.iso_code AND C.iso_code = D.iso_code
GROUP BY C.iso_code