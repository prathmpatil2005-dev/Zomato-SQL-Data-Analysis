# Zomato SQL Data Analysis

## 📌 Project Overview

This project analyzes a Zomato food delivery dataset using SQL and MySQL.

The main objective of this project is to use SQL queries to explore customer orders, restaurants, menu items, food, revenue, delivery information, and customer behavior.

The project contains multiple business questions that are solved using SQL queries and relational database concepts.

---

## 🛠️ Tools & Technologies

- MySQL
- MySQL Workbench
- SQL

---

## 📂 Dataset Tables

The project uses the following tables:

- `users`
- `restaurants`
- `food`
- `menu`
- `orders`
- `order_details`
- `delivery_partner`

These tables are connected using relevant IDs such as user ID, restaurant ID, food ID, and order ID.

---

## 🎯 Business Questions

The following questions were analyzed using SQL:

1. Selecting the Database
2. Counting the number of rows
3. Finding NULL values
4. Finding the number of orders placed by each customer
5. Finding the restaurant with the most menu items
6. Finding the number of votes and average rating for all restaurants
7. Finding the food sold at the most number of restaurants
8. Finding the restaurant with maximum revenue in May
9. Finding restaurants with sales greater than 1500
10. Finding customers who have never ordered
11. Showing order details of a particular customer within a given date range
12. Finding customer favorite food
13. Finding the most costly restaurants
14. Finding delivery partner compensation
15. Finding the correlation between delivery time and total rating
16. Finding all vegetarian restaurants
17. Finding the minimum and maximum order value for all customers

---

## 🔍 SQL Concepts Used

This project helped me practice the following SQL concepts:

- `SELECT`
- `WHERE`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `DISTINCT`
- `LIMIT`
- `IS NULL`
- `BETWEEN`
- `INNER JOIN`
- `LEFT JOIN`
- Table aliases
- Aggregate functions
- Date functions
- Data filtering
- Relational database analysis

---

## 💡 Example SQL Analysis

### Restaurant Sales Analysis

```sql
SELECT 
    r.r_id,
    r.r_name,
    SUM(o.amount) AS total_sales
FROM restaurants r
JOIN orders o
    ON r.r_id = o.r_id
GROUP BY r.r_id, r.r_name
HAVING SUM(o.amount) > 1500
ORDER BY total_sales DESC;

