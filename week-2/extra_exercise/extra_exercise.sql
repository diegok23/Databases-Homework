CREATE TABLE customers (
  id      SERIAL PRIMARY KEY,
  name    VARCHAR(30) NOT NULL,
  coordX	INT,
  coordY	INT
);

CREATE TABLE restaurants (
  id        SERIAL PRIMARY KEY,
  name      varchar(120) NOT NULL,
  coordX    INT,
  coordY    INT,
  address   VARCHAR(120),
  postcode  VARCHAR(10),
  city      VARCHAR(25),
  country   VARCHAR(25),
  foodType  VARCHAR(120),
  prepTime  INT
);

CREATE TABLE food (
  id            SERIAL PRIMARY KEY,
  restaurant_id INT REFERENCES restaurants(id),
  foodType      VARCHAR(120) NOT NULL,
  foodName      VARCHAR(120) NOT NULL,
  prepTime      INT
);

CREATE TABLE orders (
  id              SERIAL PRIMARY KEY,
  customer_id     INT REFERENCES customers(id),
  order_date      DATE NOT NULL
  );

CREATE TABLE order_items (
  id          SERIAL PRIMARY KEY,
  order_id    INT REFERENCES orders(id),
  food_id     INT REFERENCES food(id),
  quantity    INT NOT NULL
);

INSERT INTO customers (name, coordX, coordY) VALUES 
('Eduard B.', 3, 95),
('David V.', 15, 57),
('Diego K.', 23, 23);

INSERT INTO restaurants (name,coordx,coordy,foodtype,address,postcode,city,country,preptime) VALUES
  ('El pájaro loco',54,81,'pizza','Av. Republica Argentina 2','8229','Barcelona','Spain',1300),
  ('El correcaminos',7,60,'pasta, pizza','C. Valencia 590','8226','Barcelona','Spain',2400),
  ('La pantera rosa',33,75,'meat','Xifrè 74','8026','Barcelona','Spain',1750),
  ('DragonBall',108,5,'sushi','Independencia 33','8001','Barcelona','Spain',1100),
  ('El pepino',108,33,'vegetarian','Independencia 77','8002','Barcelona','Spain',1500),
  ('El pibe',77,24,'argentinian, meat','Cartagena 54','8033','Barcelona ','Spain',3000),
  ('Vegeshi',12,41,'vegetarian, sushi','Rogent 12','8026','Barcelona','Spain',1000),
  ('El Pulpo Manotas',61,100,'fish','A coruña 24','8026','Barcelona','Spain',700);
  
INSERT INTO food (restaurant_id, foodType,      foodName,                prepTime) VALUES
  (1,             'Pizza',       'Pizza Margarita',       10),
  (1,             'Pizza',       'Pizza Pepperonni',      15),
  (2,             'Pasta',       'Ravioli Bolognesa',     20),
  (2,             'Pasta',       'Spaguetti Carbonara',   17),
  (2,             'Pizza',       'Pizza Margarita',       25),
  (2,             'Pizza',       'Pizza BBQ',             27),
  (3,             'Meat',        'Bistec',                25),
  (3,             'Meat',        'Bitoque',               30),
  (3,             'Meat',        'Steak au poivre',       27),
  (4,             'Sushi',       'Tasting Menu',          20),
  (5,             'Vegetarian',  'Veggi BBQ',             35),
  (5,             'Vegetarian',  'Salad 1',               13),
  (5,             'Vegetarian',  'Salad 2',               17),
  (5,             'Vegetarian',  'Salad 3',               18),
  (6,             'Argentinian', 'Parrilada 2 Personas',  25),
  (6,             'Argentinian', 'Parrilada 4 Personas',  30),
  (6,             'Argentinian', 'Parrilada 6 Personas',  55),
  (6,             'Argentinian', 'Empanadas',             15),
  (7,             'Sushi',       'Temaki Atun',           15),
  (7,             'Sushi',       'Temaki Salmon',         15),
  (7,             'Vegetarian',  'Veggi BBQ',             35),
  (7,             'Vegetarian',  'Salad 1',               13),
  (7,             'Vegetarian',  'Salad 2',               17),
  (7,             'Vegetarian',  'Salad 3',               18),
  (8,             'Fish',        'Salmon a la plancha',   20),
  (8,             'Fish',        'Cazuela de mariscos',   25);

INSERT INTO orders (customer_id, order_date, order_reference) VALUESTYPE OF FOOD
  (1, '2022-07-01', 'ORD_001'),
  (1, '2022-07-15', 'ORD_002'),
  (1, '2022-07-11', 'ORD_003'),
  (1, '2022-07-24', 'ORD_004'),
  (1, '2022-07-30', 'ORD_005'),
  (2, '2022-07-05', 'ORD_006'),
  (2, '2022-07-05', 'ORD_007'),
  (2, '2022-07-23', 'ORD_008'),
  (2, '2022-07-24', 'ORD_009'),
  (2, '2022-07-10', 'ORD_010');

INSERT INTO order_items (order_id, food_id, quantity) VALUES
  ( 1,  5, 1),
  ( 1,  3, 2),
  ( 2,  8, 3),
  ( 2,  9, 1),
  ( 3, 25, 1),
  ( 3, 26, 2),
  ( 4,  1, 1),
  ( 5, 11, 2),
  ( 5, 14, 1),
  ( 6, 22, 3),
  ( 6, 23, 1),
  ( 6, 24, 1),
  ( 6, 21, 3),
  ( 7,  7, 1),
  ( 8,  1, 1),
  ( 8,  2, 1),
  ( 9, 26, 2),
  (10, 17, 1),
  (10, 18, 9);

SELECT name, foodtype, ABS(r.coordX-20) + ABS(r.coordY-30) AS distance FROM restaurants AS r
ORDER BY distance

SELECT r.name, r.foodtype, r.address, ABS(r.coordX-10) + ABS(r.coordY-10) AS distance 
FROM restaurants AS r
WHERE r.foodType LIKE '%pizza'
ORDER BY distance;

SELECT r.name, r.foodtype, r.address, ABS(r.coordX-10) + ABS(r.coordY-10) AS distance, (ABS(r.coordX-10) + ABS(r.coordY-10) + prepTime)/60 AS deliveryTime
FROM restaurants AS r
WHERE r.foodType LIKE '%a%' AND (ABS(r.coordX-10) + ABS(r.coordY-10) + prepTime)/60 < 100
ORDER BY distance;

SELECT r.name, r.foodtype, r.address, (ABS(r.coordX-1) + ABS(r.coordY-1) + prepTime)/60 AS deliveryTime
FROM restaurants AS r
WHERE r.foodtype LIKE '%Pizza%' AND (ABS(r.coordX-10) + ABS(r.coordY-10) < 800)
ORDER BY deliveryTime;

SELECT DISTINCT r.name, f.foodtype FROM restaurants AS r
INNER JOIN food AS f ON r.id=f.restaurant_id

SELECT DISTINCT r.name, f.foodtype, f.foodName, f.prepTime
FROM restaurants AS r
INNER JOIN food AS f ON r.id=f.restaurant_id
WHERE f.foodType LIKE '%Pizza%'

SELECT r.name, f.foodtype, (ROUND(AVG(f.prepTime)))
FROM restaurants AS r
INNER JOIN food AS f ON r.id=f.restaurant_id
GROUP BY r.id, f.foodtype
ORDER BY r.id;

SELECT c.coordX, c.coordY
FROM customers AS c
WHERE c.id = 1 

INSERT INTO orders (customer_id, order_date) VALUES ($1, $2) RETURNING id
INSERT INTO orders (customer_id, order_date) VALUES (1, '2022-07-16') RETURNING id

INSERT INTO order_items (order_id, food_id, quantity) VALUES ($1, $2, $3) 
INSERT INTO order_items (order_id, food_id, quantity) VALUES (32, 2, 1) 

SELECT c.name, r.name, f.foodName, i.quantity, f.prepTime
FROM customers AS c
INNER JOIN orders AS o ON c.id=o.customer_id
INNER JOIN order_items AS i ON o.id=i.order_id
INNER JOIN food AS f ON f.id=i.food_id
INNER JOIN restaurants AS r ON r.id=f.restaurant_id
WHERE o.id=10

SELECT (((ABS(555-55) + ABS(332-1)))/60) + MAX(f.prepTime) AS deliveryTime
FROM customers AS c
INNER JOIN orders AS o ON c.id=o.customer_id
INNER JOIN order_items AS i ON o.id=i.order_id
INNER JOIN food AS f ON f.id=i.food_id
INNER JOIN restaurants AS r ON r.id=f.restaurant_id
WHERE o.id=10



SELECT (ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY}) + f.prepTime)/60 AS deliveryTime
   FROM restaurants AS r
   WHERE r.foodtype LIKE '%${type}%' AND ${distanceCalc} < ${desiredDistance}
   ORDER BY deliveryTime;












   

SELECT MAX(f.prepTime) AS prep, (ABS(r.coordX-333) + ABS(r.coordY-222))/60 AS delivery FROM food AS f
INNER JOIN restaurants AS r ON r.id=f.restaurant_id
WHERE r.id=2 AND f.id IN (3,5)
GROUP BY r.coordX, r.coordY



SELECT (((ABS(r.coordX-10) + ABS(r.coordY-12)))/60) + MAX(f.prepTime) AS deliveryTime
  FROM customers AS c
  INNER JOIN order_items AS i ON o.id=i.order_id
  INNER JOIN food AS f ON f.id=i.food_id
  INNER JOIN restaurants AS r ON r.id=f.restaurant_id
  WHERE o.id=10
  GR