

-- Create transactions table
CREATE TABLE transactions (
    user_id INTEGER,
    spend DECIMAL(10, 2),
    transaction_date TIMESTAMP
);

-- Insert data into transactions table
INSERT INTO transactions (user_id, spend, transaction_date) VALUES
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00');




/*
-- UBER DATA ANALYST INTERVIEW QUESTION
Question:
Write a SQL query to obtain the third transaction of every user. 
Output the user id, spend, and transaction date.

*/





SELECT * FROM transaction_2





SELECT
      *
FROM	  
     (
      SELECT 
            user_id,
	        spend,
	        transaction_date,
             ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY spend ) as rn  
      FROM  transaction_2
      ) as x1
      WHERE rn = 3



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Question 2

-- Create product_revenue table
CREATE TABLE product_revenue (
    product_name VARCHAR(255),
    year INTEGER,
    revenue DECIMAL(10, 2)
);



-- Insert sample records
INSERT INTO product_revenue (product_name, year, revenue) VALUES
('Product A', 2022, 10000.00),
('Product A', 2023, 9500.00),
('Product B', 2022, 15000.00),
('Product B', 2023, 14500.00),
('Product C', 2022, 8000.00),
('Product C', 2023, 8500.00),
('Product D', 2022, 12000.00),
('Product D', 2023, 12500.00),
('Product E', 2022, 20000.00),
('Product E', 2023, 19000.00),
('Product F', 2022, 7000.00),
('Product F', 2023, 7200.00),
('Product G', 2022, 18000.00),
('Product G', 2023, 17000.00),
('Product H', 2022, 3000.00),
('Product H', 2023, 3200.00),
('Product I', 2022, 9000.00),
('Product I', 2023, 9200.00),
('Product J', 2022, 6000.00),
('Product J', 2023, 5900.00);

-- Formulate the question




/*
Question:
Find the top 5 products whose revenue has decreased in comparison to the 
previous year (both 2022 and 2023). Return the product name, 
revenue for the previous year, revenue for the current year, 
revenue decreased, and the decreased ratio (percentage).
*/



SELECT * FROM product_revenue;





WITH CTE1
AS
   (
     SELECT
	       product_name,
		   SUM(revenue) as rev_2022
     FROM product_revenue
	 WHERE year = '2022'
	 GROUP BY 1
   ),
CTE2
AS
   (
     SELECT
	       product_name,
		   SUM(revenue) as rev_2023
     FROM product_revenue
	 WHERE year = '2023'
	 GROUP BY 1
   )
SELECT 
      CTE1.product_name,
      CTE1.rev_2022 as previous_year,
	  CTE2.rev_2023 as current_year,
	  ( CTE1.rev_2022 - CTE2.rev_2023 ) as rev_desc ,
      ( ( CTE1.rev_2022 - CTE2.rev_2023 ) / CTE1.rev_2022 ) * 100 as dec_rev_ratio
FROM CTE1 
JOIN CTE2
ON CTE1.product_name = CTE2.product_name
WHERE CTE2 < CTE1




