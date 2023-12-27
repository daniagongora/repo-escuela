-- Tabla Articulista
create table if not exists Articulista(
	IDArticulista integer,
	Nombre varchar(20),
	APaterno varchar(20),
	AMaterno varchar(20),
	Profesion varchar(30),
	Correo varchar(50),
	constraint pk_Articulista primary key (IDArticulista)
);

comment on table Articulista is 'Tabla que contiene toda la información de los Articulistas';
comment on column Articulista.IDArticulista is 'Identificador único del Articulista';
comment on column Articulista.Nombre is 'Cadena de caracteres con el Nombre';
comment on column Articulista.APaterno is 'Cadena de caracteres con el Apellido Paterno';
comment on column Articulista.AMaterno is 'Cadena de caracteres con el Apellido Materno';
comment on column Articulista.Profesion is 'Cadena de caracteres con la Profesión del Articulista';
comment on column Articulista.Correo is 'Cadena de caracteres con el Correo del Articulista';

-- Tabla Seccion
create table if not exists Seccion(
	NumSeccion integer,
	constraint pk_Seccion primary key (NumSeccion)
);

comment on table Seccion is 'Tabla que contiene toda la información de las Secciones';
comment on column Seccion.NumSeccion is 'Identificador único de la Sección';

-- Tabla Edicion
create table if not exists Edicion(
	NumEdicion integer,
	Fecha date,
	constraint pk_Edicion primary key (NumEdicion)
);

comment on table Edicion is 'Tabla que contiene toda la información de las Ediciones';
comment on column Edicion.NumEdicion is 'Identificador único de la Edición';
comment on column Edicion.Fecha is 'Fecha en el formato YYYY-MM-DD';

-- Tabla Articulo
create table if not exists Articulo(
	IDArticulo integer,
	NumEdicion integer,
	IDArticulista integer,
	NumSeccion integer,
	constraint pk_Articulo primary key (IDArticulo),
	constraint fk_Edicion foreign key (NumEdicion) references Edicion(NumEdicion),
	constraint fk_Articulista foreign key (IDArticulista) references Articulista(IDArticulista),
	constraint fk_Seccion foreign key (NumSeccion) references Seccion(NumSeccion)
);

comment on table Articulo is 'Tabla que contiene toda la información de los Articulos';
comment on column Articulo.IDArticulo is 'Identificador único del Articulo';
comment on column Articulo.NumEdicion is 'Llave foránea de la tabla Edicion';
comment on column Articulo.IDArticulista is 'Llave foránea de la tabla Articulista';
comment on column Articulo.NumSeccion is 'Llave foránea de la tabla Seccion';

-- Tabla Tener
create table if not exists Tener(
	NumEdicion integer,
	NumSeccion integer,
	PaginaInicio integer,
	PaginaFinal integer,
	constraint fk_Edicion foreign key (NumEdicion) references Edicion(NumEdicion),
	constraint fk_Seccion foreign key (NumSeccion) references Seccion(NumSeccion)
);

comment on table Tener is 'Tabla que representa la relación entre Seccion y Edicion';
comment on column Tener.NumEdicion is 'Llave foránea de la tabla Edicion';
comment on column Tener.NumSeccion is 'Llave foránea de la tabla Seccion';
comment on column Tener.PaginaInicio is 'Número entero que guarda la página de inicio';
comment on column Tener.PaginaFinal is 'Número entero que guarda la página de fin';