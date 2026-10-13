-- MySQL BOOLEAN Data Type
-- MySQL does not have a dedicated Boolean data type. Instead, MySQL uses TINYINT(1) to represent the BOOLEAN data type.

-- When working with Boolean literals, you can use the constants true and false case-insensitively, which is equivalent to 1 and 0 respectively

-- MySQL BOOLEAN example 

--  create a new table called tasks:

CREATE TABLE taskss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN
);

DESCRIBE taskss;


INSERT INTO taskss(title, completed) 
VALUES 
  ('Master MySQL Boolean type', true), 
  ('Design database table', false);

SELECT 
  id, 
  title, 
  completed 
FROM 
  taskss;
  
  INSERT INTO taskss(title, completed) 
VALUES 
  ('Test Boolean with a number', 2);

SELECT * FROM taskss;

SELECT 
  id, 
  title, 
  IF(completed, 'true', 'false') completed 
FROM 
  taskss;

INSERT INTO taskss(title, completed) 
VALUES 
  ('Test Boolean with NULL', NULL);

SELECT * FROM tasks;


--   MySQL BOOLEAN operators 

SELECT 
    id, title, completed
FROM
    taskss
WHERE
    completed = TRUE;

/*The query returned the task with completed value 1. It does not show the 
 task with the completed value 2 because TRUE is 1, not 2.*/

-- To fix it, you can use the IS operator:

SELECT 
  id, 
  title, 
  completed 
FROM 
  taskss 
WHERE 
  completed IS TRUE; --  we used the IS operator to test a value against the TRUE value.

-- To get all the pending tasks, you can use IS FALSE or IS NOT TRUE as follows:

SELECT 
  id, 
  title, 
  completed 
FROM 
  taskss 
WHERE 
  completed IS NOT TRUE;

-- MySQL has no dedicated BOOLEAN data type. Instead, it uses TINYINT(1) to represent the BOOLEAN type.
-- Use the BOOLEAN keyword to declare a column with the BOOLEAN type. The BOOLEAN and TINYINT(1) are synonyms.
-- By convention, zero is false while non-zero is true.

