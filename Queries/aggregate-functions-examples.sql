-----------------------------------------------------------
-- Which employee works in the store the longest?
SELECT name,
	surname
FROM rp.worker
WHERE hire_date = (
		SELECT min(hire_date)
		FROM rp.worker
		);
-----------------------------------------------------------
-- Display the product with the highest quantity in stock.
SELECT title,
	quantity
FROM rp.product
WHERE quantity = (
		SELECT max(quantity)
		FROM rp.product
		);
-----------------------------------------------------------
-- Print the average salary of all available positions.
SELECT avg(salary)
FROM rp.position;
-----------------------------------------------------------
-- How many employees got a job in 2017?
SELECT count(id)
FROM rp.worker
WHERE year(hire_date) = 2017;