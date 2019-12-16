CREATE DATABASE IF NOT EXISTS 'imdb_db';

CREATE TABLE User (
    id int NOT NULL PRIMARY KEY,
    email_address varchar(255) NOT NULL UNIQUE,
    password varchar(20),
    
    
);


CREATE TABLE Persons (
  PersonID int,
  LastName varchar(255),
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255)
);
CREATE TABLE Orders (
  OrderID int NOT NULL PRIMARY KEY,
  OrderNumber int NOT NULL,
  PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
);