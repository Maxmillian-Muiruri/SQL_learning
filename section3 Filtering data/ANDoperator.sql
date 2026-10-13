-- MySQL AND Operator
/*The AND operator is a logical operator that 
combines two or more Boolean expressions and returns 1, 0, or NULL:
*/

/* use AND operator to  find customers who are located in California (CA), USA:*/
SELECT 
    customername, 
    country, 
    state
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA';
    
    /* this query returns the customers who are located in California,
    USA, and have a credit limit greater than 100K.*/
    SELECT 
    customername, 
    country, 
    state, 
    creditlimit
FROM
    customers
WHERE
    country = 'USA' AND 
    state = 'CA' AND 
    creditlimit > 100000;