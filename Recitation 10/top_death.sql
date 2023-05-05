Select C.iso_code, population, MAX(total_deaths)  as TotalDeathCount, MAX(total_deaths) / population as DeathRate
From deaths D, countries C
Where C.iso_code = D.iso_code
Group by iso_code
order by TotalDeathCount desc
Limit 10