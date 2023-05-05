from connect import connectionCreator
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

mydb = connectionCreator()

print("Welcome, this script outputs a barchart containing the cases throughout the covid19 pandemic")
input_country = input("Please provide the name of the country you want to display: ")
input_country2 = input("Please provide the name of the second country you want to display: ")


query = ''' 
SELECT CT.country_name, CAST(date_info AS DATETIME) as date,new_cases
FROM cases C, countries CT
WHERE C.iso_code = CT.iso_code AND (CT.country_name = '{}' OR CT.country_name = '{}')
ORDER BY date_info ASC
'''.format(input_country,input_country2)

df = pd.read_sql(query,mydb)

print(df.head())

# Plot a barplot of the ratio data
sns.barplot(x='date', y='new_cases', data=df, hue="country_name")
plt.xlabel('Date')
plt.xticks(rotation=90)
plt.tick_params(
    axis='x',          # changes apply to the x-axis
    which='both',      # both major and minor ticks are affected
    bottom=False,      # ticks along the bottom edge are off
    top=False,         # ticks along the top edge are off
    labelbottom=False) # labels along the bottom edge are off
plt.ylabel('Cases')
plt.title('Cases of {} and {}'.format(input_country,input_country2))
plt.show()


