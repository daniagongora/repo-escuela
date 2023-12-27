create table nombre_tabla(
	att_1 char,
	att_2 varchar(5),
	att_3 integer
);
--comentarios
alter table nombre_tabla 
add constraint pk_nombre_tabla
primary key (att_3)--atributos del PK

create table tabla_02(
	atrib_1 integer,
	atrib_2 varchar(5)
);

alter table tabla_02 --quiero alterar x tabla
add constraint pk_tabla_02 --¿que tipo de alteración quiero hacerle?
primary key (atrib_1, atrib_2) --el tipo de la constraint

--Foreign key
alter table tabla_02 
add constraint fk1_tabla_02
	foreign KEY(atrib_1)
	references nombre_tabla
	(att_3)
	
--Borrar un atabla
	--drop table table_02


