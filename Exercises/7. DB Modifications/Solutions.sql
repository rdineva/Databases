USE movies

--1--
INSERT INTO MOVIESTAR(NAME, BIRTHDATE)
VALUES 
('Nicole Kidman', CONVERT(VARCHAR, '1967-06-20 00:00:00'))

--2--
DELETE FROM MOVIEEXEC
WHERE NETWORTH < 30000000

--3--
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL


USE pc

--4--
INSERT INTO product(type, model, maker)
VALUES ('pc','1100', 'C')

INSERT INTO pc(model, speed, ram, hd, cd, price, code)
VALUES('1100', '2400', '2048', '500', '52x', '299', '12')

--5--
DELETE FROM pc
WHERE model='1100' 

--6--
DELETE FROM laptop
WHERE model IN (
  SELECT model FROM product
  WHERE maker NOT IN (
    SELECT maker FROM product
    WHERE type='Printer' 
  )
)

--7--
UPDATE product
SET maker='A'
WHERE maker='B'

--8--
UPDATE pc
SET price-=price*0.2, hd+=20

--9--
UPDATE laptop
SET screen+=1
WHERE model IN (
  SELECT model
  FROM product
  WHERE maker='A'
)


USE ships

--10--
INSERT INTO CLASSES(CLASS, TYPE, BORE, DISPLACEMENT, COUNTRY)
VALUES ('Nelson', 'bb', '16', '34000', 'Gt. Britain')

INSERT INTO SHIPS(NAME, CLASS, LAUNCHED)
VALUES
('Nelson', 'Nelson', 1927),
('Rodney', 'Nelson', 1927)

--11--
DELETE FROM SHIPS
WHERE NAME IN (
  SELECT SHIP
  FROM OUTCOMES
  WHERE RESULT='sunk'
)

--12--
UPDATE CLASSES
SET BORE*=2.5, DISPLACEMENT*=1.1
