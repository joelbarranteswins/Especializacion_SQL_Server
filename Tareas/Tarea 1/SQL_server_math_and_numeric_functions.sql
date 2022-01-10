/* SQL Server Math/Numeric Functions*/

--Function ABS(number)
--devuelve el valor absoluto de un numero
SELECT ABS(-5) AS valor_absoluto;

--Function ACOS(number)
--devuelve el arcocoseno de un numero
SELECT ACOS(0.5) AS arcocoseno;


--Function ASIN(number)
--devuelve el arcoseno de un numero
SELECT ASIN(0.5) AS arcoseno;

--Function ATAN(number)
--devuelve el arcotangente de un numero
SELECT ATAN(0.5) AS arcotangente;

--Function ATN2(x, y)
--devuelve el arcotangente de dos numeros
SELECT ATN2(0.5, 0.5) AS arcotangente;

--Function COUNT(expression)
--devuelve el numero de filas de una consulta
SELECT COUNT(*) AS numero_filas
FROM Customers;

SELECT COUNT(Products.ProductID) AS numero_filas
FROM Products;

--Function CEILING(number)
--devuelve el numero entero mas cercano
SELECT CEILING(5.5) AS numero_entero_mas_cercano;

--Function COS(number)
--devuelve el coseno de un numero
SELECT COS(0.5) AS coseno;

--Function COT(number)
--devuelve el cotangente de un numero
SELECT COT(0.5) AS cotangente;

--Function DEGREES(number)
--devuelve el numero en grados
SELECT DEGREES(0.5) AS numero_en_grados;

--Function EXP(number)
--devuelve el exponente de un numero
SELECT EXP(0.5) AS exponente;

--Function FLOOR(number)
--devuelve el numero entero mas cercano por debajo
SELECT FLOOR(5.5) AS numero_entero_mas_cercano;

--Function LOG(number)
--devuelve el logaritmo de un numero
SELECT LOG(0.5) AS logaritmo;

--Function LOG10(number)
--devuelve el logaritmo de 10 de un numero
SELECT LOG10(0.5) AS logaritmo_de_10;

--Function MAX(expression1,expression2,...)
--devuelve el numero mas grande de una lista de numeros
SELECT MAX(Products.UnitPrice) AS precio_mas_alto
FROM Products;

--Function MIN(expression1,expression2,...)
--devuelve el numero mas pequeño de una lista de numeros
SELECT MIN(Products.UnitPrice) AS precio_mas_bajo
FROM Products;

--Function PI()
--devuelve el numero PI
SELECT PI() AS numero_pi;

--Function POWER(number,power)
--devuelve el numero elevado a la potencia
SELECT POWER(2,3) AS numero_elevado_a_la_potencia;

--Function RADIANS(number)
--devuelve el numero en radianes
SELECT RADIANS(90) AS numero_en_radianes;

--Function RAND()
--devuelve un numero aleatorio entre 0 y 1
SELECT RAND() AS numero_aleatorio;

--Function ROUND(number,digits)
--devuelve el numero redondeado a un numero de digitos
SELECT ROUND(5.54665,2) AS numero_redondeado;

--Function SIGN(number)
--devuelve el signo de un numero
/*If number > 0, it returns 1
If number = 0, it returns 0
If number < 0, it returns -1*/

SELECT SIGN(5.54665) AS signo;

--Function SIN(number)
--devuelve el seno de un numero
SELECT SIN(0.5) AS seno;

--Function SQRT(number)
--devuelve la raiz cuadrada de un numero
SELECT SQRT(9) AS raiz_cuadrada;

--Function SQUARE(number)
--devuelve el numero elevado al cuadrado
SELECT SQUARE(2) AS numero_elevado_al_cuadrado;

--Function SUM(expression1,expression2,...)
--devuelve la suma de una lista de numeros
SELECT SUM(Products.UnitPrice) AS precio_total
FROM Products;

--Function TAN(number)
--devuelve el tangente de un numero
SELECT TAN(60) AS tangente;


SELECT * FROM Products;
SELECT * FROM Orders;