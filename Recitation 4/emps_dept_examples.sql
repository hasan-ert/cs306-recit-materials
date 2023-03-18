-- Insert data for employee table
Insert Into employees Values (1,'Hasan',100);
Insert Into employees Values (2,'Ertugrul',200);
Insert Into employees Values (3,'Elif',500);
-- 

-- Insert data for Departments table
Insert Into Departments Values (110,'CS',1000);
Insert Into Departments Values (111,'EE',700);
Insert Into Departments Values (112,'IE',1200);
-- 

-- Insert data for Works_in relationship
-- Make sure to preserve Key Contraints
-- Otherwise it will throw an error

-- Valid Examples
Insert Into Works_in Values (1,110,'2015-03-13');
Insert Into Works_in Values (2,112,'2015-03-13');
Insert Into Works_in Values (3,110,'2015-03-13');

-- Invalid Examples
-- Since ssn = 4  does not exist in employees, it will throw an error
Insert Into Works_in Values (4,110,'2015-03-13');
-- Since did = 115 does not exist in departments, it will throw an error
Insert Into Works_in Values (1,115,'2015-03-13');

--

-- Insert data for Dept_Manages relationship
-- Make sure to preserve Key Constraints and Participation Constraints
-- Otherwise it will throw an error

-- Valid Examples
Insert Into Dept_Mgr (ssn,did,since,dname,budget) Values (1,111,'2015-03-13','EE',500);
Insert Into Dept_Mgr (ssn,did,since,dname,budget) Values (3,110,'2016-04-13','CS',700);
Insert Into Dept_Mgr (ssn,did,since,dname,budget) Values (1,112,'2020-07-10','IE',600);

-- Invalid Examples
-- Since ssn value needs to be unique, it will throw an error due to already having a manager for 'did' = 112
Insert Into Dept_Mgr (ssn,did,since,dname,budget) Values (3,112,'2020-07-10','IE',600);
-- 

-- Display records in Dept_mgr table
Select * from Dept_mgr;



-- Insert data for dep_policy table
-- Make sure to preserve Key Contraints
-- Since the dep_policy is a weak entity, it requires ssn in its primary key which comes from employees table
-- Otherwise it will throw an error

-- Valid Examples
Insert Into dep_policy (pname,ssn,age,cost) Values ('policy_1',1,25,30);
Insert Into dep_policy (pname,ssn,age,cost) Values ('policy_2',2,23,20);


-- Invalid Examples
-- Since supervisor_ssn = 4 does not exist in employees, it will throw an error
Insert Into dep_policy (pname,ssn,age,cost) Values ('policy_2',4,23,20);
-- If we try to make an insert with duplicate primary key tuple, it will throw an error
Insert Into dep_policy (pname,ssn,age,cost) Values ('policy_2',2,23,20);




-- Insert data for Reports_to relationship
-- Make sure to preserve Key Contraints
-- Otherwise it will throw an error

-- Valid Examples
Insert Into Reports_to Values (3,2);
Insert Into Reports_to Values (2,1);

-- Invalid Examples
-- Since supervisor_ssn = 4 does not exist in employees, it will throw an error
Insert Into Reports_to Values (4,1);

-- Use select statements for displaying the records in tables
Select * From employees;
Select * from Dept_mgr;
Select * from dep_policy;

-- Due to referential integrity constraints, 
-- if we delete an employee, repective dependent table record will be deleted
Delete from employees where ssn = 2;
Select * from dep_policy;



-- Insert value into hourly_emp table which is a subtable to employees table in ISA relationship 
-- Hourly employee id must exist in Employees table in order to insert into hourly_emps table
INSERT INTO hourly_emps (ssn,hourly_wages,hours_worked) VALUES (1,100,20);

-- Same example can be applied to contract_worker table too

Select * from hourly_emps;
