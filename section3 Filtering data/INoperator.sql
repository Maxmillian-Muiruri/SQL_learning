--   MySQL IN operator 
/*The IN operator allows you to determine
 if a value matches any value in a list of values*/

-- the IN operator returns NULL in two cases:
# The value on the left side of the operator is NULL.
# The value doesn’t equal any value in the list and one of the values in the list is NULL.

/*use the IN operator to find the offices located in the USA and France*/

SELECT 
    officeCode, 
    city, 
    phone, 
    country
FROM
    offices
WHERE
    country IN ('USA' , 'France');
    
    -- Use the IN operator to check if a value is in a set of values.
-- Use the IN operator to form a condition for the WHERE clause.
    