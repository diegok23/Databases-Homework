CREATE TABLE customers (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  email     VARCHAR(120) NOT NULL,
  address   VARCHAR(120),
  city      VARCHAR(30),
  postcode  VARCHAR(12),
  country   VARCHAR(20)
);

CREATE TABLE hotels (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  rooms     INT NOT NULL,
  postcode  VARCHAR(12)
);

CREATE TABLE bookings (
  id               SERIAL PRIMARY KEY,
  customer_id      INT REFERENCES customers(id),
  hotel_id         INT REFERENCES hotels(id),
  checkin_date     DATE NOT NULL,
  nights           INT NOT NULL
);

INSERT INTO customers (name,        email,                  address,       city,       postcode, country)
               VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');
INSERT INTO hotels (name,                 rooms, postcode)
               VALUES ('Triple Point Hotel', 10, 'CM194JS');
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights)
               VALUES (1, 1, '2019-10-01', 2);
INSERT INTO customers (name,         email,           address,      city,     postcode, country)
               VALUES ('Diego Kogut','diego@ivan.org','Acacias 666','Manresa','08000','Spain');
               SELECT * FROM hotels;
               SELECT * FROM customers;

INSERT INTO hotels (name,                 rooms, postcode)
               VALUES ('Royal Cosmos Hotel',  5, 'TR209AX'),
                      ('Pacific Petal Motel', 15, 'BN180TG');

SELECT * FROM hotels WHERE rooms > 7;
SELECT name,address FROM customers;
SELECT * FROM hotels WHERE rooms > 7;
SELECT name,address FROM customers WHERE id = 1;
SELECT * FROM bookings WHERE checkin_date > '2019/10/01';
SELECT * FROM bookings WHERE checkin_date > '2019/10/01' AND nights >= 2;
SELECT * FROM hotels WHERE postcode = 'CM194JS' OR postcode = 'TR209AX';



Class 2

--Exercise in class 1

ALTER TABLE customers ADD COLUMN date_of_birth DATE;
ALTER TABLE customers RENAME COLUMN date_of_birth TO birthdate;
ALTER TABLE customers DROP COLUMN birthdate;

DROP TABLE customers;

--Exercise in class 2

CREATE TABLE test ();
DROP TABLE test;
UPDATE customers SET name='Bob Marley', country='Jamaica' WHERE id=3;
SELECT * FROM customers;

--Exercise in class 3

--3.1
UPDATE hotels SET postcode='L10XYZ' WHERE name='Elder Lake Hotel';
--3.2
UPDATE hotels SET rooms=25 WHERE name='Cozy Hotel';
--3.3
UPDATE customers SET address='2 Blue Street', city='Glasgow', postcode='G11ABC' WHERE name='Nadia Sethuraman';
--3.4
UPDATE bookings SET nights=5 WHERE customer_id=1 AND hotel_id=1

SELECT * FROM bookings WHERE customer_id=1;
SELECT COUNT(*) FROM bookings WHERE customer_id=1 AND hotel_id=1;
SELECT COUNT(*) FROM bookings WHERE customer_id=1 AND hotel_id!=1;

--Exercise in class 4
--4.1
DELETE FROM bookings WHERE customer_id=8 AND checkin_date='2020-01-03';
--4.2
DELETE FROM bookings WHERE customer_id=6;
--4.3
DELETE FROM customers WHERE id=6;

--Exercise in class 5
--5.2
SELECT * FROM customers 
INNER JOIN bookings ON customers.id=bookings.customer_id 
WHERE bookings.checkin_date>'2020-01-01';

--5.3
SELECT c.name, b.checkin_date AS checkInDate, b.nights 
FROM customers AS c
INNER JOIN bookings AS b ON c.id=b.customer_id 
INNER JOIN hotels AS h ON h.id=b.hotel_id 
WHERE h.name='Jade Peaks Hotel';

--5.4
SELECT c.name, b.checkin_date, h.name 
FROM bookings AS b
INNER JOIN customers AS c ON c.id=b.customer_id
INNER JOIN hotels AS h ON h.id=b.hotel_id 
WHERE b.nights>=5;

--Exercise 6 (at home)
--6.1
SELECT name FROM customers WHERE name LIKE 'S%';
--6.2
SELECT name FROM hotels WHERE name LIKE '%Hotel%';
--6.3
SELECT b.checkin_date, c.name, h.name
FROM bookings AS b
INNER JOIN customers AS c ON b.customer_id=c.id
INNER JOIN hotels AS h ON b.hotel_id=h.id
ORDER BY b.nights DESC
LIMIT 5;


/*  Teacher's notes:

1.  lo que nos piden: customer names, booking start dates and number of nights => customers, bookings
    condiciones: for all customers who booked the hotel name Jade Peaks Hotel => customers, bookings, hotels
2.  como se relacionan: bookings.customer_id=customers.id, hotels.id=bookings.hotel_id
3.  Condición: => hotel name: Jade Peaks Hotel 
4.  ALIAS!
5.  lo que nos piden => escribir con alias las columnas a devolver.
6.  [opcional!] alias en la respuesta
 */
