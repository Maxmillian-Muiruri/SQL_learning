-- MySQL DROP TABLE

CREATE TABLE insurances (
    id INT AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    effectiveDate DATE NOT NULL,
    duration INT NOT NULL,
    amount DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);

DROP TABLE insurances;

desc insurance;

--  Using MySQL DROP TABLE to drop multiple tables 


CREATE TABLE CarAccessories (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE CarGadgets (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);
DROP TABLE CarAccessories, CarGadgets;


-- using mysql DROP TABLE  to drop a non existing table
DROP TABLE aliens;   -- it issues an error   0	148	20:10:59	DROP TABLE aliens	Error Code: 1051. Unknown table 'datatypes_demo.aliens'	0.000 sec
--   if you use the IF EXISTS option in the DROP TABLE statement:

DROP TABLE IF EXISTS aliens; --  mysql  issues a warning instead 1	149	20:12:23	DROP TABLE IF EXISTS aliens	0 row(s) affected, 1 warning(s): 1051 Unknown table 'datatypes_demo.aliens'	0.031 sec

-- MySQL DROP TABLE based on a pattern 

-- 1. create table
CREATE TABLE test1(
  id INT AUTO_INCREMENT,
  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS test2 LIKE test1;
CREATE TABLE IF NOT EXISTS test3 LIKE test1;

-- 2. declare two variables that accept database schema and a pattern that you want to the tables to match:

-- set table schema and pattern matching for tables
SET @schema = 'classicmodels';
SET @pattern = 'test%';

-- 3.  construct a dynamic DROP TABLE statement:

-- construct dynamic sql (DROP TABLE tbl1, tbl2...;)
SELECT CONCAT('DROP TABLE ',GROUP_CONCAT(CONCAT(@schema,'.',table_name)),';')
INTO @droplike
FROM information_schema.tables
WHERE @schema = database()
AND table_name LIKE @pattern;


-- 4.  display the dynamic SQL to verify if it works correctly:

-- display the dynamic sql statement
SELECT @droplike;

-- 5. execute the statement using a prepared statement  as shown in the following query:

-- execute dynamic sql
PREPARE stmt FROM @droplike;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
/* if you want to drop multiple tables that have a specific pattern in a database, you just use the script above to save time.

All you need to do is replace the pattern and the database schema in @pattern and @schema variables.*/

