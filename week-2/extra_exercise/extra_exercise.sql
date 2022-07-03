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

INSERT INTO customers (name, coordX, coordY) VALUES ('Eduard B.', 3, 95);
INSERT INTO customers (name, coordX, coordY) VALUES ('Diego K.', 23, 23);

INSERT INTO restaurants (name,coordx,coordy,foodtype,address,postcode,city,country,preptime) VALUES
  ('El pájaro loco',54,81,'pizza','Av. Republica Argentina 2','8229','Barcelona','Spain',1300),
  ('El correcaminos',7,60,'pasta, pizza','C. Valencia 590','8226','Barcelona','Spain',2400),
  ('La pantera rosa',33,75,'meat','Xifrè 74','8026','Barcelona','Spain',1750),
  ('DragonBall',108,5,'sushi','Independencia 33','8001','Barcelona','Spain',1100),
  ('El pepino',108,33,'vegetarian','Independencia 77','8002','Barcelona','Spain',1500),
  ('El pibe',77,24,'argentinian, meat','Cartagena 54','8033','Barcelona ','Spain',3000),
  ('Vegeshi',12,41,'vegetarian, sushi','Rogent 12','8026','Barcelona','Spain',1000),
  ('El Pulpo Manotas',61,100,'fish','A coruña 24','8026','Barcelona','Spain',700);
  

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
WHERE r.foodtype LIKE '%a%' AND (ABS(r.coordX-1) + ABS(r.coordY-1) < 800)
ORDER BY deliveryTime;