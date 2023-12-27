-- CREACIÓN DE TABLAS

-- Tabla Cliente
create table Cliente(
	IDCliente integer,
	Nombre varchar(15),
	ApellidoP varchar(15),
	ApellidoM varchar(15),
	Calle varchar(15),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(20),
	FechaNacimiento date 
);

-- Primary key de la tabla Cliente
alter table Cliente
add constraint pk_Cliente 
primary key (IDCliente);

-- Comentarios de la tabla Cliente
comment on table Cliente is 'Tabla que contiene la información de los clientes';
comment on column Cliente.IDCliente is 'Identificador del cliente';
comment on column Cliente.Nombre is 'Nombre de pila del cliente';
comment on column Cliente.ApellidoP is 'Apellido paterno del cliente';
comment on column Cliente.ApellidoM is 'Apellido materno del cliente';
comment on column Cliente.Calle is 'Nombre de la calle donde vive el cliente';
comment on column Cliente.Numero is 'Número de la calle donde vive el cliente';
comment on column Cliente.CodigoPostal is 'Código postal de donde vive el cliente';
comment on column Cliente.Alcaldia is 'Alcaldia donde vive el cliente';
comment on column Cliente.FechaNacimiento is 'Fecha de nacimiento del cliente';

-- Restricciones de la tabla Cliente
alter table Cliente alter column Nombre set not NULL;
alter table Cliente alter column ApellidoP set not NULL;
alter table Cliente alter column ApellidoM set not NULL;
alter table Cliente alter column Calle set not NULL;
alter table Cliente alter column CodigoPostal set not NULL;
alter table Cliente add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Cliente alter column FechaNacimiento set not NULL;
alter table Cliente add constraint FechaNacimiento check (FechaNacimiento <= current_date);
alter table Cliente alter column IDCliente set not NULL;
alter table Cliente add constraint IDCliente unique (IDCliente);

-- Tabla TelefonoCliente
create table TelefonoCliente(
	IDCliente integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint pk_TelefonoCliente
primary key (Telefono);

-- Comentarios de la tabla TelefonoCliente 
comment on table TelefonoCliente is 'Tabla con la información de los teléfonos de los clientes';
comment on column TelefonoCliente.IDCliente is 'Foreign key que conecta con el IDCliente';
comment on column TelefonoCliente.Telefono is 'El teléfono del cliente';

-- Restricciones de la tabla TelefonoCliente
alter table TelefonoCliente alter column Telefono set not NULL;
alter table TelefonoCliente add constraint Telefono check (length (cast (Telefono as TEXT)) = 10);
alter table TelefonoCliente alter column IDCliente set not NULL;

-- Tabla CorreoCliente
create table CorreoCliente(
	IDCliente integer,
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint pk_CorreoCliente
primary key (Correo);

-- Comentarios de la tabla CorreoCliente
comment on table CorreoCliente is 'Tabla con la información de los correos de los clientes';
comment on column CorreoCliente.IDCliente is 'Foreign key que conecta con el IDCliente';
comment on column CorreoCliente.Correo is 'El correo del cliente';

-- Restricciones de la tabla CorreoCliente
alter table CorreoCliente alter column Correo set not NULL;
alter table CorreoCliente add constraint CorreoC1 check (Correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table CorreoCliente alter column IDCliente set not NULL;

-- Tabla Cajero
create table Cajero(
	IDCajero integer,
	IDSucursal integer,
	Nombre varchar(15),
	ApellidoP varchar(15),
	ApellidoM varchar(15),
	Calle varchar(15),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(20),
	FechaNacimiento date,
	NSS varchar(11),
	DNI varchar(9),
	Sueldo double precision,
	NumDiasVacaciones integer,
	FechaIngreso date
);

-- Primary key de la Tabla Cajero
alter table Cajero
add constraint pk_Cajero
primary key (IDCajero);

-- Comentarios de la tabla Cajero
comment on table Cajero is 'Tabla que contiene la información de los cajeros';
comment on column Cajero.IDCajero is 'Identificador del cajero';
comment on column Cajero.IDSucursal is 'Foreign key que conecta con el IDSucursal';
comment on column Cajero.Nombre is 'Nombre de pila del cajero';
comment on column Cajero.ApellidoP is 'Apellido paterno del cajero';
comment on column Cajero.ApellidoM is 'Apellido materno del cajero';
comment on column Cajero.Calle is 'Nombre de la calle donde vive el cajero';
comment on column Cajero.Numero is 'Número de la calle donde vive el cajero';
comment on column Cajero.CodigoPostal is 'Código postal de donde vive el cajero';
comment on column Cajero.Alcaldia is 'Alcaldia donde vive el cajero';
comment on column Cajero.FechaNacimiento is 'Fecha de nacimiento del cajero';
comment on column Cajero.NSS is 'Número de Seguro Social del cajero';
comment on column Cajero.DNI is 'Número que representa al Documento Nacional de Identificación del cajero';
comment on column Cajero.Sueldo is 'Sueldo del cajero';
comment on column Cajero.NumDiasVacaciones is 'Número de días de vacaciones del cajero';
comment on column Cajero.FechaIngreso is 'Fecha en la que ingresó a trabajar el cajero';

-- Restricciones de la tabla Cajero
alter table Cajero alter column Nombre set not NULL;
alter table Cajero alter column ApellidoP set not NULL;
alter table Cajero alter column ApellidoM set not NULL;
alter table Cajero alter column Calle set not NULL;
alter table Cajero alter column CodigoPostal set not NULL;
alter table Cajero add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Cajero alter column FechaNacimiento set not NULL;
alter table Cajero add constraint FechaNacimiento check (FechaNacimiento <= current_date);
alter table Cajero alter column NSS set not NULL;
alter table Cajero alter column DNI set not NULL;
alter table Cajero alter column Sueldo set not NULL;
alter table Cajero add constraint Sueldo check (Sueldo >= 0);
alter table Cajero alter column IDCajero set not NULL;
alter table Cajero add constraint IDCajero unique (IDCajero);
alter table Cajero alter column IDSucursal set not NULL;
alter table Cajero add constraint IDSucursal unique (IDSucursal);

-- Tabla TelefonoCajero
create table TelefonoCajero(
	IDCajero integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoCajero
alter table TelefonoCajero
add constraint pk_TelefonoCajero
primary key (Telefono);

-- Comentarios de la tabla TelefonoCajero 
comment on table TelefonoCajero is 'Tabla con la información de los teléfonos de los cajeros';
comment on column TelefonoCajero.IDCajero is 'Foreign key que conecta con el IDCajero';
comment on column TelefonoCajero.Telefono is 'El teléfono del cajero';

-- Restricciones de la tabla TelefonoCajero
alter table TelefonoCajero alter column Telefono set not NULL;
alter table TelefonoCajero add constraint Telefono check (length (cast (Telefono as TEXT)) = 10);
alter table TelefonoCajero alter column IDCajero set not NULL;

-- Tabla CorreoCajero
create table CorreoCajero(
	IDCajero integer,
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoCajero
alter table CorreoCajero
add constraint pk_CorreoCajero
primary key (Correo);

-- Comentarios de la tabla CorreoCajero
comment on table CorreoCajero is 'Tabla con la información de los correos de los cajeros';
comment on column CorreoCajero.IDCajero is 'Foreign key que conecta con el IDCajero';
comment on column CorreoCajero.Correo is 'El correo del cajero';

-- Restricciones de la tabla CorreoCajero
alter table CorreoCajero alter column Correo set not NULL;
alter table CorreoCajero add constraint CorreoC1 check (Correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table CorreoCajero alter column IDCajero set not NULL;

-- Tabla Sucursal
create table Sucursal(
	IDSucursal integer,
	Nombre varchar(15),
	Calle varchar(15),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(20),
	NumCuentaBancaria integer,
	PaginaWeb varchar(40),
	DNI varchar(9),
	HoraApertura time,
	FechaApertura date,
	HoraCierre time
);

-- Primary key de la Tabla Sucursal
alter table Sucursal
add constraint pk_Sucursal
primary key(IDSucursal);

-- Comentarios de la tabla Sucursal
comment on table Sucursal is 'Tabla con la información de las sucursales';
comment on column Sucursal.IDSucursal is 'Identificador de la sucursal';
comment on column Sucursal.Nombre is 'Nombre de la sucursal';
comment on column Sucursal.Calle is 'La calle de la sucursal'; 
comment on column Sucursal.Numero is 'El número de la calle';
comment on column Sucursal.CodigoPostal is 'El código postal de la sucursal';
comment on column Sucursal.Alcaldia is 'La alcaldia en la que se encuentra la sucursal';
comment on column Sucursal.NumCuentaBancaria is 'El número de cuenta bancaria de la sucursal';
comment on column Sucursal.PaginaWeb is 'La página web de la sucursal';
comment on column Sucursal.DNI is 'El DNI de la sucursal';
comment on column Sucursal.HoraApertura is 'La hora de apertura de la sucursal';
comment on column Sucursal.FechaApertura is 'La fecha de apertura de la sucursal';
comment on column Sucursal.HoraCierre is 'La hora de cierre de la sucursal';

-- Restricciones de la tabla Sucursal
alter table Sucursal alter column Nombre set not NULL;
alter table Sucursal alter column Calle set not NULL;
alter table Sucursal alter column CodigoPostal set not NULL;
alter table Sucursal add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Sucursal alter column Alcaldia set not NULL;
alter table Sucursal alter column NumCuentaBancaria set not NULL;
alter table Sucursal alter column PaginaWeb set not NULL;
alter table Sucursal add constraint PaginaWeb check (PaginaWeb ~* '^((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)?$');
alter table Sucursal alter column DNI set not NULL;
alter table Sucursal alter column HoraApertura set not NULL;
alter table Sucursal alter column FechaApertura set not NULL;
alter table Sucursal add constraint FechaApertura check (FechaApertura <= current_date);
alter table Sucursal alter column HoraCierre set not NULL;
alter table Sucursal alter column IDSucursal set not NULL;

-- Tabla TelefonoSucursal
create table TelefonoSucursal(
	IDSucursal integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoSucursal
alter table TelefonoSucursal
add constraint pk_TelefonoSucursal
primary key(Telefono);

-- Comentarios de la tabla TelefonoSucursal
comment on table TelefonoSucursal is 'Tabla con los telefonos de la sucursal';
comment on column TelefonoSucursal.IDSucursal is 'Foreign key que conecta con el IDSucursal';
comment on column TelefonoSucursal.Telefono is 'El telefono de la sucursal';

-- Restricciones de la tabla TelefonoSucursal
alter table TelefonoSucursal alter column Telefono set not NULL;
alter table TelefonoSucursal add constraint Telefono check (length (cast (Telefono as TEXT)) = 10);
alter table TelefonoSucursal alter column IDSucursal set not NULL;

-- Tabla Gerente
create table Gerente(
	IDGerente integer, 
	IDSucursal integer, 
	Nombre varchar(15), 
	ApellidoP varchar(15), 
	ApellidoM varchar(15), 
	Calle varchar(15), 
	Numero integer, 
	CodigoPostal integer, 
	Alcaldia varchar(20), 
	FechaNacimiento date, 
	NSS varchar(11), 
	DNI varchar(9), 
	Sueldo double precision, 
	NumDiasVacaciones integer, 
	FechaIngreso date
);

-- Primary key de la Tabla Gerente
alter table Gerente 
add constraint pk_Gerente
primary key (IDGerente);

-- Comentarios de la tabla Gerente
comment on table Gerente is 'Tabla que contiene la información de los gerentes';
comment on column Gerente.IDGerente is 'Identificador del gerente';
comment on column Gerente.IDSucursal is 'Foreign key que conecta con el IDSucursal';
comment on column Gerente.Nombre is 'Nombre de pila del gerente';
comment on column Gerente.ApellidoP is 'Apellido paterno del gerente';
comment on column Gerente.ApellidoM is 'Apellido materno del gerente';
comment on column Gerente.Calle is 'Nombre de la calle donde vive el gerente';
comment on column Gerente.Numero is 'Número de la calle donde vive el gerente';
comment on column Gerente.CodigoPostal is 'Código postal de donde vive el gerente';
comment on column Gerente.Alcaldia is 'Alcaldia donde vive el gerente';
comment on column Gerente.FechaNacimiento is 'Fecha de nacimiento del gerente';
comment on column Gerente.NSS is 'Número de Seguro Social del gerente';
comment on column Gerente.DNI is 'Número que representa al Documento Nacional de Identificación del gerente';
comment on column Gerente.Sueldo is 'Sueldo del gerente';
comment on column Gerente.NumDiasVacaciones is 'Número de días de vacaciones del gerente';
comment on column Gerente.FechaIngreso is 'Fecha en la que ingresó a trabajar el gerente';

-- Restricciones de la tabla Gerente
alter table Gerente alter column Nombre set not NULL;
alter table Gerente alter column ApellidoP set not NULL;
alter table Gerente alter column ApellidoM set not NULL;
alter table Gerente alter column Calle set not NULL;
alter table Gerente alter column CodigoPostal set not NULL;
alter table Gerente add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Gerente alter column FechaNacimiento set not NULL;
alter table Gerente add constraint FechaNacimiento check (FechaNacimiento <= current_date);
alter table Gerente alter column NSS set not NULL;
alter table Gerente alter column DNI set not NULL;
alter table Gerente alter column Sueldo set not NULL;
alter table Gerente add constraint Sueldo check (Sueldo >= 0);
alter table Gerente alter column IDGerente set not NULL;
alter table Gerente add constraint IDGerente unique (IDGerente);
alter table Gerente alter column IDSucursal set not NULL;

-- Tabla TelefonoGerente
create table TelefonoGerente(
	IDGerente integer, 
	Telefono integer
);

-- Primary key de la Tabla TelefonoGerente
alter table TelefonoGerente
add constraint pk_TelefonoGerente
primary key (Telefono);

-- Comentarios de la tabla TelefonoGerente 
comment on table TelefonoGerente is 'Tabla con la información de los teléfonos de los gerentes';
comment on column TelefonoGerente.IDGerente is 'Foreign key que conecta con el IDGerente';
comment on column TelefonoGerente.Telefono is 'El teléfono del gerente';

-- Restricciones de la tabla TelefonoGerente
alter table TelefonoGerente alter column Telefono set not NULL;
alter table TelefonoGerente add constraint Telefono check (length (cast (Telefono as TEXT)) = 10);
alter table TelefonoGerente alter column IDGerente set not NULL;

-- Tabla CorreoGerente
create table CorreoGerente(
	IDGerente integer, 
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoGerente
alter table CorreoGerente
add constraint pk_CorreoGerente
primary key (Correo);

-- Comentarios de la tabla CorreoGerente
comment on table CorreoGerente is 'Tabla con la información de los correos de los gerentes';
comment on column CorreoGerente.IDGerente is 'Foreign key que conecta con el IDGerente';
comment on column CorreoGerente.Correo is 'El correo del gerente';

-- Restricciones de la tabla CorreoGerente
alter table CorreoGerente alter column Correo set not NULL;
alter table CorreoGerente add constraint CorreoC1 check (Correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table CorreoGerente alter column IDGerente set not NULL;

-- Tabla Encargado
create table Encargado(
	IDEncargado integer, 
	IDSucursal integer, 
	Nombre varchar(15), 
	ApellidoP varchar(15), 
	ApellidoM varchar(15), 
	Calle varchar(15), 
	Numero integer, 
	CodigoPostal integer, 
	Alcaldia varchar(20), 
	FechaNacimiento date, 
	NSS varchar(11), 
	DNI varchar(9), 
	Sueldo double precision, 
	NumDiasVacaciones integer, 
	FechaIngreso date
);

-- Primary key de la Tabla Encargado
alter table Encargado 
add constraint pk_Encargado
primary key (IDEncargado);

-- Comentarios de la tabla Encargado
comment on table Encargado is 'Tabla que contiene la información de los encargados';
comment on column Encargado.IDEncargado is 'Identificador del encargado';
comment on column Encargado.IDSucursal is 'Foreign key que conecta con el IDSucursal';
comment on column Encargado.Nombre is 'Nombre de pila del encargado';
comment on column Encargado.ApellidoP is 'Apellido paterno del encargado';
comment on column Encargado.ApellidoM is 'Apellido materno del encargado';
comment on column Encargado.Calle is 'Nombre de la calle donde vive el encargado';
comment on column Encargado.Numero is 'Número de la calle donde vive el encargado';
comment on column Encargado.CodigoPostal is 'Código postal de donde vive el encargado';
comment on column Encargado.Alcaldia is 'Alcaldia donde vive el encargado';
comment on column Encargado.FechaNacimiento is 'Fecha de nacimiento del encargado';
comment on column Encargado.NSS is 'Número de Seguro Social del encargado';
comment on column Encargado.DNI is 'Número que representa al Documento Nacional de Identificación del encargado';
comment on column Encargado.Sueldo is 'Sueldo del encargado';
comment on column Encargado.NumDiasVacaciones is 'Número de días de vacaciones del encargado';
comment on column Encargado.FechaIngreso is 'Fecha en la que ingresó a trabajar el encargado';

-- Restricciones de la tabla Encargado
alter table Encargado alter column Nombre set not NULL;
alter table Encargado alter column ApellidoP set not NULL;
alter table Encargado alter column ApellidoM set not NULL;
alter table Encargado alter column Calle set not NULL;
alter table Encargado alter column CodigoPostal set not NULL;
alter table Encargado add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Encargado alter column FechaNacimiento set not NULL;
alter table Encargado add constraint FechaNacimiento check (FechaNacimiento <= current_date);
alter table Encargado alter column NSS set not NULL;
alter table Encargado alter column DNI set not NULL;
alter table Encargado alter column Sueldo set not NULL;
alter table Encargado add constraint Sueldo check (Sueldo >= 0);
alter table Encargado alter column IDEncargado set not NULL;
alter table Encargado add constraint IDEncargado unique (IDEncargado);
alter table Encargado alter column IDSucursal set not NULL;

-- Tabla TelefonoEncargado
create table TelefonoEncargado(
	IDEncargado integer, 
	Telefono integer
);

-- Primary key de la Tabla TelefonoEncargado
alter table TelefonoEncargado
add constraint pk_TelefonoEncargado
primary key (Telefono);

-- Comentarios de la tabla TelefonoEncargado 
comment on table TelefonoEncargado is 'Tabla con la información de los teléfonos de los encargados';
comment on column TelefonoEncargado.IDEncargado is 'Foreign key que conecta con el IDEncargado';
comment on column TelefonoEncargado.Telefono is 'El teléfono del encargado';

-- Restricciones de la tabla TelefonoEncargado
alter table TelefonoEncargado alter column Telefono set not NULL;
alter table TelefonoEncargado add constraint Telefono check (length (cast (Telefono as TEXT)) = 10);
alter table TelefonoEncargado alter column IDEncargado set not NULL;

-- Tabla CorreoEncargado
create table CorreoEncargado(
	IDEncargado integer, 
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoEncargado
alter table CorreoEncargado
add constraint pk_CorreoEncargado
primary key (Correo);

-- Comentarios de la tabla CorreoEncargado
comment on table CorreoEncargado is 'Tabla con la información de los correos de los encargados';
comment on column CorreoEncargado.IDEncargado is 'Foreign key que conecta con el IDEncargado';
comment on column CorreoEncargado.Correo is 'El correo del encargado';

-- Restricciones de la tabla CorreoEncargado
alter table CorreoEncargado alter column Correo set not NULL;
alter table CorreoEncargado add constraint CorreoC1 check (Correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
alter table CorreoEncargado alter column IDEncargado set not NULL;

-- Tabla Venta
create table Venta(
	IDVenta integer,
	IDCliente integer,
	IDCajero integer,
	IDSucursal integer,
	NombreCliente varchar(64),
	NombreCajero varchar(64),
	NombreSucursal varchar(64)
);

-- Primary key de la Tabla Venta
alter table Venta
add constraint pk_Venta
primary key (IDVenta);

-- Comentarios de la tabla Venta
comment on table Venta is 'Tabla donde se registran las ventas realizadas';
comment on column Venta.IDVenta is 'Identificador de la venta';
comment on column Venta.IDCliente is 'Foreign key que conecta con la tabla Cliente';
comment on column Venta.IDCajero is 'Foreign key que conecta con la tabla Cajero';
comment on column Venta.IDSucursal is 'Foreign key que conecta con la tabla Sucursal';
comment on column Venta.NombreCliente is 'Nombre del cliente involucrado en la venta';
comment on column Venta.NombreCajero is 'Nombre del cajero involucrado en la venta';
comment on column Venta.NombreSucursal is 'Nombre de la sucursal involucrada en la venta';

-- Restricciones de la tabla Venta
alter table Venta alter column NombreCliente set not NULL;
alter table Venta alter column NombreCajero set not NULL;
alter table Venta alter column NombreSucursal set not NULL;
alter table Venta alter column IDVenta set not NULL;
alter table Venta add constraint IDVenta unique (IDVenta);
alter table Venta alter column IDCliente set not NULL;
alter table Venta alter column IDCajero set not NULL;
alter table Venta alter column IDSucursal set not NULL;

-- Tabla Inventario
create table Inventario(
	IDInventario integer,
	TotalInventario integer
);

-- Primary key de la Tabla Inventario
alter table Inventario
add constraint pk_Inventario
primary key(IDInventario);

-- Comentarios de la tabla Inventario
comment on table Inventario is 'Tabla donde se almacenará el inventario';
comment on column Inventario.IDInventario is 'Identificador del inventario';
comment on column Inventario.TotalInventario is 'Indicador del total del inventario';

-- Restricciones de la tabla Inventario
alter table Inventario alter column TotalInventario set not NULL;
alter table Inventario add constraint TotalInventario check (TotalInventario >= 0);
alter table Inventario alter column IDInventario set not NULL;
alter table Inventario add constraint IDInventario unique (IDInventario);

-- Tabla Perecedero
create table Perecedero(
	IDPerecedero integer,
	Nombre varchar(20),
	PrecioAlmacenado integer,
	Marca varchar(20),
	FechaPreparacion date,
	Presentacion varchar(20),
	FechaCaducidad date	
);

-- Primary key de la Tabla Perecedero
alter table Perecedero
add constraint pk_Perecedero
primary key(IDPerecedero);

-- Comentarios de la tabla Perecedero
comment on table Perecedero is 'Tabla con la información de un producto perecedero';
comment on column Perecedero.IDPerecedero is 'Identificador del producto perecedero';
comment on column Perecedero.Nombre is 'Nombre del producto perecedero';
comment on column Perecedero.PrecioAlmacenado is 'El precio del producto perecedero';
comment on column Perecedero.Marca is 'La marca del producto perecedero';
comment on column Perecedero.FechaPreparacion is 'La fecha en que se preparó el producto perecedero';
comment on column Perecedero.Presentacion is 'La presentación en la que viene el producto perecedero';
comment on column Perecedero.FechaCaducidad is 'La fecha en la que caduca el producto perecedero';

-- Restricciones de la tabla Perecedero
alter table Perecedero alter column Nombre set not NULL;
alter table Perecedero alter column PrecioAlmacenado set not NULL;
alter table Perecedero alter column Marca set not NULL;
alter table Perecedero alter column FechaPreparacion set not NULL;
alter table Perecedero add constraint FechaPreparacion check (FechaPreparacion <= current_date);
alter table Perecedero alter column Presentacion set not NULL;
alter table Perecedero alter column FechaCaducidad set not NULL;
alter table Perecedero add constraint FechaCaducidad check (FechaCaducidad >= FechaPreparacion);
alter table Perecedero alter column IDPerecedero set not NULL;
alter table Perecedero add constraint IDPerecedero unique (IDPerecedero);

-- Tabla NoPerecedero
create table NoPerecedero(
	IDNoPerecedero integer,
	Nombre varchar(20),
	PrecioAlmacenado integer,
	Marca varchar(20),
	FechaPreparacion date,
	Presentacion varchar(20),
	FechaCaducidad date
);

-- Primary key de la Tabla NoPerecedero
alter table NoPerecedero
add constraint pk_NoPerecedero
primary key(IDNoPerecedero);

-- Comentarios de la tabla NoPerecedero
comment on table NoPerecedero is 'Tabla con la información de un producto no perecedero';
comment on column NoPerecedero.IDNoPerecedero is 'Identificador del producto no perecedero';
comment on column NoPerecedero.Nombre is 'Nombre del producto no perecedero';
comment on column NoPerecedero.PrecioAlmacenado is 'El precio del producto no perecedero';
comment on column NoPerecedero.Marca is 'La marca del producto no perecedero';
comment on column NoPerecedero.FechaPreparacion is 'La fecha en que se preparó el producto no perecedero';
comment on column NoPerecedero.Presentacion is 'La presentación en la que viene el producto no perecedero';
comment on column NoPerecedero.FechaCaducidad is 'La fecha en la que caduca el producto no perecedero';

-- Restricciones de la tabla NoPerecedero
alter table NoPerecedero alter column Nombre set not NULL;
alter table NoPerecedero alter column PrecioAlmacenado set not NULL;
alter table NoPerecedero alter column Marca set not NULL;
alter table NoPerecedero alter column FechaPreparacion set not NULL;
alter table NoPerecedero add constraint FechaPreparacion check (FechaPreparacion <= current_date);
alter table NoPerecedero alter column Presentacion set not NULL;
alter table NoPerecedero alter column FechaCaducidad set not NULL;
alter table NoPerecedero add constraint FechaCaducidad check (FechaCaducidad >= FechaPreparacion);
alter table NoPerecedero alter column IDNoPerecedero set not NULL;
alter table NoPerecedero add constraint IDNoPerecedero unique (IDNoPerecedero);

-- Tabla Electronica
create table Electronica(
	IDElectronica integer,
	Nombre varchar(15),
	PrecioAlmacenado float(2),
	Marca varchar(15),
	Descripcion varchar(100),
	ConsumoElectrico integer,
	Categoria varchar(30)
);

-- Primary key de la Tabla Electronica
alter table Electronica
add constraint pk_Electronica
primary key(IDElectronica);

-- Comentarios de la tabla Electronica
comment on table Electronica is 'Tabla donde se almacena los datos de los productos de electronica';
comment on column Electronica.IDElectronica is 'Identificador de los productos de electronica';
comment on column Electronica.Nombre is 'Nombre del producto de electronica';
comment on column Electronica.PrecioAlmacenado is 'Precio del producto de electronica';
comment on column Electronica.Marca is 'El nombre de la marca del producto de electronica';
comment on column Electronica.Descripcion is 'Descripción breve del producto';
comment on column Electronica.ConsumoElectrico is 'Cantidad del consumo eléctrico del producto';
comment on column Electronica.Categoria is 'Categoria a la que pertenece el producto';

-- Restricciones de la tabla Electronica
alter table Electronica alter column Nombre set not NULL;
alter table Electronica alter column PrecioAlmacenado set not NULL;
alter table Electronica add constraint PrecioAlmacenado check (PrecioAlmacenado >= 0);
alter table Electronica alter column Marca set not NULL;
alter table Electronica alter column ConsumoElectrico set not NULL;
alter table Electronica add constraint ConsumoElectrico check (ConsumoElectrico >= 0);
alter table Electronica alter column Categoria set not NULL;
alter table Electronica alter column IDElectronica set not NULL;
alter table Electronica add constraint IDElectronica unique (IDElectronica);

-- Tabla Pago
create table Pago(
	IDPago integer,
	Monto integer,
	EsCredito boolean,
	EsDebito boolean,
	EsEfectivo boolean
);

-- Primary key de la Tabla Pago
alter table Pago
add constraint pk_Pago
primary key(IDPago);

-- Comentarios de la tabla Pago
comment on table Pago is 'Tabla con la información del pago';
comment on column Pago.IDPago is 'Identificador del pago';
comment on column Pago.Monto is 'La cantidad a pagar';
comment on column Pago.EsCredito is 'Booleano que indica si el pago es en credito';
comment on column Pago.EsDebito is 'Booleano que indica si el pago es en debito';
comment on column Pago.EsEfectivo is 'Booleano que indica si el pago es en efectivo';

-- Restricciones de la tabla Pago
alter table Pago alter column Monto set not NULL;
alter table Pago alter column EsCredito set not NULL;
alter table Pago alter column EsDebito set not NULL;
alter table Pago alter column EsEfectivo set not NULL;
alter table Pago alter column IDPago set not NULL;
alter table Pago add constraint IDPago unique (IDPago);

-- Tabla ListaProducto
create table ListaProducto(
	IDLista integer,
	PrecioProducto integer
);

-- Primary key de la Tabla ListaProducto
alter table ListaProducto
add constraint pk_ListaProducto
primary key(IDLista);

-- Comentarios de la tabla ListaProducto
comment on table ListaProducto is 'Tabla con la información de los productos a comprar';
comment on column ListaProducto.IDLista is 'Identificador de la lista de productos';
comment on column ListaProducto.PrecioProducto is 'El precio del producto';

-- Restricciones de la tabla ListaProducto
alter table ListaProducto alter column IDLista set not NULL;
alter table ListaProducto add constraint IDLista unique (IDLista);

-- Tabla Pertenecer
create table Pertenecer(
	IDSucursal integer,
	IDInventario integer,
	Nombre varchar(15),
	Calle varchar(15),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(20),
	NumCuentaBancaria integer,
	PaginaWeb varchar(40),
	DNI varchar(9),
	HoraApertura time,
	FechaApertura date,
	HoraCierre time,
	TotalInventario integer
);

-- Comentarios de la tabla Pertenecer
comment on table Pertenecer is 'Tabla que representa la relación entre las tablas Sucursal e Inventario';
comment on column Pertenecer.IDSucursal is 'Foreign key que conecta con el IDSucursal';
comment on column Pertenecer.IDInventario is 'Foreign key que conecta con el IDInventario';
comment on column Pertenecer.Nombre is 'Nombre de pila de la sucursal';
comment on column Pertenecer.Calle is 'Nombre de la calle de la dirección de la sucursal';
comment on column Pertenecer.Numero is 'Número de la calle de la dirección de la sucursal';
comment on column Pertenecer.CodigoPostal is 'Número del código postal de la dirección de la sucursal';
comment on column Pertenecer.Alcaldia is 'Nombre de la alcaldia de la dirección de la sucursal';
comment on column Pertenecer.NumCuentaBancaria is 'Número de cuenta bancaria de la sucursal';
comment on column Pertenecer.PaginaWeb is 'Dirección de la página web de la sucursal';
comment on column Pertenecer.DNI is 'Número que representa al Documento Nacional de Identificación de la sucursal';
comment on column Pertenecer.HoraApertura is 'Hora en la que abre la sucursal';
comment on column Pertenecer.FechaApertura is 'Fecha en la que se inaguró la sucursal';
comment on column Pertenecer.HoraCierre is 'Hora en la que cierra la sucursal';
comment on column Pertenecer.TotalInventario is 'Indicador del total del inventario';

-- Restricciones de la tabla Pertenecer
alter table Pertenecer alter column Nombre set not NULL;
alter table Pertenecer alter column Calle set not NULL;
alter table Pertenecer alter column CodigoPostal set not NULL;
alter table Pertenecer add constraint CodigoPostal check (CodigoPostal >= 10000 and CodigoPostal <= 99999);
alter table Pertenecer alter column NumCuentaBancaria set not NULL;
alter table Pertenecer alter column PaginaWeb set not NULL;
alter table Pertenecer add constraint PaginaWeb check (PaginaWeb ~* '^((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)?$');
alter table Pertenecer alter column DNI set not NULL;
alter table Pertenecer alter column HoraApertura set not NULL;
alter table Pertenecer alter column FechaApertura set not NULL;
alter table Pertenecer add constraint FechaApertura check (FechaApertura <= current_date);
alter table Pertenecer alter column HoraCierre set not NULL;
alter table Pertenecer alter column TotalInventario set not NULL;
alter table Pertenecer add constraint TotalInventario check (TotalInventario >= 0);
alter table Pertenecer alter column IDSucursal set not NULL;
alter table Pertenecer alter column IDInventario set not NULL;

-- Tabla Constar
create table Constar(
	IDVenta integer,
	IDLista integer,
	PrecioProducto decimal(8,2),
	PrecioTotal decimal(8,2),
	CantidadProducto integer
);

-- Comentarios de la tabla Constar
comment on table Constar is 'Tabla que representa la relación entre las tablas Venta y ListaProducto';
comment on column Constar.IDVenta is 'Foreign key que conecta con la tabla Venta';
comment on column Constar.IDLista is 'Foreign key que conecta con la tabla ListaProducto';
comment on column Constar.PrecioProducto is 'El precio por pieza de cada producto';
comment on column Constar.PrecioTotal is 'El monto total de la venta';
comment on column Constar.CantidadProducto is 'La cantidad de piezas vendidas del producto';

-- Restricciones de la tabla Constar
alter table Constar alter column PrecioProducto set not NULL;
alter table Constar alter column PrecioTotal set not NULL;
alter table Constar alter column CantidadProducto set not NULL;
alter table Constar alter column IDVenta set not NULL;
alter table Constar alter column IDLista set not NULL;

-- Tabla Registrar
create table Registrar(
	IDPago integer,
	IDVenta integer,
	Monto decimal(8,2) check (Monto >= 0)
);

-- Comentarios de la tabla Registrar
comment on table Registrar is 'Tabla que representa la relación entre las tablas Venta y Pago';
comment on column Registrar.IDPago is 'Foreign key que conecta con la tabla Pago';
comment on column Registrar.IDVenta is 'Foreign key que conecta con la tabla Venta';
comment on column Registrar.Monto is 'El monto total a pagar';

-- Restricciones de la tabla Registrar
alter table Registrar alter column Monto set not NULL;
alter table Registrar alter column IDPago set not NULL;
alter table Registrar alter column IDVenta set not NULL;

-- Tabla Tener
create table Tener(
	IDInventario integer,
	IDPerecedero integer,
	IDNoPerecedero integer,
	IDElectronica integer
);

-- Comentarios de la tabla Tener
comment on table Tener is 'Tabla que representa la relación entre las tablas Inventario, Perecedero, NoPerecedero y Electronica';
comment on column Tener.IDInventario is 'Identificador del inventario';
comment on column Tener.IDPerecedero is 'Identificador de los productos que son de tipo Perecedero';
comment on column Tener.IDNoPerecedero is 'Identificador de los productos que son de tipo No Perecedero';
comment on column Tener.IDElectronica is 'Identificador de los productos que son de tipo Electronica';

-- Restricciones de la tabla Tener
alter table Tener alter column IDInventario set not NULL;
alter table Tener alter column IDPerecedero set not NULL;
alter table Tener alter column IDNoPerecedero set not NULL;
alter table Tener alter column IDElectronica set not NULL;

-- Tabla Contener
create table Contener(
	IDLista integer,
	IDPerecedero integer,
	IDNoPerecedero integer,
	IDElectronica integer
);

-- Comentarios de la tabla Contener
comment on table Contener is 'Tabla que representa la relación entre las tablas Producto y ListaProducto';
comment on column Contener.IDLista is 'Foreign key que conecta con la tabla ListaProducto';
comment on column Contener.IDPerecedero is 'Foreign key que conecta con la tabla Perecedero';
comment on column Contener.IDNoPerecedero is 'Foreign key que conecta con la tabla NoPerecedero';
comment on column Contener.IDElectronica is 'Foreign key que conecta con la tabla Electronica';

-- Restricciones de la tabla Contener
alter table Contener alter column IDLista set not NULL;
alter table Contener alter column IDPerecedero set not NULL;
alter table Contener alter column IDNoPerecedero set not NULL;
alter table Contener alter column IDElectronica set not NULL;


-- DEFINICIÓN DE LLAVES FORÁNEAS

-- Foreign key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint fk_TelefonoCliente
foreign key (IDCliente)
references Cliente(IDCliente)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint fk_CorreoCliente
foreign key (IDCliente)
references Cliente(IDCliente)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Cajero
alter table Cajero
add constraint fk_Cajero
foreign key (IDSucursal)
references Sucursal(IDSucursal)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla TelefonoCajero
alter table TelefonoCajero
add constraint fk_TelefonoCajero
foreign key (IDCajero)
references Cajero(IDCajero)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla CorreoCajero
alter table CorreoCajero
add constraint fk_CorreoCajero
foreign key (IDCajero)
references Cajero(IDCajero)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla TelefonoSucursal
alter table TelefonoSucursal
add constraint fk_TelefonoSucursal
foreign key (IDSucursal)
references Sucursal(IDSucursal)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Gerente
alter table Gerente
add constraint fk_Gerente
foreign key (IDSucursal)
references Sucursal(IDSucursal)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla TelefonoGerente
alter table TelefonoGerente
add constraint fk_TelefonoGerente
foreign key (IDGerente)
references Gerente(IDGerente)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla CorreoGerente
alter table CorreoGerente
add constraint fk_CorreoGerente
foreign key (IDGerente)
references Gerente(IDGerente)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Encargado
alter table Encargado
add constraint fk_Encargado
foreign key (IDSucursal)
references Sucursal(IDSucursal)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla TelefonoEncargado
alter table TelefonoEncargado
add constraint fk_TelefonoEncargado
foreign key (IDEncargado)
references Encargado(IDEncargado)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla CorreoEncargado
alter table CorreoEncargado
add constraint fk_CorreoEncargado
foreign key (IDEncargado)
references Encargado(IDEncargado)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Venta
alter table Venta 
add constraint fk_IDCliente foreign key (IDCliente) references Cliente(IDCliente),
add constraint fk_IDCajero foreign key (IDCajero) references Cajero(IDCajero),
add constraint fk_IDSucursal foreign key (IDSucursal) references Sucursal(IDSucursal)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Pertenecer
alter table Pertenecer
add constraint fk_IDSucursal foreign key (IDSucursal) references Sucursal(IDSucursal),
add constraint fk_IDInventario foreign key (IDInventario) references Inventario(IDInventario)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Constar
alter table Constar
add constraint fk_IDVenta foreign key (IDVenta) references Venta(IDVenta),
add constraint fk_IDLista foreign key (IDLista) references ListaProducto(IDLista)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Registrar
alter table Registrar
add constraint fk_IDPago foreign key (IDPago) references Pago(IDPago),
add constraint fk_IDVenta foreign key (IDVenta) references Venta(IDVenta)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Tener
alter table Tener
add constraint fk_IDInventario foreign key (IDInventario) references Inventario(IDInventario),
add constraint fk_IDPerecedero foreign key (IDPerecedero) references Perecedero(IDPerecedero),
add constraint fk_IDNoPerecedero foreign key (IDNoPerecedero) references NoPerecedero(IDNoPerecedero),
add constraint fk_IDElectronica foreign key (IDElectronica) references Electronica(IDElectronica)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;

-- Foreign key de la Tabla Contener
alter table Contener
add constraint fk_IDLista foreign key (IDLista) references ListaProducto(IDLista),
add constraint fk_IDPerecedero foreign key (IDPerecedero) references Perecedero(IDPerecedero),
add constraint fk_IDNoPerecedero foreign key (IDNoPerecedero) references NoPerecedero(IDNoPerecedero),
add constraint fk_IDElectronica foreign key (IDElectronica) references Electronica(IDElectronica)

-- Mantenimiento de llaves foráneas
match simple
on update cascade on delete cascade;