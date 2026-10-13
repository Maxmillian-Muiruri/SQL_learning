 /*In MySQL, the WHERE clause is used to
 filter records and extract only the rows
 that meet a specific condition. Instead 
 of returning or modifying every single row in a table,
 it allows you to pinpoint exactly which data
 you want to interact with.*/

# WHERE clause to find all employees whose job titles are Sales Rep:  
 SELECT 
    lastname, 
    firstname, 
    jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep';
    
     /* use the WHERE clause to find employees whose job titles are Sales Rep
    and office codes are 1: */ 
    SELECT 
    lastname, 
    firstname, 
    jobtitle,
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND 
    officeCode = 1;
    
	/* find employees whose job title is Sales Rep or employees 
     who locate the office with office code 1: */
     
     SELECT 
    lastName, 
    firstName, 
    jobTitle, 
    officeCode
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' OR 
    officeCode = 1
ORDER BY 
    officeCode , 
    jobTitle;
    
    /* find employees who are located in offices
    whose office code is from 1 to 3:*/
    SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode BETWEEN 1 AND 3
ORDER BY officeCode;
    
    /* find the employees whose
    last names end with the string 'son':*/
    SELECT 
    firstName, 
    lastName
FROM
    employees
WHERE
    lastName LIKE '%son'
ORDER BY firstName;
    
    /*find employees who are located in the
    offices with the codes 1, 2, and 3:*/
    SELECT 
    firstName, 
    lastName, 
    officeCode
FROM
    employees
WHERE
    officeCode IN (1 , 2, 3)
ORDER BY 
    officeCode;
    
    /*use the WHERE clause with the IS NULL
    operator to get the rows with the values 
    in the reportsTo column are NULL:
*/
SELECT 
    lastName, 
    firstName, 
    reportsTo
FROM
    employees
WHERE
    reportsTo IS NULL;
    /* finds employees whose office code is greater than 5:*/
    SELECT 
    lastname,
    firstname,
    officecode
    FROM
    employees
    WHERE 
    officecode > 5;
    
    
     
     
     
    