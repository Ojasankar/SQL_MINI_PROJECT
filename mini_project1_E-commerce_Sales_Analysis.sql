SELECT * FROM orders

--🎯 Project Task 1 — Basic Sales Overview
SELECT COUNT(order_id) AS total_orders,
SUM(quantity*unit_price) AS total_sales_value
FROM orders

--🛒 Task 2 — Sales by Category
SELECT category,
SUM(quantity*unit_price) AS total_sales,
SUM(quantity) AS total_quantity 
--made mistake as took count(quantity) instead write sum(quantity)
FROM orders
GROUP BY category
ORDER BY total_sales DESC

--🛒 Task 3 — Sales by Region
SELECT region,
COUNT(order_id) AS total_orders ,
SUM(quantity*unit_price) AS total_sales,
--here i have calculated average and given it name as allias
SUM(quantity*unit_price)/COUNT(order_id) AS average_order_value
FROM orders
GROUP BY region
ORDER BY total_sales DESC

--🛒 Task 4 — Product Performance
SELECT product,
SUM(quantity) AS total_qty_sold,
SUM(quantity*unit_price) AS total_sales,
AVG(unit_price) AS average_price
FROM orders
GROUP BY product
ORDER BY total_sales DESC

--🎯 Task 5 — Delivered Sales Analysis
SELECT region,
COUNT(order_status) AS total_delivered_orders,
SUM(quantity*unit_price) AS total_delivered_sales
FROM orders
WHERE order_status='Delivered'
GROUP BY region
ORDER BY total_delivered_sales DESC

--🔥 Task 6 — Customer Spending
SELECT customer_id,
COUNT(customer_id) AS total_orders,
SUM(quantity) AS total_quantity,
SUM(quantity*unit_price) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC

--🔥 Task 7 — High-Value Customers
SELECT customer_id,
COUNT(customer_id) AS total_orders,
SUM(quantity*unit_price) AS total_spend
FROM orders
GROUP BY customer_id
HAVING SUM(quantity*unit_price)>10000
ORDER BY total_spend DESC

--🔥 Task 8 — Category Performance
SELECT category,
COUNT(category) AS total_orders,
SUM(quantity) AS total_quantity,
SUM(quantity*unit_price) AS total_sales,
SUM(quantity*unit_price)/COUNT(category) AS average_order_value
FROM orders
GROUP BY category
ORDER BY total_sales DESC

--🔥 Task 9 — Cancellation Analysis
SELECT region,
COUNT(order_status) AS cancelled_orders,
SUM(quantity*unit_price) AS cancelled_sales
FROM orders
WHERE order_status='Cancelled'
GROUP BY region
ORDER BY cancelled_sales DESC

--🔥 Task 10 — Final Business Question
SELECT region,
COUNT(order_id) AS total_orders,
SUM(quantity*unit_price) AS total_sales,
SUM(quantity*unit_price)/COUNT(order_id) AS average_order_value
FROM orders 
GROUP BY region 
HAVING COUNT(order_id)>=2 AND SUM(quantity*unit_price)>10000
ORDER BY total_sales DESC 

--🚀 Final Challenge
SELECT customer_id,
COUNT(order_status) AS delivered_orders,
SUM(quantity) AS delivered_quantity,
SUM(quantity*unit_price) AS delivered_sales
FROM orders
WHERE order_status='Delivered'
GROUP BY customer_id
HAVING SUM(quantity*unit_price)>10000
ORDER BY delivered_sales DESC




