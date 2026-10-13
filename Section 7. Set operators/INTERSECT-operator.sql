-- MySQL INTERSECT
-- The INTERSECT operator is a set operator that returns the common rows of two or more queries.

-- Setting up sample tables 
CREATE TABLE t1 (
    id INT PRIMARY KEY
);

CREATE TABLE t2 LIKE t1;

INSERT INTO t1(id) VALUES(1),(2),(3);

INSERT INTO t2(id) VALUES(2),(3),(4);
SELECT id FROM t1;
SELECT id FROM t2;

/* use the INTERSECT operator to get a result set that contains 
the rows common to both t1 and t2 tables:*/
SELECT id FROM t1
INTERSECT
SELECT id FROM t2;

/* use the INTERSECT operator to find the common
 first names of customers and employees:*/
 
 SELECT 
    firstName
FROM
    employees 
INTERSECT
SELECT 
    contactFirstname
FROM
    customers;
--  Using INTERSECT operator with ORDER BY clause 

/*use the INTERSECT operator to find the common first names of employees and 
customers and sort them in ascending order:*/

 SELECT 
    firstName
FROM
    employees 
INTERSECT
SELECT 
    contactFirstname
FROM
    customers
ORDER BY firstName;


--  Using INTERSECT operator with ALL option example 

/* use the INTERSECT operator with the ALL option that finds the common first names 
of employees and customers and retains the duplicates:*/

SELECT 
    firstName
FROM
    employees 
INTERSECT ALL
SELECT 
    contactFirstname
FROM
    customers
ORDER BY firstName;
