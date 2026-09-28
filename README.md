# 🧹  Mini Project 2— Data Cleaning & Transformation

## Project Datasets Used

### 1. `date_table`

| order_id | customer_id | order_date | delivery_date |
| :--- | :--- | :--- | :--- |
| 1001 | C101 | 05-01-2026 | 08-01-2026 |
| 1002 | C102 | 10-01-2026 | 15-01-2026 |
| 1003 | C103 | 03-02-2026 | 05-02-2026 |
| 1004 | C104 | 18-02-2026 | 25-02-2026 |
| 1005 | C105 | 02-03-2026 | 10-03-2026 |

### 2. `customer_data`

| customer_id | customer_name | city | age | spending |
| :--- | :--- | :--- | :--- | :--- |
| C101 | Rahul  | mumbai | 25 | '50000' |
| C102 | Priya | MUMBAI | NULL | '65000' |
| C103 | Amit | delhi  | 28 | NULL |
| C104 | Neha  | Delhi | 24 | '45000' |
| C105 | Arjun | mumbai | NULL | '72000' |

---

## Checklist

| Topic | Status |
| :--- | :--- |
| NULL handling | Completed |
| COALESCE() | Completed |
| CASE WHEN | Completed |
| CAST / data types | Completed |
| String functions | Completed |
| Numeric functions | Completed |
| Date functions | Completed |
| Date calculations | Completed |
| Conditional aggregation | Completed |
| Messy-data challenge | Completed |
| Week 3 checkpoint | Passed |

---

## NULL Handling

### Find NULL values:
```sql
SELECT name, department, bonus FROM employee
WHERE bonus IS NULL;
```

### Find non-NULL values:
```sql
WHERE bonus IS NOT NULL
```

### Replace NULL:
```sql
COALESCE(bonus, 0)
```

### COALESCE + Calculations
```sql
salary + COALESCE(bonus, 0) AS total_compensation
```
Without COALESCE, a NULL bonus can make an arithmetic result NULL.

---

## CASE WHEN
```sql
CASE
WHEN salary >= 70000 THEN 'Senior Pay' 
WHEN salary >= 50000 THEN 'Mid Pay' 
ELSE 'Entry'
END AS salary_level
```
CASE conditions are checked top-to-bottom. Avoid overlapping ranges.

---

## Data Type Conversion
```sql
CAST(unit_price AS DECIMAL(10,2))
```
Use CAST before calculations when numeric data is stored as text.

---

## String Cleaning

| Function | Purpose |
| :--- | :--- |
| TRIM() | Remove leading/trailing spaces |
| UPPER() | Uppercase |
| LOWER() | Lowercase |
| REPLACE() | Replace text |
| CONCAT() | Join strings |
| LEFT() | Get left characters |
| SUBSTRING() | Extract part of text |

### Example:
```sql
UPPER(TRIM(city)) AS cleaned_city
```

---

## Numeric Functions
* `ROUND(value, 2)` -> round to decimals
* `CEIL(value)` -> round upward
* `FLOOR(value)` -> round downward
* `ABS(value)` -> absolute value

---

## Date Functions
```sql
EXTRACT(YEAR FROM order_date)
EXTRACT(MONTH FROM order_date)
EXTRACT(DAY FROM order_date)
```
* **PostgreSQL delivery calculation:** `delivery_date - order_date`
* **MySQL** commonly uses `DATEDIFF();`
* **SQL Server** uses `DATEDIFF(DAY, ...).`

---

## Conditional Aggregation
```sql
COUNT(CASE WHEN delivery_date - order_date > 5 THEN order_id END) AS slow_orders
```
This counts only rows meeting the condition. Week 3 used this for delivery performance.

* **Fast** -> ≤ 3 days
* **Normal** -> > 3 and ≤ 5 days
* **Slow** -> > 5 days

*Common mistake:* overlapping conditions can cause the same row to be counted in multiple categories.

---

## Messy Data Challenge
The `customer_data` table contained extra spaces, inconsistent city casing, NULL ages, and spending stored as text.

* `TRIM(customer_name)`
* `UPPER(TRIM(city))`
* `COALESCE(CAST(spending AS DECIMAL(10,2)), 0)`
* `CASE WHEN` for spending levels
* `WHERE` using cleaned spending
* `GROUP BY/HAVING` with cleaned expressions

---

## Important Patterns

| Business need | SQL pattern |
| :--- | :--- |
| Find missing | WHERE column IS NULL |
| Replace missing | COALESCE(column, 0) |
| Create categories | CASE WHEN ... THEN ... ELSE ... END |
| Convert text number | CAST(column AS DECIMAL(10,2)) |
| Standardize city | UPPER(TRIM(city)) |
| Conditional count | COUNT(CASE WHEN condition THEN id END) |
| Delivery days | delivery_date - order_date |
