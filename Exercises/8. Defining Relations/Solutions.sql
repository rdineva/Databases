CREATE DATABASE pc2
USE pc2

---1---
--a/
CREATE TABLE Product (
  maker CHAR(4),
  model CHAR(1),
  type VARCHAR(7)
)

CREATE TABLE Printer (
  code INT,
  model CHAR(4),
  price DECIMAL(10, 2)
)

--b/
INSERT INTO Product
VALUES
('AAAA', '1', 'printer'),
('BBBB', '2', 'printer'),
('CCCC', '3', 'laptop'),
('DDDD', '4', 'pc')

INSERT INTO Printer
VALUES
(1, 'AAAA', 10.23),
(2, 'BBBB', 10.23),
(3, 'CCCC', 10.23),
(4, 'DDDD', 10.23)

--c/
ALTER TABLE Printer 
ADD type VARCHAR(6) CHECK (type IN ('laser', 'matrix', 'jet'))

ALTER TABLE Printer
ADD color CHAR(1) CHECK (color IN ('y', 'n')) NOT NULL DEFAULT('n')

--d/
ALTER TABLE Printer
DROP COLUMN price

--e/
DROP TABLE Printer
DROP TABLE Product
DROP DATABASE pc2

---2---
CREATE DATABASE Facebook
USE Facebook

CREATE TABLE Users (
  id INT UNIQUE NOT NULL,
  email VARCHAR(35) NOT NULL,
  password VARCHAR(100) NOT NULL,
  regdate DATETIME DEFAULT GETDATE()
)

CREATE TABLE Friends (
  person1 INT NOT NULL,
  person2 INT NOT NULL
)

CREATE TABLE Walls (
  userId INT NOT NULL,
  wrtiterUserId INT NOT NULL,
  message VARCHAR(255),
  date DATETIME DEFAULT GETDATE()
)

CREATE TABLE Groups (
  id INT UNIQUE NOT NULL,
  name VARCHAR(25) NOT NULL,
  description VARCHAR(255) DEFAULT('')
)

CREATE TABLE GroupMembers (
  groupId INT NOT NULL,
  userId INT NOT NULL
)