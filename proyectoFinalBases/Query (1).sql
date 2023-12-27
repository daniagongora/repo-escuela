--Consulta 1: Nombre completo de los empleados de las sucursales 300, 301, 302 y 303
SELECT Nombre, ApellidoP, ApellidoM FROM cajero WHERE idsucursal = 300 OR idsucursal = 301 OR idsucursal = 302 OR idsucursal = 303
UNION
SELECT Nombre, ApellidoP, ApellidoM FROM encargado WHERE idsucursal = 300 OR idsucursal = 301 OR idsucursal = 302 OR idsucursal = 303
UNION
SELECT Nombre, ApellidoP, ApellidoM FROM gerente WHERE idsucursal = 300 OR idsucursal = 301 OR idsucursal = 302 OR idsucursal = 303;

--Consulta 2: Información de contacto de todos los clientes que hicieron compras en sucursales con nombre Xochimilco o Milpa Alta.
SELECT Nombre, ApellidoP, ApellidoM, Telefono, Correo FROM venta NATURAL JOIN correocliente NATURAL JOIN telefonocliente t NATURAL JOIN cliente WHERE nombresucursal = 'Xochimilco'  or nombresucursal = 'Milpa Alta' ;

--Consulta 3: Los 10 suministradores con mayor cantidad de productos suministrados.
SELECT * FROM suministrar ORDER BY cantidad DESC limit 10;

--Consulta 4: Los 10 suministradores con el menor precio de compra.
SELECT * FROM suministrar ORDER BY preciodecompra ASC limit 10;

--Consulta 5: Nombre completo, número y teléfono de los encargados de las sucursales 300 - 320
SELECT Nombre, ApellidoP, ApellidoM, telefono FROM encargado NATURAL JOIN  telefonoencargado WHERE idsucursal >= 300 AND idsucursal <= 320;

-- Consulta 6: ID y horario de las sucursales que abren después de las 6:59 y cierran antes de las 23:00
SELECT IDSucursal,HoraApertura, HoraCierre FROM sucursal WHERE horaapertura > '6:59:00' AND horacierre < '23:00';
--Consulta 7:  Clientes con las ventas más grANDes en precio total.
SELECT Nombre, ApellidoP, ApellidoM FROM constar NATURAL JOIN venta NATURAL JOIN cliente ORDER BY preciototal DESC limit 10;

--Consulta 8: Información de sucursales que comparten calle con 3 o más sucursales distintas.
SELECT *
FROM sucursal
WHERE calle  IN(
	SELECT calle  FROM sucursal
	group by calle 
	HAVING COUNT(*)>=4
);

--Consulta 9: Productos de electrónica con precios por encima de la media
SELECT idelectronica, nombre, precioalmacenado FROM electronica WHERE precioalmacenado >=
(SELECT avg(precioalmacenado) FROM electronica);

--Consulta 10: Productos empacados cuya presentación es la más común de su categoría.
SELECT idnoperecedero, nombre, precioalmacenado, presentacion  FROM noperecedero WHERE presentacion  = (
SELECT       presentacion
    FROM     noperecedero
    GROUP BY presentacion 
    ORDER BY COUNT(*) DESC
    LIMIT    1)
 union
 SELECT idperecedero, nombre, precioalmacenado, presentacion  FROM perecedero WHERE presentacion  = (
SELECT       presentacion
    FROM     perecedero
    GROUP BY presentacion 
    ORDER BY COUNT(*) DESC
    LIMIT    1);

-- Consulta 11: Productos de perecedero con precios por debajo de la media
SELECT idperecedero, nombre, precioalmacenado FROM perecedero WHERE precioalmacenado >=
(SELECT avg(precioalmacenado) FROM perecedero);

-- Consulta 12: Clientes cuya edad sea menor o igual a 30 años
SELECT DATE_PART('year', CURRENT_DATE) - DATE_PART('year', fechanacimiento) AS edad
FROM cliente
WHERE DATE_PART('year', AGE(CURRENT_DATE, fechanacimiento)) <= 30;

-- Consulta 13: Cajeros que cumplan años antes de julio
SELECT nombre,fechanacimiento
FROM (
  SELECT nombre,fechanacimiento
  FROM cajero
  WHERE EXTRACT(MONTH FROM fechanacimiento) < 6

  UNION

  SELECT nombre,fechanacimiento
  FROM encargado
  WHERE EXTRACT(MONTH FROM fechanacimiento) < 6

  UNION

  SELECT nombre,fechanacimiento
  FROM gerente
  WHERE EXTRACT(MONTH FROM fechanacimiento) < 6
) AS empleados;

-- Consulta 14: Encargados de las sucursales con nombre "Xochimilco" o "Milpa Alta"
SELECT *
FROM encargado
WHERE idsucursal IN (
SELECT idsucursal
FROM sucursal
WHERE nombre IN ('Xochimilco', 'Milpa Alta')
);

-- Consulta 15: Cajeros cuyo sueldo esta por encima de la media
SELECT * FROM cajero WHERE sueldo >
(SELECT avg(sueldo) FROM cajero);