/*
## Título: Procedimiento almacenado para insertar en la tabla venta.

### Descripción:
Este procedimiento permite insertar una nueva fila en la tabla "venta" con los valores proporcionados.

### Parámetros:
- $1 (integer): ID de la venta.
- $2 (varchar(18)): CURP del cliente.
- $3 (varchar(18)): CURP del cajero.
- $4 (integer): ID de la sucursal.
- $5 (varchar(50)): Nombre del cliente.
- $6 (varchar(50)): Nombre del cajero.
- $7 (varchar(50)): Nombre de la sucursal.

### Tablas afectadas:
- venta: Se inserta una nueva fila en esta tabla con los valores especificados.

### Lógica:
El procedimiento ejecuta una sentencia SQL para insertar una nueva fila en la tabla "venta" utilizando los valores proporcionados como parámetros.
*/
CREATE OR REPLACE PROCEDURE inserta_venta(
	integer,
	varchar(18),
	varchar(18),
	integer,
	varchar(50),
	varchar(50),
	varchar(50))
AS 
$$
	INSERT INTO Venta(IDVenta,CURPCliente,CURPCajero,IDSucursal,NombreCliente,NombreCajero,NombreSucursal) VALUES ($1,$2,$3,$4,$5,$6,$7);
$$
LANGUAGE sql;

/*
## Título: Procedimiento almacenado para insertar en la tabla pago.

### Descripción:
Este procedimiento permite insertar una nueva fila en la tabla "pago" con los valores proporcionados.

### Parámetros:
- $1 (integer): ID del pago.
- $2 (integer): Monto del pago.
- $3 (boolean): Indica si el pago es a través de crédito.
- $4 (boolean): Indica si el pago es en efectivo.
- $5 (boolean): Indica si el pago es con tarjeta de débito.

### Tablas afectadas:
- pago: Se inserta una nueva fila en esta tabla con los valores especificados.

### Lógica:
El procedimiento ejecuta una sentencia SQL para insertar una nueva fila en la tabla "pago" utilizando los valores proporcionados como parámetros.
*/
CREATE OR REPLACE PROCEDURE inserta_pago(
	integer,
	integer,
	boolean,
	boolean,
	boolean)
AS 
$$
	INSERT INTO Pago(IDPago,Monto,EsCredito,EsEfectivo,EsDebito) VALUES ($1,$2,$3,$4,$5);
$$
LANGUAGE sql;

/*
## Título: Procedimiento almacenado para insertar en la tabla registrar.

### Descripción:
Este procedimiento permite insertar una nueva fila en la tabla "registrar" con los valores proporcionados.

### Parámetros:
- $1 (integer): ID del registro.
- $2 (integer): ID de la venta asociada al registro.
- $3 (integer): Monto del registro.

### Tablas afectadas:
- registrar: Se inserta una nueva fila en esta tabla con los valores especificados.

### Lógica:
El procedimiento ejecuta una sentencia SQL para insertar una nueva fila en la tabla "registrar" utilizando los valores proporcionados como parámetros.
*/
CREATE OR REPLACE PROCEDURE inserta_registrar(
	int,
	int,
	int)
AS
$$
	INSERT INTO Registrar(IDPago,IDVenta,Monto) VALUES ($1,$2,$3);
$$
LANGUAGE sql;

/*
## Título: Función para generar el ID de la siguiente venta.

### Descripción:
Esta función devuelve el ID de la última venta registrada en la tabla "venta" más 1, lo que permite generar un nuevo ID único para la siguiente venta.

### Valor de retorno:
- integer: ID de la siguiente venta.

### Tablas relacionadas:
- venta: Se consulta el valor máximo del campo "idventa" para obtener el último ID de venta registrado.

### Lógica:
La función ejecuta una sentencia SQL para obtener el valor máximo del campo "idventa" de la tabla "venta". Luego, devuelve este valor incrementado en 1.
*/
CREATE OR REPLACE FUNCTION genera_id_venta() RETURNS integer
AS 
$$
DECLARE
	max_id int;
BEGIN
	SELECT MAX(IDVenta) INTO max_id FROM Venta;
	RETURN max_id + 1;
END;
$$
LANGUAGE plpgsql;

/*
## Título: Función para generar el ID del siguiente pago.

### Descripción:
Esta función devuelve el ID del último pago registrado en la tabla "pago" más 1, lo que permite generar un nuevo ID único para el siguiente pago.

### Valor de retorno:
- integer: ID del siguiente pago.

### Tablas relacionadas:
- pago: Se consulta el valor máximo del campo "idpago" para obtener el último ID de pago registrado.

### Lógica:
La función ejecuta una sentencia SQL para obtener el valor máximo del campo "idpago" de la tabla "pago". Luego, devuelve este valor incrementado en 1.
*/
CREATE OR REPLACE FUNCTION genera_id_pago() RETURNS integer
AS 
$$
DECLARE
	max_id int;
BEGIN
	SELECT MAX(IDPago) INTO max_id FROM Pago;
	RETURN max_id + 1;
END;
$$
LANGUAGE plpgsql;

/*
## Título: Función para calcular el monto total de una compra.

### Descripción:
Esta función recibe como parámetros dos arreglos: "ids_producto" y "cantidad_productos". Calcula el monto total de la compra sumando el precio individual de cada producto multiplicado por la cantidad correspondiente.

### Parámetros:
- ids_producto: Arreglo de enteros que contiene los IDs de los productos.
- cantidad_productos: Arreglo de enteros que contiene las cantidades de cada producto.

### Valor de retorno:
- integer: Monto total de la compra.

### Tablas relacionadas:
- perecedero, noperecedero, electronica: Se consultan los precios individuales de los productos en estas tablas.

### Lógica:
La función utiliza un bucle while para iterar sobre los elementos de los arreglos "ids_producto" y "cantidad_productos". Para cada ID de producto, realiza una serie de consultas condicionales para obtener el precio individual correspondiente desde las tablas "perecedero", "noperecedero" y "electronica". Luego, suma al monto total el resultado de multiplicar el precio individual por la cantidad correspondiente. Finalmente, devuelve el monto total calculado.
*/
CREATE OR REPLACE FUNCTION calcula_monto(ids_producto INT[], cantidad_productos INT[]) RETURNS integer
AS 
$$
DECLARE
	i int := 1;
	n int := array_length(ids_producto,1);
	id_producto int;
	p Perecedero%ROWTYPE;
	np NoPerecedero%ROWTYPE;
	e Electronica%ROWTYPE;
	precio_individual int;
	monto int := 0;
BEGIN
	WHILE (i <= n)
		LOOP
		id_producto := ids_producto[i];
		IF (SELECT COUNT(*) FROM Perecedero WHERE IDPerecedero = id_producto) = 1 THEN
			SELECT * INTO p FROM Perecedero WHERE IDPerecedero = id_producto;
			precio_individual := p.precioalmacenado;
		END IF;
		IF (SELECT COUNT(*) FROM NoPerecedero WHERE IDNoPerecedero = id_producto) = 1 THEN
			SELECT * INTO np FROM NoPerecedero WHERE IDNoPerecedero = id_producto;
			precio_individual := np.precioalmacenado;
		END IF;
		IF (SELECT COUNT(*) FROM Electronica WHERE IDElectronica = id_producto) = 1 THEN
			SELECT * INTO e FROM Electronica WHERE IDElectronica = id_producto;
			precio_individual := e.precioalmacenado;
		END IF;
		monto = monto + (precio_individual * (cantidad_productos[i]));
		i := i + 1;
		END LOOP;
	RETURN monto;
END;
$$
language plpgsql;

/*
## Título: Procedimiento para generar una venta.

### Descripción:
Este procedimiento permite generar una venta en el sistema. Recibe como parámetros la información necesaria para realizar la venta, como el CURP del cliente, el CURP del cajero, el ID de la sucursal, el tipo de pago, los IDs de los productos y las cantidades correspondientes.

### Parámetros:
- curp_cliente: VARCHAR(18) - CURP del cliente que realiza la compra.
- curp_cajero: VARCHAR(18) - CURP del cajero encargado de cobrar la venta.
- id_sucursal: INT - ID de la sucursal donde se realiza la venta.
- tipo_pago: VARCHAR(8) - Tipo de pago utilizado en la venta (credito, efectivo o debito).
- ids_producto: INT[] - Arreglo de IDs de los productos vendidos.
- cantidad_productos: INT[] - Arreglo de las cantidades correspondientes de cada producto.

### Tablas afectadas:
- cliente, cajero, sucursal: Se consultan los datos del cliente, cajero y sucursal involucrados en la venta.
- venta, pago, registrar: Se insertan registros en estas tablas para registrar la venta y el pago.

### Lógica:
El procedimiento realiza las siguientes operaciones:
1. Obtiene la información del cliente, cajero y sucursal mediante consultas a las respectivas tablas.
2. Genera el ID de la venta llamando a la función "genera_id_venta()".
3. Genera el ID del pago llamando a la función "genera_id_pago()".
4. Calcula el monto total de la venta llamando a la función "calcula_monto(ids_producto, cantidad_productos)".
5. Inserta un registro en la tabla "venta" utilizando el procedimiento "inserta_venta" con los parámetros correspondientes.
6. Inserta un registro en la tabla "pago" utilizando el procedimiento "inserta_pago" con los parámetros correspondientes, dependiendo del tipo de pago.
7. Inserta un registro en la tabla "registrar" utilizando el procedimiento "inserta_registrar" con los parámetros correspondientes.
*/
CREATE OR REPLACE PROCEDURE venta(
	curp_cliente VARCHAR(18),
	curp_cajero VARCHAR(18),
	id_sucursal int,
	tipo_pago VARCHAR(8),
	ids_producto INT[],
	cantidad_productos INT[])
AS $$
DECLARE
	i int;
	resultado int := 0;
	cli Cliente%ROWTYPE; -- Cliente que realizó la compra
	caj Cajero%ROWTYPE; -- Cajero que realizó el cobro
	suc Sucursal%ROWTYPE; -- Sucursal dónde se realizó la venta
	id_venta int := genera_id_venta(); -- Id de la venta
	id_pago int := genera_id_pago(); -- Id del pago
	monto int := calcula_monto(ids_producto,cantidad_productos); -- Monto de la venta
BEGIN
	-- Información del cliente
	SELECT * INTO cli FROM Cliente WHERE CurpCliente = curp_cliente;
	-- Información del cajero
	SELECT * INTO caj FROM Cajero WHERE CurpCajero = curp_cajero;
	-- Información de la sucursal
	SELECT * INTO suc FROM Sucursal WHERE IDSucursal = id_sucursal;
	-- Insertamos en venta
	CALL inserta_venta(id_venta,curp_cliente,curp_cajero,id_sucursal,cli.nombre,caj.nombre,suc.nombre);
	-- Insertamos en Pago
	IF (tipo_pago = 'credito') THEN
		CALL inserta_pago(id_pago,monto,TRUE,FALSE,FALSE);
	END IF;
	IF (tipo_pago = 'efectivo') THEN
		CALL inserta_pago(id_pago,monto,FALSE,TRUE,FALSE);
	END IF;
	IF (tipo_pago = 'debido') THEN
		CALL inserta_pago(id_pago,monto,FALSE,FALSE,TRUE);
	END IF;
	-- Insertamos en registrar
	CALL inserta_registrar(id_pago,id_venta,monto);
END;
$$
LANGUAGE plpgsql;

-- Disparador: actualizacion_sucursal
-- Tabla asociada: sucursal
-- Evento disparador: UPDATE (actualización)
-- Función del disparador: check_sucursal()

-- Descripción: 
-- El disparador "actualizacion_sucursal" se ejecuta después de una operación de actualización en la tabla "sucursal". 
-- Su propósito es verificar si se está intentando cambiar el nombre de una sucursal.
CREATE OR REPLACE FUNCTION check_sucursal() RETURNS TRIGGER
AS
$$
DECLARE
	nombre_sucursal varchar(50);
BEGIN
	IF (TG_OP = 'UPDATE') THEN
		SELECT Nombre INTO nombre_sucursal FROM Sucursal WHERE IDSucursal = NEW.idsucursal;
		IF nombre_sucursal <> OLD.nombre THEN
			RAISE EXCEPTION 'No se puede cambiar el nombre de una sucursal';
		END IF;
	END IF;
	RETURN null;
END;
$$
LANGUAGE plpgsql;

-- Creamos el disparador
CREATE TRIGGER actualizacion_sucursal
AFTER UPDATE ON Sucursal
FOR EACH ROW
EXECUTE PROCEDURE check_sucursal();

-- Disparador: actualizacion_sucursal_fecha
-- Tabla asociada: sucursal
-- Evento disparador: UPDATE (actualización)
-- Función del disparador: check_sucursal_fecha()

-- Descripción: 
-- El disparador "actualizacion_sucursal_fecha" se ejecuta después de una operación de actualización en la tabla "sucursal". 
-- Su propósito es verificar si se está intentando cambiar la fecha de apertura de una sucursal.
CREATE OR REPLACE FUNCTION check_sucursal_fecha() RETURNS TRIGGER
AS
$$
DECLARE
	fecha DATE;
BEGIN
	IF (TG_OP = 'UPDATE') THEN
		SELECT FechaApertura INTO fecha FROM Sucursal WHERE IDSucursal = NEW.idsucursal;
		IF fecha <> OLD.fechaapertura THEN
			RAISE EXCEPTION 'No se puede cambiar la fecha de una sucursal';
		END IF;
	END IF;
	RETURN null;
END;
$$
LANGUAGE plpgsql;

-- Creamos el disparador
CREATE TRIGGER actualizacion_sucursal_fecha
AFTER UPDATE ON Sucursal
FOR EACH ROW
EXECUTE PROCEDURE check_sucursal_fecha();

-- Ejemplo procedimientos
-- SELECT venta('UFBH153244HTXXVNN5','VIOX223362LDGERMV1',300,'efectivo',ARRAY[1,2,3],ARRAY[10,20,30]);

-- Ejemplo disparadores
-- UPDATE Sucursal SET Nombre = 'Madero' WHERE IDSucursal = 300;
-- UPDATE Sucursal SET FechaApertura = '2002-08-24' WHERE IDSucursal = 300;