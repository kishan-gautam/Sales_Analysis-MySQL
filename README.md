# Sales_Analysis-MySQL
Sales Analysis project using MySQL with 9 BI queries.

## 📌 Overview
A Sales Analysis project built using MySQL, simulating a real retail
business scenario inspired by my previous work experience in the
retail industry. The project covers database design, data insertion,
and 9 business intelligence analysis queries.

---

## 🗄️ Database Structure

| Table | Description | Records |
|---|---|---|
| `customers_info` | Stores customer details | 15 rows |
| `product_info` | Stores product catalog | 12 rows |
| `sales_info` | Stores sales transactions | 12 rows |

### Relationships
- `sales_info` connects to `customers_info` via `Customers_Id` (Foreign Key)
- `sales_info` connects to `product_info` via `Product_Id` (Foreign Key)

---

## 🔧 Key Features
- Relational database design with **Foreign Keys**
- Auto-calculated **Total** column using `GENERATED ALWAYS AS`
- **ENUM** constraints for Gender and Order Status
- **AUTO_INCREMENT** starting from 1111 for Product IDs
- **TIMESTAMP** for automatic customer registration tracking

---

## 📊 Business Analysis Queries

| # | Business Question |
|---|---|
| 1 | What is the total sales from delivered orders? |
| 2 | Which city generates the most sales? |
| 3 | Top 3 highest sales generating products? |
| 4 | Which product category contributes most to total sales? |
| 5 | How many orders are Delivered, Inprocess, or Cancelled? |
| 6 | Who are the top 3 most valuable customers? |
| 7 | Which products were never sold? (Dead Stock) |
| 8 | Do male or female customers spend more? |
| 9 | How much sales value was lost from cancellations? |

---

## 🛠️ Tools Used
- MySQL 8.0
- MySQL Workbench

---

## 💡 SQL Concepts Used
- `CREATE DATABASE` / `CREATE TABLE`
- `PRIMARY KEY` / `FOREIGN KEY`
- `AUTO_INCREMENT` / `GENERATED ALWAYS AS`
- `ENUM` / `DECIMAL` / `TIMESTAMP`
- `INSERT INTO` / `SELECT`
- `JOIN` / `LEFT JOIN`
- `GROUP BY` / `ORDER BY` / `LIMIT`
- `SUBQUERIES`
- `CASE WHEN`
- Aggregate Functions — `SUM()`, `COUNT()`, `ROUND()`

---

## 📁 Files
| File | Description |
|---|---|
| `sales_analysis.sql` | Complete SQL script — setup, data, and analysis |
| `README.md` | Project documentation |

---

## 🚀 How to Run
1. Open **MySQL Workbench**
2. Open `sales_analysis.sql`
3. Run the full script top to bottom
4. All tables, data, and analysis queries will execute automatically

---
