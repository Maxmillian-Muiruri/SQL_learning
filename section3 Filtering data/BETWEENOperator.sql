-- MySQL BETWEEN Operator
/*The BETWEEN operator is a logical operator that specifies
 whether a value is in a range or not.*/
 
 /*use the BETWEEN operator to find products
 whose buy prices between 90 and 100:*/
 SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice BETWEEN 90 AND 100;
    
    /*find the products whose buy prices are not between $20 and $100, 
    use the NOT BETWEEN operator:*/
    SELECT 
    productCode, 
    productName, 
    buyPrice
FROM
    products
WHERE
    buyPrice NOT BETWEEN 20 AND 100;
    
    -- Using MySQL BETWEEN operator with dates 
    /*To check if a value is between a date range,
    you should explicitly cast the value to the DATE type.*/
    
   /*  returns the orders with the required dates
   between 01/01/2003 to 01/31/2003: */
   
   SELECT 
   orderNumber,
   requiredDate,
   status
FROM 
   orders
WHERE 
   requireddate BETWEEN 
     CAST('2003-01-01' AS DATE) AND 
     CAST('2003-01-31' AS DATE);
   
   
    /*Use the MySQL BETWEEN operator to test if a value 
    falls within a range of values.
*/
     