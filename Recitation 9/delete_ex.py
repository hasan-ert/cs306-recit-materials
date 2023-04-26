import _mysql_connector
from connect import connectionCreator
from cursor_utils import *


cnx = connectionCreator()
cursor = cnx.cursor()

query = """DELETE FROM countries WHERE iso_code = 'GBR'"""
cursor.execute(query)
cnx.commit()
print("Query executed successfully")

filters = [{"field": "iso_code", "value": "TUR", "operator": "="}]

delete_operation(cursor=cursor, table_name="countries", filters=filters)
cnx.commit()
