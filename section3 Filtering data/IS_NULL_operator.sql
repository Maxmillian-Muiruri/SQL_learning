-- MySQL IS NULL operator
/*The MySQL IS NULL operator is a comparison operator used to test whether a value or a column entry is NULL. In database terms, NULL represents missing, unknown, or inapplicable data. It acts as a placeholder when
 a specific field does not contain any value.*/
 
 /* use the IS NULL operator to find customers
 who do not have a sales representative:*/
 
 SELECT 
    customerName, 
    country, 
    salesrepemployeenumber
FROM
    customers
WHERE
    salesrepemployeenumber IS NULL
ORDER BY 
    customerName; 
    
    /*use the IS NOT NULL operator to get the customers
    who have a sales representative:*/
    SELECT 
    customerName, 
    country, 
    salesrepemployeenumber
FROM
    customers
WHERE
    salesrepemployeenumber IS NOT NULL
ORDER BY 
   customerName;
   /*Use the IS NULL operator to test if a value is NULL or not. The IS NOT NULL operator negates the result of the IS NULL operator.
*/ 
/*The value IS NULL returns true if the value is NULL or false if the value is not NULL.
*/

/*The value IS NOT NULL returns true if the value is not NULL or false if the value is NULL.
*/
    