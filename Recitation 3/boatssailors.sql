
-- Table structure for table `boats`
--

DROP TABLE IF EXISTS `boats`;

CREATE TABLE `boats` (
  `bid` integer AUTO_INCREMENT,
  `bname` varchar(200) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT 'white',
  PRIMARY KEY (`bid`));

--
-- Dumping data for table `boats`
--

INSERT INTO `boats` 
VALUES (101,'Interlake','blue'),(102,'Interlake','red'),(103,'Clipper','green'),(104,'Marine','red'),(105,'Titanic','black');

--
-- Table structure for table `sailors`
--

DROP TABLE IF EXISTS `sailors`;

CREATE TABLE `sailors` (
  `sid` integer AUTO_INCREMENT,
  `sname` varchar(200) NOT NULL,
  `rating` double NOT NULL DEFAULT '0.0',
  `age` double NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`sid`)
);

--
-- Dumping data for table `sailors`
--

INSERT INTO `sailors` VALUES (22,'Dustin',7.1,45.0),(29,'Brutus',1.1,33.0),(31,'Lubber',8.0,55.0),(32,'Andy',8.0,25.5),(58,'Rusty',10.0,35.0),(64,'Horatio',7.0,35.0),(71,'Zorba',10.0,16.0),(74,'Horatio',9.0,35.0),(85,'Art',3.0,25.5),(95,'Bob',3.0,63.5);

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;

CREATE TABLE `reserves` (
  `sid` integer NOT NULL,
  `bid` integer NOT NULL,
  `rdate` date NOT NULL,
  UNIQUE `sid` (`sid`,`bid`),
  CONSTRAINT `fk_boat` FOREIGN KEY (`bid`) REFERENCES `boats` (`bid`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sailor` FOREIGN KEY (`sid`) REFERENCES `sailors` (`sid`) ON DELETE CASCADE ON UPDATE NO ACTION
);

--
-- Dumping data for table `reserves`
--

INSERT INTO `reserves` VALUES (22,101,'2014-02-19'),(58,105,'2014-02-27'),(71,103,'2014-02-03'),(22,104,'2014-03-12'),(29,102,'2014-03-14');

CREATE TRIGGER update_rating
AFTER INSERT ON reserves
FOR EACH ROW
UPDATE sailors SET rating = rating+0.1
WHERE sid = NEW.sid;


SELECT S.sid,S.sname,S.rating,R.rdate, R.bid, R.sid 
FROM sailors S, reserves R;

SELECT DISTINCT S.sname 
FROM sailors S, reserves R 
WHERE S.sid = R.sid;

-- Find the boat that is not reserved yet

SELECT DISTINCT B.bname 
FROM boats B 
WHERE B.bid not in (SELECT R.bid 
					FROM reserves R);

SELECT B.bid 
FROM boats B 
WHERE not EXISTS (SELECT R.bid 
					FROM reserves R 
                    WHERE R.bid = B.bid);

-- find the sailot that did not reserve a boat yet
SELECT DISTINCT S.sname 
FROM sailors S 
WHERE S.sid not in (SELECT R.sid 
					FROM reserves R);
                    
-- Get the numbers of sailors according to their ratings:
SELECT S.rating, COUNT(*) as group_count 
FROM sailors S 
GROUP BY S.rating;

-- Find the reservations for each boat :
SELECT B.bid, COUNT(*) AS reserve_count 
FROM boats B, reserves R 
WHERE R.bid=B.bid 
GROUP BY B.bid;

SELECT B.bid,COUNT(*) AS reserve_count 
FROM boats B, reserves R 
WHERE 
R.bid=B.bid and B.color='red' 
GROUP BY B.bid;