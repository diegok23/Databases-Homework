SELECT b.checkin_date, b.nights, h.name, h.postcode FROM customers AS c
INNER JOIN bookings AS b ON c.id=b.customer_id 
INNER JOIN hotels AS h ON h.id=b.hotel_id
WHERE c.id=1

SELECT * FROM bookings AS b
WHERE b.hotel_id=1