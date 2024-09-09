# Online Retail Analytics

## 1. Dataset:
- The dataset comprises of 2,000 rows and 11 columns.
- Out
- The dataset store the transaction records from 01-January-2022 to 31-December-2023.
- There are 155 unique customers.
- The store has 3 different categories of products:
    - Beauty
    - Clothing
    - Electronics

---

## Overview

This project involves analyzing retail sales data stored in a PostgreSQL database. The focus is on querying the `retail_sales` table to answer various business questions and explore sales trends.

## Database Schema

### Table: `retail_sales`

```sql
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

## Data Exploration

### 1. Which product category generates the highest total sales?

> Electronics

### 2. What are the peak sales times during the day?

> After 4 p.m.

### 3. Which age groups contribute the most to overall sales?

> Senior Citizens

### 4. How do sales differ between male and female customers?

> Male customers tend to spend more on electronics

> Female customers tend to spend more on Clothing

### 5. Which customers (by customer_id) are the most valuable in terms of total purchases?

> Customer_id 3

### 6. What is the profit margin by category (total_sale - cogs)?

> Clothing: 1,43,949
> Electronics: 1,42,040
> Beauty: 1,37,473

### 7. What is the trend in sales over time (monthly, yearly)?

> Monthly Sales increased by 37,988 every month

> Yearly Sales increased by 6,070

### 8. Which product categories have the highest number of items sold?

> Clothing: 1,785
> Electronics: 1,698
> Beauty: 1,535

### 9. Which days of the week generate the highest sales and profits?

> Highest Sales by Day of the Week - Sunday (1,53,800)

> Highest Profits by Day of the Week - Monday (71,644)


### 10. What is the average price per unit for each category, and how does it impact sales?

> Average price by category:
> Beauty - 184.56 | Electronics - 181.901 | Clothing - 174.494

> Average sales by category:
> Beauty - 468.693 | Electronics - 458.787 | Clothing - 443.752

## Notes

- Ensure that the PostgreSQL server is running and accessible.
- Replace any placeholder values with actual data or parameters as needed.
- The above queries provide insights into various aspects of sales and customer behavior.

---
