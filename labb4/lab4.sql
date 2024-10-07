CREATE DATABASE lab4;
CREATE TABLE "Warehouses"(
   Code INTEGER,
   Location VARCHAR(255),
   Capacity INTEGER
 );
CREATE TABLE "Boxes" (
  Code     CHAR(4),
  Contents VARCHAR(255),
  Value REAL,
  Warehouse INTEGER
);

INSERT INTO "Warehouses"(code,location,capacity) VALUES(1,'Chicago',3),
                                                       (2,'Chicago',4),
                                                       (3,'New York',7),
                                                       (4,'Los Angeles',2),
                                                       (5,'San Francisco',8);

 INSERT INTO "Boxes"(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3),
                                                          ('4H8P','Rocks',250,1),
                                                          ('4RT3','Scissors',190,4),
                                                          ('7G3H','Rocks',200,1),
                                                          ('8JN6','Papers',75,1),
                                                          ('8Y6U','Papers',50,3),
                                                          ('9J6F','Papers',175,2),
                                                          ('LL08','Rocks',140,4),
                                                          ('P0H6','Scissors',125,1),
                                                          ('P2T6','Scissors',150,2),
                                                          ('TU55','Papers',90,5);
SELECT * FROM "Warehouses";

SELECT * FROM "Boxes" WHERE Value > 150;

SELECT DISTINCT Contents FROM "Boxes";

SELECT Warehouse, COUNT(*) AS BoxCount
FROM "Boxes"
GROUP BY Warehouse;

SELECT Warehouse, COUNT(*) AS BoxCount
FROM "Boxes"
GROUP BY Warehouse
HAVING COUNT(*) > 2;

INSERT INTO "Warehouses"(code, location, capacity)
VALUES (6, 'New York', 3);

INSERT INTO "Boxes"(Code, Contents, Value, Warehouse)
VALUES ('H5RT', 'Papers', 200, 2);

UPDATE "Boxes"
SET Value = Value * 0.85
WHERE Code = (
   SELECT Code
   FROM "Boxes"
   ORDER BY Value DESC
   LIMIT 1 OFFSET 2);

DELETE FROM "Boxes"
WHERE Value < 150;

DELETE FROM "Boxes"
WHERE Warehouse IN (
  SELECT Code FROM "Warehouses" WHERE Location = 'New York')
RETURNING *;