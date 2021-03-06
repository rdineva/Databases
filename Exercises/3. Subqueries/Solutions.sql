USE movies

--1--
SELECT NAME AS name
FROM MOVIEEXEC
WHERE NETWORTH>10000000 
AND NAME IN (
  SELECT NAME
  FROM MOVIESTAR
  WHERE GENDER='F'
)

--2--
SELECT NAME AS name
FROM MOVIESTAR
WHERE name NOT IN (
  SELECT NAME
  FROM MOVIEEXEC
) 

--3--
SELECT TITLE AS title
FROM MOVIE
WHERE LENGTH > (
  SELECT LENGTH
  FROM MOVIE
  WHERE TITLE='Star Wars'
)

--4--
SELECT m.TITLE AS title, e.NAME AS name
FROM MOVIEEXEC e
JOIN MOVIE m ON e.CERT#=m.PRODUCERC#
  WHERE NETWORTH > (
  SELECT NETWORTH 
  FROM MOVIEEXEC
  WHERE NAME='Merv Griffin'
)


USE pc

--1--
SELECT maker
FROM product
WHERE model IN (
  SELECT model
  FROM pc
  WHERE speed > 500
)
--2--
SELECT TOP(2) code, model, price
FROM printer
ORDER BY price DESC

--3--
SELECT *
FROM laptop
WHERE speed < ALL (
  SELECT speed 
  FROM pc
)

--4--
SELECT TOP(1) *
FROM (
  SELECT model, price 
  FROM printer
  WHERE price >= ALL (
    SELECT price
    FROM printer
  )
  UNION
  SELECT model, price
  FROM pc
  WHERE price >= ALL (
    SELECT price
    FROM pc
  )
  UNION
  SELECT model, price
  FROM laptop
  WHERE price >= ALL (
    SELECT price
    FROM laptop
  )
) t
ORDER BY price DESC

--5--
SELECT maker
FROM product
WHERE model = (
  SELECT TOP(1) model
  FROM printer
  WHERE color='y'
  ORDER BY price ASC
)

--6--
SELECT maker
FROM product
WHERE model IN (
  SELECT TOP(2) model
  FROM pc
  ORDER BY ram ASC, speed DESC 
)


USE ships

--1--
SELECT DISTINCT(COUNTRY)
FROM CLASSES
WHERE NUMGUNS >= ALL (
  SELECT NUMGUNS
  FROM CLASSES
)

--2--
SELECT DISTINCT(CLASS)
FROM SHIPS
WHERE NAME IN (
  SELECT SHIP
  FROM OUTCOMES
  WHERE RESULT='sunk'
)

--3--
SELECT NAME AS name, c.CLASS AS class
FROM CLASSES c
JOIN SHIPS s
ON s.CLASS=c.CLASS
WHERE BORE='16'

--4--
SELECT BATTLE AS battle
FROM OUTCOMES
WHERE SHIP IN (
  SELECT NAME
  FROM SHIPS
  WHERE CLASS='Kongo'
)

--5-- correct but hardcoded
SELECT *
FROM CLASSES AS c
JOIN SHIPS s
ON s.CLASS=c.CLASS
WHERE c.CLASS IN (
  SELECT CLASS
  FROM CLASSES
  WHERE BORE=15
  AND NUMGUNS >= ALL (
    SELECT NUMGUNS
    FROM CLASSES
    WHERE BORE=15
  )
  UNION
  SELECT CLASS
  FROM CLASSES
  WHERE BORE=14
  AND NUMGUNS >= ALL (
    SELECT NUMGUNS
    FROM CLASSES
    WHERE BORE=14
  )
  UNION
  SELECT CLASS
  FROM CLASSES
  WHERE BORE=16
  AND NUMGUNS >= ALL (
    SELECT NUMGUNS
    FROM CLASSES
    WHERE BORE=16
  )
  UNION
  SELECT CLASS
  FROM CLASSES
  WHERE BORE=18
  AND NUMGUNS >= ALL (
    SELECT NUMGUNS
    FROM CLASSES
    WHERE BORE=18
  )
)