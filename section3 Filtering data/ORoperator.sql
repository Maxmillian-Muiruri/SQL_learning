-- MySQL OR operator 
# The MySQL OR operator is a logical operator that combines two Boolean expressions.

/*use the OR operator in the WHERE clause to select all
 the customers located in the USA or France:*/
SELECT    
	customername, 
	country
FROM    
	customers
WHERE country = 'USA' OR 
      country = 'France';
      
/* uses the OR operator to select the customers 
who locate in the USA or France and have a credit limit greater than 100,000.
*/
SELECT   
	customername, 
	country, 
	creditLimit
FROM   
	customers
WHERE(country = 'USA'
		OR country = 'France')
	  AND creditlimit > 100000;

/*The OR operator combines two Boolean expressions 
and returns true when either expression is true.
 Otherwise, it returns false.*/
 
/* MySQL evaluates the OR operator after the AND operator 
if an expression contains both AND and OR operators.*/