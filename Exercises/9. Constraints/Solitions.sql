--1--
--USE master DROP DATABASE Flights
CREATE DATABASE Flights
GO
USE Flights

CREATE TABLE Airline (
  code VARCHAR(15) NOT NULL,
  name VARCHAR(50) NOT NULL,
  country VARCHAR(30) NOT NULL,

  CONSTRAINT pk_airline PRIMARY KEY (code),
  CONSTRAINT uq_country_airline UNIQUE (name)
)
GO

CREATE TABLE Airport (
  code VARCHAR(15) NOT NULL,
  name VARCHAR(50) NOT NULL,
  country VARCHAR(30) NOT NULL,
  city VARCHAR(30) NOT NULL,

  CONSTRAINT pk_airport PRIMARY KEY(code),
  CONSTRAINT uq_country_airport UNIQUE (name, country)
)
GO

CREATE TABLE Airplane (
  code VARCHAR(15) NOT NULL,
  type VARCHAR(15),
  seats INT NOT NULL,
  year DATETIME,

  CONSTRAINT pk_airplane PRIMARY KEY(code),
  CHECK (seats > 0)
)
GO

CREATE TABLE Flight (
  fnumber VARCHAR(15) NOT NULL,
  airline_operator VARCHAR(15) NOT NULL,
  dep_airport VARCHAR(15) NOT NULL,
  arr_airport VARCHAR(15) NOT NULL,
  flight_time DATETIME NOT NULL,
  flight_duration INT,
  airplane VARCHAR(15) NOT NULL,

  CONSTRAINT pk_flight PRIMARY KEY (fnumber),
  CONSTRAINT fk_airline_operator FOREIGN KEY (airline_operator) REFERENCES Airline(code) ON DELETE NO ACTION,
  CONSTRAINT fk_dep_airport FOREIGN KEY (dep_airport) REFERENCES Airport(code) ON DELETE NO ACTION,
  CONSTRAINT fk_arr_airport FOREIGN KEY (arr_airport) REFERENCES Airport(code) ON DELETE NO ACTION,
  CONSTRAINT fk_airplane FOREIGN KEY (airplane) REFERENCES Airplane(code) ON DELETE NO ACTION,
)
GO

CREATE TABLE Customer (
  id INT NOT NULL,
  fname VARCHAR(30) NOT NULL,
  lname VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,

  CONSTRAINT pk_customer PRIMARY KEY (id),
  CHECK (email LIKE '%@%' AND email LIKE '%.%' AND DATALENGTH(email) >= 6)
)
GO

CREATE TABLE Agency (
  name VARCHAR(50) NOT NULL,
  country VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  phone VARCHAR(30)

  CONSTRAINT pk_agency PRIMARY KEY (name)
)
GO

CREATE TABLE Booking (
  code VARCHAR(15) NOT NULL,
  agency VARCHAR(50) NOT NULL,
  airline_code VARCHAR(15) NOT NULL,
  flight_number VARCHAR(15) NOT NULL,
  customer_id INT NOT NULL,
  booking_date DATETIME DEFAULT GETDATE(),
  flight_date DATETIME NOT NULL,
  price DECIMAL(10, 2),
  status INT,

  CONSTRAINT pk_booking PRIMARY KEY (code),
  CONSTRAINT fk_agency FOREIGN KEY (agency) REFERENCES Agency(name) ON DELETE NO ACTION,
  CONSTRAINT fk_airline_code FOREIGN KEY (airline_code) REFERENCES Airline(code) ON DELETE NO ACTION,
  CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE NO ACTION,
  CHECK (flight_date >= booking_date),
  CHECK (status IN (0, 1))
)
GO

--SEED DATA--

INSERT INTO AIRLINE
VALUES ('AZ', 'Alitalia', 'Italy'),
('BA', 'British Airways', 'United Kingdom'),
('LH', 'Lufthansa', 'Germany'),
('SR', 'Swissair', 'Switzerland'),
('FB', 'Bulgaria Air', 'Bulgaria'),
('AF', 'Air France', 'France'),
('TK', 'Turkish Airlines', 'Turkey'),
('AA', 'American Airlines', 'United States');
INSERT INTO AIRPORT
VALUES ('SOF', 'Sofia International', 'Bulgaria', 'Sofia'),
('CDG', 'Charles De Gaulle', 'France', 'Paris'),
('ORY', 'Orly', 'France', 'Paris'),
('LBG', 'Le Bourget', 'France', 'Paris'),
('JFK', 'John F Kennedy International', 'United States', 'New York'),
('ORD', 'Chicago O''Hare International', 'United States', 'Chicago'),
('FCO', 'Leonardo da Vinci International', 'Italy', 'Rome'),
('LHR', 'London Heathrow', 'United Kingdom', 'London');
INSERT INTO AIRPLANE
VALUES ('319', 'Airbus A319', 150, 1993),
('320', 'Airbus A320', 280, 1984),
('321', 'Airbus A321', 150, 1989),
('100', 'Fokker 100', 80, 1991),
('738', 'Boeing 737-800', 90, 1997),
('735', 'Boeing 737-800', 90, 1995);
INSERT INTO FLIGHT
VALUES ('FB1363', 'AZ', 'SOF', 'ORY', '12:45', 100, '738'),
('FB1364', 'AZ', 'CDG', 'SOF', '10:00', 120, '321'),
('SU2060', 'AZ', 'LBG', 'SOF', '11:10', 110, '738'),
('SU2061', 'TK', 'SOF', 'JFK', '13:00', 110, '320'),
('FB363', 'FB', 'SOF', 'ORD', '15:10', 110, '738'),
('FB364', 'FB', 'LHR', 'SOF', '21:05', 120, '738');
INSERT INTO CUSTOMER
VALUES (1, 'Petar', 'Milenov', 'petter@mail.com'),
(2, 'Dimitar', 'Petrov', 'petrov@mail.com'),
(3, 'Ivan', 'Ivanov', 'ivanov@mail.com'),
(4, 'Petar', 'Slavov', 'slavov@mail.com'),
(5, 'Bogdan', 'Bobov', 'bobov@mail.com');
INSERT INTO AGENCY
VALUES ('Travel One', 'Bulgaria', 'Sofia', '0783482233'),
('Travel Two', 'Bulgaria', 'Plovdiv', '02882234'),
('Travel Tour', 'Bulgaria', 'Sofia', NULL),
('Aerotravel', 'Bulgaria', 'Varna', '02884233');
INSERT INTO BOOKING
VALUES ('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 0),
('YA298P', 'Travel Two', 'FB', 'FB1364', 2, '2013-12-18', '2013-12-25', 300, 1),
('YB298P', 'Travel Tour', 'FB', 'SU2060', 3, '2014-01-18', '2014-02-25', 400, 0),
('YC298P', 'Travel One', 'FB', 'SU2061', 4, '2014-11-11', '2014-11-25', 350, 0),
('YD298P', 'Travel Tour', 'FB', 'FB363', 1, '2013-11-03', '2013-12-20', 250, 1),
('YE298P', 'Aerotravel', 'FB', 'FB364', 2, '2013-11-07', '2013-12-21', 150, 0);