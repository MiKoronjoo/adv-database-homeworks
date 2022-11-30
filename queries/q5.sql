UPDATE Employee
SET Phone = '+' || Phone,
    Fax   = '+' || Fax
WHERE Phone NOT LIKE '+%';
