/* Tarea
utilizando cualquiera de la stablas de la BD Northwin
usar funciones de cadena.

daniel.ramos.c@sistemasuni.edu.pe
asunto: tarea semana02
*/

/*ALUMNO: Joel Barrantes Palacios*/


--ingresar a la BD
USE Northwind;
--validando que base de datos estamos usando
SELECT db_name() AS DatabaseName; 


SELECT * FROM Customers;
SELECT * FROM Products;

---------------------------------------------------------------------------------------------
/*TODAS LAS FUNCIONES STRING DE SQL SERVER*/

--Function: ASCII(character)
--si se introduce mas de una letra, solo usa el primer caracter y devuelve el numero de codigo
SELECT ASCII(ContactName) AS Number_code_of_first_char
FROM Customers;

SELECT ASCII('A') AS A; 

--Function: CHAR(number)
--se especifica el numero y te devuelve un caracter basado en el codigo ASCII
SELECT CHAR(65) AS CodeToCharacter; 

SELECT CHAR(71) AS codigo_ASCCI_a_valor; 

--Function: CHARINDEX(character,string)
--busca una cadena en una subcadena y devuelve la posicion
--si no encuentra una cadena devuelve cero
SELECT CHARINDEX('anna',ContactName) 
AS posicion_indice
FROM Customers;

SELECT CHARINDEX('a', Products.ProductName) AS product_name
FROM Products;

--Function: CONCAT(string1,string2,...)
SELECT CONCAT(Customers.City, ' - ', Customers.Country)
FROM Customers;

SELECT CONCAT(Products.ProductName, ' :',Products.CategoryID, ' - ', Products.UnitsInStock) 
AS Productos
FROM Products;

--Function: Concat with +
SELECT Customers.PostalCode + ' - ' + Customers.Country
FROM Customers;

SELECT ' - ' + Products.ProductName
FROM Products;

--Function: CONCAT_WS(separator,string1,string2,...)
--agrega dos o mas cadenas junto con un separador. 
SELECT CONCAT_WS('.', Customers.CustomerID,'@gmail','com')
FROM Customers;

--Function: DATALENGTH(string)
--devuelve la longitud de una expresion en bytes (cuenta tambien espacios)
SELECT DATALENGTH(Customers.PostalCode)
FROM Customers;

SELECT DATALENGTH(Products.ProductName) AS longitud_producto
FROM Products;

--Function: DIFFEREENCE(string1,string2)
--Compara dos valores SOUNDEX y devuelve un numero entero
--el numero entero es una coincidencia de los dos valores e 0 - 4
SELECT DIFFERENCE(Customers.Country, Customers.City)
FROM Customers; 

--Function: FORMAT(number,format)
--formatea un valor con el formato especificado
--para formatear valores y numeros de fecha/hora valores-
SELECT FORMAT(987654321, '###-###-###'); 

DECLARE @d DATE = '11/22/2020';
SELECT FORMAT( @d, 'd', 'en-US' ) 'US English'; 

SELECT FORMAT(Products.UnitPrice, '##,### ###') AS precio_formateado
FROM Products;

--Function: LEFT(string,length)
--extrae un numero de caracteres de un string
SELECT LEFT(Customers.Phone, 3) AS string_extraido
FROM Customers;

--Function: LEN(string)
--devuelve la longitud de una cadena
SELECT LEN(Customers.CustomerID) 
FROM Customers;

SELECT LEN(Products.ProductName) AS longitud_producto
FROM Products;

--Function: LOWER(string)
--convierte una cadena a min�sculas
SELECT LOWER(Customers.ContactTitle) AS valores_minuscula
FROM Customers;

SELECT LOWER(Products.ProductName) AS producto_minuscula
FROM Products;


--Function: LTRIM(string)
--elimina los espacios en blanco de la izquierda
SELECT LTRIM(Customers.ContactTitle) AS valores
FROM Customers;

SELECT LTRIM('     SQL Tutorial') AS valores;

--Function: NCHAR(number_code)
--devuelve el carácter Unicode según el código numérico
SELECT NCHAR(65) AS Number_code_to_unicode;

--Function: PATINDEX(%pattern%, string)
--busca una cadena en una subcadena y devuelve la posicion
--si no encuentra una cadena devuelve cero
SELECT PATINDEX('%an%',ContactName) AS posicion_indice
FROM Customers;

SELECT PATINDEX('%com%', 'W3Schools.com');


--Function: QUOTENAME(string, quote_char)
--devuelve una cadena con comillas simples
SELECT QUOTENAME(Customers.ContactTitle,'{}') AS valores
FROM Customers;

SELECT QUOTENAME(Customers.ContactTitle,'()') AS valores
FROM Customers;

--Function: REPLACE(string, old_string, new_string)
--reemplaza todas las apariciones de una subcadena dentro de una cadena, con una nueva subcadena
SELECT REPLACE(Customers.CompanyName, 'AN', '---')
FROM Customers;

--Function: REPLICATE(string, integer)
--repite una cadena un numero de veces
SELECT REPLICATE(Customers.CompanyName, 2) AS repeticion
FROM Customers;

--Function REVERSE(string)
--devuelve una cadena invertida
SELECT REVERSE(Customers.CompanyName) AS cadena_invertida
FROM Customers;

SELECT REVERSE(Products.ProductName) AS producto_invertido
FROM Products;

--Function RIGHT(string, number_of_chars)
--extrae un numero de caracteres de un string desde la derecha
SELECT RIGHT(Customers.Phone, 3) AS string_extraido
FROM Customers;

--Function RTRIM(string)
--elimina los espacios en blanco de la derecha
SELECT RTRIM('SQL Tutorial     ') AS resultado;

SELECT RTRIM(Customers.ContactTitle) AS valores
FROM Customers;

--Function SOUNDEX(expression)
--Compara dos valores SOUNDEX y devuelve un n�mero entero
--el numero entero es una coincidencia de los dos valores de 0 - 4
SELECT SOUNDEX('juego'), SOUNDEX('diversion');

SELECT SOUNDEX(Customers.Country) AS valores
FROM Customers;

--Function: SPACE(number)
--devuelve una cadena de caracteres de espacio de acuerdo al numero
SELECT CONCAT(Customers.City, SPACE(2), Customers.Country)
FROM Customers;

--Function STR(number, length(OPTIONAL), decimals(OPTIONAL))
--devuelve un numero como string
SELECT STR(185.476, 6, 2); 
SELECT STR(185); 

--Function STUFF(string, start, length, new_string)
--devuelve una cadena con una subcadena reemplazada
SELECT STUFF('SQL Tutorial', 1, 3, 'HTML');

SELECT STUFF('SQL Tutorial', 1, 5, 'SQL') AS resultado;


--Function SUBSTRING(string, start, length)
--extrae una subcadena de una cadena
SELECT SUBSTRING(Customers.ContactName, 1, 4) AS subcadena
FROM Customers;

SELECT SUBSTRING(Products.ProductName, 2, 3) AS subcadena
FROM Products;

--Function TRANSLATE(string, characters, translations)
--en los charactrs se especifica los valores que se quiere cambiar y en translation la traduccion
SELECT TRANSLATE(Customers.Fax,'()','[]') AS FAX 
FROM Customers;

SELECT TRANSLATE(Products.QuantityPerUnit, '-', '~') AS cantidad_por_unidad
FROM Products;

--Function: UNICODE(string)
--Function UNICODE(character_expression)
--devuelve un valor entero (el valor Unicode), para el primer car�cter de la expresi�n de entrada
SELECT UNICODE(Customers.ContactName) as unicode_of_first_char
FROM Customers;

SELECT UNICODE(Products.ProductName) as unicode_of_first_char
FROM Products;

--Function UPPER()
--convierte una cadena en may�sculas
SELECT UPPER(Customers.ContactName) AS nombre_mayuscula
FROM Customers;

SELECT UPPER(Products.ProductName) AS nombre_mayuscula
FROM Products;

