from connect import connectionCreator
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

mydb = connectionCreator()

# Check out the view named death_cases_ratio for the data itself
# It basically returns the DeathPercentage regarding to the number of cases for each country

# North Korea is excluded because there is a problem with the data provided
# You may check it if you are curious

query = ''' 
SELECT DeathPercentage 
FROM death_cases_ratio
ORDER BY DeathPercentage DESC
LIMIT 10
'''

df = pd.read_sql(query,mydb)

print(df.head())

# Plot a barplot of the ratio data
sns.barplot(x='name', y='DeathPercentage', data=df)
plt.xlabel('Country')
plt.ylabel('Death Percentage')
plt.title('Death Percentage of countries')
plt.show()


