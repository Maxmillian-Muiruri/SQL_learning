-- MySQL LIMIT clause 
-- The MySQL LIMIT clause is used to restrict the number of rows returned by a query.

/*Instead of pulling thousands of records from a table, 
LIMIT tells the database, "Only give me the first X rows."
 It is incredibly useful for improving query performance
 and handling large datasets.*/
 
 /*use the LIMIT clause to get the top five customers who
 have the highest credit:*/
 SELECT 
    customerNumber, 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY creditLimit DESC
LIMIT 5;

/*use the LIMIT clause to find five customers who have the lowest credits:*/
SELECT 
    customerNumber, 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY creditLimit
LIMIT 5;

--  Using MySQL LIMIT clause for pagination 

/*use  the LIMIT clause to get rows of page 1 which contains the first 10 customers 
sorted by the customer name:*/

SELECT 
    customerNumber, 
    customerName
FROM
    customers
ORDER BY customerName    
LIMIT 10;

/* uses the LIMIT clause to get the rows of the 
 second page that include rows 11 – 20:*/
 
 SELECT 
    customerNumber, 
    customerName
FROM
    customers
ORDER BY customerName    
LIMIT 10, 10;
 
--  Using MySQL LIMIT to get the nth highest or lowest value
/*Using the LIMIT clause to get the \(n^{th}\) highest or lowest value means finding a specific ranked item in your database—such as the 2nd highest salary,
 the 3rd lowest price, or the 5th most recent order.*/
 
 /*For example, the following finds the 
 customer who has the second-highest credit:
*/
SELECT 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY 
    creditLimit DESC    
LIMIT 1,1;

-- MySQL LIMIT & DISTINCT clauses 
/*
The LIMIT and DISTINCT clauses in MySQL are used to 
control and filter the rows returned by a SELECT query*/

/* use  the LIMIT clause with the DISTINCT clause to return the first five
 unique states in the customers table:*/
 SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL
LIMIT 5;
 

-- we Use the MySQL LIMIT clause to constrain the number of rows returned by the SELECT statement.
