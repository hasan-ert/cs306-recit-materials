
-- Insert data for Continents table
Insert Into continent values ('NA','North America');
Insert Into continent Values ('AF','Africa');
Insert Into continent Values ('EU','Europe');
Insert Into continent Values ('SA','South America');
Insert Into continent Values ('OC','Oceania');
Insert Into continent Values ('AS','Asia');


-- Insert data for continent_has relationship
-- Make sure to preserve Key Contraints, they must exist in referenced tables
-- Otherwise it will throw an error

-- Valid Examples
Insert Into continent_has Values ('AS','CHN');
Insert Into continent_has Values ('EU','GBR');
Insert Into continent_has Values ('EU','TUR');

-- Invalid Examples
-- Since HAS does not exist in continents , it will throw an error
Insert Into continent_has Values ('HAS','TUR');
-- Since PPP does not exist in countries, it will throw an error
Insert Into continent_has Values ('EU','PPP');

-- Since each continent_has relationship is one to many, each continent can be used twice, 
-- but any country cannot be used more than once
Insert Into continet_has Values ('AF','CHN');


--

-- Insert data for Dept_Manages relationship
-- Make sure to preserve Key Constraints and Participation Constraints
-- Otherwise it will throw an error

-- Valid Examples
Insert Into cases (iso_code,date_info,new_cases,total_cases) Values ('CHN','2021-03-13',300,10000);
Insert Into cases   (iso_code,date_info,new_cases,total_cases) Values ('GBR','2022-06-21',100,3200);


-- Invalid Examples
-- Remember that cases entity is a weak entity and depends on the iso_code that comes from countries table
-- Since (iso_code,date_info) tuple value needs to be unique due to being a Primary Key, it will throw an error due to already having a record for this key
Insert Into cases   (iso_code,date_info,new_cases,total_cases) Values ('GBR','2022-06-21',150,3500);

-- The iso_code must exist in the countries table due to being required for determining which record corresponds to which country
Insert Into cases   (iso_code,date_info,new_cases,total_cases) Values ('AAAA','2022-06-21',150,3500);
-- 


-- Display inserted records in cases table
(Select * 
from cases 
where iso_code = 'GBR' 
and  date_info = '2022-06-21' 
limit 10000
);

-- This exercise can be applied to other weak entities, deaths and vaccination, in ER model


-- Use select statements for displaying the records in tables
-- Display countries that are a part of Europe
Select C.iso_code,C.name, C.population From countries C, continent_has H where H.continent_code = 'EU' AND H.iso_code = C.iso_code; 

-- Display cases which belongs to Turkey
Select C.date_info, C.new_cases, C.total_cases, CT.name from cases C, countries CT where CT.name = 'Turkey' and C.iso_code = CT.iso_code;


-- Due to referential integrity constraints, 
-- if we delete an employee, repective dependent table record will be deleted
Delete from countries where iso_code = 'CHN';
Select * from continent_has;

