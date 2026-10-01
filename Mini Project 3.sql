--🛒 Week 4 Mini Project — E-Commerce Business Analytics

--Part A — Customer Analysis

--Task 1 — Customer Revenue Analysis
SELECT c.customer_name,c.city,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales,
COALESCE(SUM(o.sales)/NULLIF(COUNT(o.order_id),0),0) AS average_order_value
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name,c.city
ORDER BY total_sales DESC;

--Task 2 — Inactive Customers
--Now find customers who have never placed an order.
SELECT c.customer_id,
c.customer_name,
c.city
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL
ORDER BY customer_id ASC;

--Task 3 — High-Value Customers
--Find customers whose total sales are greater than ₹5,000.
SELECT c.customer_name,c.city,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name,c.city
HAVING COALESCE(SUM(o.sales),0)>5000
ORDER BY total_sales DESC ;

--Task 4 — City Performance
--city-level analysis.
SELECT c.city,
COUNT(DISTINCT(c.customer_id))AS customer_count,
COUNT (o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales,
COALESCE(SUM(o.sales)/NULLIF(COUNT (o.order_id),0),0) AS average_order_value
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
GROUP BY c.city
HAVING COALESCE(SUM(o.sales),0)>5000
ORDER BY total_sales DESC ;

--Task 5 — Product Performance
--product analysis.
SELECT p.product_name,
p.category,
COUNT (o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales,
COALESCE(SUM(o.sales)/NULLIF(COUNT (o.order_id),0),0) AS average_order_value
FROM products AS p
LEFT JOIN orders_data AS o
ON p.product_id=o.product_id
GROUP BY  p.product_name,p.category
ORDER BY total_sales DESC ;

--Task 6 — Category Performance
--Product → Category
SELECT
p.category,
COUNT(DISTINCT(p.product_id)) AS total_products,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales
FROM products AS p
LEFT JOIN orders_data AS o
ON p.product_id=o.product_id
GROUP BY  p.category
HAVING COUNT(o.order_id)>=2
ORDER BY total_sales DESC ;

--Task 7 — Customer Sales by City
--customer-level and city-level analysis.
SELECT c.city,
c.customer_name,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
GROUP BY c.city,c.customer_name
HAVING COALESCE(SUM(o.sales),0)>4000
ORDER BY total_sales DESC ;

--Task 8 — Customer + Product Category Analysis
--Find each customer's performance by product category.
SELECT 
c.customer_name,
c.city,
p.category,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
LEFT JOIN products AS p
ON o.product_id=p.product_id
GROUP BY c.customer_name,c.city,p.category
HAVING COALESCE(SUM(o.sales),0)>4000 AND COUNT(o.order_id)>=1
ORDER BY total_sales DESC ;

--Task 9 — Customer Segmentation
--Create customer segments based on total sales: high , medium , low values
SELECT c.customer_name,
c.city,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales,
CASE 
	WHEN COALESCE(SUM(o.sales),0)>=7000 THEN 'High Value'
	WHEN COALESCE(SUM(o.sales),0)>=5000 THEN 'Medium Value'
	ELSE 'Low Value'
	END AS customer_segment
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name,c.city
ORDER BY total_sales DESC ;

--Task 10 — Final Business Challenge
--Which customers are generating significant 
--revenue from which product categories?
SELECT c.customer_name,
c.city,
p.category,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.sales),0) AS total_sales
FROM customers AS c
LEFT JOIN orders_data AS o
ON c.customer_id=o.customer_id
LEFT JOIN products AS p
ON p.product_id=o.product_id
GROUP BY c.customer_name,c.city,p.category
HAVING COUNT(o.order_id)>=1 AND COALESCE(SUM(o.sales),0)>4000
ORDER BY total_sales DESC ;



