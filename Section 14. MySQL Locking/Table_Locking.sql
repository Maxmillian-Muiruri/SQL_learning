-- MySQL Table Locking

-- A lock is a flag on a table. A session can lock a table so that other
-- sessions cannot use it (or can only read it) for a while.
--
-- A session can only lock and unlock tables for ITSELF, never for others.
-- A "session" is one connection to MySQL. To practice, open TWO query tabs
-- in Workbench or two terminals. Each one is its own session.

-- Syntax:
--   LOCK TABLES table_name [READ | WRITE];
--
-- Lock several tables at once:
--   LOCK TABLES table1 READ, table2 WRITE;
--
-- Release all locks held by your session:
--   UNLOCK TABLES;
--
-- If your session ends (normally or by a crash), MySQL releases its locks
-- automatically.

-- SETUP

DROP TABLE IF EXISTS messages;

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(100) NOT NULL
);

-- PART 1: READ lock
-- Rules:
--   - Many sessions can hold a READ lock on the same table at once.
--   - The session holding the lock can only READ the table, not write.
--   - Other sessions can also read, but their writes must WAIT until the
--     lock is released.

 -- part 1

--  connect to the database in the first session 
-- and use the CONNECTION_ID() function to get the current connection id
SELECT CONNECTION_ID();

INSERT INTO messages(message)
VALUES ('Hello');

SELECT * FROM messages;

-- Lock the table for reading
LOCK TABLE messages READ;

-- Try to write while holding the READ lock. This FAILS.
INSERT INTO messages(message)
VALUES ('Hi');
-- Error 1099: Table 'messages' was locked with a READ lock
-- and can't be updated.

-- part 2 
--  connect to the database and check the connection id:
SELECT CONNECTION_ID();   -- a different number from session 1

-- Reading works
SELECT * FROM messages;

-- Writing WAITS (the query just hangs) because session 1 holds a READ lock
INSERT INTO messages(message)
VALUES ('Bye');

-- ---------- SESSION 1 again ----------

-- See what every session is doing. Session 2's INSERT shows as waiting.
SHOW PROCESSLIST;

-- Release the lock. Session 2's INSERT now runs immediately.
UNLOCK TABLES;

-- Check if  'Hello'  and 'Bye' are both in the table if they were executed in session 2
SELECT * FROM messages;

-- PART 2: WRITE lock
-- Rules:
--   - Only the session holding the lock can read AND write the table.
--   - Every other session must WAIT, even to read.
 
 -- session1

LOCK TABLE messages WRITE;

-- Writing works
INSERT INTO messages(message)
VALUES ('Good Morning');

-- Reading works
SELECT * FROM messages;

-- SESSION 2 

-- Both of these WAIT (hang) because of session 1's WRITE lock
INSERT INTO messages(message)
VALUES ('Bye Bye');

SELECT * FROM messages;

--  SESSION 1 again 

-- Check that session 2's statements are waiting
SHOW PROCESSLIST;

-- Release the lock. Session 2's waiting statements now run.
UNLOCK TABLES;

-- READ vs WRITE locks
--   READ  = "shared" lock. Others can also read, but nobody can write.
--   WRITE = "exclusive" lock. Nobody else can read or write.

-- SUMMARY
-- 1. LOCK TABLES t READ  -> everyone can read, nobody can write.
-- 2. LOCK TABLES t WRITE -> only you can read and write.
-- 3. UNLOCK TABLES releases all your locks.
-- 4. Other sessions wait (they do not fail) until the lock is released.
-- 5. Locks are released automatically if your session ends.
-- 6. A session can only lock and unlock for itself.
