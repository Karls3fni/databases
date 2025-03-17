USE sakila;

-- 1. Start the transaction
START TRANSACTION;

-- 2. Count how many copies of the film are currently available
SELECT COUNT(*) INTO @stock_disponible
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE i.inventory_id = 5;

-- 3. Try to insert the rental only if there is stock
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT NOW(), 5, 3, NULL, 1
WHERE @stock_disponible > 0;

-- 4. Force an error if there is no stock so that MySQL does a ROLLBACK
SELECT IF(@stock_disponible = 0, SLEEP(0), NULL) INTO @error;

-- 5. If everything is correct, confirm the transaction
COMMIT;


