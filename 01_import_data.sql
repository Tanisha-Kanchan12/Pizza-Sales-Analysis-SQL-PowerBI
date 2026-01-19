-- Pizza Sales Project

-- Step 1: Modify Data Types 

ALTER TABLE pizza_sales
ALTER COLUMN pizza_id TYPE INTEGER
USING pizza_id::INTEGER;

ALTER TABLE pizza_sales
ALTER COLUMN order_id TYPE INTEGER
USING order_id::INTEGER;

ALTER TABLE pizza_sales
ALTER COLUMN quantity TYPE INTEGER
USING quantity::INTEGER;

ALTER TABLE pizza_sales
ALTER COLUMN unit_price TYPE NUMERIC
USING unit_price::NUMERIC;

ALTER TABLE pizza_sales
ALTER COLUMN total_price TYPE NUMERIC
USING total_price::NUMERIC;

-- Step 2: Data check

SELECT COUNT(*) FROM pizza_sales;

-- Step 3: Preview data

SELECT * 
FROM pizza_sales
LIMIT 10;

-- Step 4: Total Revenue (KPI 1)

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

-- Step 5: Average Order Value

SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

-- Step 6: Total Pizzas Sold

SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- Step 7: Total Orders

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- Step 8: Average Pizzas Per Order
SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) /
        CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
    AS DECIMAL(10,2)) AS avg_pizzas_per_order
FROM pizza_sales;

B. Daily Trend for Total Orders

-- Step 9: Orders by Day of Week

SELECT
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY total_orders DESC;

-- Step 10: Monthly Trend for Orders

SELECT
    TO_CHAR(order_date, 'Month') AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY 
    TO_CHAR(order_date, 'Month'),
    EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);

-- Step 11: % of Sales by Pizza Category

SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS pct
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pct DESC;

-- Step 12: % of Sales by Pizza Size

SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS pct
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pct DESC;

-- Step 13: Total Pizzas Sold by Pizza Category

SELECT 
    pizza_category,
    SUM(quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

-- Step 14. Top 5 Pizzas by Revenue

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Step 15. Bottom 5 Pizzas by Revenue

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

-- Step 16. Top 5 Pizzas by Quantity Sold

SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

-- Step 17. Bottom 5 Pizzas by Quantity Sold

SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
LIMIT 5;

-- Step 18. Top 5 Pizzas by Total Orders

SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

-- Step 19. Bottom 5 Pizzas by Total Orders

SELECT
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;

