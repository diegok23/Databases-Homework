--1. Retrieve all the customers names and addresses who lives in United States
SELECT name, address 
FROM customers 
WHERE country='United States';

--2. Retrieve all the customers ordered by ascending name
SELECT * FROM customers
ORDER BY name;

--3. Retrieve all the products which cost more than 100
SELECT * FROM products
WHERE unit_price > 100;

--4. Retrieve all the products whose name contains the word `socks`
SELECT * FROM products
WHERE product_name LIKE '%socks%';

--5. Retrieve the 5 most expensive products
SELECT * FROM products
ORDER BY unit_price DESC
LIMIT 5;

--6. Retrieve all the products with their corresponding suppliers. The result should only contain the columns `product_name`, `unit_price` and `supplier_name`
SELECT product_name, unit_price, supplier_name
FROM products AS p
INNER JOIN suppliers AS s ON s.id=p.supplier_id;

--7. Retrieve all the products sold by suppliers based in the United Kingdom. The result should only contain the columns `product_name` and `supplier_name`.
SELECT product_name, supplier_name
FROM products AS p
INNER JOIN suppliers AS s ON s.id=p.supplier_id
WHERE s.country='United Kingdom';

--8. Retrieve all orders from customer ID `1`
SELECT * FROM orders
WHERE customer_id=1;

--9. Retrieve all orders from customer named `Hope Crosby`
SELECT *
FROM orders AS o
INNER JOIN customers AS c ON c.id=o.customer_id
WHERE c.name='Hope Crosby';

--10. Retrieve all the products in the order `ORD006`. The result should only contain the columns `product_name`, `unit_price` and `quantity`.
SELECT product_name, unit_price, quantity
FROM products AS p
INNER JOIN order_items AS i ON p.id=i.product_id
INNER JOIN orders AS o ON o.id=i.order_id
WHERE o.order_reference='ORD006';

--11. Retrieve all the products with their supplier for all orders of all customers. The result should only contain the columns `name` (from customer), `order_reference` `order_date`, `product_name`, `supplier_name` and `quantity`.
SELECT name, order_reference, order_date, product_name, supplier_name, quantity
FROM customers AS c
INNER JOIN orders AS o ON c.id=o.customer_id
INNER JOIN order_items AS i ON o.id=i.order_id
INNER JOIN products AS p ON p.id=i.product_id
INNER JOIN suppliers AS s ON s.id=p.supplier_id;

--12. Retrieve the names of all customers who bought a product from a supplier from China.
SELECT name
FROM customers AS c
INNER JOIN orders AS o ON c.id=o.customer_id
INNER JOIN order_items AS i ON o.id=i.order_id
INNER JOIN products AS p ON p.id=i.product_id
INNER JOIN suppliers AS s ON s.id=p.supplier_id
WHERE s.country='China';

-----------------------------

--(STRETCH GOAL Node API) Add a new GET endpoint /products to load all the product names along with their supplier names.

SELECT product_name, supplier_name
FROM products AS p
INNER JOIN suppliers AS s ON s.id=supplier_id;


SELECT * FROM suppliers AS s
INNER JOIN products AS p ON s.id=p.supplier_id 
WHERE s.id=6

SELECT * FROM customers AS c WHERE c.id=1

UPDATE customers SET name = 'a', address = 'b', city = 'c', country = 'd'
WHERE id = 12

SELECT * FROM orders AS o WHERE o.id=13
DELETE FROM orders WHERE id=13

--order references, order dates, product names, unit prices, suppliers and quantities.

SELECT order_reference, order_date, product_name, unit_price, supplier_name, quantity
FROM customers AS c
INNER JOIN orders AS o ON c.id=o.customer_id
INNER JOIN order_items AS i ON o.id=i.order_id
INNER JOIN products AS p ON p.id=i.product_id
INNER JOIN suppliers AS s ON s.id=p.supplier_id
WHERE c.id=1;