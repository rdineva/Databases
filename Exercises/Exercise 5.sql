USE pc

--1--
SELECT  ROUND(AVG(speed),2) AS AvgSpeed
FROM pc

--2--
SELECT p.maker, AVG(l.screen) AS AvgScreen
FROM laptop AS l
JOIN product AS p
ON p.model=l.model
GROUP BY p.maker

--3--
SELECT AVG(speed) AS AvgSpeed
FROM laptop
WHERE price > 1000

--4--
SELECT pr.maker, ROUND(AVG(price),2) AS AvgPrice
FROM pc AS pc
JOIN product AS pr
ON pr.model=pc.model
WHERE pr.maker='A'
GROUP BY pr.maker

--5--
SELECT maker, AVG(price) AS AvgPrice
FROM (
  SELECT maker, price
  FROM pc AS pc
  JOIN product AS pr
  ON pr.model=pc.model
  WHERE pr.maker='B'
  UNION ALL
  SELECT maker, price
  FROM laptop AS l
  JOIN product AS pr
  ON l.model=pr.model
  WHERE pr.maker='B'
) AS a
GROUP BY maker

--6--
SELECT speed, AVG(price) AS AvgPrice
FROM pc
GROUP BY speed

--7--
SELECT maker, COUNT(pc.code) AS number_of_pc
FROM product AS pr
JOIN pc AS pc
ON pc.model=pr.model
GROUP BY maker
HAVING COUNT(pc.code)>=3

--8--
SELECT TOP(1) maker, MAX(price) AS price
FROM product AS pr
JOIN pc AS pc
ON pc.model=pr.model
GROUP BY maker

--9--
SELECT speed, AVG(price) AS AvgPrice
FROM pc
WHERE speed > 800
GROUP BY speed

--10--
SELECT maker, AVG(hd) AS AgvHDD
FROM pc AS pc
JOIN product AS pr
ON pr.model=pc.model
WHERE pr.maker IN (
  SELECT maker
  FROM product
  WHERE type='PC'
  INTERSECT
  SELECT maker
  FROM product
  WHERE type='Printer'
)
GROUP BY maker


USE ships

--1--
SELECT COUNT(*) AS NO_Classes
FROM CLASSES
WHERE TYPE='bb'

--2--
SELECT CLASS AS class, AVG(NUMGUNS) AS avgGuns 
FROM CLASSES
WHERE TYPE='bb'
GROUP BY CLASS

--3--
SELECT AVG(NUMGUNS) AS avgGuns
FROM CLASSES
WHERE TYPE='bb'

--4--
SELECT 
  c.CLASS AS class,
  MIN(s.LAUNCHED) AS FirstYear,
  MAX(s.LAUNCHED) AS LastYear
FROM CLASSES AS c
JOIN SHIPS AS s
ON s.CLASS=c.CLASS
GROUP BY c.CLASS

--5--
SELECT CLASS AS class, COUNT(*) AS No_Sunk
FROM SHIPS AS s
JOIN OUTCOMES AS o
ON o.SHIP=s.NAME
WHERE o.RESULT='sunk'
GROUP BY CLASS

--6--
SELECT s.CLASS AS class, COUNT(*) AS No_Sunk
FROM SHIPS AS s
JOIN OUTCOMES AS o
ON o.SHIP=s.NAME
WHERE o.RESULT='sunk' AND
 s.CLASS IN (
 SELECT CLASS FROM SHIPS
 GROUP BY CLASS
 HAVING COUNT(*) > 2
)  
GROUP BY s.CLASS

--7--
SELECT 
  COUNTRY AS country,
  AVG(BORE) AS avg_bore
FROM CLASSES
GROUP BY COUNTRY