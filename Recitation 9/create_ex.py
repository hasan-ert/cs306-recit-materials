from connect import connectionCreator
from cursor_utils import create_operation

# create a connection with database
cnx = connectionCreator()

cursor = cnx.cursor()

# You can directly write your querries and execute them

query = """Create table continents_countries(
    iso_code Varchar(5),
	continent_code Varchar(10),
    Primary key (iso_code, continent_code),
    Foreign key (continent_code) references continents(continent_code) on delete cascade,
    Foreign key (iso_code) references countries(iso_code) On delete Cascade
) """

cursor.execute(query)

# Create a table dictionary to store queries
TABLES = {}

TABLES["continents"] = (
    "Create Table continents("
    "continent_code Varchar(10),"
    "continent_name Varchar(50),"
    "primary key (continent_code))"
)

TABLES[
    "countries"
] = """Create Table countries(
	iso_code Varchar(5),
    country_name Varchar(50),
    population INT,
    primary key (iso_code)
)"""

# Then feed this dictonary into the create_operation function to easily create your tables
create_operation(cursor, TABLES)
