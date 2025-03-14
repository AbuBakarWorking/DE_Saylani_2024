
-- We are using BikeStores Database
-- This !!! (USE) !!!  statement selects the 'BikeStores' database as the current 
-- database context. All subsequent SQL queries and operations will be 
-- executed within the 'BikeStores' database.

USE BikeStores;


-- Section 1. Querying data 
-- This section teaches you how to query data from an SQL Server database. 
-- We’ll begin with a simple query that retrieves data from a single table.


-- Basic SQL Server SELECT statement
--In SQL Server, tables store data in rows and columns, similar to a spreadsheet. 
-- Each row represents a unique record, and each column represents 
-- a field within that record.


-- *** Syntax *** 
-- SELECT
--     select_list
-- FROM
--     schema_name.table_name;

SELECT
    first_name,
    last_name
FROM
    sales.customers;


-- The following statement uses the SELECT statement to retrieve the 
-- first name, last name, and email of all customers:




SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers;



-- To retrieve all columns from a table in SQL Server, you can list each 
-- column in the SELECT  statement or use ## `SELECT *' ## as a shorthand 
-- to select all columns.

--           *** Syntax ***
-- SELECT * FROM schema_name.table_name;


SELECT * FROM sales.customers;



--      *** Filtering rows using the WHERE clause ***
-- The WHERE clause is used to filter the rows returned by a SELECT statement. 
-- It allows you to specify conditions that must be met for a row to be included 
--in the result set.


--         *** Syntax ***
-- SELECT * 
-- FROM schema_name.table_name
-- WHERE condition;


SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA';


-- 4) Sorting rows using the ORDER BY clause
-- The `ORDER BY` clause sorts rows in a result set. For example, to sort 
-- customers by their first names in ascending order, use `ORDER BY first_name`.


-- The columns in the ORDER BY clause must match either column in the select list or 
-- columns defined in the table specified in the FROM clause.


-- *** Syntax ***
-- SELECT *
-- FROM schema_name.table_name
-- WHERE
--    state = 'CA';
-- ORDER BY column_name [ ASC / DESC ];


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;



-- 5) Grouping rows into groups
-- The `GROUP BY` clause groups rows into categories. For example, to find all cities 
-- in California and count the customers in each city, use `GROUP BY city`.

-- *** Syntax ***
-- SELECT *
-- FROM schema_name.table_name
-- GROUP BY column_name ;


SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
ORDER BY
    city;


-- `COUNT` is an (aggregate function) in SQL that returns the number of rows 
-- matching a specified condition.





-- 6) Filtering groups using the HAVING clause
-- The `HAVING` clause filters groups based on conditions. For example, 
-- to find all citiesin California with more than 10 customers, 
-- use `HAVING COUNT(*) > 10`

-- *** Syntax ***
-- SELECT *
-- FROM schema_name.table_name
-- GROUP BY column_name
-- HAVING condition;

SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city;




--       ### Section 2. Sorting data ###


-- 1) Sort a result set by one column in ascending order
-- The `ORDER BY` clause sorts a result set in ascending order by default.

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;



-- Alternative

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name ASC;

-- Same output




-- 2) Sort a result set by one column in descending order

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name DESC;


-- 3) Sort a result set by multiple columns

-- The following statement uses the ORDER BY clause to sort 
-- customers by cities first and then by first names:


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;


-- 4) Sort a result set by multiple columns in different orders

-- City DESC
-- First_name ASC

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
city DESC,
first_name ASC;




-- 5) Sort a result set by a column that is not in the select list

-- SQL Server allows you to sort a result set by columns specified in a table,
--  even if those columns do not appear in the select list.

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;



-- 6) Sort a result set by an expression
-- The LEN() function returns the number of characters in a string.

SELECT
city,
first_name,
last_name
FROM
sales.customers
ORDER BY
LEN(first_name) DESC;



-- 7) Sort by ordinal positions of columns


-- The following statement sorts the customers by first and last names. 
-- But instead of specifying the column names explicitly, 
-- it uses the ordinal positions of the columns:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    1,
    2;


-- Section 3. Limiting rows

--Introduction to SQL Server OFFSET FETCH
-- The OFFSET and FETCH clauses are options of the ORDER BY clause. 
-- They allow you to limit the number of rows returned by a query.

-- Example 

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name;





-- OFFSET
-- To skip the first 10 products and return the 
-- rest, you use the OFFSET clause

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;




-- To skip the first 10 products and select the next 10 products, 
-- you use both OFFSET and FETCH clauses as follows:

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;




-- 2) Using the OFFSET FETCH clause to get the top N rows

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 0 ROWS 
FETCH FIRST 10 ROWS ONLY;


-- First, the ORDER BY clause sorts the products by 
-- their list prices in descending order.


-- Then, the OFFSET clause skips zero rows, and the FETCH 
-- clause retrieves the first 10 products from the list.