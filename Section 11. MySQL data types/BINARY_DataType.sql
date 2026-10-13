-- MySQL BINARY Data Type

-- BINARY stores fixed-length binary data (raw bytes, not text).
-- Good for values that always have the same length, like
-- hashes (SHA-256), checksums, and UUIDs.



-- How BINARY behaves (4 rules)

-- 1) RIGHT-PADDING
--    If your value is shorter than the size, MySQL adds zero bytes
--    (0x00) on the right until it reaches the full size.
--
-- 2) NO TRIMMING ON RETRIEVAL
--    When you read the value back, the padded zero bytes are still
--    there. MySQL does not remove them.
--
-- 3) ALL BYTES COUNT IN COMPARISONS
--    In WHERE, ORDER BY, and DISTINCT, every byte matters, even
--    trailing zero bytes. Two values are equal only if ALL bytes match.
--
-- 4) 0x00 AND SPACE ARE DIFFERENT
--    The zero byte (0x00) and the space character (0x20) are not equal.
--    In sorting, zero bytes come BEFORE spaces.

-- PART 1: Storing SHA-256 hashes
-- SHA-256 always produces 32 bytes, so BINARY(32) fits perfectly.

CREATE TABLE binary_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data BINARY(32)   -- 32 bytes for SHA-256
);

-- SHA2('Hello', 256) -> computes the SHA-256 hash (as hex text)
-- UNHEX(...)         -> converts that hex text into real binary data
INSERT INTO binary_demo(data)
VALUES (UNHEX(SHA2('Hello', 256)));

-- HEX(...) converts the binary data back into readable hex text
SELECT HEX(data)
FROM binary_demo
WHERE id = 1;

-- PART 2: See the padding in action
-- BINARY(4) holds 4 bytes. We insert only 1 byte (AB),
-- so MySQL pads the other 3 bytes with 00.

CREATE TABLE padding_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data BINARY(4)
);

INSERT INTO padding_demo(data)
VALUES (UNHEX('AB'));

-- HEX shows the padded zero bytes
-- LENGTH shows the size in bytes (always 4 for BINARY(4))
SELECT HEX(data), LENGTH(data)
FROM padding_demo;

-- PART 3: Comparisons use ALL bytes
-- The stored value is AB000000 (padded), not just AB.

-- Does NOT match, because AB is only 1 byte and the stored value is 4 bytes
SELECT * FROM padding_demo
WHERE data = UNHEX('AB');

-- Matches, because all 4 bytes are the same
SELECT * FROM padding_demo
WHERE data = UNHEX('AB000000');

-- PART 4: 0x00 and space are different
-- 0x00 = zero byte, 0x20 = space character

CREATE TABLE zero_vs_space (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data BINARY(2)
);

INSERT INTO zero_vs_space(data)
VALUES (UNHEX('4100')),   -- 'A' followed by a zero byte
       (UNHEX('4120'));   -- 'A' followed by a space

-- Matches only the row with the zero byte, not the space
SELECT id, HEX(data) FROM zero_vs_space
WHERE data = UNHEX('4100');

-- Sorting: zero bytes come before spaces
SELECT id, HEX(data) FROM zero_vs_space
ORDER BY data;


-- SUMMARY

-- 1. BINARY(n) stores exactly n bytes of binary data.
-- 2. Short values are padded on the right with 0x00.
-- 3. Padding is NOT removed when you read the data.
-- 4. Every byte counts in comparisons (WHERE, ORDER BY, DISTINCT).
-- 5. 0x00 and space (0x20) are different.
-- 6. Use UNHEX() to store hex text as binary and HEX() to read it back.
-- 7. Best for fixed-length data like SHA-256 hashes and UUIDs.