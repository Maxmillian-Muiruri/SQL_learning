--  MySQL HAVING clause 
-- The HAVING clause is used with the GROUP BY clause to filter the groups based on a specified condition.

/*find which order has total sales greater 
than 1000 by using the HAVING clause*/

SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach * quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING total > 1000;

/* use the HAVING clause to find orders that have total amounts
 greater than 1000 and contain more than 600 items:*/
 
 SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM
    orderdetails
GROUP BY ordernumber
HAVING 
    total > 1000 AND 
    itemsCount > 600;
 
 -- Use the MySQL HAVING clause with the GROUP BY clause to specify a filter condition for groups of rows or aggregates.
