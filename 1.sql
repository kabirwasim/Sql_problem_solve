

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);



-- Insert records for three departments
INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);


/*

Write the SQL query to find the second highest salary

*/

-- -------------------------
-- My Solution
-- -------------------------



SELECT * FROM employees



-----------------------------EACH DEPARTMENT


SELECT
      employee_id,
	  name,
	  department,
	  salary
FROM
(
SELECT
      employee_id,
	  name,
	  department,
	  salary,
	  RANK() OVER(PARTITION BY department ORDER BY salary DESC ) as rn
FROM employees
) as sub
WHERE rn = 2


-----------------------------


SELECT
      employee_id,
	  name,
	  department,
	  salary
FROM
(
SELECT
      employee_id,
	  name,
	  department,
	  salary,
	  RANK() OVER( ORDER BY salary DESC ) as rk
FROM employees 
) as sub
WHERE rk = 2



--ORIGINAL ANS

SELECT *
FROM
(	SELECT *,
	DENSE_RANK() OVER( ORDER BY salary DESC) drn	
	FROM employees
) as subquery
WHERE drn = 2