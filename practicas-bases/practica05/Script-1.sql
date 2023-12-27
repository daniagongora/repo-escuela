--Practica05 tabla Cliente
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


--Primary key de la tabla cliente
alter table Cliente
add constraint pk_Cliente 
primary key (IDCliente)