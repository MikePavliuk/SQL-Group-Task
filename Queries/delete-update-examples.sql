-------------------------------------------
-- Delete the product with id = 3.
DELETE
FROM rp.product
WHERE id = 3;
-------------------------------------------
-- Delete the check with id = 2.
DELETE
FROM rp.order
WHERE id = 2;
-------------------------------------------
-- Change the check which id = 6 to 7.
UPDATE rp.order
SET id = 7
WHERE id = 6;
-------------------------------------------
-- Change the position which id = 1 to 10.
UPDATE rp.position
SET id = 10
WHERE id = 1;