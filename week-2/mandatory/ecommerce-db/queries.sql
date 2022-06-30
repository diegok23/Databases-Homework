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


