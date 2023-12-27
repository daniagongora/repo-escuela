--Practica05 tabla Cliente
create table Cliente(
	IDCliente integer serial,
	Nombre varchar(15),
	ApellidoP varchar(15),
	ApellidoM varchar(15),
	Calle varchar(15),
	Numero integer,
	CodigoPostal integer,
	Alcaldia varchar(20),
	FechaNacimiento date 
);


--Primary key de la tabla cliente
alter table Cliente
add constraint pk_Cliente 
primary key (IDCliente)

--Tabla TelefonoCliente
create table TelefonoCliente(
	IDTelefono integer,
	Telefono integer
);

--Primary key de la tabla Telefonocliente
alter table TelefonoCliente
add constraint pk_TelefonoCliente
primary key (IDTelefono, Telefono) 

--Forreign key que conecta el telefono del cliente al cliente
alter table TelefonoCliente
add constraint fk_TelefonoCliente
foreign KEY (IDTelefono)
references Cliente(IDCliente) 

--Tabla para CorreoCliente
create table CorreoCliente(
	IDCorreo integer,
	Correo varchar(50)
);

--Primary key de la tabla CorreoCliente
alter table CorreoCliente
add constraint pk_CorreoCliente
primary key (IDCorreo, Correo)-

--Forreign key que conecta el Correo del cliente al cliente
alter table CorreoCliente
add constraint fk_CorreoCliente
foreign KEY (IDCorreo)
references Cliente(IDCliente) 

--Tabla del inventario
create table Inventario(
	IDInventario integer,
	TotalInventario integer
);

--Primary key de la tabla inventario
alter table Inventario
add constraint pk_Inventario
primary key(IDInventario)

--Tabla de los productos de electronica
create table Electronica(
	IDElectronica integer,
	Nombre varchar(15),
	PrecioAlmacenado float(2),
	Marca varchar(15),
	Decripcion varchar(100),
	ConsumoElectrico integer,
	Categoria varchar(30)
	
);

--Primary key de la tabla electronica
alter table Electronica
add constraint pk_Electronica
primary key(IDElectronica)
