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

-- Tabla TelefonoCliente
create table TelefonoCliente(
	IDCliente integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint pk_TelefonoCliente
primary key (Telefono);

-- Tabla CorreoCliente
create table CorreoCliente(
	IDCliente integer,
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint pk_CorreoCliente
primary key (Correo);

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

-- Tabla TelefonoCajero
create table TelefonoCajero(
	IDCajero integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoCajero
alter table TelefonoCajero
add constraint pk_TelefonoCajero
primary key (Telefono);

-- Tabla CorreoCajero
create table CorreoCajero(
	IDCajero integer,
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoCajero
alter table CorreoCajero
add constraint pk_CorreoCajero
primary key (Correo);

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

-- Tabla TelefonoSucursal
create table TelefonoSucursal(
	IDSucursal integer,
	Telefono integer
);

-- Primary key de la Tabla TelefonoSucursal
alter table TelefonoSucursal
add constraint pk_TelefonoSucursal
primary key(Telefono);

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

-- Tabla TelefonoGerente
create table TelefonoGerente(
	IDGerente integer, 
	Telefono integer
);

-- Primary key de la Tabla TelefonoGerente
alter table TelefonoGerente
add constraint pk_TelefonoGerente
primary key (Telefono);

-- Tabla CorreoGerente
create table CorreoGerente(
	IDGerente integer, 
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoGerente
alter table CorreoGerente
add constraint pk_CorreoGerente
primary key (Correo);

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

-- Tabla TelefonoEncargado
create table TelefonoEncargado(
	IDEncargado integer, 
	Telefono integer
);

-- Primary key de la Tabla TelefonoEncargado
alter table TelefonoEncargado
add constraint pk_TelefonoEncargado
primary key (Telefono);

-- Tabla CorreoEncargado
create table CorreoEncargado(
	IDEncargado integer, 
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoEncargado
alter table CorreoEncargado
add constraint pk_CorreoEncargado
primary key (Correo);

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

-- Tabla Inventario
create table Inventario(
	IDInventario integer,
	TotalInventario integer
);

-- Primary key de la Tabla Inventario
alter table Inventario
add constraint pk_Inventario
primary key(IDInventario);

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

-- Tabla ListaProducto
create table ListaProducto(
	IDLista integer,
	PrecioProducto integer
);

-- Primary key de la Tabla ListaProducto
alter table ListaProducto
add constraint pk_ListaProducto
primary key(IDLista);

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

-- Tabla Constar
create table Constar(
	IDVenta integer,
	IDLista integer,
	PrecioProducto decimal(8,2),
	PrecioTotal decimal(8,2),
	CantidadProducto integer
);

-- Tabla Registrar
create table Registrar(
	IDPago integer,
	IDVenta integer,
	Monto decimal(8,2) CHECK (Monto >= 0)
);

-- Tabla Tener
create table Tener(
	IDInventario integer,
	IDPerecedero integer,
	IDNoPerecedero integer,
	IDElectronica integer
);

-- Tabla Contener
create table Contener(
	IDLista integer,
	IDPerecedero integer,
	IDNoPerecedero integer,
	IDElectronica integer
);


-- DEFINICIÓN DE LLAVES FORÁNEAS

-- Foreign key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint fk_TelefonoCliente
foreign key (IDCliente)
references Cliente(IDCliente);

-- Foreign key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint fk_CorreoCliente
foreign key (IDCliente)
references Cliente(IDCliente); 

-- Foreign key de la Tabla Cajero
alter table Cajero
add constraint fk_Cajero
foreign key (IDSucursal)
references Sucursal(IDSucursal);

-- Foreign key de la Tabla TelefonoCajero
alter table TelefonoCajero
add constraint fk_TelefonoCajero
foreign key (IDCajero)
references Cajero(IDCajero);

-- Foreign key de la Tabla CorreoCajero
alter table CorreoCajero
add constraint fk_CorreoCajero
foreign key (IDCajero)
references Cajero(IDCajero); 

-- Foreign key de la Tabla TelefonoSucursal
alter table TelefonoSucursal
add constraint fk_TelefonoSucursal
foreign key (IDSucursal)
references Sucursal(IDSucursal);

-- Foreign key de la Tabla Gerente
alter table Gerente
add constraint fk_Gerente
foreign key (IDSucursal)
references Sucursal(IDSucursal);

-- Foreign key de la Tabla TelefonoGerente
alter table TelefonoGerente
add constraint fk_TelefonoGerente
foreign key (IDGerente)
references Gerente(IDGerente);

-- Foreign key de la Tabla CorreoGerente
alter table CorreoGerente
add constraint fk_CorreoGerente
foreign key (IDGerente)
references Gerente(IDGerente);

-- Foreign key de la Tabla Encargado
alter table Encargado
add constraint fk_Encargado
foreign key (IDSucursal)
references Sucursal(IDSucursal);

-- Foreign key de la Tabla TelefonoEncargado
alter table TelefonoEncargado
add constraint fk_TelefonoEncargado
foreign key (IDEncargado)
references Encargado(IDEncargado);

-- Foreign key de la Tabla CorreoEncargado
alter table CorreoEncargado
add constraint fk_CorreoEncargado
foreign key (IDEncargado)
references Encargado(IDEncargado);

-- Foreign key de la Tabla Venta
alter table Venta 
add constraint fk_IDCliente foreign key (IDCliente) references Cliente(IDCliente),
add constraint fk_IDCajero foreign key (IDCajero) references Cajero(IDCajero),
add constraint fk_IDSucursal foreign key (IDSucursal) references Sucursal(IDSucursal);

-- Foreign key de la Tabla Pertenecer
alter table Pertenecer
add constraint fk_IDSucursal foreign key (IDSucursal) references Sucursal(IDSucursal),
add constraint fk_IDInventario foreign key (IDInventario) references Inventario(IDInventario);

-- Foreign key de la Tabla Constar
alter table Constar
add constraint fk_IDVenta foreign key (IDVenta) references Venta(IDVenta),
add constraint fk_IDLista foreign key (IDLista) references ListaProducto(IDLista);

-- Foreign key de la Tabla Registrar
alter table Registrar
add constraint fk_IDPago foreign key (IDPago) references Pago(IDPago),
add constraint fk_IDVenta foreign key (IDVenta) references Venta(IDVenta);

-- Foreign key de la Tabla Tener
alter table Tener
add constraint fk_IDInventario foreign key (IDInventario) references Inventario(IDInventario),
add constraint fk_IDPerecedero foreign key (IDPerecedero) references Perecedero(IDPerecedero),
add constraint fk_IDNoPerecedero foreign key (IDNoPerecedero) references NoPerecedero(IDNoPerecedero),
add constraint fk_IDElectronica foreign key (IDElectronica) references Electronica(IDElectronica);

-- Foreign key de la Tabla Contener
alter table Contener
add constraint fk_IDLista foreign key (IDLista) references ListaProducto(IDLista),
add constraint fk_IDPerecedero foreign key (IDPerecedero) references Perecedero(IDPerecedero),
add constraint fk_IDNoPerecedero foreign key (IDNoPerecedero) references NoPerecedero(IDNoPerecedero),
add constraint fk_IDElectronica foreign key (IDElectronica) references Electronica(IDElectronica);