USE AdventureWorksLT2022;
GO

-- SUM
SELECT SUM(LineTotal) AS Total
FROM SalesLT.SalesOrderDetail;


-- COUNT 
SELECT COUNT(*) AS Cantidad
FROM SalesLT.Customer;


-- COUNT para columna no nula
SELECT COUNT(EmailAddress) AS CantidadNoNula
FROM SalesLT.Customer;


-- AVG
SELECT AVG(TotalDue) AS Promedio
FROM SalesLT.SalesOrderHeader;


-- MAX
SELECT MAX(ListPrice) AS Maximo
FROM SalesLT.Product;


-- MIN
SELECT MIN(ListPrice) AS Minimo
FROM SalesLT.Product;


-- GROUP BY total por producto
SELECT ProductID, SUM(LineTotal) AS Total
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID;


-- HAVING productos con total > 1000
SELECT ProductID, SUM(LineTotal) AS Total
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 1000;
