USE AdventureWorksLT2022;
GO

-- ---------- SUBCONSULTAS ----------

-- EXISTS: clientes que SI tienen pedidos
SELECT c.CustomerID, c.FirstName, c.LastName
FROM SalesLT.Customer c
WHERE EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader h
    WHERE h.CustomerID = c.CustomerID
);

-- NOT EXISTS: clientes que NO tienen pedidos
SELECT c.CustomerID, c.FirstName, c.LastName
FROM SalesLT.Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader h
    WHERE h.CustomerID = c.CustomerID
);

-- IN productos que aparecen en detalles de pedido
SELECT p.ProductID, p.Name
FROM SalesLT.Product p
WHERE p.ProductID IN (
    SELECT DISTINCT sd.ProductID
    FROM SalesLT.SalesOrderDetail sd
);

-- Subconsulta en SELECT (correlacionada) total comprado por cliente
SELECT c.CustomerID, c.FirstName, c.LastName,
  (
    SELECT SUM(sd.LineTotal)
    FROM SalesLT.SalesOrderHeader h
    JOIN SalesLT.SalesOrderDetail sd ON h.SalesOrderID = sd.SalesOrderID
    WHERE h.CustomerID = c.CustomerID
  ) AS TotalComprado
FROM SalesLT.Customer c;


-- ---------- FUNCIONES DE FECHA ----------

-- GETDATE(): fecha y hora actuales
SELECT GETDATE() AS FechaHoraActual;

-- DAY día del mes del pedido (primeros 10)
SELECT TOP 10 SalesOrderID, OrderDate, DAY(OrderDate) AS DiaDelPedido
FROM SalesLT.SalesOrderHeader;

-- MONTH(): mes del pedido
SELECT TOP 10 SalesOrderID, OrderDate, MONTH(OrderDate) AS MesDelPedido
FROM SalesLT.SalesOrderHeader;


-- YEAR(): año del pedido
SELECT TOP 10 SalesOrderID, OrderDate, YEAR(OrderDate) AS AnoDelPedido
FROM SalesLT.SalesOrderHeader;


-- DATEADD(): estimar envío +10 días
SELECT TOP 10 SalesOrderID, OrderDate, DATEADD(DAY, 10, OrderDate) AS EstimaEnvio
FROM SalesLT.SalesOrderHeader;


-- DATEDIFF(): días desde el pedido hasta hoy
SELECT TOP 10 SalesOrderID, OrderDate, DATEDIFF(DAY, OrderDate, GETDATE()) AS DiasDesdePedido
FROM SalesLT.SalesOrderHeader;



-- ---------- FUNCIONES DE CADENA ----------

-- CONCAT(): nombre completo del cliente
SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS NombreCompleto
FROM SalesLT.Customer;


-- LEN(): longitud del email (si existe)
SELECT CustomerID, EmailAddress, LEN(ISNULL(EmailAddress, '')) AS LongitudEmail
FROM SalesLT.Customer;


-- SUBSTRING(): primeros 8 caracteres del nombre del producto
SELECT ProductID, Name, SUBSTRING(Name, 1, 8) AS Primeros8
FROM SalesLT.Product;


-- LOWER(): nombre en minúsculas
SELECT CustomerID, FirstName, LOWER(FirstName) AS FirstNameMinusculas
FROM SalesLT.Customer;


-- UPPER(): apellido en mayúsculas
SELECT CustomerID, LastName, UPPER(LastName) AS LastNameMayusculas
FROM SalesLT.Customer;


-- LTRIM(): quitar espacios a la izquierda de AddressLine1
SELECT AddressID, LTRIM(ISNULL(AddressLine1, '')) AS Address_LTRIM
FROM SalesLT.Address;

-- RTRIM(): quitar espacios a la derecha de AddressLine1
SELECT AddressID, RTRIM(ISNULL(AddressLine1, '')) AS Address_RTRIM
FROM SalesLT.Address;



-- ---------- FUNCIONES DE CONVERSIÓN ----------

-- CAST(): mostrar TotalDue con 2 decimales
SELECT SalesOrderID, CAST(TotalDue AS DECIMAL(12,2)) AS TotalDueDecimal
FROM SalesLT.SalesOrderHeader;


-- CONVERT()
SELECT SalesOrderID, OrderDate, CONVERT(VARCHAR(10), OrderDate, 103) AS OrderDate_DDMMYYYY
FROM SalesLT.SalesOrderHeader;

