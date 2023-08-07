SELECT DISTINCT p.name
  FROM people AS p
 WHERE p.id IN
       (SELECT s.person_id
          FROM stars AS s
         WHERE s.movie_id IN
               (SELECT m.id
                  FROM movies AS m
                 WHERE m.year = 2004))
 ORDER BY p.birth;