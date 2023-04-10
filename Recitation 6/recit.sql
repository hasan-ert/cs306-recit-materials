
-- Q11: List the names of managers with at least one dependent
SELECT EMPLOYEE.NAME
FROM EMPLOYEE, DEPARTMENT
WHERE DEPARTMENT.MGRSSN = EMPLOYEE.SSN AND
								EMPLOYEE.SSN IN
								(SELECT DISTINCT ESSN
								FROM DEPENDENT);

-- Q12: List the names of employees who do not work on a project controlled by
-- department no 5.
SELECT NAME, SSN
FROM EMPLOYEE
WHERE SSN NOT IN (SELECT WORKSON.ESSN
					FROM WORKSON, PROJECT
					WHERE WORKSON.PNO = PROJECT.PNUMBER
					AND PROJECT.DNUM = 5);


-- Q13: List the names of employees who do not work on all projects controlled by
-- department no 5.
SELECT Distinct E.NAME, E.SSN
FROM WORKSON W, EMPLOYEE E
WHERE E.SSN = W.ESSN
AND EXISTS (SELECT P.PNUMBER
			FROM PROJECT P
			WHERE P.DNUM = 5
			AND NOT EXISTS (SELECT W1.ESSN
							FROM WORKSON W1
							WHERE W1.ESSN = W.ESSN
							AND W1.PNO = P.PNUMBER));

Select * from Employee;

SELECT NAME
FROM EMPLOYEE
WHERE SUPERSSN IS NULL;


-- Q15: Find the SUM of the salaries of all employees, the max salary,
-- min salary and average salary.
SELECT SUM(SALARY) AS SALARY_SUM, MAX(SALARY) AS MAX_SALARY,
MIN(SALARY) AS MIN_SALARY, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEE;


-- Q16: Find the SUM of the salaries of all employees, the max salary,
-- min salary and average salary for research department.
SELECT COUNT(*) AS EMPLOYEE_COUNT, SUM(SALARY) AS SALARY_SUM, MAX(SALARY) AS MAX_SALARY,
MIN(SALARY) AS MIN_SALARY, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DNO = DEPARTMENT.DNUMBER
AND DEPARTMENT.DNAME = 'RESEARCH';

-- Q18: Find the number of distinct salary values for Employees.
SELECT COUNT(DISTINCT SALARY)
FROM EMPLOYEE;

Select Count(*) from employee;


SELECT NAME
FROM EMPLOYEE
WHERE SSN IN (SELECT ESSN
			FROM DEPENDENT
			WHERE RELATIONSHIP LIKE '%Child%'
			GROUP BY ESSN
			HAVING COUNT(*) > 5);
            
Select * from Dependent;
            
-- Q20: For each department, retrieve the department number, number of employees
-- in that department and the average salary.
SELECT DNO, COUNT(*) AS EMPLOYEE_COUNT, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEE
GROUP BY DNO;



-- Q21: For each project, retrieve the project number, the project name, and the number
-- of employees who work for that project.
SELECT PROJECT.PNAME, PROJECT.PNUMBER, COUNT(*) AS EMPLOYEE_COUNT
FROM PROJECT, WORKSON
WHERE WORKSON.PNO = PROJECT.PNUMBER
GROUP BY PROJECT.PNUMBER, PROJECT.PNAME;



-- Q22: For each project on which more than two employees work,
-- retrieve the project number, the project name, and the number
-- of employees who work on the project.
SELECT PROJECT.PNAME, PROJECT.PNUMBER, COUNT(*) AS EMPLOYEE_COUNT
FROM PROJECT, WORKSON
WHERE WORKSON.PNO = PROJECT.PNUMBER
GROUP BY PROJECT.PNUMBER, PROJECT.PNAME
HAVING COUNT(*) > 2;


-- Q23: For each department that has more than four employees, retrieve the department
-- number and the number of its employees who are making more than 40000.
SELECT DNO, COUNT(*) AS EMPLOYEE_COUNT
FROM EMPLOYEE
WHERE SALARY > 40000
			AND DNO IN (SELECT DNO
						FROM EMPLOYEE
						GROUP BY DNO
						HAVING COUNT(*) > 4)
GROUP BY DNO
