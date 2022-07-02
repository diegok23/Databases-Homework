CREATE TABLE customers (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(30) NOT NULL,
  coordX	INT,
  coordY	INT
);

CREATE TABLE hotels (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(120) NOT NULL,
  coordX	INT,
  coordY	INT
);

INSERT INTO customers (name, coordX, coordY) VALUES ('Eduard B.', 3, 95);
INSERT INTO customers (name, coordX, coordY) VALUES ('Diego K.', 23, 23);
INSERT INTO restaurants (name, coordX, coordY) VALUES ('El pájaro loco', 54, 81);
INSERT INTO restaurants (name, coordX, coordY) VALUES ('El correcaminos', 7, 60);


SELECT name, foodtype, ABS(r.coordX-20) + ABS(r.coordY-30) AS distance FROM restaurants AS r
ORDER BY distance

ALTER TABLE public.restaurants ADD foodtype varchar(120) NULL;
ALTER TABLE public.restaurants ADD address varchar(120) NULL;
ALTER TABLE public.restaurants ADD postcode numeric(5) NULL;
ALTER TABLE public.restaurants ADD city varchar(25) NULL;
ALTER TABLE public.restaurants ADD country varchar(25) NULL;


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