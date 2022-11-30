# Advanced Database Course - Homework 2 Answers

## Table of Contents

1. [Question 1](#q1)
   1. [Result](#result)
2. [Question 2](#q2)
   1. [note](#note)
   2. [Result](#result-1)
3. [Question 3](#q3)
   1. [description](#description)
   2. [Result](result-2)
4. [Question 4](#q4)
   1. [description](#description-1)
   2. [Result](result-3)
5. [Question 5](#q5)
6. [Question 6](#q6)
   1. [description](#description-2)
7. [Question 7](#q7)
   1. [Result](result-4)
8. [Question 8](#q8)
   1. [description](#description-3)
   2. [Result](result-5)
9. [Question 9](#q9)
    1. [Added Rows](#added-rows)
10. [Question 10](#q10)
   1. [description](#description-4)
   2. [Result](result-6)
11. [Question 11](#q11)

## Q1

```sql
SELECT 'Hassan' AS first_name, 'Abbasi' AS last_name, 'StudentNumber' AS std_num;
```

### Result

| first\_name | last\_name | std\_num      |
|:------------|:-----------|:--------------|
| Hassan      | Abbasi     | StudentNumber |

## Q2

```sql
SELECT Name, ArtistID
FROM Artist
WHERE Name LIKE 'f%'
ORDER BY ArtistID;
```

#### note:

SQLite `LIKE` operator is by default case-insensitive. It means `"A" LIKE "a"` is true.

### Result

| Name                                                                 | ArtistID |
|:---------------------------------------------------------------------|:---------|
| Frank Zappa & Captain Beefheart                                      | 23       |
| Fernanda Porto                                                       | 39       |
| Faith No More                                                        | 82       |
| Falamansa                                                            | 83       |
| Foo Fighters                                                         | 84       |
| Frank Sinatra                                                        | 85       |
| Funk Como Le Gusta                                                   | 86       |
| Felix Schmidt, London Symphony Orchestra & Rafael Frühbeck de Burgos | 241      |
| Fretwork                                                             | 251      |

## Q3

```sql
SELECT AlbumID
FROM Album
WHERE AlbumID % 23 = 0
ORDER BY AlbumID;
```

#### description:

SQLite `%` arithmetic operator divides the left-hand operand by the right-hand operand and returns the remainder.

### Result

| AlbumID |
|:--------|
| 23      |
| 46      |
| 69      |
| 92      |
| 115     |
| 138     |
| 161     |
| 184     |
| 207     |
| 230     |

## Q4

```sql
SELECT FirstName || ', ' || LastName as Name
FROM Employee
ORDER BY length(Name);
```

#### description:

SQLite `||` operator allows you to concatenate 2 or more strings together.

### Result

| Name              |
|:------------------|
| Robert, King      |
| Andrew, Adams     |
| Jane, Peacock     |
| Nancy, Edwards    |
| Margaret, Park    |
| Steve, Johnson    |
| Laura, Callahan   |
| Michael, Mitchell |

## Q5

```sql
UPDATE Employee
SET Phone = '+' || Phone,
    Fax   = '+' || Fax
WHERE Phone NOT LIKE '+%';
```

## Q6

```sql
CREATE TABLE IF NOT EXISTS Login
(
    Username   VARCHAR
        CONSTRAINT Login_pk
            PRIMARY KEY,
    Password   VARCHAR NOT NULL,
    LastUpdate DATE DEFAULT (datetime('now', 'localtime')),
    Status     VARCHAR,
    CustomerID INTEGER
        CONSTRAINT Login_Customer_CustomerID_fk
            REFERENCES Customer,
    CHECK (Status IN ('active', 'inactive'))
);
```

#### description:

The `datetime()` function returns a datetime value in this format: `YYYY-MM-DD HH:MM:SS`. \
The `now` time string returns the current date and time. \
The `localtime` modifier instructs the function to return the local time. \
SQLite `CHECK` constraints allow you to define expressions to test values whenever they are inserted into or updated within a column.

## Q7

```sql
SELECT Name
FROM Track
WHERE Name LIKE 'right %'
   OR Name LIKE '% right'
   OR Name LIKE '% right %'
   OR Name LIKE 'right'
ORDER BY Name;
```

### Result

| Name                                            |
|:------------------------------------------------|
| Always Be All Right                             |
| Get Right                                       |
| I Guess You're Right                            |
| Night Time Is The Right Time                    |
| Right Next Door to Hell                         |
| Right Now                                       |
| Right On Time                                   |
| Right Through You                               |
| The Right Thing                                 |
| You Can't Do it Right \(With the One You Love\) |

## Q8

```sql
SELECT Title, count(TrackID) AS Tracks, round(sum(UnitPrice), 6) AS Price
FROM Album A
         INNER JOIN Track T ON A.AlbumID = T.AlbumID
GROUP BY A.AlbumID
HAVING Price >= 30
ORDER BY Price DESC;
```

#### description:

The `sum()` function is an aggregate function that returns the sum the non-NULL values or only the distinct values in a group. \
The `round()` function returns a floating-point value that represents value rounded to a specified length or precision.

### Result

| Title                                      | Tracks | Price |
|:-------------------------------------------|:-------|:------|
| Greatest Hits                              | 57     | 56.43 |
| Lost, Season 3                             | 26     | 51.74 |
| The Office, Season 3                       | 25     | 49.75 |
| Lost, Season 1                             | 25     | 49.75 |
| Battlestar Galactica \(Classic\), Season 1 | 24     | 47.76 |
| Lost, Season 2                             | 24     | 47.76 |
| Heroes, Season 1                           | 23     | 45.77 |
| The Office, Season 2                       | 22     | 43.78 |
| Battlestar Galactica, Season 3             | 19     | 37.81 |
| LOST, Season 4                             | 17     | 33.83 |

## Q9

```sql
INSERT INTO Playlist (Name)
VALUES ('Quick Music');

INSERT INTO PlaylistTrack (PlaylistID, TrackID)
SELECT PL.PlaylistID, TrackID
FROM Track
         CROSS JOIN (SELECT PlaylistID FROM Playlist WHERE Name = 'Quick Music' LIMIT 1) AS PL
ORDER BY Millisecond LIMIT 10;
```

### Added Rows

| PlaylistID | TrackID |
|:-----------|:--------|
| 19         | 2461    |
| 19         | 168     |
| 19         | 170     |
| 19         | 178     |
| 19         | 3304    |
| 19         | 172     |
| 19         | 3310    |
| 19         | 2241    |
| 19         | 1086    |
| 19         | 246     |

## Q10

```sql
SELECT Title, group_concat(DISTINCT G.Name) AS Genres
FROM Album A
         INNER JOIN Track T ON A.AlbumID = T.AlbumID
         INNER JOIN Genre G ON G.GenreID = T.GenreID
GROUP BY Title
HAVING count(DISTINCT G.Name) > 1
ORDER BY Title;
```

#### description:
The `count()` function is an aggregate function that returns the number of items in a group. \
The `group_concat()` function is an aggregate function that concatenates all non-null values in a column.

### Result

| Title                          | Genres                                    |
|:-------------------------------|:------------------------------------------|
| Battlestar Galactica, Season 3 | TV Shows,Science Fiction,Sci Fi & Fantasy |
| Greatest Hits                  | Rock,Reggae,Metal                         |
| Heroes, Season 1               | TV Shows,Drama                            |
| LOST, Season 4                 | Drama,TV Shows                            |
| Live After Death               | Heavy Metal,Metal                         |
| Lost, Season 2                 | TV Shows,Drama                            |
| Lost, Season 3                 | TV Shows,Drama                            |
| Rock In Rio CD2                | Rock,Metal                                |
| The Number of The Beast        | Metal,Rock                                |
| The Office, Season 3           | TV Shows,Comedy                           |

## Q11

```sql
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
```
