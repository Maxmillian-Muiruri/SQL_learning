-- MySQL GROUP BY

/*GROUP BY clause groups rows into summary 
rows based on column values or expressions. 
It returns one row for each group and reduces the number
 of rows in the result set.

*/

/*If you want to group the order statuses, you can use the GROUP BY clause
 with the status column */
 SELECT 
  status 
FROM 
  orders 
GROUP BY 
  status;
  
-- Using MySQL GROUP BY with aggregate functions 
-- An aggregate function calculates a set of rows and returns a single value.
/* to obtain the number of orders in each status,
 you can use the COUNT function with the GROUP BY clause  */
 
 SELECT 
  status, 
  COUNT(*) 
FROM 
  orders 
GROUP BY 
  status;

/* join the orders table with the orderdetails
 table and use the SUM function to calculate the total amount:
 To get the total amount of all orders by status,*/
 
 SELECT 
  status, 
  SUM(quantityOrdered * priceEach) AS amount 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
GROUP BY 
  status;
  
-- MySQL GROUP BY with expression

/* you can group rows by expressions. 
The following query calculates the total sales for each year*/

SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  YEAR(orderDate);

--  Using MySQL GROUP BY with HAVING clause example 
/*To filter the groups returned by GROUP BY 
clause, you use a  HAVING clause.

*/

-- use the HAVING clause to select the total sales of the years after 2003.
  SELECT 
  YEAR(orderDate) AS year, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
WHERE 
  status = 'Shipped' 
GROUP BY 
  year 
HAVING 
  year > 2003;
 
-- Grouping by multiple columns 
/* following query returns the year, order status, and
 the total order for each combination 
of year and order status by grouping rows into groups*/

SELECT 
  YEAR(orderDate) AS year, 
  status, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orders 
  INNER JOIN orderdetails USING (orderNumber) 
GROUP BY 
  year, 
  status 
ORDER BY 
  year;

  