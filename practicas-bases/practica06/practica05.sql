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

--Comentario de la tabla Cliente--
comment on table Cliente is 'Tabla que contiene la información de los clientes';
comment on column Cliente.IDCliente is 'Identificador del cliente';
comment on column Cliente.Nombre is 'Nombre de pila del cliente';
comment on column Cliente.ApellidoP is 'Apellido paterno del cliente';
comment on column Cliente.ApellidoM is 'Apellido materno del cliente';
comment on column Cliente.Calle is 'Nombre de la calle donde vive el cliente';
comment on column Cliente.Numero is 'Numero de la calle donde vive el cliente';
comment on column Cliente.CodigoPostal is 'Código posta de donde vive el cliente';
comment on column Cliente.Alcaldia is 'Alcaldia donde vive el cliente';
comment on column Cliente.FechaNacimiento is 'Fecha de nacimiento del cliente';

--Restricciones de la tabla Cliente--
ALTER TABLE Cliente ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN ApellidoP SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN ApellidoM SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN CodigoPostal SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT CodigoPostal CHECK (CodigoPostal >= 10000 AND CodigoPostal <= 99999);
ALTER TABLE Cliente ALTER COLUMN FechaNacimiento SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT FechaNacimiento CHECK (FechaNacimiento <= CURRENT_DATE);
ALTER TABLE Cliente ALTER COLUMN IDCliente SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT IDCliente UNIQUE (IDCliente);

--Primary key de la tabla cliente
alter table Cliente
add constraint pk_Cliente 
primary key (IDCliente)

--Tabla TelefonoCliente
create table TelefonoCliente(
	IDTelefono integer,
	Telefono integer
);


-- Primary key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint pk_TelefonoCliente
primary key (Telefono);

-- Foreign key de la Tabla TelefonoCliente
alter table TelefonoCliente
add constraint fk_TelefonoCliente
foreign key (IDCliente)
references Cliente(IDCliente)
--Mantenimiento de llaves foraneas--
match simple
on update cascade on delete cascade;

-- Comentarios de la tabla TelefonoCliente--
comment on table TelefonoCliente is 'Tabla con la información de los telefonos de los clientes';
comment on column TelefonoCliente.IDCliente is 'Foreign key que conecta con el IDCliente';
comment on column TelefonoCliente.Telefono is 'El telefono del cliente';

--Restricciones de la tabla TelefonoCliente--
ALTER TABLE TelefonoCliente ALTER COLUMN Telefono SET NOT NULL;
ALTER TABLE TelefonoCliente ADD CONSTRAINT Telefono CHECK (LENGTH(CAST(Telefono AS TEXT)) = 10);
ALTER TABLE Cliente ALTER COLUMN IDCliente SET NOT NULL;


-- Tabla CorreoCliente
create table CorreoCliente(
	IDCliente integer,
	Correo varchar(50)
);

-- Primary key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint pk_CorreoCliente
primary key (Correo);

-- Foreign key de la Tabla CorreoCliente
alter table CorreoCliente
add constraint fk_CorreoCliente
foreign key (IDCliente)
references Cliente(IDCliente)
--Mantenimiento de llaves foraneas--
match simple
on update cascade on delete cascade; 



-- Comentarios de la tabla CorreoCliente --
comment on table CorreoCliente is 'Tabla con la información de los correos de los clientes';
comment on column CorreoCliente.IDCliente is 'Foreign key que conecta con el IDCliente';
comment on column CorreoCliente.Correo is 'El correo del cliente';

--Restricciones --
ALTER TABLE CorreoCliente ALTER COLUMN Correo SET NOT NULL;
ALTER TABLE CorreoCliente ADD CONSTRAINT CorreoC1 CHECK (Correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
ALTER TABLE Cliente ALTER COLUMN IDCliente SET NOT NULL;

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

--Tabla del inventario
create table Inventario(
	IDInventario integer,
	TotalInventario integer
);

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
--Primary key de la tabla inventario
alter table Inventario
add constraint pk_Inventario
primary key(IDInventario)

--Comentarios de la tabla inventario--
comment on table Inventario is 'Tabla donde se almacenara el inventario';
comment on column Inventario.IDInventario is 'Identificador del inventario';
comment on column Inventario.TotalInventario is 'Indicador del total del inventario';

--Restricciones para la tabla inventario--
ALTER TABLE Inventario ALTER COLUMN TotalInventario SET NOT NULL;
ALTER TABLE Inventario ADD CONSTRAINT TotalInventario CHECK (TotalInventario >= 0);


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

--comentarios de la tabla Electronica--
comment on table Electronica is 'Tabla donde se almacena los datos de los productos de electronica';
comment on column Electronica.IDElectronica is 'Identificador de los productos de electronica';
comment on column Electronica.Nombre is 'Nombre del producto de electronica';
comment on column Electronica.PrecioAlmacenado is 'Precio del producto de electronica';
comment on column Electronica.Marca is 'El nombre de la marca del producto de electronica';
comment on column Electronica.Descripcion is 'Descripción breve del producto';
comment on column Electronica.ConsumoElectrico is 'Cantidad del consumo electrico del producto';
comment on column Electronica.Categoria is 'Categoria a la que pertenece el producto';

--Restricciones de la tabla electronica--
ALTER TABLE Electronica ALTER COLUMN Nombre SET NOT NULL;
ALTER TABLE Electronica ALTER COLUMN PrecioAlmacenado SET NOT NULL;
ALTER TABLE Electronica ADD CONSTRAINT PrecioAlmacenado CHECK (PrecioAlmacenado >= 0);
ALTER TABLE Electronica ALTER COLUMN Marca SET NOT NULL;
ALTER TABLE Electronica ALTER COLUMN ConsumoElectrico SET NOT NULL;
ALTER TABLE Electronica ADD CONSTRAINT ConsumoElectrico CHECK (ConsumoElectrico >= 0);
ALTER TABLE Electronica ALTER COLUMN Categoria SET NOT NULL;



