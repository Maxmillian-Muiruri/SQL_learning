-- MySQL INT Data Type

--  INT stands for the integer that represents the whole numbers

-- An integer can be zero, positive, and negative.

/* MySQL supports all standard SQL integer types INTEGER or INT and SMALLINT.
 Additionally, MySQL provides TINYINTMEDIUMINT, and BIGINT as extensions to the SQL standard */
 
-- MySQL INT Data Type

-- INT stores whole numbers (no decimals).
-- INT and INTEGER mean the same thing.
-- Other sizes: TINYINT, SMALLINT, MEDIUMINT, BIGINT.

-- 1) INT with AUTO_INCREMENT (most common use)

-- INT is usually used for primary keys.
-- AUTO_INCREMENT gives each new row the next number automatically,
-- starting from 1.

CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_text VARCHAR(255)
);

-- No need to give item_id, MySQL fills it in: 1, 2, 3
INSERT INTO 
    items(item_text)
VALUES
    ('laptop'), 
    ('mouse'),
    ('headphone');

SELECT * FROM items;

--  insert a new row whose value of the item_id column is specified explicitly.INSERT INTO items(item_id, item_text)
VALUES (10, 'Server');

-- Since the current value of the item_id column is 10, the sequence is reset to 11. If you insert a new row, the AUTO_INCREMENT column will use 11 as the next value.
INSERT INTO items(item_text)
VALUES ('Router');

SELECT * FROM items;


-- Rule: inserting NULL or 0 into an AUTO_INCREMENT column
-- makes MySQL use the next sequence value.

-- 2) INT UNSIGNED (no negative numbers)

-- UNSIGNED allows only 0 and positive numbers.
-- Good for things that can never be negative (counts, quantities).

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    total_member INT UNSIGNED,
    PRIMARY KEY (class_id)
);

-- Works: 100 is positive
INSERT INTO classes(name, total_member)
VALUES ('Weekend', 100);

-- Fails: -50 is negative
INSERT INTO classes(name, total_member)
VALUES ('Fly', -50);
-- mysql  brought an error 

-- Deprecated features (avoid these)
-- Display width, e.g. INT(5), is deprecated.
-- ZEROFILL is deprecated.
-- To pad numbers with zeros, use LPAD instead:
SELECT LPAD(item_id, 5, '0') AS padded_id FROM items;
-- 00001, 00002, 00003, 00010, 00011 

