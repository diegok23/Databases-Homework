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


