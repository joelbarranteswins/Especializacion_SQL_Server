
/*SQL Server Advanced Functions*/

--FUCTION CAST(expression)
--convierte una expresion a un tipo de dato
SELECT CAST(Products.UnitPrice AS money) AS precio_formateado
FROM Products;

SELECT CAST(25.65 AS int);

--Function COALESCE(expression1, expression2, ...)
--devuelve la primera expresión que no es NULL
SELECT COALESCE(Products.UnitPrice, 0) AS precio_formateado
FROM Products;

SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com');

--Function CONVERT(data_type, expression)
--convierte una expresión a un tipo de dato
SELECT CONVERT(money, Products.UnitPrice) AS precio_formateado
FROM Products;

SELECT CONVERT(varchar, 25.65);

--Function CURRENT_USER()
--devuelve el nombre de usuario de la conexión actual
SELECT CURRENT_USER;

--Function IIF(condition, expression1, expression2)
--devuelve la primera expresión si la condición es verdadera, 
--y la segunda si es falsa
SELECT IIF(Products.UnitPrice > 30, 'MAYOR', 'MENOR') 
AS precio_formateado
FROM Products;

--Function ISNULL(expression1, expression2)
--devuelve la primera expresión si es NULL, y la segunda si no
SELECT ISNULL(Products.UnitPrice, 0) AS precio_formateado
FROM Products;

SELECT ISNULL(NULL, NULL) AS is_null;

--Function ISNUMERIC(expression)
--devuelve verdadero si la expresión es un número
SELECT ISNUMERIC(Products.UnitPrice) AS is_numeric
FROM Products;

SELECT ISNUMERIC('SDS');

--Function NUllIF(condition, expression1, expression2)
--si las expresiones son iguales, entonces retorna la primera expresion
SELECT NULLIF('Hello', 'Hello');

SELECT NULLIF('Hello', 'Hellosdfv');

SELECT NULLIF('HSFVSDFello', 'Hello');

--Function SESSION_USER()
--devuelve el nombre de usuario de la conexión actual
SELECT SESSION_USER;

--Function SESSIONPROPERTY(name)
--devuelve el valor de una propiedad de sesión
SELECT SESSIONPROPERTY('ANSI_NULLS');

--Function SYSTEM_USER()
--devuelve el nombre de usuario de la conexión actual
SELECT SYSTEM_USER;

--Function USER_NAME()
--devuelve el nombre de usuario de la conexión actual
SELECT USER_NAME();


select * from products;