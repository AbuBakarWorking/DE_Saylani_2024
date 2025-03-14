USE BikeStores;

-- Introduction to SQL Server SELECT TOP

-- The following shows the syntax of the TOP clause with the SELECT statement:

-- *** Syntax ***
-- SELECT TOP (expression) [PERCENT]
--     [WITH TIES]
-- FROM 
--     table_name
-- ORDER BY 
--     column_name;


select @@SERVERNAME;


-- 1) Using SQL Server SELECT TOP with a constant value
SELECT TOP 10
product_name,
list_price
FROM
production.products
ORDER BY
list_price DESC;





-- 2) Using SELECT TOP to return a percentage of rows

-- The following example uses PERCENT to specify the 
-- number of products returned in the result set


--The following example uses PERCENT to specify the number of products 
--returned in the result set.

-- The production.products table has 321 rows. Therefore, one percent of 321 is a fraction value ( 3.21), 
-- SQL Server rounds it up to the next whole number, which is four ( 4) in this case:


SELECT TOP 1 PERCENT
product_name,
list_price
FROM
production.products
ORDER BY
list_price DESC;





-- 3) Using SELECT TOP WITH TIES to include rows 
-- that match values in the last row

SELECT TOP 3 with TIES 
product_name,
list_price
FROM
production.products
ORDER BY
list_price DESC;

-- Introduction to SQL Server SELECT ** (DISTINCT) ** clause

-- *** Syntax ***
-- SELECT 
--   DISTINCT column_name 
-- FROM 
--   table_name;




-- 1) Using the SELECT DISTINCT with one column

SELECT 
city 
FROM 
sales.customers 
ORDER BY 
city;



-- 2) Using SELECT DISTINCT with multiple columns

SELECT 
city, 
state 
FROM 
sales.customers 
ORDER BY 
city, 
state;




-- same result but short form querry
SELECT 
DISTINCT city, state 
FROM 
sales.customers




-- DISTINCT vs. GROUP BY
-- The following statement uses the GROUP BY clause to return distinct 
-- cities together with state and zip code from the sales.customers table:

SELECT 
    city, 
    state, 
    zip_code 
FROM 
    sales.customers 
GROUP BY 
    city, 
    state, 
    zip_code 
ORDER BY 
    city, 
    state, 
    zip_code




-- It is equivalent to the following query that uses the DISTINCT operator :

SELECT 
DISTINCT city, state, zip_code 
FROM 
sales.customers;




-- 1) Using the WHERE clause with a simple equality operator

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1
ORDER BY
    list_price DESC;




--  1)Basic SQL Server AND operator 


SELECT * FROM 
production.products 
WHERE 
category_id = 1 
AND list_price > 400 
ORDER BY 
list_price DESC;




-- 2) Using the AND operator with other logical operators
SELECT
    *
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
AND list_price > 1000
ORDER BY
    brand_id DESC;




-- 3) Using the WHERE clause with the AND operator

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1 AND model_year = 2018
ORDER BY
    list_price DESC;





-- 4) Using WHERE to filter rows using a comparison operator

 SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 300 AND model_year = 2018
ORDER BY
    list_price DESC;




-- 5) Using the WHERE clause to filter rows that 
-- meet any of two conditions

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 3000 OR model_year = 2018
ORDER BY
    list_price DESC;




-- 6) Using the WHERE clause to filter rows with the value between two values

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
    list_price DESC;




-- 7) Using the WHERE clause to filter rows that have a 
-- value in a list of values

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price IN (299.99, 369.99, 489.99)
ORDER BY
    list_price DESC;





-- Using SQL Server IN operator with a subquery

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;



-- Using SQL Server BETWEEN with dates

SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;




