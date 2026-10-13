/* MySQL DISTINCT clause*/
/* MySQL DISTINCT clause is used in a SELECT
 statement to eliminate duplicate rows from a query's result set,
 ensuring that only unique values are returned.
 */
 
 /*select the last names from the employees table using
 the  SELECT statement:
 */
 SELECT 
    lastname
FROM
    employees
ORDER BY 
    lastname;
--     select unique last names by adding the DISTINCT clause
SELECT 
    DISTINCT lastname
FROM
    employees
ORDER BY 
    lastname;
    /*get a unique combination of city and state from the customers table,
    */
    SELECT DISTINCT
    state, city
FROM
    customers
WHERE
    state IS NOT NULL
ORDER BY 
    state, 
    city;
    
