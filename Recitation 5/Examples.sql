-- Using distinct keyword for getting unique values

SELECT Distinct(sailors.age)
FROM sailors
WHERE age < 50;

-- Find names of sailors who
-- are the captain of some sailors
Select Distinct(S.sname) 
From sailors S, captain_of C
Where C.captain_id = S.sid;

-- Arithmetic operations & using string patterns
SELECT S.sname, S.age, S.age-5 as age1, 2*S.age AS age2
FROM Sailors S
WHERE S.sname LIKE 'B_%B';


-- Display the sailors who reserved red or green boats
SELECT R.sid, R.bid
FROM Boats B, Reserves R
WHERE R.bid=B.bid
AND (B.color='red' OR B.color='green');

-- Same example using union

SELECT R.sid
FROM Boats B, Reserves R
WHERE R.bid=B.bid
AND B.color='red'
UNION
SELECT R.sid
FROM Boats B, Reserves R
WHERE R.bid=B.bid
AND B.color='green';

-- Not In is a keyword that returns the set difference of two union-compatible sets of tuples 
SELECT R.sid
FROM Boats B, Reserves R
WHERE R.bid=B.bid
AND B.color='red' AND R.sid NOT IN (
					SELECT R.sid
					FROM Boats B, Reserves R
					WHERE R.bid=B.bid
					AND B.color='green');
                    
                    
-- Find sid's of sailors who've reserved a red and a green boat
SELECT R1.sid
FROM Boats B1, Reserves R1,
Boats B2, Reserves R2
WHERE R1.sid = R2.sid AND
R1.bid=B1.bid AND R2.bid=B2.bid
AND (B1.color='red' AND B2.color='green');

-- same example using IN keyword
-- In keyword checks whether a given value exist in the corresponding set that is provided

SELECT R.sid
FROM Boats B, Reserves R
WHERE R.bid=B.bid
AND B.color='red' AND (R.sid IN (
						SELECT R1.sid
						FROM Boats B1, Reserves R1
						WHERE R1.bid=B1.bid
						AND B1.color='green'));

-- Sailors who did not reserve boat 103

SELECT S.sid, S.sname
FROM Sailors S
WHERE S.sid IN (
				SELECT R.sid
				FROM Reserves R
				WHERE R.bid=103);


-- Find names of sailors who’ve reserved both a red and a green boat:
SELECT S.sname, S.sid
FROM Sailors S, Boats B, Reserves R
WHERE S.sid=R.sid AND R.bid=B.bid AND B.color='red' 
		AND S.sid IN (SELECT S2.sid
					FROM Sailors S2, Boats B2, Reserves R2
					WHERE S2.sid=R2.sid AND R2.bid=B2.bid
					AND B2.color='green');


-- Join Examples
Select * 
from sailors S
Join reserves R;

Select * 
from sailors S
Inner Join reserves R on R.sid = S.sid;


Select * 
from Sailors S
Left Join Reserves R on R.sid = S.sid;

Select * 
from Sailors S
Right Join Reserves R on R.sid = S.sid;


-- Since there is not a full outer join in MySQL, here is a work around
SELECT *
FROM sailors
LEFT JOIN reserves ON sailors.sid = reserves.sid
UNION
SELECT *
FROM sailors
RIGHT JOIN reserves ON sailors.sid = reserves.sid
WHERE sailors.sid IS NULL;



-- Aggregate Functions

-- Average age of sailors in the club whose rating is 10
SELECT AVG(S.age)
FROM Sailors S
WHERE S.rating=10;

-- Average distinct ages of sailors in the club whose rating is 10?

SELECT AVG ( DISTINCT S.age)
FROM Sailors S
WHERE S.rating=10;

-- Names of sailors whose rating is equal to the maximum rating in the club.
SELECT S.sname
FROM Sailors S
WHERE S.rating= (SELECT MAX(S2.rating)
					FROM Sailors S2);


-- How many different ratings are there in the club?
SELECT COUNT(S.rating)
FROM Sailors S;

-- Above query is nor right, why?
-- The correct one is: 
SELECT COUNT(DISTINCT(S.rating))
FROM Sailors S;

-- Find the age of the youngest sailor with age >= 18,
-- for each rating with at least 2 such sailors

SELECT S.rating, MIN(S.age) AS min_age
FROM Sailors S
WHERE S.age >= 18
GROUP BY S.rating
HAVING COUNT(*) > 1;

