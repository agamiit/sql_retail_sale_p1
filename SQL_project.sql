SELECT * FROM retail_sales_analysis;

DROP TABLE IF EXISTS Retail_sales_Analysis;
CREATE TABLE Retail_sales_Analysis (
    transactions_id INT PRIMARY KEY,
    sale_date DATE ,
    sale_time TIME ,
    customer_id INT ,
    gender VARCHAR(10),
    age INT ,
    category VARCHAR(50),
    quantity INT,
    price_per_unit NUMERIC(10,2),
    cogs NUMERIC(10,2),
    total_sale NUMERIC(10,2)
);

--PERFORMING SOME QUERIES REALATED TO DATA CLEANING??

SELECT COUNT(*) FROM retail_sales_analysis;

--CHECKING IF THE COL HAS ANY NULL VALUES??
SELECT * FROM  retail_sales_analysis
WHERE transactions_ID IS NULL;

 --Another mehod of checking multiple NULL values??
SELECT * FROM  retail_sales_analysis
WHERE 
	transactions_ID IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	Gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	COGS IS NULL;

--DELETE THE NULL VALUE RECORDS IN columns
DELETE FROM retail_sales_analysis
WHERE 
	transactions_ID IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	Gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	COGS IS NULL;

--DATA EXPLORATION??

--How many sales we have ??
SELECT COUNT(*) AS total_sales FROM retail_sales_analysis;

--How many customers we have??
SELECT COUNT(customer_id) AS total_customers FROM retail_sales_analysis;

--Data analysis & business key problems 

--My analysis and findings??

--Q1) Write an SQL query to retireve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';

--Q2) Write an SQL query to retireve all transactions where the category is 'Clothing' and the quantity sold is more than 4
--in the month of November??

SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing' 
AND 
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
AND 
quantity >=4;

--Write an SQL query to calculate the total_sales for each category?? IF needed total_orders
SELECT SUM(total_Sale)  as total_sales , category, 
	COUNT(*) AS total_orders
FROM retail_sales_analysis
GROUP BY category;

--Write an SQL query to find the average age of customers who purchased items from the 'Beauty' category??
SELECT ROUND(AVG(age),2)
FROM retail_sales_analysis
WHERE  Category = 'Beauty';

--Write an SQL query to find all the transactions where the Total_sale > 1000??
SELECT * 
FROM retail_sales_analysis
WHERE total_sale >1000;

--Write an SQL query to find all the transactions(transaction_ID) made by each gender in each category??
SELECT 
	gender, 
	category,
	COUNT(*) AS total_trans
FROM retail_sales_analysis
GROUP BY gender,
	category
ORDER BY category;

--Write an SQL query to find the Average sale for each month. Find out best selling month in each year??
SELECT
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	AVG(total_sale) AS Avg_sale
FROM retail_sales_analysis
GROUP BY 1,2
ORDER BY 1,2,3;


--Write an SQL query to find the top 5 customers based on the highest total_sales??
SELECT customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales_analysis
GROUP BY 1
ORDER BY 1,2 ASC
LIMIT 5;

--Write an SQL query to find the number of unique customers who purchased the items from each category??
SELECT 
 	category,
 	COUNT(DISTINCT(customer_id))  AS unique_customers 
FROM retail_sales_analysis
GROUP BY category;

--Write an SQL query to create each shift and number of order (Example Morning <=12 , Afternoon between 12 -7 , Evening < 17)

WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM sale_time)  <=12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS Shift
FROM retail_sales_analysis
)

SELECT 
	shift,
	COUNT(*) AS total_sale
FROM hourly_sale
GROUP BY Shift ;

--END OF PROJECT 
