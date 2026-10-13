-- MySQL Recursive CTE
--  a recursive Common Table Expression (CTE) is a named temporary result set that references itself in the recursive member, 
-- enabling the hierarchical traversal or iteration over data until a specified termination condition is met.

--  syntax of a recursive CTE:

-- WITH RECURSIVE cte_name AS (
--     initial_query  -- anchor member
--     UNION ALL
--     recursive_query -- recursive member that references to the CTE name
-- )

-- CTE has 3 parts

-- The three parts:
--   1. ANCHOR MEMBER: the starting query. It runs once and gives the  first set of rows.
--   2. RECURSIVE MEMBER: a query that uses the CTE's own name. It runs
--      again and again, each time using the rows from the previous round.
--      It is joined to the anchor with UNION ALL (or UNION DISTINCT).
--   3. TERMINATION CONDITION: the recursion stops when the recursive
--      member returns NO rows.

-- How it runs, step by step:
--   1. MySQL splits the query into the anchor and recursive members.
--   2. It runs the anchor member to get the first result set (R0).
--   3. It runs the recursive member using R0 as input to get R1,  then uses R1 to get R2, and so on.
--   4. It stops when a round returns an empty result.
--   5. It combines R0, R1, R2 ... Rn with UNION ALL.

-- Restrictions on the RECURSIVE member (the anchor has none):
--   - No aggregate functions (MAX, MIN, SUM, AVG, COUNT ...)
--   - No GROUP BY
--   - No ORDER BY
--   - No LIMIT
--   - No DISTINCT (but DISTINCT is allowed if you join with UNION DISTINCT)
--   - It can refer to the CTE name only ONCE in its FROM clause,
--     and not inside a subquery.

-- EXAMPLE 1: A simple counter

WITH RECURSIVE cte_count (n) AS (
    SELECT 1                    -- anchor member: starts with n = 1
    UNION ALL
    SELECT n + 1                -- recursive member: adds 1 each round
    FROM cte_count
    WHERE n < 3                 -- termination condition
)
SELECT n
FROM cte_count;

-- Round by round: 
--   Round 0 (anchor):    n = 1
--   Round 1: n is 1, and 1 < 3 is true,  so it produces 2
--   Round 2: n is 2, and 2 < 3 is true,  so it produces 3
--   Round 3: n is 3, and 3 < 3 is false, so it returns no rows. Stop.
-- All rounds are combined, so the query returns the numbers 1, 2, 3.
-- Without the WHERE, it would never stop.

-- EXAMPLE 2: Walking through a hierarchy (employees and managers)

CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT              -- points to the boss's employee_id
);

INSERT INTO employees VALUES
    (1, 'John Doe', NULL),        -- CEO, no manager
    (2, 'Jane Smith', 1),         -- reports to John
    (3, 'Bob Johnson', 2),        -- reports to Jane
    (4, 'Alice Brown', 2),        -- reports to Jane
    (5, 'Charlie Davis', 3);      -- reports to Bob

-- The company tree:
--   John Doe (level 0)
--     Jane Smith (level 1)
--       Bob Johnson (level 2)
--         Charlie Davis (level 3)
--       Alice Brown (level 2)

--  traverse the hierarchical data in the employees table using a recursive CTE:

WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: start at the top (the person with no manager)
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive member: find the people who report to the rows
    -- found in the previous round, and add 1 to the level
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh
        ON e.manager_id = eh.employee_id
)
-- Final query: read the result, sorted by level and then by id
SELECT
    employee_id,
    employee_name,
    manager_id,
    level
FROM EmployeeHierarchy
ORDER BY level, employee_id;

-- Round by round:
--   Round 0: John (manager_id is NULL)
--   Round 1: people whose manager is John -> Jane
--   Round 2: people whose manager is Jane -> Bob, Alice
--   Round 3: people whose manager is Bob or Alice -> Charlie
--   Round 4: nobody reports to Charlie -> no rows, so it stops.
-- The level column counts how deep each person is in the tree.

-- SUMMARY
-- 1. A recursive CTE refers to itself to repeat a query until no rows
--    are left.
-- 2. It has an anchor member, a recursive member, and a stop condition.
-- 3. The syntax starts with WITH RECURSIVE ... AS ( anchor UNION ALL
--    recursive ).
-- 4. The recursive member cannot use aggregates, GROUP BY, ORDER BY,
--    LIMIT, or DISTINCT.
-- 5. It is ideal for hierarchies such as org charts and category trees.
-- 6. Needs MySQL 8.0 or later.