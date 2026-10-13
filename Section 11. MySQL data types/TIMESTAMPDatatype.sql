-- MySQL TIMESTAMP Data Type

-- MySQL TIMESTAMP
-- TIMESTAMP stores a date AND time together.
-- Format: YYYY-MM-DD HH:MM:SS (always 19 characters)
-- Example: 2026-10-11 15:54:00
--
-- Range: '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC
-- (dates outside this range do not fit in a TIMESTAMP)


-- PART 1: How TIMESTAMP handles time zones
-- Big idea:
--   When you INSERT -> MySQL converts your time to UTC and stores that.
--   When you SELECT -> MySQL converts the UTC value to YOUR time zone.
-- So the stored value never changes, but what you SEE depends on
-- the time zone of your connection (session).
-- (DATETIME does NOT do this conversion. It shows exactly what you stored.)

CREATE TABLE t (
    ts TIMESTAMP
);

-- Step 1: tell MySQL our session is in UTC (+00:00)
SET time_zone = '+00:00';

-- Step 2: insert a value (stored as UTC)
INSERT INTO t(ts)
VALUES ('2008-01-01 00:00:01');

-- Step 3: read it back
SELECT ts FROM t;
-- 2008-01-01 00:00:01   (same, because we are still in UTC)

-- Step 4: change the session time zone to +03:00
SET time_zone = '+03:00';

-- Step 5: read the SAME row again
SELECT ts FROM t;
-- 2008-01-01 03:00:01   (shifted by 3 hours)

-- The stored value did not change.
-- Only the way it is DISPLAYED changed to match the new time zone.
-- Set the time zone back and you get the original value again.

-- PART 2: Automatic initialization

-- DEFAULT CURRENT_TIMESTAMP
-- = "if I don't give a value, use the current date and time"
-- Great for a created_at column.

CREATE TABLE categoriesss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- We do not give created_at, MySQL fills in the current time
INSERT INTO categoriesss(name)
VALUES ('A');

SELECT * FROM categoriesss;
-- id | name | created_at
--  1 | A    | (the time of the insert)


-- PART 3: Automatic updating

- ON UPDATE CURRENT_TIMESTAMP
-- = "every time this row changes, set this column to the current time"
-- Great for an updated_at column.

ALTER TABLE categoriesss
ADD COLUMN updated_at
    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP;

-- DEFAULT CURRENT_TIMESTAMP -> filled in when the row is inserted
-- ON UPDATE CURRENT_TIMESTAMP -> refreshed when the row is changed

INSERT INTO categoriesss(name)
VALUES ('B');

SELECT * FROM categoriesss;
-- created_at and updated_at are the same for a new row

-- Now change the name of row 2
UPDATE categoriesss
SET name = 'B+'
WHERE id = 2;

SELECT * FROM categoriesss WHERE id = 2;
-- created_at stays the same (when the row was born)
-- updated_at changes (when the row was last modified)

-- IMPORTANT: if you "update" a column to the SAME value it
-- already has, MySQL sees no change, so updated_at does NOT change.
UPDATE categoriesss
SET name = 'B+'
WHERE id = 2;
-- updated_at stays unchanged

-- Extra notes

-- Since MySQL 5.6.5, DATETIME columns can also use
-- DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP.
-- You can also use them on more than one column in a table.

-- SUMMARY
-- 1. TIMESTAMP = date + time, range 1970 to 2038.
-- 2. Stored in UTC, displayed in the session time zone.
-- 3. DEFAULT CURRENT_TIMESTAMP -> auto-fills when a row is inserted.
-- 4. ON UPDATE CURRENT_TIMESTAMP -> auto-refreshes when a row changes.