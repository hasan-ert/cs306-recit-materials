import mysql.connector
from mysql.connector import errorcode


def columns_string(columns):
    temp = ""
    for col in columns:
        temp += col + ", "
    temp = temp.strip()[:-1]
    return temp


def values_string(columns):
    temp = ""
    for col in columns:
        temp += "%(" + col + ")s, "
    temp = temp.strip()[:-1]
    return temp


def filter_generation(query, condition=None, filters=None):
    """'Generates filters based on a dictionary array which contains {field,value,operator} keys or directly with given condition string"""
    if condition != None:
        query += condition

    elif filters != None:
        query += " Where "
        try:
            for filter in filters:
                query += (
                    filter["field"]
                    + " "
                    + filter["operator"]
                    + " '{}'".format(filter["value"])
                    + " AND "
                )
        except:
            print("The filters array has items which are not a dictionary object")
            return False

        # To get rid of excessive AND at the end, strip and do not take last 4 char
        query = query.strip()[:-4]
    return query


def set_query_generation(query, values=None):
    """'Generates value setter based on a dictionary which has the column name as keys and corresponding values"""
    print("yesss")
    print(values)
    if values != None:
        query += " SET "
        try:
            for key, val in values.items():
                query += key + " = " + " '{}'".format(val) + " , "
        except:
            print("The values is not a dictionary")

        # To get rid of excessive AND at the end, strip and do not take last 4 char
        query = query.strip()[:-2]
    return query


def create_operation(cursor, TABLES):
    """Create tables with a given dictionary object which has table names as keys and corresponding create statements"""
    for table_name in TABLES:
        table_description = TABLES[table_name]
        try:
            print("Creating table {}: ".format(table_name), end="")
            cursor.execute(table_description)
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
                print("already exists.")
            else:
                print(err.msg)
        else:
            print("OK")

    return True


def insert_operation(cursor, table_name, data):
    """Inserts data given which contains column names as the keys and corresponding values"""

    # get column names for generating query string
    columns = data.keys()

    """
    Example query string:
        "INSERT INTO salaries "
        "(emp_no, salary, from_date, to_date) "
        "VALUES (%(emp_no)s, %(salary)s, %(from_date)s, %(to_date)s)")
    """

    # query string is constructed here
    query = (
        "INSERT INTO " + table_name + " (" + columns_string(columns) + ")"
        "VALUES (" + values_string(columns) + ")"
    )
    try:
        print("Inserting {}: ".format(table_name))
        cursor.execute(query, data)
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_DUP_ENTRY:
            print("This instance already exists. \n", data)
        else:
            print(err.msg)
    else:
        print("OK")

    return True


def update_operation(cursor, table_name, values, condition=None, filters=None):
    """Updates instances with given values which contains column names as keys and filter array which has dictionaries that contains filter info"""
    query = """UPDATE {}""".format(table_name)
    query = set_query_generation(query, values=values)
    query = filter_generation(query=query, filters=filters)
    cursor.execute(query)
    print("Update operation successful")
    return True


def delete_operation(cursor, table_name, condition=None, filters=None):
    """Deletes instances with given filter array that contains dictionaries that has filter info"""
    query = """DELETE FROM {} """.format(table_name)
    query = filter_generation(query, condition, filters)
    cursor.execute(query)
    print("Deletion successfull")
    return True


def select_operation(cursor, table_name, condition=None, filters=None):
    """Selects instances with given filter array that contains dictionaries that has filter info"""
    query = """SELECT * FROM {} """.format(table_name)
    query = filter_generation(query=query, condition=condition, filters=filters)
    cursor.execute(query)
    data = cursor.fetchall()
    return data
