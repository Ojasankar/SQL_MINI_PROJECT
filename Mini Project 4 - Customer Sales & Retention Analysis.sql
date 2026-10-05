--Mini Project 4 : Customer Sales & Retention Analysis 🚀
--📊 Project Goal : 
/*You're working as a Data Analyst for an e-commerce company.

Management wants to understand:

Which customers are generating the most revenue?
Which customers are inactive?
How many orders does each customer place?
Which customers are high-value?
Which cities generate the most sales?
Which customers need attention? */


--🎯Task 1 — Customer Revenue Analysis
/*Find every customer and calculate their total number of orders 
and total sales.Include customers who have never placed an order.*/
SELECT  c.customer_id,
		c.customer_name,
		c.city,
		COALESCE(customer_metrics.total_orders, 0) AS total_orders,
        COALESCE(customer_metrics.total_sales, 0) AS total_sales
FROM customers AS c
LEFT JOIN (
			SELECT customer_id ,
			COUNT (order_id) AS total_orders,
			SUM(sales) AS total_sales
			FROM orders_data 
			GROUP BY customer_id
			) AS customer_metrics
ON c.customer_id=customer_metrics.customer_id
ORDER BY total_sales DESC ;

--🚀 Task 2 — Find Inactive Customers
--Find customers who have never placed an order.
SELECT customer_id,
customer_name,
city
FROM customers AS c
WHERE NOT EXISTS ( SELECT 1 
				FROM orders_data AS o
				WHERE o.customer_id=c.customer_id
) ;


--🚀 Task 3 — High-Value Customers
--Find customers whose total sales are greater than ₹5,000.
WITH customer_metrics AS (
		SELECT c.customer_id, 
		c.customer_name,
		c.city,
		COUNT(o.order_id) AS total_orders,
		COALESCE(SUM(o.sales),0) AS total_sales
		FROM customers AS c
		LEFT JOIN orders_data AS o
		ON c.customer_id=o.customer_id
		GROUP BY c.customer_id, c.customer_name, c.city
) 
SELECT customer_id,customer_name,city,
COALESCE(total_orders,0) AS total_orders,
COALESCE(total_sales ,0) AS total_sales
FROM customer_metrics
WHERE COALESCE(total_sales ,0) > 5000
ORDER BY total_sales DESC;


--🚀 Task 4 — Customer Segmentation with a CTE
--Segment every customer based on their total sales.
WITH customer_metrics AS (
SELECT c.customer_id, 
		c.customer_name,
		c.city,
		COUNT(o.order_id) AS total_orders,
		COALESCE(SUM(o.sales),0) AS total_sales
		FROM customers AS c
		LEFT JOIN orders_data AS o
		ON c.customer_id=o.customer_id
		GROUP BY c.customer_id, c.customer_name, c.city
) 
SELECT  customer_id,
		customer_name,
		city,
		total_orders,
		total_sales,
CASE 
		WHEN total_sales >= 7000 THEN 'High Value'
		WHEN total_sales >= 5000 THEN 'Medium Value'
		ELSE 'Low Value'
END AS customer_segment
FROM customer_metrics
ORDER BY total_sales DESC ; 

--🚀 Task 5 — Customer Ranking
--Find the top 2 customers based on total sales. USING CTE
WITH customer_metrics AS (
		SELECT c.customer_id, c.customer_name,
		c.city,
		COUNT(o.order_id) AS total_orders,
		COALESCE(SUM(o.sales),0) AS total_sales
		FROM customers AS c
		LEFT JOIN orders_data AS O
		ON c.customer_id=o.customer_id
		GROUP BY c.customer_id,c.customer_name,c.city
)
SELECT  customer_id,
		customer_name ,
		city,
		total_orders,
		total_sales
		FROM customer_metrics
ORDER BY total_sales DESC
LIMIT 2;


--🚀 Task 6 — Customers Above the Average
--Find customers whose total sales 
--are greater than the average customer sales.
WITH customer_metrics AS (
		SELECT c.customer_id,
		c.customer_name,
		c.city,
		COALESCE(SUM(o.sales),0) AS total_sales
		FROM customers AS c
		LEFT JOIN orders_data AS o
		ON c.customer_id=o.customer_id
		GROUP BY c.customer_id,c.customer_name,c.city
)
SELECT customer_id,
		customer_name,
		city,
		total_sales
FROM customer_metrics
WHERE total_sales > (
						SELECT avg(total_sales)
						FROM customer_metrics
--calculating the average from the 
--CTE itself rather than going back to the raw orders_data.
)

--🚀 Task 7 — Customers With No High-Value Orders
--Find customers who do not have any individual order greater than ₹5,000.
WITH customer_list AS ( 
	SELECT customer_name,
			customer_id,
			city
	FROM customers 
)
SELECT customer_name,customer_id,city
FROM customer_list  AS cl
WHERE NOT EXISTS (
		SELECT 1 
		FROM orders_data AS o
		WHERE o.customer_id=cl.customer_id AND o.sales>5000
);

--🚀 Task 8 — Customer Revenue + City Performance
--For each city, calculate the number of customers,
--total orders, total sales, and average order value. 
--Show only cities with total sales above ₹5,000.
WITH customer_metrics AS (
     SELECT c.customer_id,
	 c.city,
	 COUNT(o.order_id) AS total_orders,
	 COALESCE(SUM(o.sales),0) AS total_sales
	 FROM customers AS c
	 LEFT JOIN orders_data AS o
	 ON c.customer_id=o.customer_id
	 GROUP BY c.customer_id,c.city
)
SELECT city,
	COUNT(DISTINCT(customer_id)) AS customer_count,
		SUM(total_orders) AS total_orders,
		SUM(total_sales) AS total_sales,
		SUM(total_sales)/NULLIF(SUM(total_orders),0) AS average_order_value
FROM customer_metrics
GROUP BY city
HAVING SUM(total_sales) > 5000
ORDER BY total_sales DESC;
		
--🚀 Task 9 — Customer Retention Signal
--Identify customers who have placed at least 2 orders 
--and whose total sales are greater than ₹5,000.
WITH customer_metrics AS (
		SELECT c.customer_id,
		       c.customer_name,
				c.city,
				COUNT(o.order_id) AS total_orders,
				COALESCE(SUM(o.sales),0) AS total_sales
	 FROM customers AS c
	 LEFT JOIN orders_data AS o
	 ON c.customer_id=o.customer_id
	 GROUP BY c.customer_id,c.customer_name,c.city
)
SELECT customer_id,
		customer_name,
		city,
		total_orders,
		total_sales
FROM customer_metrics
WHERE total_orders>=2 AND total_sales>5000
ORDER BY total_sales DESC;

--🔥 Task 10 — Final Mini Project Challenge
--Management wants to identify high-value customers who are also active,
--but they also want to know which city they belong to.
--Find customers who satisfy all three:
--Have at least 1 order
--Total sales are greater than ₹5,000
--Their city is Mumbai or Pune
WITH customer_metrics AS (
		SELECT c.customer_id,
		       c.customer_name,
				c.city,
				COUNT(o.order_id) AS total_orders,
				COALESCE(SUM(o.sales),0) AS total_sales
	 FROM customers AS c
	 LEFT JOIN orders_data AS o
	 ON c.customer_id=o.customer_id
	 GROUP BY c.customer_id,c.customer_name,c.city
)
SELECT customer_id,
		customer_name,
		city,
		total_orders,
		total_sales,
CASE 
		WHEN total_sales >= 7000 THEN 'High Value'
		WHEN total_sales >= 5000 THEN 'Medium Value'
		ELSE 'Low Value'
END AS customer_segment
FROM customer_metrics
WHERE city IN ('Mumbai','Pune') AND total_orders>=1 AND total_sales>5000
ORDER BY total_sales DESC ;

--BONUS 🏁 Task 11 — Customer Revenue Ranking
--Management wants a ranked list of all customers based on total sales.
WITH customer_metrics AS (
		SELECT c.customer_id,
		       c.customer_name,
				c.city,
				COUNT(o.order_id) AS total_orders,
				COALESCE(SUM(o.sales),0) AS total_sales
	 FROM customers AS c
	 LEFT JOIN orders_data AS o
	 ON c.customer_id=o.customer_id
	 GROUP BY c.customer_id,c.customer_name,c.city
)
SELECT customer_id,
		customer_name,
		city,
		total_orders,
		total_sales,
CASE 
		WHEN total_sales >= 7000 THEN 'High Value'
		WHEN total_sales >= 5000 THEN 'Medium Value'
		ELSE 'Low Value'
END AS customer_segment
FROM customer_metrics
ORDER BY total_sales DESC ;



