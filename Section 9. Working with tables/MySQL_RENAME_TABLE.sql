-- MySQL RENAME TABLE Statement

-- MySQL RENAME TABLE examples #

CREATE DATABASE IF NOT EXISTS hr;
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id int AUTO_INCREMENT primary key,
    first_name VARCHAR(50) not null,
    last_name VARCHAR(50) not null,
    department_id INT not null,
    FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
);

INSERT INTO departments(dept_name) 
VALUES 
  ('Sales'), 
  ('Markting'), 
  ('Finance'), 
  ('Accounting'), 
  ('Warehouses'), 
  ('Production');
  
  
  INSERT INTO employees(
  first_name, last_name, department_id
) 
VALUES 
  ('John', 'Doe', 1), 
  ('Bush', 'Lily', 2), 
  ('David', 'Dave', 3), 
  ('Mary', 'Jane', 4), 
  ('Jonatha', 'Josh', 5), 
  ('Mateo', 'More', 1);
  
  SELECT 
    department_id, dept_name
FROM
    departments;
    
    SELECT 
    id, first_name, last_name, department_id
FROM
    employees;
    
    
--    Renaming a table referenced by a view

-- If the table you are going to rename is referenced by a view, the view will become invalid, and you have to adjust the view manually.

--  create a view named v_employee_info based on the employees and departments tables

CREATE VIEW v_employee_info as 
SELECT 
  id, 
  first_name, 
  last_name, 
  dept_name 
from 
  employees 
  inner join departments USING (department_id);
  
--   The views use the inner join clause to join departments and employees tables.

RENAME TABLE employees TO people;

SELECT * FROM v_employee_info;

CHECK TABLE v_employee_info;

-- Renaming a table that is referenced by a stored procedure 

-- First, rename the people table back to the employees table.
-- RENAME TABLE people TO employees;
DELIMITER $$

CREATE PROCEDURE get_employee(IN p_id INT)
BEGIN
	SELECT first_name, last_name, dept_name
	FROM employees
	INNER JOIN departments using (department_id)
	WHERE id = p_id;
END$$

DELIMITER ;


-- get the data of the employee with ID 1
CALL get_employee(1);
RENAME TABLE employees TO people;

CALL get_employee(2);



--  Renaming a table that is referenced by foreign key constraints 

-- If you rename the departments table, all the foreign keys that reference the departments table will not be automatically updated. In such cases, you must drop and recreate the foreign keys manually.

RENAME TABLE departments TO depts;

DELETE FROM depts 
WHERE
    department_id = 1


-- Renaming multiple tables 

--  rename the people and depts tables to employees and departments tables:
     RENAME TABLE depts TO departments,
             people TO employees;

-- NB Note the RENAME TABLE statement is not atomic. It means that if any errors occur, MySQL performs a rollback of all renamed tables to their old names.

-- Renaming tables using ALTER TABLE statement 

-- The ALTER TABLE statement can rename a temporary table while the RENAME TABLE statement cannot.

-- Renaming temporary table 


-- create a temporary table that contains all unique last names that come from the last_name column of the employees table:

CREATE TEMPORARY TABLE lastnames
SELECT DISTINCT last_name from employees;

-- use the RENAME TABLE to rename the lastnames table:

RENAME TABLE lastnames TO unique_lastnames;

-- MySQL returns the following error message:

-- 0	99	18:48:58	RENAME TABLE lastnames TO unique_lastnames	Error Code: 1146. Table 'hr.lastnames' doesn't exist	0.000 sec
 
--  use the ALTER TABLE statement to rename the lastnames table

ALTER TABLE lastnames
RENAME TO unique_lastnames;

--  query data from the unique_lastnames temporary table:

SELECT 
    last_name
FROM
    unique_lastnames;
    
--     MySQL ALTER TABLE renames temporary table