
CREATE DATABASE lab10;

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INT
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT REFERENCES Books(book_id),
    customer_id INT,
    order_date DATE,
    quantity INT
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);


INSERT INTO Books (book_id, title, author, price, quantity)
VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);


INSERT INTO Customers (customer_id, name, email)
VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

-- Task 1
BEGIN TRANSACTION;

INSERT INTO Orders(order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1 AND quantity >= 2;

COMMIT;

-- Task 2
BEGIN TRANSACTION;

DO $$
    BEGIN
        IF (SELECT quantity FROM Books WHERE book_id = 3)>=10 THEN
            INSERT INTO Orders(order_id, book_id, customer_id, order_date, quantity)
            VALUES (2,3,102,CURRENT_DATE,10);

            UPDATE Books
            SET quantity = quantity - 10
            WHERE book_id = 3;
        ELSE
            ROLLBACK ;
        END IF;
END $$;
-- Task 3
-- Session 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION;
UPDATE Books
SET price = 45.00
WHERE book_id = 1;

COMMIT;

-- Session 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION;
SELECT price FROM Books WHERE book_id = 1;

COMMIT;

-- Task 4
BEGIN TRANSACTION;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

SELECT * FROM Customers WHERE customer_id = 101;
