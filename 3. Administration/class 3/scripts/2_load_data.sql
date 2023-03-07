USE VENTAS
GO

INSERT INTO DEPARTAMENTO VALUES(10,'CONTABILIDAD','PIURA');
INSERT INTO DEPARTAMENTO VALUES(20,'INVESTIGACION','CHICLAYO');
INSERT INTO DEPARTAMENTO VALUES(30,'VENTAS','LAMBAYEQUE');
GO


INSERT INTO EMPLEADO VALUES(7839,'WILMAN','PRESIDENTE',NULL,convert(datetime,'1981-11-17',120),5000,NULL,10);
INSERT INTO EMPLEADO VALUES(7698,'SILVER','GERENTE',7839,convert(datetime,'1981-05-01',120),2850,NULL,30);
INSERT INTO EMPLEADO VALUES(7782,'LUISA','GERENTE',7839,convert(datetime,'1981-06-09',120),2450,NULL,10);
GO


INSERT INTO PRODUCTO(IDPRODUC, DESCRIPCION) VALUES(100860,'RAQUETA DE TENIS ACE I');
INSERT INTO PRODUCTO(IDPRODUC, DESCRIPCION) VALUES(100861,'RAQUETA DE TENIS ACE II');
INSERT INTO PRODUCTO(IDPRODUC, DESCRIPCION) VALUES(100862,'RAQUETA DE TENIS ACE III');
GO


INSERT INTO CLIENTE (ESTADO, REPID, TELEFONO, NOMBRE, IDCLIENTE, CREDITO_LIMITADO, CIUDAD, AREA, DIRECCION, COMENTARIOS) 
VALUES('AC',7844,'598-6609','JOCK SPORTS',100,5000,'BELMONT',415,'345 VIEWRIDGE','Gente muy amable para trabajar con el representante de ventas. Le gusta ser llamado Mike.');
INSERT INTO CLIENTE (ESTADO, REPID, TELEFONO, NOMBRE, IDCLIENTE, CREDITO_LIMITADO, CIUDAD, AREA, DIRECCION, COMENTARIOS) 
VALUES('AC',7521,'368-1233','TKB SPORTS SHOP',101,10000,'REDWOOD CITY',415,'490 BOLI RD','Representante llamado 5/8 sobre cambio en orden - contactó envío.');
GO