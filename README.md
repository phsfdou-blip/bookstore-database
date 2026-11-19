# Bookstore Database — Phillip's First GitHub Portfolio Project

> Built in Meta Database Engineer, Course 1: Introduction to Databases (Day 1, Nov 15, 2026).
> Status: tables built Tue Nov 17 on the iMac — all three CREATE TABLEs ran, Dune + 2 sample orders inserted, 90-day filter returned Dune, Frank Herbert, 3 copies, stock 10. Project runs end to end.
> Posted to GitHub Wed Nov 18, 2026 as a public repo.

## What it is

A small bookstore database, designed in Meta Database Engineer Course 1
(Introduction to Databases). It answers one business question — which books sold
the most, and do we have enough in stock?

Day 1 result: 100% on the first quiz (pass mark 80%).

## The schema (Phillip's own design)

Three tables. One order can hold many books, and one book can appear in many
orders, so Order_Items is the junction table in the middle (many-to-many).

- Books — book_id (PK), title, author, isbn (UNIQUE, 13 digits), publisher,
  publication_year, genre, format, price, stock_quantity
- Orders — order_id (PK), customer_id, order_date, total_amount, status
- Order_Items — order_item_id (PK), order_id (FK), book_id (FK), quantity,
  unit_price — the price at the time of purchase

## Build it — PostgreSQL (Phillip's own machine)

Same tables as MySQL, one change: SERIAL PRIMARY KEY instead of
INT AUTO_INCREMENT PRIMARY KEY. On the iMac: Postgres.app, database phillip,
no password, prompt phillip=#.

## Verified result

Query 1 (which books sold the most in the last 90 days, and how many are in
stock) returns one row: Dune, Frank Herbert, 3 copies, stock 10. The Aug 1
order (5 copies) is correctly excluded.

## What I learned

- Table vs record: a table holds all the records of one kind; a record is one row.
- CRUD: Create = INSERT, Read = SELECT, Update = UPDATE, Delete = DELETE.
- SQL execution order: FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT.
- MySQL vs Postgres: in MySQL a schema is the database; in Postgres a schema is
  a folder inside a database (tables live in public).

## Next steps

1. Design the Customers table.
2. Next Coursera lab: design the mobile-devices table in cm_devices.
