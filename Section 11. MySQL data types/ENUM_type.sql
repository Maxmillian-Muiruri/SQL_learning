-- MySQL ENUM

-- ENUM is a text column that only accepts values from a list
-- you define when you create the column.
-- Think of it like a dropdown menu: you can only pick from the list.


-- PART 1: Creating a table with ENUM
-- Example: a ticket system where priority can only be Low, Medium, or High.

CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL
);

-- Behind the scenes, MySQL gives each value a number (its index),
-- based on the ORDER you wrote them in:
--   'Low'    = 1
--   'Medium' = 2
--   'High'   = 3

-- PART 2: Inserting ENUM values

-- Using the text value
INSERT INTO tickets(title, priority)
VALUES ('Scan virus for computer A', 'High');

-- Using the number (index) instead. 1 = 'Low'
INSERT INTO tickets(title, priority)
VALUES ('Upgrade Windows OS for all computers', 1);

-- Inserting several rows at once
INSERT INTO tickets(title, priority)
VALUES ('Install Google Chrome for Mr. John', 'Medium'),
       ('Create a new user for the new employee David', 'High');

-- Leaving the column out
-- The column is NOT NULL, so MySQL uses the FIRST value in the list
-- ('Low') as the default.
INSERT INTO tickets(title)
VALUES ('Refresh the computer of Ms. Lily');

SELECT * FROM tickets;

-- PART 3: Invalid values
-- Non-strict SQL mode:
--   MySQL quietly stores an empty string '' (index 0).
-- Strict SQL mode:
--   MySQL gives an error, and the row is not inserted.

INSERT INTO tickets(title, priority)
VALUES ('Invalid ticket', -1);
-- In strict mode -> Error 1265: Data truncated for column 'priority'

-- If you define the column as nullable (without NOT NULL),
-- an ENUM column can also hold NULL.

-- PART 4: Filtering ENUM values

-- By text
SELECT * FROM tickets
WHERE priority = 'High';

-- By number. 'High' = 3, so this gives the same result
SELECT * FROM tickets
WHERE priority = 3;

-- PART 5: Sorting ENUM values
-- ENUM sorts by its INDEX NUMBER, not alphabetically.
-- So the order follows how you wrote the list: Low (1), Medium (2), High (3).

-- High first, then Medium, then Low
SELECT title, priority
FROM tickets
ORDER BY priority DESC;

-- Tip: write the ENUM values in the order you want them sorted.
-- If you had written ENUM('High', 'Medium', 'Low'),
-- then High would be 1 and ORDER BY would put it first in ASC order.

-- ADVANTAGES

-- 1. Data validation: only allowed values can be stored.
-- 2. Readability: values are real words, easy to understand.
-- 3. Space efficiency: stored internally as small numbers.

-- LIMITATIONS

-- 1. Not flexible: adding or removing a value needs an ALTER TABLE.
-- 2. Not portable: ENUM is MySQL-specific, other databases may not have it.
-- 3. Harder to maintain as your app grows and the list changes.


-- SUMMARY
-- 1. ENUM = a column that accepts only values from a fixed list.
-- 2. Each value has an index starting at 1 (0 is the empty-string error value).
-- 3. You can insert and filter using either the text or the index.
-- 4. Sorting follows the index order, not alphabetical order.
-- 5. Invalid values: '' in non-strict mode, an error in strict mode.
-- 6. Use it for short lists that rarely change (priority, status, size).