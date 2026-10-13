-- MySQL DECIMAL Data Type
-- The MySQL DECIMAL data type allows you to store exact numeric values in the database. In practice, you often use the DECIMAL data type for columns that preserve exact precision e.g., monetary data in financial systems.

-- MySQL DECIMAL data type example 
--  create a new table named materials:

CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    cost DECIMAL(19,4) NOT NULL
);

--  insert data into the materials table.

INSERT INTO materials(description, cost) 
VALUES 
  ('Bicycle', 500.34), 
  ('Seat', 10.23), 
  ('Break', 5.21);
  
--    query data from the materials table.
SELECT 
    *
FROM
    materials;
    
-- Use MySQL DECIMAL data type to store exact numeric values such as financial data in the database.
-- Use column_name DECIMAL (P, D) to define a column with the DECIMAL data type that has up to P digits and D decimal places.
-- The DECIMAL(P) is equivalent to DECIMAL(P,0) and DECIMAL is equivalent to DECIMAL(P, 0).
