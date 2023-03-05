/* 
You may insert values manually by using insert into statement
If the column order is not specified, the table column order is applied to insertion operation values
*/
Insert Into cases (iso_code, date_info,new_cases,total_cases) Values ('TUR','2023-03-11 00:00:00',1,1);

/* 
For deletion operation, delete from statement is used
If the stament does not provide a where clause in the query, all the records in the table is deleted
Otherwise, only the columns that satisfies the condition are deleted
*/

Delete from cases where date_info = '2023-03-11 00:00:00';


/*
Alter table is used for modifying the rules of the table itself
In this example it is used for altering the name of "country_name" column to "name"
You may check out https://www.w3schools.com/ for different examples
*/
Alter table countries 
Rename column country_name to `name`;