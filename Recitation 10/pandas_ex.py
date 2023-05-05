from connect import connectionCreator
import pandas as pd
import numpy as np

mydb = connectionCreator()
query = "Select * from countries"

# By sending your query along with the connector, 
# pandas can automatically read the incoming data and create a dataframe for it

result_dataFrame = pd.read_sql(query,mydb)

#close the connection
mydb.close() 

# Let's see the dataset's sample
print(result_dataFrame.head())