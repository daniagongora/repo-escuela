-- FUNCIONES

-- Insertar en Venta
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

-- Insertar en Pago
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

-- Inserta en Registrar
CREATE OR REPLACE PROCEDURE inserta_registrar(
	int,
	int,
	int)
AS
$$
	INSERT INTO Registrar(IDPago,IDVenta,Monto) VALUES ($1,$2,$3);
$$
LANGUAGE sql;

-- Función que regresa el id de la última venta más 1
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

-- Función que regresa el id del último pago más 1
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

-- Función que calcula el monto
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
LANGUAGE plpgsql;

-- Función para generar una venta
CREATE OR REPLACE PROCEDURE venta(
	curp_cliente VARCHAR(18),
	curp_cajero VARCHAR(18),
	id_sucursal int,
	tipo_pago VARCHAR(8),
	ids_producto INT[],
	cantidad_productos INT[])
AS
$$
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
	-- Insertamos en Venta
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
	-- Insertamos en Registrar
	CALL inserta_registrar(id_pago,id_venta,monto);
END;
$$
LANGUAGE plpgsql;