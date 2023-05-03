/* Crear base de datos dbGamarraMarket */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

use dbgamarramarket;


/* Crear la tabla CLIENTE */
CREATE TABLE CLIENTE
(
    id int,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    email varchar(80),
    celular char(9),
    fecha_nacimiento date,
    activo bool,
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

/* Listar estructura de tabla CLIENTE */
SHOW COLUMNS IN CLIENTE;

/* Listar tablas existentes en la base de datos en uso */
SHOW TABLES;

/* Agregar columna estado civil */
ALTER TABLE CLIENTE
	ADD COLUMN estado_civil char(1);

/* Eliminar columna fecha_nacimiento */
ALTER TABLE CLIENTE
	DROP COLUMN fecha_nacimiento;
    
    /* Crear la tabla Venta */
CREATE TABLE Venta
(
    id int,
    fecha_hora timestamp,
    activo bool,
    cliente_id int,
    vendedor_id int,
    
    CONSTRAINT Venta_pk PRIMARY KEY (id)
);

    /* Crear la tabla Vendedor */
CREATE TABLE Vendedor
(
    id int,
    tipo_documento char(3),
    numero_documento char(15),
    nombres varchar(60),
    apellidos varchar(90),
    salario decimal(8,2),
	celular char(9),
    email varchar(80),
    activo bool,
    CONSTRAINT Vendedor_pk PRIMARY KEY (id)
);

   /* Crear la tabla Venta_Detalle */
CREATE TABLE Venta_Detalle
(
    id int,
   cantidad int,
    venta_id int,
    prenda_id int,
    
    CONSTRAINT Venta_Detalle_pk PRIMARY KEY (id)
);

   /* Crear la tabla Prenda */
CREATE TABLE Prenda
(
    id int,
    descripcion varchar(90),
    marca varchar(60),
    cantidad int,
    talla varchar(10),
    precio decimal(8,2),
    activo bool,
    
    CONSTRAINT Prenda_pk PRIMARY KEY (id)
);


/* Crear relación VENTA_CLIENTE */
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_CLIENTE FOREIGN KEY (cliente_id)
    REFERENCES CLIENTE (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;


/* Listar relaciones de tablas de la base de datos activa */
SELECT 
    i.constraint_name, k.table_name, k.column_name, 
    k.referenced_table_name, k.referenced_column_name
FROM 
    information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k 
ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA = DATABASE();


/* Crear relación VENTA_Vendedor */
ALTER TABLE VENTA
	ADD CONSTRAINT VENTA_Vendedor FOREIGN KEY (Vendedor_id)
    REFERENCES Vendedor(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;


/* Crear relación VENTA_Detalle_Venta */
ALTER TABLE VENTA_Detalle
	ADD CONSTRAINT VENTA_Detalle_Venta FOREIGN KEY (Venta_id)
    REFERENCES Venta (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;

/* Crear relación VENTA_Detalle_Prenda */
ALTER TABLE VENTA_Detalle
	ADD CONSTRAINT VENTA_Detalle_Prenda FOREIGN KEY (Prenda_id)
    REFERENCES Prenda (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
;
