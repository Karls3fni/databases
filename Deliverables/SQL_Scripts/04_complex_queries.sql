use sakila;

-- Write an SQL script that
-- Lists all customers who have rented a film in the last 30 days.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, r.rental_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= CURDATE() - INTERVAL 30 DAY;

--  Identifies the most rented film in the database.
SELECT f.film_id, f.title, COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY total_alquileres DESC
LIMIT 1;

-- Displays the total revenue generated per store
SELECT s.store_id, SUM(p.amount) AS ingresos_totales
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

