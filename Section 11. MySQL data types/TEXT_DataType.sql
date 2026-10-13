-- MySQL TEXT Data Type

/*The TEXT is useful for storing long-form text strings that can take from 1 byte to 4GB. In practice, you often use the TEXT data type for storing articles in news sites, and product descriptions in e-commerce sites.
*/

-- MySQL provides four TEXT types:

-- TINYTEXT
-- TEXT
-- MEDIUMTEXT
-- LONGTEXT

-- TINYTEXT – 255 Bytes (255 characters) 
-- The maximum number of characters that TINYTEXT can store is 255 ( 2^8 = 256, 1 byte overhead).

-- In practice, you use TINYTEXT for the column that requires less than 255 characters, has inconsistent length, and does not require sorting.

--  creates a new table called articles that has a summary column with the data type is TINYTEXT:

CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    summary TINYTEXT
);


-- TEXT – 64KB (65,535 characters) 

-- The TEXT data type can hold up to 64 KB which is equivalent to 65535 (2^16 – 1) characters

--  the table adds the column body with the TEXT type to the articles table using the ALTER TABLE statement:

ALTER TABLE articles 
ADD COLUMN body TEXT NOT NULL
AFTER summary;


-- LONGTEXT – 4GB (4,294,967,295 characters)
-- The LONGTEXT can store text data up to 4GB, which is quite big in common scenarios. It has 4 bytes overhead.


# Use the TEXT data type to store long texts in the database.
