SELECT m.title,
       m.year
  FROM movies AS m
 WHERE m.title LIKE "Harry Potter%"
 ORDER BY m.year;