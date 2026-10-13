-- MySQL NOT NULL Constraint
-- A NOT NULL constraint ensures that values stored in a column are not NULL.


--  creates the tasks table using the CREATE TABLE statement:

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

DESC tasks;

-- Adding a NOT NULL constraint to an existing column 

--  you may want to add a NOT NULL constraint to a column of an existing table. In this case, you use the following steps:

-- First, check the current values of the column if there are any NULL values.
-- Second, update the NULL to non-NULL.
-- Third, modify the column with a NOT NULL constraint.

 -- example
 INSERT INTO tasks(title ,start_date, end_date)
VALUES('Learn MySQL NOT NULL constraint', '2017-02-01','2017-02-02'),
      ('Check and update NOT NULL constraint to your database', '2017-02-01',NULL);
 
--  find rows with NULLs in the column end_date using the IS NULL operator:

SELECT * FROM tasks 
WHERE end_date IS NULL;


/* update the NULL values to non-null values. In this case, you can create a rule that sets to one week after the start date when the end_date is NULL.
*/

SET SQL_SAFE_UPDATES = 0;

UPDATE tasks 
SET 
    end_date = start_date + 7
WHERE
    end_date IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM tasks;

--  add a NOT NULL constraint to the end_date column using the following ALTER TABLE statement:

ALTER TABLE tasks 
CHANGE 
    end_date 
    end_date DATE NOT NULL;

DESC tasks;

-- Removing a NOT NULL constraint 
-- To drop a NOT NULL constraint for a column, you use the ALTER TABLE..MODIFY statement:

--  the following statement removes the NOT NULL constraint from the end_date column in the tasks table:
ALTER TABLE tasks 
MODIFY end_date DATE;

DESC tasks;
















