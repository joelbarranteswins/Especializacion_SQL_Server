/* SQL Server Date Functions */

--Function CURRENT_TIMESTAMP(number)
--devuelve la fecha y hora actual
SELECT CURRENT_TIMESTAMP AS fecha_hora_actual;

--Function DATEADD(interval, number, date)
--devuelve una fecha sumando un numero de días, 
--meses, años, horas, minutos o segundos a una fecha
SELECT DATEADD(DAY, 1, CURRENT_TIMESTAMP) AS fecha_mas_1_dia;

--Function DATEDIFF(interval, date1, date2)
--devuelve la diferencia entre dos fechas
SELECT DATEDIFF(DAY, CURRENT_TIMESTAMP, '2025-01-01') 
AS dias_entre_fechas;

--Function DATEFROMPARTS(year, month, day)
--devuelve una fecha a partir de sus componentes
SELECT DATEFROMPARTS(2020, 1, 1) AS fecha_desde_componentes;

--Function DATENAME(weekday, date)
--devuelve el nombre del dia de la semana
SELECT DATENAME(WEEKDAY, CURRENT_TIMESTAMP) AS nombre_dia_semana;

--Function DATEPART(interval, date)
--devuelve el componente de una fecha
SELECT DATEPART(DAY, CURRENT_TIMESTAMP) AS dia_de_la_fecha;

SELECT DATEPART(MONTH, CURRENT_TIMESTAMP) AS mes_de_la_fecha;

SELECT DATEPART(YEAR, CURRENT_TIMESTAMP) AS año_de_la_fecha;

--Function DAY(date)
--devuelve el dia de una fecha
SELECT DAY(CURRENT_TIMESTAMP) AS dia_de_la_fecha;

--Function GETDATE()
--devuelve la fecha y hora actual
SELECT GETDATE() AS fecha_hora_actual;

--Function GETUTCDATE()
--devuelve la fecha y hora actual en UTC
SELECT GETUTCDATE() AS fecha_hora_actual_UTC;

--Function ISDATE(date)
--devuelve true si la expresion es una fecha
SELECT ISDATE(2000-15-555) AS es_fecha;

SELECT ISDATE(2017-08-25) AS es_fecha;

--Function MONTH(date)
--devuelve el mes de una fecha
SELECT MONTH(CURRENT_TIMESTAMP) AS mes_de_la_fecha;

--Function SYSDATETIME()
--devuelve la fecha y hora actual en UTC
SELECT SYSDATETIME() AS fecha_hora_actual_UTC;

--Function YEAR(date)
--devuelve el año de una fecha
SELECT YEAR(CURRENT_TIMESTAMP) AS año_de_la_fecha;