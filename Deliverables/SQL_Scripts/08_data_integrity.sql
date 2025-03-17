use sakila;

-- We ensure that each rental has a valid customer
ALTER TABLE rental
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id)
REFERENCES customer (customer_id)
ON DELETE CASCADE;

-- We ensure that if an actor is removed, their relationships with the films are also removed.
ALTER TABLE film_actor
ADD CONSTRAINT fk_actor_id
FOREIGN KEY (actor_id)
REFERENCES actor (actor_id)
ON DELETE CASCADE;

-- The rental dates in the rental table do not follow a correct format or are inconsistent, such as having a rental date that is later than the return date.
DELIMITER //

CREATE TRIGGER check_rental_dates
BEFORE INSERT ON rental
FOR EACH ROW
BEGIN
    IF NEW.rental_date > NEW.return_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de alquiler no puede ser posterior a la fecha de devolución';
    END IF;
END //

DELIMITER ;

-- In the payment table, recording payments without verifying that the full rent amount has been paid correctly could lead to data inconsistencies.
DELIMITER //

CREATE TRIGGER check_payment_amount
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
    DECLARE rental_amount DECIMAL(6,2);
    
    -- Obtener el monto total del alquiler desde la tabla rental
    SELECT amount INTO rental_amount
    FROM rental
    WHERE rental_id = NEW.rental_id;
    
    -- Verificar que el monto del pago no sea mayor que el monto total del alquiler
    IF NEW.amount > rental_amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto del pago no puede ser mayor que el monto del alquiler';
    END IF;
END //

DELIMITER ;
