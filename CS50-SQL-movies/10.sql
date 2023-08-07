SELECT DISTINCT p.name
  FROM people AS p
 WHERE p.id IN
       (SELECT d.person_id
          FROM directors AS d
         WHERE d.movie_id IN
               (SELECT r.movie_id
                  FROM ratings AS r
                 WHERE r.rating >= 9.0));