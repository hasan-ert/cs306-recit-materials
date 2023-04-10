drop table if exists cases;
drop table if exists vaccinations;
drop table if exists deaths;
drop table if exists continents_countries;
drop table if exists continents;
drop table if exists countries;


-- IF You are having a problem while using load data local infile try this:
-- https://stackoverflow.com/questions/63361962/error-2068-hy000-load-data-local-infile-file-request-rejected-due-to-restrict

-- The answer that helped me to solve is as follows:
/*To Fix this error (mysql 8):
WINDOWS:

ERROR 2068 (HY000): LOAD DATA LOCAL INFILE file request rejected due to restrictions on access.

add the following line into your server's config file, under the "client" section:

To find you config file:
Use this query -> SHOW VARIABLES LIKE 'datadir'
Select the directory without the last folder, which is DATA
You will find an mysql.ini file that contains configuration options

[client]
loose-local-infile=1


That will fix the error. However, this assumes you have already set the following under the "mysqld" section:

[mysqld]
local_infile=1
Having both parameters set in your config file will allow loading data from any directory.

After completing this steps, make sure you restart your MySQL Server. Remember that the Workbench is just a GUI. So you need to go to services and restart your MYSQL80 service which runs your server
*/

-- Mac users please check out the link I have shared in order to solve this problem if you encounter it

Create Table continents(
	continent_code Varchar(10),
    continent_name Varchar(50),
    primary key (continent_code)
);

SET @base_path = 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/';

LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/continents.csv'
INTO TABLE continents fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(continent_code, continent_name);

Create Table countries(
	iso_code Varchar(5),
    country_name Varchar(50),
    population INT,
    primary key (iso_code)
);


LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/countries.csv' 
INTO TABLE countries fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(iso_code, country_name, population);

Create table continents_countries(
    iso_code Varchar(5),
	continent_code Varchar(10),
    Primary key (iso_code, continent_code),
    Foreign key (continent_code) references continents(continent_code) on delete cascade,
    Foreign key (iso_code) references countries(iso_code) On delete Cascade
);

LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/continents_countries.csv' 
INTO TABLE continents_countries fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(iso_code, continent_code);

Create Table cases(
	date_info date,
    iso_code varchar(5),
    new_cases INT default 0,
	total_cases INT default 0,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/cases.csv' 
INTO TABLE cases fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(iso_code, @var_date_info, total_cases, new_cases)
set date_info = STR_TO_DATE(@var_date_info,'%c/%e/%Y');


Create Table vaccinations(
	date_info DATE,
    iso_code varchar(5),
    total_vaccinations DECIMAL,
	people_vaccinated DECIMAL,
	people_fully_vaccinated DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19/vaccinations.csv' 
INTO TABLE vaccinations fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(iso_code, @var_date_info, total_vaccinations, people_vaccinated, people_fully_vaccinated)
set date_info = STR_TO_DATE(@var_date_info, '%c/%e/%Y');

Create Table deaths(
	date_info DATE,
    iso_code varchar(5),
    new_deaths DECIMAL,
	total_deaths DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);


drop table if exists deaths_calculated;
Create Table deaths_calculated(
	date_info DATE,
    iso_code varchar(5),
    total_deaths_calculated DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

INSERT INTO deaths Values ('1998-12-11','TUR',1,1);

LOAD DATA local INFILE 'C:/Users/suuser/Desktop/Elif Hoca/Recitation Slides/Covid19/Covid19//deaths.csv' 
INTO TABLE deaths fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
(iso_code, @var_date_info, total_deaths, new_deaths)
set date_info = STR_TO_DATE(@var_date_info, '%c/%e/%Y');