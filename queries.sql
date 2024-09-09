/*
# Postgresql project
*/

/*
## Create Table:
*/

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10;

/*
## Data Exploration
*/

-- No. of items per category
SELECT
    category,
    COUNT(transaction_id) AS items_per_category
FROM
    retail_sales
GROUP BY
    category

-- No. of unique customers we have
SELECT
    DISTINCT(COUNT(customer_id)) FROM retail_sales ORDER BY customer_id ASC

-- Days with no sale of products
SELECT
    (EXTRACT(DAYS FROM sale_date)) AS working_days
FROM
    retail_sales
GROUP BY
    sale_date
ORDER BY
    sale_date;

/*
## Explore _missing values_:
*/

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR
	age IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

/*
## Handle _missing values_ by averaging:
*/

UPDATE 
    retail_sales
SET
    age = (SELECT AVG(age) FROM retail_sales WHERE age IS NOT NULL)
WHERE
    age is NULL;

/*
## Delete the remaining records with missing values:
*/

DELETE 
    FROM retail_sales
WHERE
    quantity IS NULL;

/*
## Business Problems:
1. Which product category generate the highesh total sales?
2. What are the peak sales times during the day?
3. Which age groups contribute the most to overall sales?
4. How do sales differ between male and female customers?
5. Which customers (by customer_id) are the most valuable in terms of total purchases?
6. What is the profit margin by category (total_sale - cogs)?
7. What is the trend in sales over time (daily, weekly or monthly)?
8. Which product categories have the highest number of items sold?
9. Which days of the week generate the highest sales and profits?
10. What is the average price per unit for each category, and how does it impact sales?
*/

/*
## 1. Which product category generate the highesh total sales?
*/

SELECT 
    category, 
    SUM(total_sale) Total_Sales
FROM
    retail_sales
GROUP BY
    category;

/*
## 2. What are the peak sales times during the day?
*/

SELECT
    EXTRACT(HOUR FROM sale_time) AS Peak_Hours, 
    SUM(total_sale) AS Total_Sales
FROM
    retail_sales
GROUP BY
    Peak_Hours
ORDER BY
    Peak_Hours

/*
## 3. Which age groups contribute the most to overall sales?
*/

SELECT CASE
	WHEN age BETWEEN 18 AND 29 THEN '18-29'
	WHEN age BETWEEN 30 AND 39 THEN '30-39'
	WHEN age BETWEEN 40 AND 49 THEN '40-49'
	ELSE 'Senior Citizen'
END AS Age_Group, SUM(total_sale) AS Overall_Sales
FROM
	retail_sales
GROUP BY
	Age_Group
ORDER BY
	Overall_Sales DESC;

/*
## 4. How do sales differ between male and female customers?
*/

SELECT
    gender,
    SUM(total_sale) AS Overall_Sales,
	category
FROM
	retail_sales
GROUP BY
	gender, category
ORDER BY
	gender;

/*
## 5. Which customers (by customer_id) are the most valuable in terms of total purchases?
*/

-- SELECT customer_id, SUM(total_sale) as Max_spent FROM retail_sales  GROUP BY customer_id ORDER BY Max_spent DESC;
SELECT 
	customer_id,
	SUM(total_sale) as Max_spent 
FROM 
	retail_sales 
GROUP BY 
	customer_id
ORDER BY
	Max_spent DESC
LIMIT 5;

/*
## 6. What is the profit margin by category (total_sale - cogs)?
*/

SELECT
	category,
	SUM(total_sale-(cogs*quantity)) AS profit
FROM
	retail_sales
GROUP BY
	category
ORDER BY
	profit DESC;

/*
## 7. What is the trend in sales over time (daily, weekly or monthly)?
*/

SELECT
	EXTRACT(MONTH FROM sale_date) AS Months,
	SUM (total_sale) as Total_Sale
FROM
	retail_sales
GROUP BY
	Months
ORDER BY
	Months;

SELECT
	EXTRACT(YEAR FROM sale_date) AS Years,
	SUM (total_sale) as Total_Sale
FROM
	retail_sales
GROUP BY
	Years
ORDER BY
	Years;

/*
## 8. Which product categories have the highest number of items sold?
*/

SELECT
	category,
	SUM(quantity) AS Items_sold
FROM
	retail_sales
GROUP BY
	category
ORDER BY
	Items_sold DESC;

/*
## 9. Which days of the week generate the highest sales and profits?
*/

SELECT
    TO_CHAR(sale_date, 'Day') AS day_of_week,
    SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY
    day_of_week
ORDER BY
    total_sales DESC;

SELECT
    TO_CHAR(sale_date, 'Day') AS day_of_week,
    SUM(total_sale - (cogs * quantity)) AS total_profit
FROM
    retail_sales
GROUP BY
    day_of_week
ORDER BY
    total_profit DESC;

/*
## 10. What is the average price per unit for each category, and how does it impact sales?
*/

SELECT
	category,
	AVG(price_per_unit) AS Avg_price_by_category,
	AVG(total_sale) AS Avg_sales_by_category
FROM
	retail_sales
GROUP BY
	category
ORDER BY
	Avg_price_by_category DESC;