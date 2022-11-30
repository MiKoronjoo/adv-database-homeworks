CREATE TABLE IF NOT EXISTS Login
(
    Username   VARCHAR
        CONSTRAINT Login_pk
            PRIMARY KEY,
    Password   VARCHAR NOT NULL,
    LastUpdate DATE DEFAULT current_timestamp,
    Status     VARCHAR,
    CustomerID INTEGER
        CONSTRAINT Login_Customer_CustomerID_fk
            REFERENCES Customer,
    CHECK (Status IN ('active', 'inactive'))
);
