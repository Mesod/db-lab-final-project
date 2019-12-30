CREATE FUNCTION dbo.movie_finder(
	@actor1 VARCHAR(100),
	@actor2 VARCHAR(100)
)

RETURNS VARCHAR(100)
AS
SELECT DISTINCT(m.name)
FROM imdb_db.dbo.actor AS a
JOIN imdb_db.dbo.actor_plays AS p
ON a.id = p.actor_id
JOIN imdb_db.dbo.movie AS m
ON p.movie_id = m.id
WHERE a.first_name IN (actor1, actor2)
AND m.director_id IN (
	SELECT m2.director_id
	FROM imdb_db.dbo.movie AS m2
	GROUP BY m2.director_id
	HAVING COUNT(id) = 1
)

