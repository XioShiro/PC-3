USE AdventureWorksLT2022;
GO

BEGIN TRANSACTION;

UPDATE SalesLT.Customer
SET CompanyName = 'Tech World SAC'
WHERE CustomerID = 1;

INSERT INTO SalesLT.SalesOrderHeader
    (CustomerID, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, SubTotal, TaxAmt, Freight, ShipMethod)
VALUES
    (1, GETDATE(), DATEADD(DAY, 5, GETDATE()), NULL, 1, 1, 450.00, 25.00, 25.00, 'Ground');

COMMIT;

-- Verificamos los cambios
SELECT CustomerID, CompanyName FROM SalesLT.Customer WHERE CustomerID = 1;
GO


BEGIN TRANSACTION;

UPDATE SalesLT.Customer
SET CompanyName = 'Prueba Rollback'
WHERE CustomerID = 1;

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = GETDATE();

ROLLBACK;

-- Verificamos que el rollback haya funcionado
SELECT CustomerID, CompanyName FROM SalesLT.Customer WHERE CustomerID = 1;
GO


BEGIN TRANSACTION;

UPDATE SalesLT.Customer
SET Phone = '999888777'
WHERE CustomerID = 2;

COMMIT;

-- Mostramos resultado
SELECT CustomerID, Phone FROM SalesLT.Customer WHERE CustomerID = 2;
GO


BEGIN TRANSACTION;

UPDATE SalesLT.Customer
SET CompanyName = 'Cliente Test 1'
WHERE CustomerID = 3;

SAVE TRAN Save1;

UPDATE SalesLT.Customer
SET CompanyName = 'Cliente Test 2'
WHERE CustomerID = 4;

ROLLBACK TRAN Save1;

COMMIT;

-- Verificamos los resultados finales
SELECT CustomerID, CompanyName FROM SalesLT.Customer WHERE CustomerID IN (3,4);
GO
