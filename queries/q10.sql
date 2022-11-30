SELECT Title, group_concat(DISTINCT G.Name) AS Genres
FROM Album A
         INNER JOIN Track T ON A.AlbumID = T.AlbumID
         INNER JOIN Genre G ON G.GenreID = T.GenreID
GROUP BY Title
HAVING count(DISTINCT G.Name) > 1
ORDER BY Title;
