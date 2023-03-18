CREATE TABLE Employees 
                  (ssn CHAR(11),
                  name CHAR(20),
                  lot  INTEGER,
                  PRIMARY KEY  (ssn));
                  
CREATE TABLE Departments 
                  (did integer,
                  dname CHAR(20),
                  budget  INTEGER,
                  PRIMARY KEY  (did));
                  
CREATE TABLE Works_in(
  ssn  CHAR(11),
  did  INTEGER,
  since  DATE,
  PRIMARY KEY (ssn, did),
  FOREIGN KEY (ssn) 
        REFERENCES employees(ssn) ON DELETE CASCADE,
  FOREIGN KEY (did) 
        REFERENCES departments(did) ON DELETE CASCADE);
        
CREATE TABLE  Dept_Mgr(
   did  INTEGER,
   dname  CHAR(20),
   budget  REAL,
   ssn  CHAR(11) not null,
   since  DATE,
   PRIMARY KEY  (did),
   FOREIGN KEY (ssn) REFERENCES Employees(ssn) ON UPDATE CASCADE);

CREATE TABLE  Dep_Policy (
   pname  CHAR(20),
   age  INTEGER,
   cost  REAL,
   ssn  CHAR(11),
   PRIMARY KEY  (pname, ssn),
   FOREIGN KEY  (ssn) REFERENCES Employees(ssn)
      ON DELETE CASCADE);

CREATE TABLE Reports_To 
                  (supervisor_ssn CHAR(11),
                  subordinate_ssn CHAR(11),
                  FOREIGN KEY  (supervisor_ssn) REFERENCES Employees(ssn),
                  FOREIGN KEY  (subordinate_ssn) REFERENCES Employees(ssn));

CREATE TABLE Hourly_Emps 
                  (ssn CHAR(11),
                  hourly_wages integer,
                  hours_worked integer,
				  primary key (ssn),
                  FOREIGN KEY  (ssn) REFERENCES Employees(ssn));
                  
CREATE TABLE Contract_Emps 
                  (ssn CHAR(11),
                  contract_id integer,
				  primary key (ssn),
                  FOREIGN KEY  (ssn) REFERENCES Employees(ssn));