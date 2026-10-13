-- MySQL EXISTS
-- The EXISTS operator is a boolean operator that returns either true or false.

--  use the EXISTS operator to find the customer who has at least one order:

SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS(
	SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber 
		= customers.customernumber);
        
-- use the NOT EXISTS operator to find customers who do not have any orders:
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    NOT EXISTS( 
	SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customernumber
	);

-- MySQL UPDATE EXISTS examples 

/*add  number 1 to the phone extension of 
 employees who work at the office in San Francisco:*/
 UPDATE employees 
SET 
    extension = CONCAT(extension, '1')
WHERE
    EXISTS( 
        SELECT 
            1
        FROM
            offices
        WHERE
            city = 'San Francisco'
                AND offices.officeCode = employees.officeCode);
 
-- MySQL INSERT EXISTS example 

CREATE TABLE customers_archive 
LIKE customers;
INSERT INTO customers_archive
SELECT * 
FROM customers
WHERE NOT EXISTS( 
   SELECT 1
   FROM
       orders
   WHERE
       orders.customernumber = customers.customernumber
);


SELECT * FROM customers_archive;

-- MySQL DELETE EXISTS example 
DELETE FROM customers
WHERE EXISTS( 
    SELECT 
        1
    FROM
        customers_archive a
    
    WHERE
        a.customernumber = customers.customerNumber);
        
--         MySQL EXISTS operator vs. IN operator 
/*To ind the customer who has placed at least one order,
 you can use the IN operator */
 SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    customerNumber IN (
        SELECT 
            customerNumber
        FROM
            orders);
 
