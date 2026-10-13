-- MySQL DROP COLUMN

-- In some situations, you want to remove one or more columns from a table. In such cases, you use the following ALTER TABLE DROP COLUMN statement:

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    excerpt VARCHAR(400),
    content TEXT,
    created_at DATETIME,
    updated_at DATETIME
);

ALTER TABLE posts
DROP COLUMN excerpt;

DESCRIBE posts;

ALTER TABLE posts
DROP COLUMN created_at,
DROP COLUMN updated_at;

DESCRIBE posts;

-- MySQL drop a column which is a foreign key example
/*If you remove the column that is a foreign key, MySQL will issue an error.*/


CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);


ALTER TABLE posts 
ADD COLUMN category_id INT NOT NULL;

-- make the category_id column as a foreign key column of that references to the id column of the categories table
ALTER TABLE posts 
ADD CONSTRAINT fk_cat 
FOREIGN KEY (category_id) 
REFERENCES categories(id);

ALTER TABLE posts
DROP COLUMN category_id;

-- MySQL issued an error message:
-- To avoid this error, you must remove the foreign key constraint before dropping the column.


/* 0	110	19:25:20	ALTER TABLE posts
 DROP COLUMN category_id	Error Code: 1828. Cannot drop column 'category_id': needed in a foreign key constraint 'fk_cat'	0.015 sec */
 


