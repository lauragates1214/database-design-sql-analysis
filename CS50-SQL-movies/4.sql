SELECT COUNT(*)
  FROM movies AS m
 WHERE m.id IN
       (SELECT r.movie_id
          FROM ratings AS r
         WHERE r.rating = 10.0);

