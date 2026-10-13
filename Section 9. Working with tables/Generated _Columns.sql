-- How to Use the MySQL Generated Columns

-- A special column that automatically calculates its own values using a predefined formula based on other columns in the same row.

-- you have the contacts with the following structure:

DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

--  get the full name of a contact, you use the CONCAT() function 

SELECT 
    id, 
    CONCAT(first_name, ' ', last_name), 
    email
FROM
    contacts; -- This is not the most beautiful query yet.

--  using a Generated Column, you can recreate the contacts table as follows:
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    fullname varchar(101) GENERATED ALWAYS AS (CONCAT(first_name,' ',last_name)),
    email VARCHAR(100) NOT NULL
);
    INSERT INTO contacts(first_name,last_name, email)
VALUES('john','doe','john.doe@mysqltutorial.org');

SELECT 
    *
FROM
    contacts;
    
    
--     MySQL Generated Column
     /*we can add a stored generated column named stock_value to the products table using 
     the following ALTER TABLE ...ADD COLUMN statement:*/
     
     ALTER TABLE products
ADD COLUMN stockValue DEC(10,2)
GENERATED ALWAYS AS (buyprice*quantityinstock) STORED;
    

-- Use a MySQL Generated column to store data computed from an expression or other columns.
  
  
  