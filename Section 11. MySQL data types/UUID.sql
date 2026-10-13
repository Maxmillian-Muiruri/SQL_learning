-- MySQL UUID Smackdown: UUID vs. INT for Primary Key

-- UUID = Universally Unique IDentifier.
-- It is a 128-bit number designed to be unique everywhere,
-- even when generated on two different servers at the same time.

-- In MySQL it is shown as a text string of 5 groups of hex digits:
--   aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee

-- Generate one with the UUID() function.
-- UUID() returns a version 1 UUID (RFC 4122).

SELECT UUID();

-- UUID vs AUTO_INCREMENT INT as a primary key
-- PROS of UUID:
--   1. Unique across tables, databases, and servers, so you can merge
--      rows from different databases or spread data across servers.
--   2. Safer in URLs. With ID 10, anyone can guess that customers 11
--      and 12 exist. A UUID cannot be guessed like that.
--   3. Can be created anywhere (even in your app) without asking the
--      database first. You can create the parent ID up front and insert
--      parent and child rows together in one transaction.
--
-- CONS of UUID:
--   1. Uses more space: 16 bytes vs 4 (INT) or 8 (BIGINT).
--   2. Harder to debug:
--        WHERE id = 'df3b7cb7-6a95-11e7-8846-b05adad3f0ae'
--      is harder to read than WHERE id = 10.
--   3. Can be slower, because UUIDs are large and not in order.

-- The MySQL solution: store compact, display readable
-- Store the UUID as BINARY(16) (small), and show it as text when reading.
-- These functions do the conversion (MySQL 8.0 or later only):
--   UUID_TO_BIN(uuid)  -> text to binary, used when STORING
--   BIN_TO_UUID(bin)   -> binary to text, used when DISPLAYING
--   IS_UUID(text)      -> 1 if valid, 0 if not valid, NULL if the input is NULL

-- Valid UUID text formats for IS_UUID:
--   aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
--   aaaaaaaabbbbccccddddeeeeeeeeeeee
--   {aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee}

SELECT IS_UUID('6ccd780c-baba-1026-9564-5b8c656024db');   -- 1 (valid)
SELECT IS_UUID('not-a-uuid');                             -- 0 (not valid)

-- EXAMPLE 1: UUID as the primary key
-- BINARY(16) = 16 bytes = exactly the size of a UUID.

CREATE TABLE customers (
    id BINARY(16) PRIMARY KEY,
    name VARCHAR(255)
);

-- UUID() makes the text UUID, UUID_TO_BIN() converts it to binary
INSERT INTO customers(id, name)
VALUES (UUID_TO_BIN(UUID()), 'John Doe'),
       (UUID_TO_BIN(UUID()), 'Will Smith'),
       (UUID_TO_BIN(UUID()), 'Mary Jane');

-- Without BIN_TO_UUID you would see unreadable binary
SELECT
    BIN_TO_UUID(id) AS id,
    name
FROM customers;

-- EXAMPLE 2: UUID as an automatic default value
-- The id fills itself in, like AUTO_INCREMENT, but with a UUID.
-- Note the extra brackets: a default made from a function
-- must be wrapped in ( ).

CREATE TABLE vendors (
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255),
    PRIMARY KEY (id)
);

-- No need to give an id
INSERT INTO vendors(name)
VALUES ('ABC Inc.');

SELECT
    BIN_TO_UUID(id) AS id,
    name
FROM vendors;

-- EXTRA TIP (not in the tutorial): ordering UUIDs
-- UUID() values are not stored in time order, which can slow down
-- inserts on big tables. Adding a second argument of 1 rearranges the
-- bytes so new UUIDs are stored in roughly increasing order.
-- Use the same flag when converting back.

INSERT INTO vendors(id, name)
VALUES (UUID_TO_BIN(UUID(), 1), 'XYZ Ltd.');

SELECT BIN_TO_UUID(id, 1) AS id, name
FROM vendors;

-- SUMMARY
-- 1. UUID = a globally unique 128-bit ID, made with UUID().
-- 2. Pros: unique everywhere, not guessable, can be made anywhere.
-- 3. Cons: bigger (16 bytes), harder to read, can be slower.
-- 4. Store it as BINARY(16) to save space.
-- 5. UUID_TO_BIN() to store, BIN_TO_UUID() to display (MySQL 8.0+).
-- 6. IS_UUID() checks whether a string is a valid UUID.
-- 7. Use DEFAULT (UUID_TO_BIN(UUID())) to auto-generate the primary key.