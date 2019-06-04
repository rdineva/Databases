----Views----

USE Flights
GO

--1--
CREATE VIEW v_airline_info
AS 
	SELECT 
	f.airline_operator AS airline_operator,
	f.fnumber AS flight_number,
	SUM(b.customer_id) AS passengersCount
	FROM Flight AS f
	JOIN Airline AS a
	ON a.code=f.airline_operator
	JOIN Booking AS b
	ON b.flight_number=f.fnumber
	WHERE b.status=1
	GROUP BY f.airline_operator, f.fnumber

--2--
CREATE VIEW v_agency_most_reservations
AS 
	SELECT TOP(1) COUNT(c.id) AS customerId
	FROM Agency AS a
	JOIN Booking AS b
	ON b.agency=a.name
	JOIN Customer AS c
	ON c.id=b.customer_id
	GROUP BY c.id
	ORDER BY c.id DESC

--3--
CREATE VIEW v_agencies_sofia
AS 
	SELECT *
	FROM Agency
	WHERE city='Sofia'
WITH CHECK OPTION

--4--
CREATE VIEW v_agencies_nullphone
AS
	SELECT *
	FROM Agency
	WHERE phone IS NULL
WITH CHECK OPTION


USE movies
GO

--6--
CREATE VIEW RichExec
AS
	SELECT 
	NAME, ADDRESS, CERT#, NETWORTH
	FROM MOVIEEXEC
	WHERE NETWORTH >= 10000000

--7--
CREATE VIEW ExecutiveStar
AS 
	SELECT
	ms.NAME, ms.ADDRESS, ms.GENDER, ms.BIRTHDATE,
	me.CERT#, me.NETWORTH
	FROM MOVIESTAR AS ms
	JOIN MOVIEEXEC AS me
	ON me.NAME=ms.NAME

--9--
SELECT NAME
FROM ExecutiveStar
WHERE GENDER='F'

--10--
SELECT NAME
FROM ExecutiveStar
WHERE NETWORTH >= 5000000

--11--
DROP VIEW ExecutiveStar
DROP VIEW RichExec

