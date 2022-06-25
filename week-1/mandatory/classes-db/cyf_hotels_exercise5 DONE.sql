SELECT * FROM customers WHERE name = 'Laurence Lebihan';
SELECT * FROM customers WHERE country = 'UK';
SELECT address, city, postcode FROM customers WHERE name = 'Melinda Marsh';
SELECT * FROM hotels WHERE postcode = 'DGQ127';
SELECT * FROM hotels WHERE rooms > 11;
SELECT * FROM hotels WHERE rooms > 6 AND rooms < 15;
SELECT * FROM hotels WHERE rooms = 10 OR rooms = 20;
SELECT * FROM bookings WHERE customer_id = 1;
SELECT * FROM bookings WHERE nights > 4;
SELECT * FROM bookings WHERE checkin_date > '2020/01/01';
SELECT * FROM bookings WHERE checkin_date > '2020/01/01' AND nights < 4;

