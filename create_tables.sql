CREATE DATABASE
IF NOT EXISTS 'imdb_db';

CREATE TABLE country
(
  id int NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL
);

CREATE TABLE movie
(
  id int NOT NULL PRIMARY KEY,
  imdb_code varchar(30) NOT NULL UNIQUE,
  country_id int FOREIGN KEY REFERENCES country(id),
);

CREATE TABLE age_group
(
  id int NOT NULL PRIMARY KEY,
  min_age int NOT NULL,
  max_age int NOT NULL,
  name varchar(30)
);

CREATE TABLE movie_suitable_for
(
  id int NOT NULL PRIMARY KEY,
  movie_id int FOREIGN KEY REFERENCES movie(id),
  age_group_id int FOREIGN KEY REFERENCES age_group(id)
);

CREATE TABLE critic
(
  id int NOT NULL PRIMARY KEY,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL
);

CREATE TABLE critic_reviews
(
  id int NOT NULL PRIMARY KEY,
  movie_id int FOREIGN KEY REFERENCES movie(id),
  critic_id int FOREIGN KEY REFERENCES critic(id)
  -- TODO: add score with range
);

CREATE TABLE user
(
  id int NOT NULL PRIMARY KEY,
  email_address varchar(255) NOT NULL UNIQUE,
  password varchar(20)
);
