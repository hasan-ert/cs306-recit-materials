DROP TABLE IF EXISTS `enrolled`;
DROP TABLE IF EXISTS `students`;

CREATE TABLE students (
sid INTEGER,
name VARCHAR(50),
login VARCHAR(50),
age INTEGER,
gpa real,
PRIMARY KEY(sid)
);

-- insert students
INSERT INTO  Students (sid, name, login, age, gpa)
VALUES  (53688, ‘Shero’, ‘shero@cs’, 18, 3.2);

--

SELECT  *
FROM  Students S
WHERE  S.age=18;


CREATE TABLE courses(
cid INTEGER,
cname VARCHAR(30),
grade char(1),
PRIMARY KEY (cid)
);

-- insert courses

CREATE TABLE enrolled(
sid INTEGER,
cid INTEGER,
grade Char(1),
FOREIGN KEY (sid) REFERENCES students(sid) ON DELETE SET NULL,
FOREIGN KEY (cid) REFERENCES courses(cid) ON UPDATE CASCADE);

-- insert enrolled

SELECT  S.name, E.cid
FROM  Students S, Enrolled E
WHERE  S.sid=E.sid AND E.grade=“A”;

CREATE VIEW goodStudents (sid,gpa)
AS SELECT S.sid
	FROM students S
    WHERE S.gpa > 3;


