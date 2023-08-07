SELECT p.name
  FROM people AS p
 WHERE p.id IN
       (SELECT s.person_id
          FROM stars AS s
         WHERE s.movie_id IN
               (SELECT s.movie_id
                FROM stars AS s
                WHERE s.person_id IN
                      (SELECT p.id
                         FROM people AS p
                        WHERE p.name = "Kevin Bacon"
                          AND birth = 1958)))
EXCEPT SELECT p.name
  FROM people AS p
 WHERE p.name = "Kevin Bacon";