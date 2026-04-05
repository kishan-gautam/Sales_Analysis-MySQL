-- ============================================================
-- PROJECT    : Sales Analysis
-- TOOL       : MySQL(Workbench)
-- AUTHOR     : KISHAN GAUTAM
-- DATE       : April 2026
-- DESCRIPTION: A Sales Analysis project simulating a retail
--              business scenario. Includes database setup,
--              data insertion, and BI analysis queries.
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

DROP DATABASE IF EXISTS sales_analysis;
CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;
SET sql_mode = '';


-- ============================================================
-- SECTION 2: TABLE CREATION
-- ============================================================

-- Customer Table
CREATE TABLE IF NOT EXISTS customers_info (
    Customers_Id   INT AUTO_INCREMENT PRIMARY KEY,
    Customers_Name VARCHAR(30) NOT NULL,
    Gender         ENUM('Male', 'Female', 'Others'),
    Age            INT,
    Adresses       VARCHAR(25),
    Email          VARCHAR(30) UNIQUE NOT NULL,
    Created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Product Table
-- Note: Product_Id starts from 1111
CREATE TABLE IF NOT EXISTS product_info (
    Product_Id   INT AUTO_INCREMENT PRIMARY KEY,
    Product_Name VARCHAR(25) UNIQUE,
    Category     VARCHAR(25),
    Price        DECIMAL(10,2) NOT NULL
) AUTO_INCREMENT = 1111;

-- Sales Table
-- Note: Total is auto-calculated from Order_Quantity * Price
CREATE TABLE IF NOT EXISTS sales_info (
    Bill_No           INT AUTO_INCREMENT PRIMARY KEY,
    Customers_Id      INT NOT NULL,
    Product_Id        INT NOT NULL,
    Order_Quantity    INT,
    Price             DECIMAL(10,2) NOT NULL,
    Total             DECIMAL(20,2) GENERATED ALWAYS AS (Order_Quantity * Price) STORED,
    Delivery_Adresses VARCHAR(30) NOT NULL,
    Status            ENUM('Delivered', 'Inprocess', 'Cancel'),
    FOREIGN KEY (Customers_Id) REFERENCES customers_info(Customers_Id),
    FOREIGN KEY (Product_Id)   REFERENCES product_info(Product_Id)
);


-- ============================================================
-- SECTION 3: DATA INSERTION
-- ============================================================

-- Insert Customers (15 records)
INSERT INTO customers_info
    (Customers_Name, Gender, Age, Adresses, Email)
VALUES
    ('Aarav Sharma',     'Male',   28, 'Kathmandu', 'aarav.sharma@gmail.com'),
    ('Sita Thapa',       'Female', 35, 'Pokhara',   'sita.thapa@gmail.com'),
    ('Bikash Rai',       'Male',   22, 'Lalitpur',  'bikash.rai@gmail.com'),
    ('Priya Gurung',     'Female', 30, 'Bhaktapur', 'priya.gurung@gmail.com'),
    ('Rohan Adhikari',   'Male',   45, 'Chitwan',   'rohan.adhikari@gmail.com'),
    ('Anita Bhandari',   'Female', 27, 'Kathmandu', 'anita.bhandari@gmail.com'),
    ('Suresh Karki',     'Male',   33, 'Pokhara',   'suresh.karki@gmail.com'),
    ('Mina Shrestha',    'Female', 29, 'Lalitpur',  'mina.shrestha@gmail.com'),
    ('Dipak Tamang',     'Male',   38, 'Kathmandu', 'dipak.tamang@gmail.com'),
    ('Kabita Limbu',     'Female', 24, 'Dharan',    'kabita.limbu@gmail.com'),
    ('Nabin Poudel',     'Male',   31, 'Kathmandu', 'nabin.poudel@gmail.com'),
    ('Sunita Maharjan',  'Female', 26, 'Bhaktapur', 'sunita.maharjan@gmail.com'),
    ('Rajesh Hamal',     'Male',   42, 'Pokhara',   'rajesh.hamal@gmail.com'),
    ('Puja Bajracharya', 'Female', 23, 'Lalitpur',  'puja.bajracharya@gmail.com'),
    ('Manish Dahal',     'Male',   36, 'Chitwan',   'manish.dahal@gmail.com');

-- Insert Products (12 records | ID starts from 1111)
INSERT INTO product_info
    (Product_Name, Category, Price)
VALUES
    ('WaiWai Noodles',      'FMCG',         25.00),
    ('Mayos Biscuit',       'FMCG',         40.00),
    ('CG Smart TV 32"',     'Electronics',  25000.00),
    ('CG Washing Machine',  'Electronics',  45000.00),
    ('CG Refrigerator',     'Electronics',  55000.00),
    ('Aashirvad Flour 5kg', 'FMCG',         350.00),
    ('CG Rice 10kg',        'FMCG',         850.00),
    ('CG Cement 50kg',      'Construction', 950.00),
    ('CG Solar Panel',      'Energy',       85000.00),
    ('CG Water Heater',     'Electronics',  12000.00),
    ('Olive Oil 1L',        'FMCG',         650.00),
    ('CG Laptop 15"',       'Electronics',  75000.00);

-- Insert Sales (12 records)
INSERT INTO sales_info
    (Customers_Id, Product_Id, Order_Quantity, Price, Delivery_Adresses, Status)
VALUES
    (1,  1111, 5,  25.00,    'Kathmandu', 'Delivered'),
    (2,  1112, 3,  40.00,    'Pokhara',   'Delivered'),
    (3,  1113, 1,  25000.00, 'Lalitpur',  'Delivered'),
    (4,  1114, 1,  45000.00, 'Bhaktapur', 'Inprocess'),
    (5,  1115, 1,  55000.00, 'Chitwan',   'Delivered'),
    (6,  1116, 4,  350.00,   'Kathmandu', 'Delivered'),
    (7,  1117, 2,  850.00,   'Pokhara',   'Cancel'),
    (8,  1118, 10, 950.00,   'Lalitpur',  'Delivered'),
    (9,  1119, 1,  85000.00, 'Kathmandu', 'Inprocess'),
    (10, 1120, 2,  12000.00, 'Dharan',    'Delivered'),
    (11, 1111, 3,  25.00,    'Kathmandu', 'Delivered'),
    (12, 1112, 2,  40.00,    'Bhaktapur', 'Delivered');

-- Verify Data
SELECT * FROM customers_info;
SELECT * FROM product_info;
SELECT * FROM sales_info;


-- ============================================================
-- SECTION 4: BUSINESS ANALYSIS QUERIES
-- ============================================================

-- Query 1: Total Sales from Delivered Orders
-- Business Question: What is the total sales value from delivered orders?
SELECT
    SUM(Total) AS Total_Sales
FROM sales_info
WHERE Status = 'Delivered';


-- Query 2: Total Sales by City
-- Business Question: Which city generates the most sales?
SELECT
    Delivery_Adresses AS City,
    SUM(Total)        AS Total_Sales
FROM sales_info
WHERE Status = 'Delivered'
GROUP BY Delivery_Adresses
ORDER BY Total_Sales DESC;


-- Query 3: Top 3 Highest Sales Generating Products
-- Business Question: Which products make us the most sales?
SELECT
    p.Product_Name,
    p.Category,
    SUM(s.Order_Quantity) AS Units_Sold,
    SUM(s.Total)          AS Total_Sales
FROM sales_info s
JOIN product_info p ON s.Product_Id = p.Product_Id
WHERE s.Status = 'Delivered'
GROUP BY p.Product_Name, p.Category
ORDER BY Total_Sales DESC
LIMIT 3;


-- Query 4: Sales by Product Category with Percentage
-- Business Question: Which category contributes most to total sales?
SELECT
    p.Category,
    SUM(s.Total) AS Total_Sales,
    ROUND(
        SUM(s.Total) * 100.0 /
        (SELECT SUM(Total) FROM sales_info WHERE Status = 'Delivered'), 2
    ) AS Sales_in_Percent
FROM sales_info s
JOIN product_info p ON p.Product_Id = s.Product_Id
WHERE s.Status = 'Delivered'
GROUP BY p.Category
ORDER BY Total_Sales DESC;


-- Query 5: Order Status Summary
-- Business Question: How many orders are Delivered, Inprocess, or Cancelled?
SELECT
    Status,
    COUNT(Bill_No) AS Total_Orders,
    SUM(Total)     AS Total_Value,
    ROUND(COUNT(Bill_No) * 100.0 / (SELECT COUNT(*) FROM sales_info), 2) AS Percentage
FROM sales_info
GROUP BY Status
ORDER BY Total_Orders DESC;


-- Query 6: Top 3 Customers by Total Purchase Value
-- Business Question: Who are our most valuable customers?
SELECT
    c.Customers_Name,
    c.Gender,
    c.Adresses   AS City,
    SUM(s.Total) AS Total_Purchase
FROM sales_info s
JOIN customers_info c ON c.Customers_Id = s.Customers_Id
WHERE s.Status = 'Delivered'
GROUP BY c.Customers_Name, c.Gender, c.Adresses
ORDER BY Total_Purchase DESC
LIMIT 3;


-- Query 7: Products That Were Never Sold
-- Business Question: Which products have zero sales? (Dead Stock)
SELECT
    p.Product_Id,
    p.Product_Name,
    p.Category,
    p.Price
FROM product_info p
LEFT JOIN sales_info s ON s.Product_Id = p.Product_Id
WHERE s.Product_Id IS NULL;


-- Query 8: Sales by Gender with Percentage
-- Business Question: Do male or female customers spend more?
SELECT
    c.Gender,
    SUM(s.Total) AS Total_Sales,
    ROUND(
        SUM(s.Total) * 100.0 /
        (SELECT SUM(Total) FROM sales_info WHERE Status = 'Delivered'), 2
    ) AS Sales_in_Percent
FROM sales_info s
LEFT JOIN customers_info c ON c.Customers_Id = s.Customers_Id
WHERE s.Status = 'Delivered'
GROUP BY c.Gender
ORDER BY Total_Sales DESC;


-- Query 9: Loss from Cancelled Orders
-- Business Question: How much sales value did we lose from cancellations?
SELECT
    COUNT(Bill_No) AS Cancelled_Orders,
    SUM(Total)     AS Total_Loss
FROM sales_info
WHERE Status = 'Cancel';

-- ============================================================
-- END OF SCRIPT
-- ============================================================