-- How to Use the MySQL Generated Columns
-- Introduction to MySQL Generated Column 

DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    fullname varchar(101) GENERATED ALWAYS AS (CONCAT(first_name,' ',last_name)),
    email VARCHAR(100) NOT NULL
);  -- The GENERATED ALWAYS as (expression) is the syntax for creating a generated column.



INSERT INTO contacts(first_name,last_name, email)
VALUES('john','doe','john.doe@mysqltutorial.org');

SELECT 
    *
FROM
    contacts;
-- MySQL stored column example 
/*add a stored generated column named stock_value to the products table
 using the following ALTER TABLE ...ADD COLUMN statement:*/
 
 ALTER TABLE products
ADD COLUMN stockValue DEC(10,2)
GENERATED ALWAYS AS (buyprice*quantityinstock) STORED;

-- query the stock value directly from the products table.
SELECT 
    productName, 
    ROUND(stockValue, 2) stock_value
FROM
    products;
    
    
--     Use a MySQL Generated column to store data computed from an expression or other columns.
