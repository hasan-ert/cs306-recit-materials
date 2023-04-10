
/*
Queries
*/
 

Select SUM(new_deaths) as total, max(total_deaths)
From deaths
where iso_code = 'TUR';

/*
101492	101492
*/


Select SUM(new_deaths) as new_total, max(total_deaths) as total, d.iso_code, country_name
From deaths d, countries c
where d.iso_code = c.iso_code
group by d.iso_code, country_name
having total > new_total;

/*
How do you explain the difference in total death numbers?
Is it possible that some countries started reporting after deaths 
because new_death numbers are given daily?

Lets select couple countires in this list and look closer..
...

18920	19265	AUS	Australia
51811	64102	CHL	Chile
...
*/

Select *
From deaths
where iso_code = 'CHL';

/*
2020-03-22	CHL	1	1
2020-03-23	CHL	1	2
2020-03-24	CHL	0	2
*/

Select *
From deaths
where iso_code = 'AUS';

/*
2020-03-01	AUS	1	1
2020-03-02	AUS	0	1
2020-03-03	AUS	0	1
*/

Select SUM(new_deaths) as new_total, max(total_deaths) as total, d.iso_code, country_name
From deaths d, countries c
where d.iso_code = c.iso_code
group by d.iso_code, country_name
having total < new_total;

/*
There are also some countires the total death is smaller than sum of daily death numbers..
So the first question is not true..
Is it possible it could be an data or reporting error.. Lets examine closer..

Lets select couple countires in this list and look closer..
...
3636	3630	UGA	Uganda
1118073	1117563	USA	United States
..
*/

Select *
From deaths
where iso_code = 'USA';

/*
2020-02-29	USA	1	1
2020-03-01	USA	0	1
2020-03-02	USA	5	6
2020-03-03	USA	1	7
2020-03-04	USA	4	11
*/

Select *
From deaths
where iso_code = 'UGA';

/*
2020-07-24	UGA	1	1
2020-07-25	UGA	0	1
2020-07-26	UGA	1	2
2020-07-27	UGA	0	2
*/

/* It seems like the total_deaths number are calculated based on the daily reported new_deaths.
So which one we should use as a total_death number?
We can create a trigger and make the total_death calculation when we insert the data. */


DROP TRIGGER IF EXISTS covid_data.`sum_deaths`;

delimiter //
CREATE TRIGGER `sum_deaths` BEFORE INSERT ON `deaths`
FOR EACH ROW
BEGIN
	DECLARE total_death INT;
    SET total_death =  (Select ifnull(Max(total_deaths_calculated),0) from deaths_calculated Where iso_code = NEW.iso_code) ;
	INSERT INTO deaths_calculated (iso_code,date_info,total_deaths_calculated) VALUES (NEW.iso_code,NEW.date_info, total_death + NEW.new_deaths);

END;//
delimiter ;

/* Then we can write a query for finding out which countries has an inequality between 
the values calculated by our trigger and the ones that are existing in the dataset. */
SELECT  D.iso_code, Max(D.total_deaths) , Max(DC.total_deaths_calculated)
FROM covid_data.deaths_calculated DC , deaths D 
where D.iso_code = DC.iso_code and DC.date_info = D.date_info and DC.total_deaths_calculated != D.total_deaths
Group by iso_code;



/* We can also create a procedure which will return the number of deaths and cases in at a date for the given iso_code
	You may think of procedures as the functions in programming languages */
DROP Procedure IF EXISTS covid_data.`get_cases_and_deaths`;
DELIMITER //
CREATE PROCEDURE get_cases_and_deaths (IN iso_code1 VARCHAR(5))  
BEGIN  
    SELECT c.date_info, new_cases,new_deaths,total_cases,total_deaths FROM cases c, deaths d WHERE c.iso_code = d.iso_code and c.iso_code = iso_code1 and c.date_info = d.date_info;     
END//  
DELIMITER ;  

CALL get_cases_and_deaths("GBR");


/* Let's use a view to display the high death rate and low death rate countries */
Drop view if exists high_death_rate;
Create view   high_death_rate as
Select D.iso_code, Max(total_deaths)/C.population as DeathRate
from deaths D, countries C 
where D.iso_code = C.iso_code and (Select (SELECT Max(total_deaths)/c.population
								FROM deaths DE
                                WHERE   DE.iso_code = C.iso_code
								Group By DE.iso_code ) >= 0.005)
Group By D.iso_code;


Drop view if exists low_death_rate;
Create view   low_death_rate as
Select D.iso_code, Max(total_deaths)/C.population as DeathRate
from deaths D, countries C 
where D.iso_code = C.iso_code and (Select (SELECT Max(total_deaths)/c.population
								FROM deaths DE
                                WHERE   DE.iso_code = C.iso_code
								Group By DE.iso_code ) <= 0.002) 
Group By D.iso_code ;

select * from high_death_rate;
select * from low_death_rate;
