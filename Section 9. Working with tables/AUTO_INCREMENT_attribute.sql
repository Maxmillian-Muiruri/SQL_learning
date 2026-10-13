--  MySQL AUTO_INCREMENT attribute

-- In MySQL, you use the AUTO_INCREMENT attribute to automatically generate unique integer values for a column whenever you insert a new row into the table

CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL
);

/* When inserting rows into the table with an AUTO_INCREMENT column,
 you don’t need to specify a value for that column. MySQL will automatically generate the value for you. */
 
 INSERT INTO contacts(name, email)
VALUES('John Doe', 'john.doe@mysqltutorial.org');

SELECT * FROM contacts;

-- Retrieving the last auto-increment value 

SELECT LAST_INSERT_ID();

-- Resetting the current auto-increment value  using ALTER TABLE
ALTER TABLE contacts 
AUTO_INCREMENT = 1;

--  you can delete all rows from the table and reset the AUTO_INCREMENT value simultaneously. To do that, you use the TRUNCATE TABLE
TRUNCATE TABLE contacts;

--  how to reset the value in the AUTO_INCREMENT column to an invalid value:

INSERT INTO contacts(name, email) 
VALUES
   ('John Doe', 'john.doe@mysqltutorial.org'),
   ('Jane Doe', 'jane.doe@mysqltutorial.org');
   
   /* If you reset the AUTO_INCREMENT column to any number that is less than or equal to 2 using the ALTERTABLE statement, the operation will have no effects 
    if you insert a new row into the contacts table, MySQL will use the next number 3 for the new row
   */
   ALTER TABLE contacts 
AUTO_INCREMENT = 1;

INSERT INTO contacts(name, email) 
VALUES('Bob Climo', 'bob.climo@mysqltutorial.org');
   
--    return all rows of  the contacts table:

   SELECT * FROM contacts;
   
--    Adding an AUTO_INCREMENT column to an existing table 

-- To add an AUTO_INCREMENT to an existing table, you use the ALTERTABLE statement.

-- First, create a new table without an AUTO_INCREMENT column:

CREATE TABLE subscribers(
   email VARCHAR(320) NOT NULL UNIQUE
);

-- Second, add the column id to the subscribers table as an AUTO_INCREMENT column:

ALTER TABLE subscribers
ADD id INT AUTO_INCREMENT PRIMARY KEY;
