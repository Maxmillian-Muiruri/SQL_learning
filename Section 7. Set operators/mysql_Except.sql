-- MySQL EXCEPT
-- The MySQL EXCEPT operator allows you to retrieve rows from one query that do not appear in another query.

CREATE TABLE t1 (

    id INT PRIMARY KEY
);

CREATE TABLE t2 (
    id INT PRIMARY KEY
);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);

SELECT id FROM t1
EXCEPT
SELECT id FROM t2;

/* uss the EXCEPT operator to find the first
 names that appear in the customers table but do not appear in the employees table:*/
 
 SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers;

-- Using the EXCEPT operator with the ORDER BY clause example 

/* use the EXCEPT operator to get the first names that appear in the employees table but do not appear
 in the customers table and sort the first names alphabetically:*/

SELECT firstName
FROM employees
EXCEPT
SELECT contactFirstName
FROM customers
ORDER BY firstName;


-- Using the EXCEPT operator with the ALL option 

/* use  the EXCEPT operator with the ALL option to retain
 duplicate first names in the result set:*/
 
 SELECT firstName
FROM employees
EXCEPT ALL
SELECT contactFirstName
FROM customers
ORDER BY firstName;

