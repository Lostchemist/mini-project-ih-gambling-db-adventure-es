use irongam;
-- - **Pregunta 01**: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes
SELECT
    Title,
    FirstName,
    LastName,
    DateOfBirth
FROM
    Customer;
    
    
-- - **Pregunta 02**: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro).
SELECT
    CustomerGroup,
    COUNT(*) AS NumberOfCustomers
FROM
    Customer
GROUP BY
    CustomerGroup;
    
-- Pregunta 03
 SELECT
    c.*,
    a.CurrencyCode
FROM
    Customer c
JOIN
    Account a ON c.CustId = a.CustId;
    
-- Pregunta 04

SELECT
    b.Product,
    DATE(b.BetDate) AS BetDate,
    SUM(b.Bet_Amt) AS TotalBetAmount
FROM
    Betting b
GROUP BY
    b.Product,
    DATE(b.BetDate);
    
-- Pregunta 5 


SELECT
    b.Product,
    DATE(b.BetDate) AS BetDate,
    SUM(b.Bet_Amt) AS TotalBetAmount
FROM
    Betting b
WHERE
    DATE(b.BetDate) >= '2012-11-01' AND b.Product = 'Sportsbook'
GROUP BY
    b.Product,
    DATE(b.BetDate);
    
    -- Pregunta 6
    
SELECT
    b.Product,
    a.CurrencyCode,
    c.CustomerGroup,
    SUM(b.Bet_Amt) AS TotalBetAmount
FROM
    Betting b
JOIN
    Account a ON b.AccountNo = a.AccountNo
JOIN
    Customer c ON a.CustId = c.CustId
WHERE
    DATE(b.BetDate) > '2012-12-01'
GROUP BY
    b.Product,
    a.CurrencyCode,
    c.CustomerGroup;
    
-- Pregunta 7


SELECT
    c.Title,
    c.FirstName,
    c.LastName,
    COALESCE(SUM(b.Bet_Amt), 0) AS TotalBetAmount
FROM
    Customer c
LEFT JOIN
    Account a ON c.CustId = a.CustId
LEFT JOIN
    Betting b ON a.AccountNo = b.AccountNo AND DATE(b.BetDate) BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY
    c.CustId,
    c.Title,
    c.FirstName,
    c.LastName;
    
-- Pregunta 8

SELECT
    a.CustId,
    COUNT(DISTINCT b.Product) AS NumberOfProducts
FROM
    Betting b
JOIN
    Account a ON b.AccountNo = a.AccountNo
GROUP BY
    a.CustId;


SELECT
    a.CustId
FROM
    Betting b
JOIN
    Account a ON b.AccountNo = a.AccountNo
WHERE
    b.Product IN ('Sportsbook', 'Vegas')
GROUP BY
    a.CustId
HAVING
    COUNT(DISTINCT b.Product) = 2;
    
    
-- Pregunta 9 

SELECT
    c.CustId,
    c.FirstName,
    c.LastName,
    SUM(b.Bet_Amt) AS TotalBetAmount
FROM
    Customer c
JOIN
    Account a ON c.CustId = a.CustId
JOIN
    Betting b ON a.AccountNo = b.AccountNo
WHERE
    b.Product = 'Sportsbook'
GROUP BY
    c.CustId,
    c.FirstName,
    c.LastName
HAVING
    COUNT(DISTINCT b.Product) = 1;
    
    -- Pregunta 10 
    
    WITH FavoriteProduct AS (
    SELECT
        a.CustId,
        b.Product,
        SUM(b.Bet_Amt) AS TotalBetAmount,
        ROW_NUMBER() OVER (PARTITION BY a.CustId ORDER BY SUM(b.Bet_Amt) DESC) AS rn
    FROM
        Betting b
    JOIN
        Account a ON b.AccountNo = a.AccountNo
    GROUP BY
        a.CustId,
        b.Product
)
SELECT
    fp.CustId,
    fp.Product,
    fp.TotalBetAmount
FROM
    FavoriteProduct fp
WHERE
    fp.rn = 1;

 
 -- Pregunta 11 
 
 SELECT
    student_name,
    GPA
FROM
    Student
ORDER BY
    GPA DESC
LIMIT 5;
 
