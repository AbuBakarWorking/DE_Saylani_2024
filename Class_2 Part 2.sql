USE BikeStores


-- Introduction to SQL Server LIKE operator
-- *** Syntax ***

-- >>> SELECT column1, column2, ...
-- FROM table_name
-- WHERE column_name LIKE pattern; <<<


-- ) Finding rows whose values contain a string

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Cruiser%'
ORDER BY
    list_price;


-- Using the LIKE operator with the % wildcard


-- The example uses the LIKE operator with % to find customers whose last names start with "Z".

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;





-- The example uses the `LIKE` operator with `%` to find customers whose last names end with "er".

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%er'
ORDER BY
    first_name;



-- The statement uses the `LIKE` operator to find customers whose last names start with "t" and end with "s".

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 't%s'
ORDER BY 
    first_name;



-- The `LIKE` operator with `_` finds customers where the second character is "u".

SELECT
    customer_id,
    first_name,
    last_name
FROM
sales.customers
WHERE
last_name LIKE '_u%'
    

--  Using the LIKE operator with the [list of characters] wildcard

-- The query uses `LIKE` with `[YZ]%` to find customers 
-- whose last names start with "Y" or "Z".

SELECT
customer_id,
first_name,
last_name
FROM
sales.customers
WHERE
last_name LIKE '[%YZ]%'



-- Using the LIKE operator with the [character-character]

-- The query uses `LIKE` with `[A-C]%` to find customers whose last names start with a letter from A to C.

SELECT
customer_id,
first_name,
last_name
FROM
sales.customers
WHERE
last_name LIKE '[A-C]%'
ORDER BY
first_name



-- Using the LIKE operator with the [^Character List or Range] wildcard example


-- The query uses `LIKE` with `[!A-X]%` to find customers whose last names 
-- do not start with a letter from A to X.

SELECT
customer_id,
first_name,
last_name
FROM
sales.customers
WHERE
last_name LIKE '[^A-X]%'
ORDER BY
last_name;





-- Using the NOT LIKE operator

-- The following example uses the NOT LIKE operator to find customers where the first 
-- character in the first name is not the letter A:

SELECT
customer_id,
first_name,
last_name
FROM
sales.customers
WHERE
last_name NOT LIKE 'A%'



-- Now Both first_name and last_name NOT LIKE 'A%'

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    first_name NOT LIKE 'A%'
    AND last_name NOT LIKE 'A%';




-- 7) Using the LIKE operator with ESCAPE example
-- First, create a new table for the demonstration:

CREATE TABLE sales.feedbacks (
feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
comment VARCHAR(255) NOT NULL
);





-- Second, insert some rows into the sales.feedbacks table:

INSERT INTO sales.feedbacks(comment)
VALUES 
    ('Can you give me 30% discount?'),
    ('May I get me 30USD off?'),
    ('Is this having 20% discount today?');




-- Third, query data from the sales.feedbacks table:

SELECT * FROM sales.feedbacks;


-- SQL Server LIKE - sample table
-- If you want to search for 30% in the comment column, you may come up with a query like this:

SELECT 
    feedback_id,
    comment
FROM 
    sales.feedbacks
WHERE 
    comment LIKE '%30%';


-- SQL Server column alias


SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;

-- Back to the example above, you can rewrite the query using a column alias:

SELECT first_name + ' ' + last_name AS Full_Name
FROM
sales.customers
ORDER BY
first_name;



-- If the column alias contains spaces, enclose it in quotation marks like this:

SELECT first_name + ' ' + last_name AS 'Full Name'
FROM
sales.customers
ORDER BY
first_name;



-- The following example shows how to assign an alias to a column:

SELECT
    category_name 'Product Category'
FROM
    production.categories;




-- When assigning a column alias, you can use either the original column name or the alias 
-- in the ORDER BY clause. For example:

SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    category_name;  


-- Alternatively:

SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';