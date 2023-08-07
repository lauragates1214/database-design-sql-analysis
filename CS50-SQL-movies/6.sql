SELECT AVG(r.rating)
  FROM ratings AS r
 WHERE r.movie_id IN
       (SELECT m.id
          FROM movies AS m
         WHERE m.year = 2012);