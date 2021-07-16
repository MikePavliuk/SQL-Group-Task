---------------------------------------------------------------------------
-- How many checks were stamped between March 1, 2021 and March 31, 2021?
-- Replace the column name with “OrderQuantity”.
SELECT count(id) AS OrderQuantity
FROM rp.order
WHERE date BETWEEN '2021-03-01'
		AND '2021-03-31';
---------------------------------------------------------------------------
-- Print the total number of all available products.
-- Replace the column name with “TotalQuantity”.
SELECT sum(quantity) AS TotalQuantity
FROM rp.product;
---------------------------------------------------------------------------
-- Print the possible earnings for each type of product, 
-- based on its available quantity and unit price.
-- Let the column be named "TotalProfit".
SELECT (price * quantity) AS TotalProfit
FROM rp.product;
---------------------------------------------------------------------------
-- How many employees of each age work in the store?
-- Display the age and number of employees of a given age.
-- Name the column “WorkersQuantity”.
SELECT age,
	count(id) AS WorkersQuantity
FROM rp.worker
GROUP BY age;