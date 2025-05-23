
CREATE TABLE Orders_ (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

DROP TABLE IF EXISTS Returns;
CREATE TABLE Returns_ (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders_(OrderID)
);

INSERT INTO Orders_ (OrderID, OrderDate, TotalAmount) VALUES
(1, '2023-01-15', 150.50),
(2, '2023-02-20', 200.75),
(3, '2023-02-28', 300.25),
(4, '2023-03-10', 180.00),
(5, '2023-04-05', 250.80);

INSERT INTO Returns_ (ReturnID, OrderID) VALUES
(101, 2),
(102, 4),
(103, 5),
(104, 1),
(105, 3);


/*

Given the Orders table with columns OrderID, 
OrderDate, and TotalAmount, and the 
Returns table with columns ReturnID and OrderID, 

write an SQL query to calculate the total 
numbers of returned orders for each month

*/


SELECT
	   EXTRACT(MONTH FROM orderdate) AS month_,
       SUM(TotalAmount) as amt,      
	   COUNT(ReturnID) as rn
FROM orders_ as o
LEFT JOIN returns_ as r
ON o.OrderID = r.OrderID
GROUP BY month_ 
ORDER BY rn DESC

