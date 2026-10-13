-- MySQL INSERT IGNORE Statement

-- Normal INSERT with many rows: if ONE row causes an error, MySQL stops the whole statement and NO rows are inserted.

-- INSERT IGNORE: rows that cause an error are skipped, and the rows
-- with valid data are still inserted. MySQL gives a WARNING instead
-- of an ERROR.
--
-- Syntax:
--   INSERT IGNORE INTO table(column_list)
--   VALUES (value_list),
--          (value_list),
--          ...;
--
-- IGNORE is a MySQL extension. It is not part of standard SQL.

-- EXAMPLE 1: Skipping duplicate values

CREATE TABLE subscribers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(130) NOT NULL UNIQUE   -- UNIQUE = no duplicate emails
);

-- First insert: works
INSERT INTO subscribers(email)
VALUES ('john.doe@gmail.com');

-- Second insert: john.doe@gmail.com already exists, so this FAILS
-- and nothing is inserted, not even jane.smith@ibm.com.
INSERT INTO subscribers(email)
VALUES ('john.doe@gmail.com'),
       ('jane.smith@ibm.com');
-- Error 1062: Duplicate entry 'john.doe@gmail.com' for key 'email'

-- Same insert with IGNORE:
-- the duplicate row is skipped and the valid row is inserted.
INSERT IGNORE INTO subscribers(email)
VALUES ('john.doe@gmail.com'),
       ('jane.smith@ibm.com');
-- MySQL replies with a message like:
--   1 row(s) affected, 1 warning(s): 1062 Duplicate entry ...
--   Records: 2  Duplicates: 1  Warnings: 1
-- Records = rows tried, Duplicates = rows skipped, Warnings = problems found.

-- See the details of the warning
SHOW WARNINGS;

-- Check the table: john.doe@gmail.com once, plus jane.smith@ibm.com
SELECT * FROM subscribers;

-- EXAMPLE 2: INSERT IGNORE and strict mode
-- Strict mode ON (the default in MySQL 8):  invalid values cause an ERROR and the statement is cancelled.
-- With INSERT IGNORE:   MySQL gives a WARNING, FIXES the value to make it valid,  and inserts it.

CREATE TABLE tokens (
    s VARCHAR(6)    -- holds at most 6 characters
);

-- 'abcdefg' has 7 characters, too long for VARCHAR(6)
INSERT INTO tokens VALUES ('abcdefg');
-- Error 1406: Data too long for column 's' at row 1

-- With IGNORE, MySQL cuts the value to fit (truncates it) and warns
INSERT IGNORE INTO tokens VALUES ('abcdefg');

SELECT * FROM tokens;
-- The stored value is 'abcdef' (the last letter was cut off)

SHOW WARNINGS;

-- WARNING ABOUT INSERT IGNORE (not in the tutorial)
-- It hides errors. Besides duplicates, it can quietly cut off long text or change other invalid values. Always check SHOW WARNINGS if the  data matters.

-- SUMMARY
-- 1. Normal multi-row INSERT: one bad row cancels everything.
-- 2. INSERT IGNORE skips the bad rows and inserts the good ones.
-- 3. Errors become warnings. Use SHOW WARNINGS to see them.
-- 4. In strict mode, INSERT IGNORE also adjusts invalid values,   for example by truncating text that is too long.
-- 5. IGNORE is MySQL-specific, not standard SQL.