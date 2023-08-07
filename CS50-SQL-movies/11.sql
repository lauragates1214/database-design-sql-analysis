SELECT m.title
  FROM movies AS m
 INNER JOIN ratings AS r
    ON m.id = r.movie_id
 WHERE m.id IN
       (SELECT s.movie_id
          FROM stars AS s
         WHERE s.person_id IN
               (SELECT p.id
                  FROM people AS p
                 WHERE p.name = "Chadwick Boseman"))
 ORDER BY r.rating DESC
 LIMIT 5;