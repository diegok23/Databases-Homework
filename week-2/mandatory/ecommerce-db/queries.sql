--1. Retrieve all the customers names and addresses who lives in United States
SELECT name, address 
FROM customers 
WHERE country='United States';

--2. Retrieve all the customers ordered by ascending name
SELECT * FROM customers
ORDER BY name;

