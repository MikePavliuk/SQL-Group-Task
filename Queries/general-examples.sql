-------------------------------------------------------------------------------------------
-- Print unique names of employees.
SELECT DISTINCT name
FROM rp.worker;
-------------------------------------------------------------------------------------------
-- Display information about the CEO of the store
-- (CEO does not obey anyone - empty field manager_id)
SELECT *
FROM rp.worker
WHERE manager_id IS NULL;
-------------------------------------------------------------------------------------------
-- Display information about the three cheapest products.
SELECT *
FROM rp.product
ORDER BY price limit 3;
-------------------------------------------------------------------------------------------
-- Display all checks stamped since 12 am (which day is not important).
SELECT *
FROM rp.order
WHERE hour(date) >= 12;
-------------------------------------------------------------------------------------------
-- Print all checks stamped this year.
SELECT *
FROM rp.order
WHERE year(date) = year(CURRENT_DATE ());
-------------------------------------------------------------------------------------------
-- Print the names of the customers whose name begins with the letter "A".
SELECT name
FROM rp.customer
WHERE name LIKE 'A%';
-------------------------------------------------------------------------------------------
-- Display information about the product, the name of which begins with "IPhone".
SELECT *
FROM rp.product
WHERE title LIKE "IPhone%";
-------------------------------------------------------------------------------------------
-- Sort products by descending price.
SELECT *
FROM rp.product
ORDER BY price DESC;
-------------------------------------------------------------------------------------------
-- Display the employee and his manager
-- (4 columns - employee's name and surname and then his/her manager's name and surname).
SELECT a.name,
	a.surname,
	b.name,
	b.surname
FROM rp.worker a,
	rp.worker b
WHERE a.manager_id = b.id;