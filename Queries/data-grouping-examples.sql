---------------------------------------------------------------
-- How many goods of each type were sold?
SELECT sum(quantity)
FROM rp.order_detail
GROUP BY product_id;
---------------------------------------------------------------
-- How many orders were made each month during 2021?
-- Months in which there were no purchases - we reject. 
SELECT month(date),
	count(id)
FROM rp.order
WHERE year(date) = 2021
GROUP BY month(date);
---------------------------------------------------------------
-- How many subordinates does each manager have?
SELECT manager_id,
	count(id)
FROM rp.worker
WHERE manager_id IS NOT NULL
GROUP BY manager_id;
---------------------------------------------------------------
-- Print prices of products occurring two or more times.
SELECT price
FROM rp.product
GROUP BY price
HAVING count(id) >= 2;
---------------------------------------------------------------
-- Group customers' numbers by the subscriber's country code
-- (the first three characters) and print these numbers.
SELECT substr(phone, 1, 3) AS CountryCode,
	count(id)
FROM rp.customer
GROUP BY substr(phone, 1, 3);