Create Table continent(
	continent_code Varchar(5) NOT NULL,
    continent_name Varchar(50),
    primary key (continent_code)
);

Create Table countries(
	iso_code Varchar(5) NOT NULL,
    country_name Varchar(50),
    population INT,
    primary key (iso_code)
);

Create table continent_has(
	continent_code Varchar(5),
	iso_code Varchar(5),
    Primary key (continent_code, iso_code),
    Foreign key (continent_code) references continent(continent_code) on delete cascade,
    Foreign key (iso_code) references countries(iso_code) On delete Cascade
);

Create Table cases(
	date_info DATETIME,
    iso_code varchar(5) NOT NULL,
    new_cases DECIMAL,
	total_cases DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

Create Table vaccinations(
	date_info DATETIME,
    iso_code varchar(5) NOT NULL,
    new_vaccinations DECIMAL,
	people_vaccinated DECIMAL,
	people_fully_vaccinated DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

Create Table deaths(
	date_info DATETIME,
    iso_code varchar(5) NOT NULL,
    new_deaths DECIMAL,
	total_deaths DECIMAL,
    PRIMARY KEY (iso_code,date_info),
    Foreign Key (iso_code) References countries(iso_code) ON DELETE CASCADE
);

