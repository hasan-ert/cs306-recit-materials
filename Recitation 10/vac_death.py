from connect import connectionCreator
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

mydb = connectionCreator()


query = ''' 
Select C.country_name, population, Max(total_vaccinations),
MAX(total_deaths)  as TotalDeathCount, MAX(total_deaths) / population as DeathRate
From deaths D, countries C, vaccinations V
Where C.iso_code = D.iso_code AND V.iso_code = C.iso_code
Group by C.iso_code
order by Max(total_vaccinations)/population desc
Limit 10
'''

df = pd.read_sql(query,mydb)

print(df.head())

# Plot a barplot of the ratio data
sns.barplot(x='country_name', y='DeathRate', data=df)
plt.xlabel('Country Name')
plt.xticks(rotation=90)
plt.tick_params(
    axis='x',          # changes apply to the x-axis
    which='both',      # both major and minor ticks are affected
    bottom=False,      # ticks along the bottom edge are off
    top=False,         # ticks along the top edge are off
    labelbottom=False) # labels along the bottom edge are off
plt.ylabel('Death Rate')
plt.title('Death Rate of countries which has the highest vaccination rate to population')
plt.show()


