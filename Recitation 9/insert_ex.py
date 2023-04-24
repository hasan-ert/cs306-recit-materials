import _mysql_connector
from connect import connectionCreator
from cursor_utils import *

cnx = connectionCreator()

cursor = cnx.cursor()

# If you want to execute a query, you can do it directly by writing the whole query

insert_query = """INSERT INTO countries (iso_code,country_name,population) VALUES ("SPN","Spain","45332112")"""
cursor.execute(insert_query)

# You need to commit after your have injected your querries when you are making a change in your table

cnx.commit()

# You can also create a dictionary object to store your data first,
# then carry out insert operation with the stored data in dictionary
# I have created a utils file for insert operations, to see  how it works, checkout cursor_utils.py

country_ex = {"iso_code": "TUR", "country_name": "Turkey", "population": 85769321}

insert_operation(cursor, table_name="countries", data=country_ex)
cnx.commit()

# You can easily iterate over a list of dict objects to insert them into the respective table

country_list = [
    {"iso_code": "GBR", "country_name": "Great Britain", "population": 55493212},
    {"iso_code": "GER", "country_name": "Germany", "population": 83749431},
    {"iso_code": "FRA", "country_name": "France", "population": 60346761},
]


for country in country_list:
    insert_operation(cursor, table_name="countries", data=country)

cnx.commit()
