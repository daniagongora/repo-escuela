
create table Gerente(
IDGerente integer, IDSucursal integer, Nombre varchar, ApellidoP varchar, ApellidoM varchar, Calle varchar, Numero integer, CodigoPostal integer, Alcaldia varchar, FechaNacimiento varchar, NSS varchar, DNI varchar, Sueldo double precision , NumDiaVacaciones integer, FechaIngreso varchar ) ;

alter table Gerente 
add constraint pk_Gerente
primary key (IDGerente);

alter table Gerente
add constraint fk1_Gerente
	foreign KEY(IDSucursal)
	references Sucursal(IDSucursal);

create table Encargado(
IDEncargado integer, IDSucursal integer, Nombre varchar, ApellidoP varchar, ApellidoM varchar, Calle varchar, Numero integer, CodigoPostal integer, Alcaldia varchar, FechaNacimiento varchar, NSS varchar, DNI varchar, Sueldo double precision, NumDiaVacaciones integer, FechaIngreso varchar ) ;

alter table Encargado 
add constraint pk_Encargado
primary key (IDEncargado);

alter table Encargado
add constraint fk1_Encargado
	foreign KEY(IDSucursal)
	references Sucursal(IDSucursal);

create table TelefonoGerente(
IDGerente integer, Telefono integer) ;

alter table TelefonoGerente
add constraint pk_TelefonoGerente
primary key (Telefono);

--Foreign key que conecta el telefono del cliente al cliente
alter table TelefonoGerente
add constraint fk1_TelefonoGerente
foreign KEY (IDGerente)
references Gerente(IDGerente) 

create table CorreoGerente(
IDGerente integer, Correo integer) ;

alter table CorreoGerente
add constraint pk_CorreoGerente
primary key (Correo);

--Foreign key que conecta el correo del gerente al gerente
alter table CorreoGerente
add constraint fk1_CorreoGerente
foreign KEY (IDGerente)
references Gerente(IDGerente) 


create table TelefonoEncargado(
IDEncargado integer, Telefono integer) ;

alter table TelefonoEncargado
add constraint pk_TelefonoEncargado
primary key (Telefono);

--Foreign key que conecta el Correo del encargado al encargado
alter table TelefonoEncargado
add constraint fk1_TelefonoEncargado
foreign KEY (IDEncargado)
references Encargado(IDEncargado) 


-- Venta
CREATE TABLE Venta(
	IDVenta SERIAL,
	IDCliente INTEGER,
	IDCajero INTEGER,
	IDSucursal INTEGER,
	NombreCliente VARCHAR(64),
	NombreCajero VARCHAR(64),
	NombreSucursal VARCHAR(64)
);

ALTER TABLE Venta 
ADD CONSTRAINT pk_Venta PRIMARY KEY (IDVenta),
ADD CONSTRAINT fk_IDCliente FOREIGN KEY (IDCliente) REFERENCES Cliente (IDCliente),
ADD CONSTRAINT fk_IDCajero FOREIGN KEY (IDCajero) REFERENCES Cajero (IDCajero),
ADD CONSTRAINT fk_IDSucursal FOREIGN KEY (IDSucursal) REFERENCES Sucursal (IDSucursal);

-- Registrar
CREATE TABLE Registrar(
	IDPago INTEGER,
	IDVenta INTEGER,
	Monto DECIMAL(8,2) CHECK (Monto >= 0)
);


ALTER TABLE Registrar
ADD CONSTRAINT fk_IDPago FOREIGN KEY (IDPago) REFERENCES Pago (IDPago),
ADD CONSTRAINT fk_IDVenta FOREIGN KEY (IDVenta) REFERENCES Venta (IDVenta);

-- Constar
CREATE TABLE Constar(
	IDVenta INTEGER,
	IDLista INTEGER,
	PrecioProducto DECIMAL(8,2),
	PrecioTotal DECIMAL(8,2),
	CantidadProducto INTEGER
);

ALTER TABLE Constar
ADD CONSTRAINT fk_IDVenta FOREIGN KEY (IDVenta) REFERENCES Venta (IDVenta),
ADD CONSTRAINT fk_IDLista FOREIGN KEY (IDLista) REFERENCES ListaProducto (IDLista);

-- TelefonoEncargado
CREATE TABLE TelefonoEncargado(
	IDEncargado INTEGER,
	Telefono INTEGER
);

ALTER TABLE CorreoEncargado
ADD CONSTRAINT pk_TelefonoEncargado PRIMARY KEY (Correo)

--Foreign key que conecta el Correo del encargado al encargado
alter table CorreoEncargado
add constraint fk1_CorreoEncargado
foreign KEY (IDEncargado)
references Encargado(IDEncargado) 


-- Contener
CREATE TABLE Contener(
	IDLista INTEGER,
	IDPerecedero INTEGER,
	IDNoPerecedero INTEGER,
	IDElectronica INTEGER
);

ALTER TABLE Contener
ADD CONSTRAINT fk_IDLista FOREIGN KEY (IDLista) REFERENCES ListaProducto (IDLista),
ADD CONSTRAINT fk_IDPerecedero FOREIGN KEY (IDPerecedero) REFERENCES Perecedero (IDPerecedero),
ADD CONSTRAINT fk_IDNoPerecedero FOREIGN KEY (IDNoPerecedero) REFERENCES NoPerecedero (IDNoPerecedero),
ADD CONSTRAINT fk_IDElectronica FOREIGN KEY (IDElectronica) REFERENCES Electronica (IDElectronica);


create table Sucursal(

	IDSucursal varchar(20),
	Nombre varchar(20),
	Calle varchar(30),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(30),
	NumCuentaBancaria integer,
	PaginaWeb varchar(40),
	DNI varchar(20),
	FechaApertura date,
	HoraApertura time,
	HoraCierre time
	
);

alter table Sucursal
add constraint pk_Sucursal
primary key(IDSucursal)

------------------------------------

create table TelefonoSucursal(
	
	IDTelefonoSucursal varchar(20),
	Telefono integer

);

alter table TelefonoSucursal
add constraint pk_TelefonoSucursal
primary key(Telefono)

alter table TelefonoSucursal
add constraint fk_TelefonoSucursal
foreign key(IDSucursal)
references Sucursal(IDSucursal)

-------------------------------------

create table Pago(

	IDPago varchar(20),
	Monto integer,
	EsCredito boolean,
	EsDebito boolean,
	EsEfectivo boolean

);

alter table Pago
add constraint pk_Pago
primary key(IDPago)

--------------------------------------

create table ListaProducto(

	IDLista varchar(10000),
	PrecioProducto integer

);

alter table ListaProducto
add constraint pk_ListaProducto
primary key(IDLista)

---------------------------------------

create table Perecedero(
	
	IDPerecedero varchar(20),
	Nombre varchar(20),
	PrecioAlmacenado integer,
	Marca varchar(20),
	Presentacion varchar(20),
	FechaPreparacion date,
	FechaCaducidad date
	
);

alter table Perecedero
add constraint pk_Perecedero
primary key(IDPerecedero)

---------------------------------------------

create table NoPerecedero(

	IDNoPerecedero varchar(20),
	Nombre varchar(20),
	PrecioAlmacenado integer,
	Marca varchar(20),
	Presentacion varchar(20),
	FechaPreparacion date,
	FechaCaducidad date

);

alter table NoPerecedero
add constraint pk_NoPerecedero
primary key(IDNoPerecedero)



