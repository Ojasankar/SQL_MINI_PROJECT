# 🛒 Mini Project 4 - Customer Sales & Retention Analysis

## 📊 Project Goal : You're working as a Data Analyst for an e-commerce company.

Management wants to understand:

Which customers are generating the most revenue? <br>
Which customers are inactive? <br>
How many orders does each customer place? <br>
Which customers are high-value? <br>
Which cities generate the most sales? <br>
Which customers need attention? <br>

## Project Data Set :





### customers

| **customer_id** | **customer_name** | **city** |
|-----------------|-------------------|----------|
| C101            | Rahul             | Mumbai   |
| C102            | Priya             | Pune     |
| C103            | Amit              | Delhi    |
| C104            | Neha              | Mumbai   |

### orders_data

| **order_id** | **customer_id** | **product_id** | **sales** |
|--------------|-----------------|----------------|-----------|
| 1001         | C101            | P101           | 5000      |
| 1002         | C101            | P102           | 3000      |
| 1003         | C102            | P103           | 7000      |
| 1004         | C105            | P101           | 9000      |


## Tasks : 

🚀 Task 1 — Customer Revenue Analysis
<br>Find every customer and calculate their total number of orders 
and total sales.Include customers who have never placed an order.
<br>
<br>
🚀 Task 2 — Find Inactive Customers
<br>
Find customers who have never placed an order.
<br>
<br>
🚀 Task 3 — High-Value Customers
<br>Find customers whose total sales are greater than ₹5,000.
<br>
<br>
🚀 Task 4 — Customer Segmentation with a CTE
<br>Segment every customer based on their total sales.
<br>
<br>
🚀 Task 5 — Customer Ranking
<br>Find the top 2 customers based on total sales. USING CTE
<br>
<br>
🚀 Task 6 — Customers Above the Average
<br>Find customers whose total sales are greater than the average customer sales.
<br>
<br>
🚀 Task 7 — Customers With No High-Value Orders
<br>Find customers who do not have any individual order greater than ₹5,000.
<br>
<br>
🚀 Task 8 — Customer Revenue + City Performance
<br>For each city, calculate the number of customers,
total orders, total sales, and average order value. 
<br>Show only cities with total sales above ₹5,000.
<br>
<br>
🚀 Task 9 — Customer Retention Signal
<br>Identify customers who have placed at least 2 orders 
and whose total sales are greater than ₹5,000.
<br>
<br>
🔥 Task 10 — Final Mini Project Challenge
<br>Management wants to identify high-value customers who are also active,
but they also want to know which city they belong to.
<br>Find customers who satisfy all three:<br>
1.Have at least 1 order<br>
2.Total sales are greater than ₹5,000<br>
3.Their city is Mumbai or Pune
<br>
<br>
BONUS 🏁 Task 11 — Customer Revenue Ranking
<br>Management wants a ranked list of all customers based on total sales.
