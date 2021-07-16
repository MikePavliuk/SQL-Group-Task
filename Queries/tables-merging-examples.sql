---------------------------------------------------------------------------------------------------------
-- Print the first name, last name and title of the position for each employee.
SELECT name,
	surname,
	title
FROM rp.worker AS a
JOIN rp.position AS b ON a.position_id = b.id;
---------------------------------------------------------------------------------------------------------
-- Print a product, half or more of which has already been sold
-- (left in the warehouse <= than sold).
SELECT DISTINCT a.title
FROM rp.product AS a
JOIN rp.order_detail AS b ON a.id = b.product_id
WHERE a.quantity <= b.quantity;
---------------------------------------------------------------------------------------------------------
-- Print the date when "CEO got a job" and his/her salary.
SELECT hire_date,
	salary
FROM rp.worker AS a
JOIN rp.position AS b ON a.position_id = b.id
WHERE b.title = 'CEO';
---------------------------------------------------------------------------------------------------------
-- Print id of the checks stamped by managers.
SELECT a.id
FROM rp.order AS a
JOIN rp.worker AS b ON a.worker_id = b.id
JOIN rp.position AS c ON b.position_id = c.id
WHERE c.title = 'manager';
---------------------------------------------------------------------------------------------------------
-- List the names of employees whose first stamped check was on the day of their appointment.
SELECT name,
	surname
FROM rp.worker AS a
JOIN rp.order AS b ON a.id = b.worker_id
WHERE hire_date = DATE (b.date);
---------------------------------------------------------------------------------------------------------
-- Print the name of a product not sold yet.
SELECT a.title
FROM rp.product AS a
LEFT JOIN rp.order_detail AS b ON a.id = b.product_id
WHERE b.product_id IS NULL;
---------------------------------------------------------------------------------------------------------
-- Print the id and date of the check stamped by the youngest employee.
SELECT a.id,
	a.date
FROM rp.order AS a
JOIN rp.worker AS b ON a.worker_id = b.id
WHERE b.age = (
		SELECT min(age)
		FROM rp.worker
		);
---------------------------------------------------------------------------------------------------------
-- Print the id and date of the checks stamped by the employee who works the least in the store.
SELECT a.id,
	a.date
FROM rp.order AS a
JOIN rp.worker AS b ON a.worker_id = b.id
WHERE b.hire_date = (
		SELECT max(hire_date)
		FROM rp.worker
		);
---------------------------------------------------------------------------------------------------------
-- Print all checks stamped to the first customer.
SELECT a.*
FROM rp.order AS a
JOIN rp.customer AS b ON a.customer_id = b.id
WHERE b.id = (
		SELECT min(id)
		FROM rp.customer
		);
---------------------------------------------------------------------------------------------------------
-- Print checks that the buyer is a Vodafone (Ukraine) subscriber (+38050, +38099).
SELECT a.*
FROM rp.order AS a
JOIN rp.customer AS b ON a.customer_id = b.id
WHERE substr(b.phone, 1, 6) IN (
		'+38050',
		'+38099'
		);
---------------------------------------------------------------------------------------------------------
-- Print a full check (with product id and quantity).
SELECT a.id,
	a.date,
	a.customer_id,
	a.worker_id,
	b.product_id,
	b.quantity
FROM rp.order AS a
JOIN rp.order_detail AS b ON a.id = b.order_id;
-----------------------------------
-- Print checks containing two or more items.
SELECT a.*
FROM rp.order AS a
JOIN rp.order_detail AS b ON a.id = b.order_id
GROUP BY a.id
HAVING count(b.id) >= 2;
---------------------------------------------------------------------------------------------------------
-- Print the last name of the customer and the last name of the person who stamped the check.
SELECT a.surname,
	c.surname
FROM rp.customer AS a
JOIN rp.order AS b ON a.id = b.customer_id
JOIN rp.worker AS c ON b.worker_id = c.id;
---------------------------------------------------------------------------------------------------------
-- Print each customer information and the total amount of money he/she spent in the store.
SELECT a.id,
	a.name,
	a.surname,
	sum(c.quantity * d.price) AS Total
FROM rp.customer AS a
JOIN rp.order AS b ON a.id = b.customer_id
JOIN rp.order_detail AS c ON b.id = c.order_id
JOIN rp.product AS d ON c.product_id = d.id
GROUP BY a.id;
---------------------------------------------------------------------------------------------------------
-- Display the number of customers who bought the most expensive product.
SELECT count(DISTINCT a.id) AS Majory
FROM rp.customer AS a
JOIN rp.order AS b ON a.id = b.customer_id
JOIN rp.order_detail AS c ON b.id = c.order_id
JOIN rp.product AS d ON c.product_id = d.id
WHERE d.price = (
		SELECT max(price)
		FROM rp.product
		);
---------------------------------------------------------------------------------------------------------
-- Print employees who have sold each type of available goods.
SELECT a.id,
	a.name,
	a.surname
FROM rp.worker AS a
JOIN rp.order AS b ON a.id = b.worker_id
JOIN rp.order_detail AS c ON b.id = c.order_id
JOIN rp.product AS d ON c.product_id = d.id
GROUP BY a.id
HAVING count(DISTINCT c.product_id) = (
		SELECT count(id)
		FROM rp.product
		);
---------------------------------------------------------------------------------------------------------
-- Print a discount for each customer
-- if the total amount he spent in the store is more than 10,000, he will receive a 3% discount;
-- if from 20,000 to 30,000 - 5%;
-- more than 30,000 - 7%.
SELECT a.id,
	a.name,
	a.surname,
	CASE 
		WHEN sum(c.quantity * d.price) >= 10000
			AND sum(c.quantity * d.price) < 20000
			THEN 3
		WHEN sum(c.quantity * d.price) >= 20000
			AND sum(c.quantity * d.price) < 30000
			THEN 5
		WHEN sum(c.quantity * d.price) >= 30000
			THEN 7
		ELSE 0
		END AS DiscountPercentage
FROM rp.customer AS a
JOIN rp.order AS b ON a.id = b.customer_id
JOIN rp.order_detail AS c ON b.id = c.order_id
JOIN rp.product AS d ON c.product_id = d.id
GROUP BY a.id;