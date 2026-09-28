--Business requirement
--1.Create a clean customer report with:
--2.customer_id
--3.cleaned customer_name → remove extra spaces
--4.standardized city → all uppercase
--5.age_cleaned → replace NULL age with 0
--6.spending_cleaned → replace NULL with 0 and convert the text value to a numeric type

SELECT customer_id,
TRIM(customer_name) AS customer_name,
CONCAT(UPPER(left(city,1)),
		LOWER(SUBSTRING(city,2))) AS city,
COALESCE(age,0) AS age,
COALESCE(CAST(spending AS DECIMAL(10,2)),0)
FROM customer_data

--Data Quality Check
--Before cleaning data, 
--analysts often need to identify the problems first.
--return table,only customers where either age is NULL OR spending is NULL.
SELECT * FROM customer_data
WHERE age IS NULL OR spending IS NULL;

--Find Inconsistent City Values
--Write a query that returns: cleaned_city and customer_count
SELECT UPPER(TRIM(city))  AS cleaned_city,
COUNT(customer_id) AS customer_count 
FROM customer_data
GROUP BY cleaned_city
ORDER BY customer_count DESC;

--Clean + Filter + Aggregate:
--Which cities have at least 2 customers after standardizing the city names?
SELECT UPPER(TRIM(city))  AS cleaned_city,
COUNT(customer_id) AS customer_count 
FROM customer_data
GROUP BY cleaned_city
HAVING COUNT(customer_id)>=2
ORDER BY customer_count DESC;

--Create a customer spending report showing 
--only customers whose cleaned spending is greater than ₹50,000.
SELECT customer_id,
TRIM(customer_name),
UPPER(TRIM(CITY)) AS cleaned_city,
COALESCE(CAST(spending AS DECIMAL(10,2)),0) AS spending_cleaned,
CASE 
	WHEN COALESCE(CAST(spending AS DECIMAL(10,2)),0)>=70000 THEN 'High'
	WHEN COALESCE(CAST(spending AS DECIMAL(10,2)),0)>= 50000 THEN 'Medium'
	ELSE 'Low'
	END AS spending_level
FROM customer_data
WHERE COALESCE(CAST(spending AS DECIMAL(10,2)),0)> 50000
ORDER BY spending_cleaned DESC;
--HERE need to repeat the cleaned spending expression in the WHERE and CASE, 
--because we haven't learned CTEs/subqueries yet



--🚀 Checkpoint Question 1
--Customer Data Cleaning
SELECT customer_id,
TRIM(customer_name) AS customer_name,
UPPER(TRIM(city)) AS cleaned_city,
COALESCE(CAST(spending AS decimal(10,2)),0) AS spending_cleaned,
CASE
WHEN COALESCE(CAST(spending AS decimal(10,2)),0)>=70000 THEN 'Premium'
WHEN COALESCE(CAST(spending AS decimal(10,2)),0)>=50000 THEN 'Regular'
ELSE 'Low Value'
END AS customer_type
FROM customer_data
ORDER BY spending_cleaned DESC;

--🚀 Checkpoint Question 2
--Using customer_data, 
--find the number of customers in each standardized city.
SELECT UPPER(TRIM(city)) AS cleaned_city ,
COUNT(customer_id) AS customer_count,
SUM(COALESCE(CAST(spending AS decimal(10,2)),0)) AS total_spending
FROM customer_data
GROUP BY cleaned_city
HAVING SUM(COALESCE(CAST(spending AS decimal(10,2)),0))>100000
ORDER BY total_spending DESC;

--🚀 Checkpoint Question 3
--Using customer_data, 
--identify customers who have missing or incomplete information.
SELECT customer_id,
TRIM(customer_name) AS customer_name,
UPPER(TRIM(city)) AS cleaned_city,
age,
COALESCE(CAST(spending AS decimal(10,2)),0) AS cleaned_spending
FROM customer_data
WHERE age IS NULL OR spending IS NULL;

--🚀 Checkpoint Question 4 — Conditional Aggregation
--Using #date_table#, create a monthly delivery performance report.
SELECT 
EXTRACT(MONTH FROM order_date) AS order_month,
COUNT(order_id) AS total_orders,
COUNT(CASE 
	WHEN delivery_date-order_date<=3 THEN order_id
	END) AS fast_orders,
COUNT(CASE 
	WHEN delivery_date - order_date > 3 AND delivery_date-order_date<=5 THEN order_id
	END) AS normal_orders,
COUNT(CASE 
	WHEN delivery_date-order_date>5 THEN order_id
	END) AS slow_orders
FROM date_table
GROUP BY order_month

--🚀 Checkpoint Question 5 — Final Challenge
--Using date_table, find the monthly sales performance.
SELECT 
EXTRACT (MONTH FROM order_date) AS order_month,
COUNT (order_id) AS total_orders,
SUM(sales) AS total_sales,
SUM(sales)/COUNT(order_id) AS average_order_value,
COUNT(CASE 
WHEN delivery_date-order_date>5 THEN order_id
END) AS slow_orders
FROM date_table
GROUP BY order_month
ORDER BY total_sales DESC












