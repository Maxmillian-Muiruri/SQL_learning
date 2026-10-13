-- MySQL UNION
/* MySQL UNION operator allows you to combine two or more result
 sets of queries into a single result set.*/
 
 DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (
    id INT PRIMARY KEY
);

CREATE TABLE t2 (
    id INT PRIMARY KEY
);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);

-- combine result sets returned from t1 and t2 tables:

SELECT id
FROM t1
UNION
SELECT id
FROM t2;

--  UNION vs. JOIN 
-- A JOIN combines result sets horizontally, a UNION appends result set vertically. 

/* combine the first name and last name of employees and customers into a single result set*/
SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;
    
--     MySQL UNION and ORDER BY #
/**If you want to sort the result set of a union, you use 
an ORDER BY clause in the last SELECT statement:

/
SELECT 
    concat(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY fullname;
    