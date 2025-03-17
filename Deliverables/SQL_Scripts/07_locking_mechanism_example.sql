
-- Pessimistic locking assumes that conflicts between users accessing the same data are likely to occur
-- so it locks records to prevent any other user from modifying the data until the lock is released.

-- Optimistic locking, on the other hand, assumes that conflicts are rare, and users can work independently without blocking each other.

CREATE TABLE cuentas_bancarias (
    id INT PRIMARY KEY,
    saldo DECIMAL(10, 2),
    moneda VARCHAR(10),
    version INT -- Columna para bloquear de manera optimista
);

INSERT INTO cuentas_bancarias (id, saldo, moneda, version)
VALUES (1, 1000.00, 'USD', 1);

-- User A
START TRANSACTION;
SELECT saldo FROM cuentas_bancarias WHERE id = 1 FOR UPDATE;
UPDATE cuentas_bancarias SET saldo = saldo + 100 WHERE id = 1;
COMMIT;

-- User B
START TRANSACTION;
SELECT saldo FROM cuentas_bancarias WHERE id = 1;
UPDATE cuentas_bancarias SET saldo = saldo - 50 WHERE id = 1;
COMMIT;

