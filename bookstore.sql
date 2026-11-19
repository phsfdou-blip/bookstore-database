-- Bookstore Database — Phillip's first GitHub portfolio project
-- Meta Database Engineer, Course 1: Introduction to Databases
-- Built and verified Tue Nov 17, 2026 on the iMac (Postgres.app, database phillip).
-- Postgres version: SERIAL instead of MySQL AUTO_INCREMENT.
-- Verified result: 90-day filter returns Dune, Frank Herbert, 3 copies, stock 10.c
-- The Aug 1 order (5 copies) is correctly excluded.

CREATE TABLE books (
  book_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255),
  isbn VARCHAR(13) UNIQUE,
  publisher VARCHAR(255),
  publication_year INT,
  genre VARCHAR(100),
  format VARCHAR(20),
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE,
  total_amount DECIMAL(10,2),
  status VARCHAR(20)
);

CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL,
  book_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- First book: Dune
INSERT INTO books (title, author, isbn, publisher, publication_year, genre, format, price, stock_quantity)
VALUES ('Dune', 'Frank Herbert', '9780441172719', 'Ace Books', 1965, 'Science Fiction', 'paperback', 15.99, 10);

-- Recent order (Nov 10, 2026 — inside 90 days): 3 copies of Dune
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status)
VALUES (1, 101, '2026-11-10', 47.97, 'delivered');
INSERT INTO order_items (order_item_id, order_id, book_id, quantity, unit_price)
VALUES (1, 1, 1, 3, 15.99);

-- Old order (Aug 1, 2026 — outside 90 days): 5 copies of Dune.
-- The filter below must NOT count these.
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status)
VALUES (2, 102, '2026-08-01', 79.95, 'delivered');
INSERT INTO order_items (order_item_id, order_id, book_id, quantity, unit_price)
VALUES (2, 2, 1, 5, 15.99);

-- Query 1: Which books sold the most in the last 90 days, and how many are in stock?
-- Expected: Dune | Frank Herbert | 3 | 10
SELECT books.title, books.author,
       SUM(order_items.quantity) AS copies_sold,
       books.stock_quantity
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN books ON order_items.book_id = books.book_id
WHERE orders.order_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY books.book_id, books.title, books.author, books.stock_quantity
ORDER BY copies_sold DESC;
