SELECT Name
FROM Track
WHERE Name LIKE 'right %'
   OR Name LIKE '% right'
   OR Name LIKE '% right %'
   OR Name LIKE 'right'
ORDER BY Name;
