--Consulta 1: Empleados cuyo nombre empiece con la letra C.-- 
SELECT Nombre FROM cajero WHERE nombre LIKE 'C%'
UNION
SELECT Nombre FROM encargado WHERE nombre LIKE 'C%'
UNION
SELECT Nombre FROM gerente WHERE nombre LIKE 'C%'

--Consulta 2: Clientes que hayan nacido en el mes de Junio.--
SELECT * FROM Cliente WHERE EXTRACT(MONTH FROM FechaNacimiento) = 6

