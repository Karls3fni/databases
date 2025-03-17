-- A transaction in database management is a sequence of operations that are executed as a single unit of work.
-- Transactions are crucial in maintaining data integrity and consistency

use sakila;
START TRANSACTION;

-- 1. Insert a new rental record
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 5, 3, NULL, 1);

-- 2. Update the film's availability by inserting into the rental table
-- (In Sakila, inventory availability is checked using joins rather than stored directly)
-- However, we can simulate tracking inventory by inserting a rental record.

-- 3. Commit the transaction
COMMIT;
