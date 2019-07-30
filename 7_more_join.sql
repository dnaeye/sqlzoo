/* Q1
List the films where the yr is 1962 [Show id, title]. */

SELECT id, title
FROM movie
WHERE yr = 1962

/* Q2
Give year of 'Citizen Kane'. */

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

/* Q3
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words 
Star Trek in the title). Order results by year. */

SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER by yr

/* Q4
What id number does the actor 'Glenn Close' have? */

SELECT id
FROM actor
WHERE name = 'Glenn Close'

/* Q5
What is the id of the film 'Casablanca'. */

SELECT id
FROM movie
WHERE title = 'Casablanca'

/* Q6
Obtain the cast list for 'Casablanca'. */

SELECT name
FROM actor
JOIN casting
  ON actor.id = actorid
JOIN movie
  ON movieid = movie.id
WHERE movieid = 11768

/* Q7
Obtain the cast list for the film 'Alien'. */

SELECT name
FROM actor
JOIN casting
  ON actor.id = actorid
JOIN movie
  ON movieid = movie.id
WHERE title = 'Alien'

/* Q8
List the films in which 'Harrison Ford' has appeared. */

SELECT title
FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'

/* Q9
List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */

SELECT title
FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
  AND casting.ord <> 1

/* Q10
List the films together with the leading star for all 1962 films. */

SELECT title, actor.name
FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE yr = 1962
  AND ord = 1

/* Q11
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year 
for any year in which he made more than 2 movies. */

SELECT yr, COUNT(title) movie_count
FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE actor.name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2

/* Q12
List the film title and the leading actor for all of the films 'Julie Andrews' played in. */

SELECT title, name
FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE movie.id IN (
  SELECT movieid
  FROM casting
  JOIN actor
    ON casting.actorid = actor.id
  WHERE name = 'Julie Andrews'
)
  AND ord = 1

/* Q13
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. */

SELECT name
FROM actor
JOIN casting
  ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
  HAVING COUNT(DISTINCT movieid) >= 30
ORDER BY name

/* Q14
List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */

SELECT title, COUNT(actorid) actor_count
FROM movie
JOIN casting
  ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY actor_count DESC, title ASC

/* Q15
List all the people who have worked with 'Art Garfunkel'. */

SELECT DISTINCT name
FROM actor
JOIN casting
  ON actor.id = casting.actorid
WHERE casting.movieid IN
(
  SELECT DISTINCT movieid
  FROM casting
  JOIN actor
    ON casting.actorid = actor.id
  WHERE name = 'Art Garfunkel'
)
AND name <> 'Art Garfunkel'
