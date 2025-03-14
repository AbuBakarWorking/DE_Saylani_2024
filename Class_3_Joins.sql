USE BikeStores;


-- First, create a new schema named hr:

CREATE SCHEMA hr;


-- Second, create two new tables named candidates and employees in the hr schema:

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);



-- Third, insert some rows into the candidates and employees tables:

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');



--      ###   SQL Server Inner Join   ###       

-- ** Inner join produces a data set that includes rows from the left table, 
-- and matching rows from the right table. **

-- ## SQL Server INNER JOIN syntax ##

SELECT
    select_list
FROM
    T1
INNER JOIN T2 ON join_predicate;




-- The inner join is one of the most commonly used joins in SQL Server.
-- The inner join clause allows you to query data from two or more related tables.

-- See the following products and categories tables:

SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products
ORDER BY
    product_name DESC;



-- The query returned only a list of category identification numbers, not the category names. 
-- To include the category names in the result set, you use the INNER JOIN clause as follows:

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
INNER JOIN production.categories c 
    ON c.category_id = p.category_id
ORDER BY
    product_name DESC;


-- The c and p are the table aliases of the production.categories  and  production.products tables.


SELECT
    product_name,
    category_name,
    brand_name,
    list_price
FROM
    production.products p
INNER JOIN production.categories c ON c.category_id = p.category_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
ORDER BY
    product_name DESC;





--       ### SQL Server Left Join ###
-- Left join produces a data set that includes all rows from the left table,
-- and matching rows from the right table. If there is no match, the result is NULL on
-- the right side.


-- ## SQL Server LEFT JOIN syntax ##

SELECT
    select_list
FROM
    T1
LEFT JOIN T2 ON
    join_predicate;


-- The following statement joins the candidates table with the employees table using left join:

SELECT *
FROM
hr.candidates c
LEFT JOIN hr.employees e
ON e.fullname = c.fullname;




SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o ON o.product_id = p.product_id
ORDER BY
    order_id;


-- To get the rows that are available only in the left table but not in the right table,
-- you add a WHERE clause to the above query:

SELECT *
FROM
hr.candidates c
LEFT JOIN hr.employees e
ON e.fullname = c.fullname
WHERE
e.id is NULL;



-- The following example shows how to join three tables: production.products, 
-- sales.orders, and 
-- sales.order_items using the LEFT JOIN clauses:

SELECT
    p.product_name,
    o.order_id,
    i.item_id,
    o.order_date
FROM
    production.products p
	LEFT JOIN sales.order_items i
		ON i.product_id = p.product_id
	LEFT JOIN sales.orders o
		ON o.order_id = i.order_id
ORDER BY
    order_id;







--    ### SQL Server LEFT JOIN: conditions in ON vs. WHERE clause ###

-- The following query finds the products that belong to order id 100:

-- WHERE

SELECT
product_name,
order_id
FROM
production.products p
LEFT JOIN sales.order_items o 
ON p.product_id = o.product_id
WHERE
order_id = 100



-- ON

SELECT
    p.product_id,
    product_name,
    order_id
FROM
    production.products p
    LEFT JOIN sales.order_items o 
        ON o.product_id = p.product_id AND 
        o.order_id = 100
ORDER BY
    order_id DESC;




--       ### SQL Server Right Join ###
-- A `RIGHT JOIN` (or `RIGHT OUTER JOIN`) starts with the right table and is the reverse of a `LEFT JOIN`. 

-- ## SQL Server LEFT JOIN syntax ##

SELECT 
    select_list
FROM 
    T1
RIGHT JOIN T2 ON join_predicate;


-- It returns all the rows from the right table and the matching rows from the left table
-- If no match exists, columns from the left table will have `NULL` values.





-- The following example uses the right join to query rows from candidates and employees tables:

SELECT *
FROM
hr.candidates c
RIGHT JOIN hr.employees e
ON e.fullname = c.fullname;




SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
ORDER BY
    order_id;



-- To get rows available only in the right table, use a WHERE clause to filter 
-- NULL values from the left table, like this:


SELECT *
FROM hr.candidates 
RIGHT JOIN hr.employees
ON hr.candidates.fullname = hr.employees.fullname
WHERE hr.candidates.id IS NULL;




-- To get the products that do not have any sales, you add a WHERE clause to 
-- the above query to filter out the products that have sales:

SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
WHERE 
    order_id IS NULL
ORDER BY
    product_name;


-- Here’s the statement to return all order_id from the sales.order_items table and product_name 
-- from the production.products table:

SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
ORDER BY
    order_id;



-- To find products without sales, add a WHERE clause to filter products with no matching sales:

SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
WHERE 
    order_id IS NULL
ORDER BY
    product_name;


--       ### SQL Server Full Outer Join ###
-- A `FULL JOIN` (or `FULL OUTER JOIN`) returns all the rows from both tables
-- If there is no match, the result will contain NULL values for the non-matching rows.


-- The OUTER keyword is optional so you can skip it as shown in the following query:


SELECT 
    select_list
FROM 
    T1
FULL JOIN T2 ON join_predicate;



CREATE SCHEMA pm;


-- Creating Tables
CREATE TABLE pm.projects(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE pm.members(
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(120) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) 
        REFERENCES pm.projects(id)
);


-- Inserting Values 
INSERT INTO 
    pm.projects(title)
VALUES
    ('New CRM for Project Sales'),
    ('ERP Implementation'),
    ('Develop Mobile Sales Platform');


INSERT INTO
    pm.members(name, project_id)
VALUES
    ('John Doe', 1),
    ('Lily Bush', 1),
    ('Jane Doe', 2),
    ('Jack Daniel', null);



SELECT * FROM pm.projects;


SELECT * FROM pm.members;





-- Finally, use the FULL OUTER JOIN to query data from projects and members tables:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id;


-- To find members not in any project and projects with no members, use this query:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id
WHERE
    m.id IS NULL OR
    P.id IS NULL;


-- The following example uses the full join to query rows from *(candidates)* and *(employees)* tables:

SELECT *
FROM
hr.candidates c
FULL JOIN hr.employees e 
ON e.fullname = c.fullname;



-- To select rows that exist in either the left or right table but not in both, 
-- use a WHERE clause to exclude common rows:

SELECT * FROM
hr.candidates c
FULL JOIN hr.employees e
ON e.fullname = c.fullname
WHERE c.id IS NULL or e.id IS NULL



--       ### SQL Server CROSS JOIN clause ###

-- A cross join allows you to combine rows from the first table with every row of the second table. 
-- In other words, it returns the Cartesian product of two table.

-- ** Syntax **
SELECT
  select_list
FROM
  T1
CROSS JOIN T2;


-- The following statement returns the combinations of all products and stores:

SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity
FROM
    production.products
CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;



--       ### SQL Server Self Join ###

-- A self join allows you to join a table to itself. 
-- It helps query hierarchical data or compare rows within the same table.

--   ** Syntax **

SELECT
    select_list
FROM
    T t1
[INNER | LEFT]  JOIN T t2 ON
    join_predicate;



	SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;




	SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;



SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;



SELECT 
   customer_id, first_name + ' ' + last_name c, 
   city
FROM 
   sales.customers
WHERE
   city = 'Albany'
ORDER BY 
   c;




SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
    c1.city,
    customer_1,
    customer_2;



SELECT
    c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
	c1.city,
    customer_1,
    customer_2;

