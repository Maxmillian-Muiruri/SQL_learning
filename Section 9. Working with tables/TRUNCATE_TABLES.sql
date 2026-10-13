-- MySQL TRUNCATE TABLE

-- Introduction to the MySQL TRUNCATE TABLE statement 
-- in MySQL, the TRUNCATE TABLE statement allows you to delete all rows from a table. 


-- The TRUNCATE TABLE statement resets the value in the AUTO_INCREMENT column to its initial value if the table has an AUTO_INCREMENT column. 

--  an example of using the TRUNCATE TABLE statement.

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
)  ENGINE=INNODB;

DELIMITER $$
CREATE PROCEDURE load_book_data(IN num INT(4))
BEGIN
	DECLARE counter INT(4) DEFAULT 0;
	DECLARE book_title VARCHAR(255) DEFAULT '';

	WHILE counter < num DO
	  SET book_title = CONCAT('Book title #',counter);
	  SET counter = counter + 1;

	  INSERT INTO books(title)
	  VALUES(book_title);
	END WHILE;
END$$

DELIMITER ;

CALL load_book_data(10000);