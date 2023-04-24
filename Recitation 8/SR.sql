DROP TABLE IF EXISTS `enrolled`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `courses`;
DROP TABLE IF EXISTS `stuco`;
DROP TABLE IF EXISTS `students_w_login`;


CREATE TABLE stuco(
sid INTEGER,
sname VARCHAR(50),
address VARCHAR(20),
cid INTEGER,
cname VARCHAR(30),
PRIMARY KEY (sid,cid)
);

Insert Into stuco VALUES 
-- Insert instance that seems fine
(1,'Ali','Istanbul','306',"Database Systems"),
(1,'Ali','Istanbul','307',"Operating Systems"),
(2,'Sara','Ankara','306',"Database Systems"),
(2,'Sara','Ankara','300',"Data Structures"),
(3,'Ahmet','Izmir','306',"Database Systems"),
(3,'Ahmet','Izmir','300',"Data Structures"),
(4,'Ayse','Edirne','300',"Data Structures");


-- What happens if a student does not take any course?
Insert Into stuco VALUES  (5,'Ertuğrul','Istanbul',null,null);

-- Well it does not work, what about this one?
Insert Into stuco VALUES  (5,'Ertuğrul','Istanbul',0,null);

-- What about opening a course which deos not have anyone enrolled  yet?
Insert Into stuco VALUES (null,null,null,"48001","New Course");

-- That does not work as well, but would it be okay if we used a dummy value?
Insert Into stuco VALUES (-1,null,null,"48001","New Course");

-- Do you see any problem regarding to update as well?
Update stuco Set address = "Konya" Where sid = 1 and cid = 306;
Select * From stuco Where sid = 1;
-- How could it be possible for someone to have two differnet addresses?


-- Problems also exists on deletion operation
Delete from stuco where sid = 1;
Select * from stuco;
-- The course with cid 307 is only taken by student 1, there is no record for that course
-- This situation is called deletion anomally


/*
Can any attribute define the whole relation on this table?
 
What are the FDs on this table?
- sid -> {sname,address}
- cid -> {cname}
- sid,cid -> {sname,address,cname}

Only by using both sid and cid we can represent the whole relation

*/

-- Talk about replicated data and redundancy
-- Talk about partial dependency: sid determines snames and address not the whole relation and it is a subset of sid,cid key
-- Also cid determines only cname and it is a subset of sid,cid key



-- Create 3 decomposed tables students, cources and enrollment with PKs and FKs
-- insert all values
-- Talk about the decomposed FDs on tables

# In students relation, there is only one key, sid. 
# sid uniquely determines the whole Students relation which also means that all other attributes are functionally dependent on sid.
CREATE TABLE students (
sid INTEGER,
sname VARCHAR(50),
address VARCHAR(50),
PRIMARY KEY (sid));

Insert Into students VALUES 
-- Insert same students 
(1,'Ali','Istanbul'),
(2,'Sara','Ankara'),
(3,'Ahmet','Izmir'),
(4,'Ayse','Edirne'),
(5,'Ertuğrul','Istanbul');
Insert Into students Values
(6,'Ertuğrul','Istanbul');


-- cid determines the whole relation so it is key
CREATE TABLE courses(
cid INTEGER,
cname VARCHAR(30),
PRIMARY KEY (cid)
);

-- Insert same courses
Insert Into courses Values
("306","Database Systems"),
("307","Operating Systems"),
("300","Data Structures"),
("48001","New Course");


-- no decomposed FDs for relation enrolled 
-- sid and cid determines the whole relation (trivial FDs {SC--> S, SC-->C}), so combination is a key.
CREATE TABLE enrolled(
sid INTEGER,
cid INTEGER,
PRIMARY KEY (sid,cid),
FOREIGN KEY (sid) REFERENCES students(sid) ON DELETE CASCADE,
FOREIGN KEY (cid) REFERENCES courses(cid) ON UPDATE CASCADE);

Insert Into enrolled Values
(1,306),
(1,307),
(2,306),
(3,306),
(3,300),
(4,300),
(5,300);

Select * from students;
select * from enrolled;

Select S.sname,C.cname from students S, courses C, enrolled E where 
S.sid = E.sid AND C.cid = E.cid;



# In students_w_login relation, there are two keys, if there are more then one we call them candidate keys, sid and login. sid uniquely identify the whole relation and login uniquely identify the whole relation.
# One candidate key is chosen to be a primary key, sid. Others can be secondary keys, login..
# how about sid, login pair? this combination uniquely identify the whole relation but it is not minimal so it is not a key, in fact a superkey
# key should be minimal, if any subset is also a key it is not minimal so it is a superkey

CREATE TABLE students_w_login (
sid INTEGER,
sname VARCHAR(50),
login VARCHAR(50) not null,
address VARCHAR(50),
UNIQUE (login),
PRIMARY KEY (sid));

-- (login,sid) ->  {sname,address}
-- (login) ->  {sname,address}
-- (sid) ->  {sname,address}


Insert Into students_w_login Values (1,"Ali","ali@sabanciuniv.edu","Istanbul");
Insert Into students_w_login Values (2,"Sara","sara@sabanciuniv.edu","Istanbul");
Insert Into students_w_login Values (3,"Ali","ali@sabanciuniv.edu","Konya");
-- Since the login field is also unique for each row, we cannot insert same value for login field in different instances


-- For stuco relation for given FDs try to get sid,cid (SC for short) attribute closure and show that SC determines the whole relation 

