INSERT INTO Playlist (Name)
VALUES ('Quick Music');

INSERT INTO PlaylistTrack (PlaylistID, TrackID)
SELECT PL.PlaylistID, TrackID
FROM Track
         CROSS JOIN (SELECT PlaylistID FROM Playlist WHERE Name = 'Quick Music' LIMIT 1) AS PL
ORDER BY Millisecond
LIMIT 10;
