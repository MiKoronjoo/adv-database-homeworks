SELECT FirstName || ', ' || LastName as Name
FROM Employee
ORDER BY length(Name);
