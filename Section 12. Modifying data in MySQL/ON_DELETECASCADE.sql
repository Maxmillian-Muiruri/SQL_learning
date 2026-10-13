-- MySQL ON DELETE CASCADE
 -- ON DELETE CASCADE is a rule you attach to a foreign key.
-- It means: when a row in the PARENT table is deleted, MySQL
-- automatically deletes all matching rows in the CHILD table.

-- Example relationship (one-to-many):
--   One building has MANY rooms.
--   Each room belongs to ONE building.
--   A room cannot exist without its building.
--   buildings = parent table, rooms = child table.

-- Syntax (inside the child table's foreign key):
--   FOREIGN KEY (child_column)
--       REFERENCES parent_table (parent_column)
--       ON DELETE CASCADE



-- MySQL ON DELETE CASCADE example #

-- demonstrate how the ON DELETE CASCADE  referential action works.
CREATE TABLE buildings (
    building_no INT PRIMARY KEY AUTO_INCREMENT,
    building_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);


CREATE TABLE rooms (
    room_no INT PRIMARY KEY AUTO_INCREMENT,
    room_name VARCHAR(255) NOT NULL,
    building_no INT NOT NULL,
    FOREIGN KEY (building_no)
        REFERENCES buildings (building_no)
        ON DELETE CASCADE
);

--  Insert rows into the buildings table:

INSERT INTO buildings(building_name,address)
VALUES('ACME Headquaters','3950 North 1st Street CA 95134'),
      ('ACME Sales','5000 North 1st Street CA 95134');

--   query data from the buildings table
SELECT * FROM buildings;  

--  Insert rows into the rooms table:

INSERT INTO rooms(room_name,building_no)
VALUES('Amazon',1),
      ('War Room',1),
      ('Office of CEO',1),
      ('Marketing',2),
      ('Showroom',2);
SELECT * FROM rooms;


--  Delete the building with building no. 2:

DELETE FROM buildings 
WHERE building_no = 2;
-- Step 8. Query data from rooms table:

SELECT * FROM rooms;


-- Tips to find tables affected by MySQL ON DELETE CASCADE action

--  it is useful to know which table is affected by the ON DELETE CASCADE 
--  referential action when you delete data from a table.
--  You can query this data from the referential_constraints in the information_schema  database 
USE information_schema;

SELECT 
    table_name
FROM
    referential_constraints
WHERE
    constraint_schema = 'database_name'
        AND referenced_table_name = 'parent_table'
        AND delete_rule = 'CASCADE';

--  find tables that associated with the buildings table with the CASCADE  deletion rule  in the classicmodels database,
USE information_schema;

SELECT 
    table_name
FROM
    referential_constraints
WHERE
    constraint_schema = 'classicmodels'
        AND referenced_table_name = 'buildings'
        AND delete_rule = 'CASCADE'


