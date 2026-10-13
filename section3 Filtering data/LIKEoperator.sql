-- MySQL LIKE operator

/*The LIKE operator is a logical operator that tests whether
 a string contains a specified pattern or not.*/
 
 /* use the LIKE operator to find employees 
 whose first names start with the letter a:*/
 SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstName LIKE 'a%';
    
 /* uses the LIKE operator to find employees whose last names end with the
 literal string on e.g., Patterson, Thompson:*/   
 
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastName LIKE '%on';
    
    /* use the LIKE operator to find all employees 
    whose last names contain the substring on*/
    
    SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastname LIKE '%on%';
    
    /* find employees whose first names start with the letter T ,
    end with the letter m, and contain any single character between e.g., 
    Tom , Tim, you use the underscore (_) wildcard to construct 
    the pattern :*/
    
    SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    firstname LIKE 'T_m';
    
    -- MySQL NOT LIKE operator
    /* search for employees whose last names don’t start with the letter B,
    and  use the NOT LIKE operator */
    SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    lastName NOT LIKE 'B%'; 
    
    
    
    -- MySQL LIKE operator with the ESCAPE clause 
    
/**In MySQL, the ESCAPE clause is used alongside the 
LIKE operator to treat wildcard characters
 (% or _) as regular, literal text during a pattern search/
    
    /*if you want to find products whose product codes 
    contain the string _20 , you can use the pattern %\_20% with the default escape character:
*/
    SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';
    
    -- Use the LIKE operator to test if a value matches a pattern.
    -- The % wildcard matches zero or more characters.
    -- The _ wildcard matches a single character.
    -- Use ESCAPE clause specifies an escape character other than the default escape character (\).
    -- Use the NOT operator to negate the LIKE operator.




    
 