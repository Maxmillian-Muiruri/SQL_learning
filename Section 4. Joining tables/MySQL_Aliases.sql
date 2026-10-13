-- MySQL Aliases
-- MySQL supports two kinds of aliases: column aliases and table aliases.

# Column aliases 
/*A column alias in MySQL is a temporary, alternative name assigned to a column or a calculated expression in a query result set. It exists only for the duration of that single query and does not change
 the actual structure or name of the column in the database.*/

/*query selects the first names and last 
names of employees. It uses the CONCAT_WS() function to concatenate first name and last name into full name:*/
SELECT
   CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM
   employees;
   
   /* use the column alias in the ORDER BY clause to
   alphabetically sort the employee’s full names:*/
   SELECT
	CONCAT_WS(', ', lastName, firstname) `Full name`
FROM
	employees
ORDER BY
	`Full name`;
    
    /* this  statement selects orders whose total amount is greater than 60000.
    It uses column aliases in GROUP BY and HAVING clauses.*/
    
    SELECT
	orderNumber `Order no.`,
	SUM(priceEach * quantityOrdered) Total
FROM
	orderdetails
GROUP BY
	`Order no.`
HAVING
	total > 60000;
    
    # Table aliases 
--     In MySQL, a table alias is a temporary, alternative nickname assigned to a database table within a specific SQL query.
   /*this querry  finds your top customers by counting how many
   orders each customer has placed, then sorts them from highest to lowest.*/
SELECT
	customerName,
	COUNT(o.orderNumber) total
FROM
	customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC;
    
--   Use MySQL aliases to assign a column or a table a temporary name.
-- Use a column alias to assign a temporary name to a column in a query.
-- Use a table alias to assign a temporary name to a table in a query.





