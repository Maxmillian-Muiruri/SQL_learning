-- MySQL CTE
-- A common table expression is a named temporary result set that exists solely within the execution scope of a single SQL statement, such as SELECT, INSERT, UPDATE, or DELETE.
--  a common table expression (CTE) is not stored as an object and lasts only during the query execution.

-- MySQL CTE examples 

--   this example illustrates how to use a CTE for querying data from the customers
WITH customers_in_usa AS (
    SELECT 
        customerName, state
    FROM
        customers
    WHERE
        country = 'USA'
) SELECT 
    customerName
 FROM
    customers_in_usa
 WHERE
    state = 'CA'
 ORDER BY customerName;
 
 
--  2 Getting top sales using a CTE 


--  uses a CTE to retrieve the top 5 sales representatives based on their total sales in the year 2003:

WITH topsales2003 AS (
    SELECT 
        salesRepEmployeeNumber employeeNumber,
        SUM(quantityOrdered * priceEach) sales
    FROM
        orders
            INNER JOIN
        orderdetails USING (orderNumber)
            INNER JOIN
        customers USING (customerNumber)
    WHERE
        YEAR(shippedDate) = 2003
            AND status = 'Shipped'
    GROUP BY salesRepEmployeeNumber
    ORDER BY sales DESC
    LIMIT 5
)
SELECT 
    employeeNumber, 
    firstName, 
    lastName, 
    sales
FROM
    employees
        JOIN
    topsales2003 USING (employeeNumber);
 
--  3 Using multiple CTEs 
    
    
    
  -- this example uses multiple CTEs to map the customers with their respective sales representatives:

WITH salesrep AS (
    SELECT 
        employeeNumber,
        CONCAT(firstName, ' ', lastName) AS salesrepName
    FROM
        employees
    WHERE
        jobTitle = 'Sales Rep'
),
customer_salesrep AS (
    SELECT 
        customerName, salesrepName
    FROM
        customers
            INNER JOIN
        salesrep ON employeeNumber = salesrepEmployeeNumber
)
SELECT 
    *
FROM
    customer_salesrep
ORDER BY customerName;    
    
    
    
   --  4 Joining two CTEs example 
   

--     the example is creating two CTEs and joining them to get the Sales Representative  located in the USA, including their office information:

    
    WITH e AS (
  SELECT 
    * 
  FROM 
    employees 
  WHERE 
    jobTitle = 'Sales Rep'
), 
o AS (
  SELECT 
    * 
  FROM 
    offices 
  WHERE 
    country = 'USA'
) 
SELECT 
  firstName, 
  lastName, 
  city, 
  state, 
  postalCode 
FROM 
  e 
  INNER JOIN o USING (officeCode);

-- Use MySQL CTEs to break down complex queries into simpler, more manageable queries. Each CTE represents a temporary result set that can be referenced within the main query.
    
    
    
    