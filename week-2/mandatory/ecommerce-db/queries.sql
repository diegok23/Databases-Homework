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


