-- Section 6. Grouping data


-- The GROUP BY clause allows you to arrange the rows of a query in groups. 
-- The groups are determined by the columns that you specify in the GROUP BY clause.



-- In this query, the GROUP BY clause produces a group for each combination 
-- of the values in the columns listed in the GROUP BY clause.

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;


-- Let’s add a GROUP BY clause to the query to see the effect:

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;


-- Functionally speaking, the GROUP BY clause in the above query produced 
-- the same result as the following query that uses the DISTINCT clause:

SELECT DISTINCT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;


-- SQL Server GROUP BY clause and aggregate functions

COUNT() returns the number of rows in each group. Other 
commonly used aggregate functions are SUM(), 
AVG() (average), 
MIN() (minimum), 
MAX() (maximum).



SELECT
    customer_id,
    YEAR (order_date) order_year,
    COUNT (order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id; 



-- you will get an error because there is no guarantee that the column or expression 
-- will return a single value per group. For example, the following query will fail:

SELECT
    customer_id,
    YEAR (order_date) order_year,
    order_status
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;


-- The following query returns the number of customers in every city:

SELECT
    city,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    city
ORDER BY
    city;


SELECT
    city,
    state,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    state,
    city
ORDER BY
    city,
    state;



-- 2) Using GROUP BY clause with the MIN and MAX functions example

SELECT
    brand_name,
    MIN (list_price) min_price,
    MAX (list_price) max_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;


-- 3) Using GROUP BY clause with the AVG() function example

SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;


-- 4) Using GROUP BY clause with the SUM function example


SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id;





-- SQL Server HAVING Clause

	SELECT
    select_list
FROM
    table_name
GROUP BY
    group_list
HAVING
    conditions;


-- See the following orders table from the sample database:

SELECT
    customer_id,
    YEAR (order_date),
    COUNT (order_id) order_count
FROM
    sales.orders
GROUP BY
    customer_id,
    YEAR (order_date)
HAVING
    COUNT (order_id) >= 2
ORDER BY
    customer_id;



-- The following statement finds the sales orders whose net values are greater than 20,000:

SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id
HAVING
    SUM (
        quantity * list_price * (1 - discount)
    ) > 20000
ORDER BY
    net_value;





	SELECT
    category_id,
    MAX (list_price) max_list_price,
    MIN (list_price) min_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    MAX (list_price) > 4000 OR MIN (list_price) < 500;




	SELECT
    category_id,
    AVG (list_price) avg_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    AVG (list_price) BETWEEN 500 AND 1000;



-- SQL Server Subquery


-- Consider the orders and customers tables from the sample database.











-- Nesting subquery
-- A subquery can be nested within another subquery. SQL Server supports up to 
-- 32 levels of nesting. Consider the following example:


SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;





SELECT
    order_id,
    order_date,
    (
        SELECT
            MAX (list_price)
        FROM
            sales.order_items i
        WHERE
            i.order_id = o.order_id
    ) AS max_list_price
FROM
    sales.orders o
order by order_date desc;




-- The following query finds the names of all mountain bikes and 
-- road bikes products that the Bike Stores sell.


SELECT
    product_id,
    product_name
FROM
    production.products
WHERE
    category_id IN (
        SELECT
            category_id
        FROM
            production.categories
        WHERE
            category_name = 'Mountain Bikes'
        OR category_name = 'Road Bikes'
    );



select * from production.products



-- GROUPING SETS

Select quantity, list_price, Sum(discount) as Total_Discount
From sales.order_items
Group By quantity, list_price

UNION ALL

Select quantity, null, Sum(discount) as Total_Discount
From sales.order_items
Group By quantity

UNION ALL

Select null, list_price, Sum(discount) as Total_Discount
From sales.order_items
Group By list_price

UNION ALL


Select null, null, Sum(discount) as Total_Discount
From sales.order_items
-- Group By list_price;



Select quantity, list_price, Sum(discount) as Total_Discount
From sales.order_items
Group By
Grouping Sets (
(quantity, list_price),
(quantity),
(list_price),
()
	)
Order By GROUPING(quantity), GROUPING(list_price);




-- New Querry 

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;





	SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		()
	)
ORDER BY
	brand,
	category;



-- CUBE 
-- Make all possible combination
-- (above, below) querry give same result but with slightly difference
SELECT
	brand,
	category,
	SUM(sales) Total_Sales
FROM
sales.sales_summary
GROUP By CUBE(brand, category)


-- CUBE with (WITH) Function
SELECT
	brand,
	category,
	SUM(sales) Total_Sales
FROM
sales.sales_summary
GROUP By brand, category WITH CUBE;



-- ROLL UP
-- ROLLUP generates hierarchical groupings from the most detailed level to a grand total. 
-- It creates subtotals and a final grand total.

-- In short:
-- ROLLUP = Hierarchical aggregation (e.g., Country > State > City > Total).

SELECT
	brand,
	category,
	SUM(sales) Total_Sales
FROM
sales.sales_summary
WHERE category Like 'Mountain Bikes'
GROUP By ROLLUP(brand, category)


-- ROLLUP with (WITH) Function
SELECT
	brand,
	category,
	SUM(sales) Total_Sales
FROM
sales.sales_summary
GROUP By brand, category WITH ROLLUP;



-- GROUPING SETS 
-- This Querry and above ROLLUP querry will give same result
SELECT
	brand,
	category,
	SUM(sales) Total_Sales
FROM
sales.sales_summary
GROUP By 
GROUPING SETS (
(brand), (category),
(brand),
(category),
()
)
ORDER BY brand, category;


