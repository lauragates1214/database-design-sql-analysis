SELECT m.title
  FROM movies AS m
 WHERE m.id IN
       (SELECT s.movie_id
          FROM stars AS s
         WHERE s.person_id IN
               (SELECT p.id
                  FROM people AS p
                 WHERE p.name = "Jennifer Lawrence"))
    AND m.id IN
       (SELECT s.movie_id
          FROM stars AS s
         WHERE s.person_id IN
               (SELECT p.id
                  FROM people AS p
                 WHERE p.name = "Bradley Cooper"));