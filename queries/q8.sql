SELECT Title, count(TrackID) AS Tracks, round(sum(UnitPrice), 6) AS Price
FROM Album A
         INNER JOIN Track T ON A.AlbumID = T.AlbumID
GROUP BY A.AlbumID
HAVING Price >= 30
ORDER BY Price DESC;
