from connect import connectionCreator
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

mydb = connectionCreator()

# print()
# input_continent = input("Please enter the continent you want to create a chart for: ")
query = ''' 
SELECT CN.continent_name, Sum(new_cases) as new_cases
FROM cases C, continents_countries CH, countries CO, continents CN
WHERE C.iso_code = CO.iso_code AND CO.iso_code = CH.iso_code AND CH.continent_code = CN.continent_code 
AND C.date_info = '2021-12-10'
GROUP BY CN.continent_name
'''

df = pd.read_sql(query,mydb)

print(df.head())

labels = df["continent_name"]
data = df["new_cases"]
# Plot a pie chart of the cases data for each continent
colors = sns.color_palette('pastel')[0:7]
plt.pie(x=data, labels=labels, colors = colors, autopct='%.0f%%',explode=[0.05]*len(data))
plt.title('New Case distribution of each continent at 10 December 2021')
plt.show()


