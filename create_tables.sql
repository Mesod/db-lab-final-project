-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;

-- Drop table

-- DROP TABLE imdb_db.dbo.age_group GO

CREATE TABLE imdb_db.dbo.age_group (
	id int NOT NULL IDENTITY(0,1),
	min_age int NULL,
	max_age int NULL,
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT age_group_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.country GO

CREATE TABLE imdb_db.dbo.country (
	id int NOT NULL IDENTITY(0,1),
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT country_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.critic GO

CREATE TABLE imdb_db.dbo.critic (
	id int NOT NULL IDENTITY(0,1),
	first_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT critic_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.actor GO

CREATE TABLE imdb_db.dbo.actor (
	id int NOT NULL IDENTITY(0,1),
	first_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT actor_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.author GO

CREATE TABLE imdb_db.dbo.author (
	id int NOT NULL IDENTITY(0,1),
	first_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT author_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.director GO

CREATE TABLE imdb_db.dbo.director (
	id int NOT NULL IDENTITY(0,1),
	first_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT director_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.[file] GO

CREATE TABLE imdb_db.dbo.[file] (
	id int NOT NULL IDENTITY(0,1),
	[type] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT file_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.[language] GO

CREATE TABLE imdb_db.dbo.[language] (
	id int NOT NULL IDENTITY(0,1),
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT language_PK PRIMARY KEY (id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.[user] GO

CREATE TABLE imdb_db.dbo.[user] (
	id int NOT NULL IDENTITY(0,1),
	username varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	password varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT user_PK PRIMARY KEY (id),
	CONSTRAINT user_UN UNIQUE (username)
) GO
CREATE UNIQUE INDEX user_UN ON imdb_db.dbo.[user] (username) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.movie GO

CREATE TABLE imdb_db.dbo.movie (
	id int NOT NULL IDENTITY(0,1),
	imdb_code varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	produced_in int NULL,
	director_id int NULL,
	CONSTRAINT movie_PK PRIMARY KEY (id),
	CONSTRAINT movie_UN UNIQUE (imdb_code),
	CONSTRAINT movie_FK FOREIGN KEY (produced_in) REFERENCES imdb_db.dbo.country(id),
	CONSTRAINT movie_FK_1 FOREIGN KEY (director_id) REFERENCES imdb_db.dbo.director(id)
) GO
CREATE UNIQUE INDEX movie_UN ON imdb_db.dbo.movie (imdb_code) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.movie_suitable_for GO

CREATE TABLE imdb_db.dbo.movie_suitable_for (
	movie_id int NOT NULL,
	age_group_id int NULL,
	CONSTRAINT movie_suitable_for_FK FOREIGN KEY (age_group_id) REFERENCES imdb_db.dbo.age_group(id),
	CONSTRAINT movie_suitable_for_FK_1 FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.critic_review GO

CREATE TABLE imdb_db.dbo.critic_review (
	critic_id int NOT NULL,
	movie_id int NOT NULL,
	score int NOT NULL,
	CONSTRAINT critic_review_FK FOREIGN KEY (critic_id) REFERENCES imdb_db.dbo.critic(id),
	CONSTRAINT critic_review_FK_1 FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.actor_plays GO

CREATE TABLE imdb_db.dbo.actor_plays (
	movie_id int NOT NULL,
	actor_id int NOT NULL,
	CONSTRAINT actor_plays_FK FOREIGN KEY (actor_id) REFERENCES imdb_db.dbo.actor(id),
	CONSTRAINT actor_plays_FK_1 FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.author_write GO

CREATE TABLE imdb_db.dbo.author_write (
	movie_id int NOT NULL,
	author_id int NULL,
	CONSTRAINT author_write_FK FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id),
	CONSTRAINT author_write_FK_1 FOREIGN KEY (author_id) REFERENCES imdb_db.dbo.author(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.collection GO

CREATE TABLE imdb_db.dbo.collection (
	id int NOT NULL IDENTITY(0,1),
	user_id int NOT NULL,
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT collection_PK PRIMARY KEY (id),
	CONSTRAINT collection_FK FOREIGN KEY (user_id) REFERENCES imdb_db.dbo.[user](id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.collection_movie GO

CREATE TABLE imdb_db.dbo.collection_movie (
	collection_id int NOT NULL,
	movie_id int NOT NULL,
	CONSTRAINT collection_movie_FK FOREIGN KEY (collection_id) REFERENCES imdb_db.dbo.collection(id),
	CONSTRAINT collection_movie_FK_1 FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.film GO

CREATE TABLE imdb_db.dbo.film (
	id int NOT NULL IDENTITY(0,1),
	movie_id int NOT NULL,
	CONSTRAINT film_PK PRIMARY KEY (id),
	CONSTRAINT film_FK FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.series GO

CREATE TABLE imdb_db.dbo.series (
	id int NOT NULL IDENTITY(0,1),
	movie_id int NOT NULL,
	CONSTRAINT series_PK PRIMARY KEY (id),
	CONSTRAINT series_FK FOREIGN KEY (movie_id) REFERENCES imdb_db.dbo.movie(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.season GO

CREATE TABLE imdb_db.dbo.season (
	id int NOT NULL IDENTITY(0,1),
	series_id int NOT NULL,
	name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT season_PK PRIMARY KEY (id),
	CONSTRAINT season_FK FOREIGN KEY (series_id) REFERENCES imdb_db.dbo.series(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.episode GO

CREATE TABLE imdb_db.dbo.episode (
	id int NOT NULL IDENTITY(0,1),
	season_id int NOT NULL,
	CONSTRAINT episode_PK PRIMARY KEY (id),
	CONSTRAINT episode_FK FOREIGN KEY (season_id) REFERENCES imdb_db.dbo.season(id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.film_file GO

CREATE TABLE imdb_db.dbo.film_file (
	id int NOT NULL IDENTITY(0,1),
	file_id int NOT NULL,
	film_id int NOT NULL,
	CONSTRAINT film_file_PK PRIMARY KEY (id),
	CONSTRAINT film_file_FK FOREIGN KEY (film_id) REFERENCES imdb_db.dbo.film(id),
	CONSTRAINT film_file_FK_1 FOREIGN KEY (file_id) REFERENCES imdb_db.dbo.[file](id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.series_file GO

CREATE TABLE imdb_db.dbo.series_file (
	id int NOT NULL IDENTITY(0,1),
	file_id int NOT NULL,
	episode_id int NOT NULL,
	CONSTRAINT series_file_PK PRIMARY KEY (id),
	CONSTRAINT series_file_FK FOREIGN KEY (episode_id) REFERENCES imdb_db.dbo.episode(id),
	CONSTRAINT series_file_FK_1 FOREIGN KEY (file_id) REFERENCES imdb_db.dbo.[file](id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.user_watches GO

CREATE TABLE imdb_db.dbo.user_watches (
	user_id int NOT NULL,
	file_id int NOT NULL,
	CONSTRAINT user_watches_FK FOREIGN KEY (user_id) REFERENCES imdb_db.dbo.[user](id),
	CONSTRAINT user_watches_FK_1 FOREIGN KEY (file_id) REFERENCES imdb_db.dbo.[file](id)
) GO

-- Drop table

-- DROP TABLE imdb_db.dbo.subtitle GO

CREATE TABLE imdb_db.dbo.subtitle (
	file_id int NOT NULL,
	language_id int NOT NULL,
	CONSTRAINT subtitle_FK FOREIGN KEY (language_id) REFERENCES imdb_db.dbo.[language](id),
	CONSTRAINT subtitle_FK_1 FOREIGN KEY (file_id) REFERENCES imdb_db.dbo.[file](id)
) GO;
