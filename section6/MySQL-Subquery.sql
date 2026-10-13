-- MySQL Subquery
/* A MySQL subquery is a query nested within another query such as SELECT, INSERT, UPDATE or DELETE. Also,
 a subquery can be nested within another subquery. */
 
 /* uses a subquery to return the employees who work 
 in the offices located in the USA.*/
 SELECT 
    lastName, firstName
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');
            
--  MySQL subquery with comparison operators 
--  create a  query that returns the customer who has the highest payment.       
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount = (SELECT MAX(amount) FROM payments);
    
--  MySQL subquery with IN and NOT IN operators 
/*If a subquery returns more than one value, you can use other operators such as IN or NOT IN operator in the WHERE clause.

*/

/* use a subquery with NOT IN operator to find the
 customers who have not placed any orders :*/
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);
            
-- MySQL subquery in the FROM clause 
/* a subquery in the FROM clause is simply a query inside another query, 
where the inner query acts as a temporary table.*/

/*Instead of pulling data directly from a real table on your hard drive, you tell MySQL: "Hey, run this smaller query first, pretend the
 result is a real table, and let me query from it."*/

-- MySQL correlated subquery 

/*a correlated subquery is a subquery that uses the data from the outer query. In other words, a correlated subquery depends on the outer query. A correlated subquery
 is evaluated once for each row in the outer query.*/

/* use a correlated subquery to select products whose
 buy prices are greater than the average buy price of all products in each product line.

*/

SELECT 
    productname, 
    buyprice
FROM
    products p1
WHERE
    buyprice > (SELECT 
            AVG(buyprice)
        FROM
            products
        WHERE
            productline = p1.productline);


-- MySQL subquery with EXISTS and NOT EXISTS 
/* When a subquery is used with the EXISTS or NOT EXISTS operator, 
a subquery returns a Boolean value of TRUE or FALSE*/

/* find  sales orders whose total values are greater than 60K.*/
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;

/* find customers who placed at least one sales order with a total value greater
 than 60K by using the EXISTS operator:*/

SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
        FROM
            orderdetails
                INNER JOIN
            orders USING (orderNumber)
        WHERE
            customerNumber = customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000);
        
        