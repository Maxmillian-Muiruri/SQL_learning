-- NOT IN operator
/*The NOT IN operator returns one if the value doesn’t
 equal any value in the list. Otherwise, it returns 0.*/
 
/* use the NOT IN operator to find the offices that are not 
located in France and the USA:*/

SELECT 
    officeCode, 
    city, 
    phone
FROM
    offices
WHERE
    country NOT IN ('USA' , 'France')
ORDER BY 
    city;
--   Use the MySQL NOT IN to check if a value doesn’t match any value in a list.

