CREATE TRIGGER UndeleteLostTrack
    AFTER DELETE
    ON Track
    WHEN old.TrackID IN (SELECT TrackID
                         FROM Track T
                                  INNER JOIN Album A ON A.AlbumID = T.AlbumID
                         WHERE A.Title LIKE 'lost, season%')
BEGIN
    INSERT INTO Track
    VALUES (old.TrackID, old.Name, old.AlbumID, old.MediaTypeID, old.GenreID,
            old.Composer, old.Millisecond, old.Byte, old.UnitPrice);
END;
