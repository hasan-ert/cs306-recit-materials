from connect import connectionCreator
from cursor_utils import select_operation

cnx = connectionCreator()
cursor = cnx.cursor()

# Like in the other operations, first directly execute SELECT query
query = """SELECT * FROM countries where iso_code = 'TUR'"""
cursor.execute(query)
data = cursor.fetchall()

for instance in data:
    print(instance)

print("-----------------")
# With using the utils

data = select_operation(cursor, table_name="countries")

for instance in data:
    print(instance)

# You can also filter

print("-----------------")

data = select_operation(
    cursor, table_name="countries", condition="WHERE iso_code = 'TUR'"
)

for instance in data:
    print(instance)

print("-----------------")
# Or you can use a dictionary object to filter
# Do not forget that this utils file do not cover all the possibilities
# Since it is a very basic example of what you can create for managing database operations


filters = [{"field": "iso_code", "value": "GBR", "operator": "="}]

data = select_operation(cursor=cursor, table_name="countries", filters=filters)

for instance in data:
    print(instance)
