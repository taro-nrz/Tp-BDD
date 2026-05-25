USE [GD1C2026]
GO

CREATE SCHEMA [GRUPO_BASES26]
GO

CREATE TABLE GRUPO_BASES26.Cliente(
    Cliente_Cod bigint IDENTITY(1,1) NOT NULL,
    Cliente_Nombre nvarchar (255) NOT NULL,
    Cliente_Apellido nvarchar (255) NOT NULL,
    Cliente_Dni nvarchar(255) NOT NULL,
    Cliente_Tel nvarchar(255) NOT NULL,
    Cliente_Mail nvarchar(255) NOT NULL,
    Cliente_Direccion nvarchar(255) NOT NULL,
    Cliente_Fecha_Nac date NOT NULL, --NO SÉ si date o datetime
    Localidad_cod bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Cliente
    ADD CONSTRAINT PK_Cliente PRIMARY KEY (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.Cliente
    ADD CONSTRAINT FK_Localidad_Cod FOREIGN KEY (Localidad_cod)
    REFERENCES GRUPO_BASES26.Localidad (Localidad_cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Agente(
    Agente_Legajo bigint NOT NULL,
    Localidad_cod bigint NOT NULL,
	Agente_Nombre nvarchar(255) NOT NULL,
	Agente_Apellido nvarchar(255) NOT NULL,
	Agente_Dni nvarchar(255) NOT NULL,
	Agente_Fecha_Nac date NOT NULL,
	Agente_Telefono nvarchar(255) NOT NULL,
	Agente_Mail nvarchar(255) NOT NULL,
	Agente_Direccion nvarchar(255)
)
ALTER TABLE GRUPO_BASES26.Agente
    ADD CONSTRAINT PK_Agente PRIMARY KEY (Agente_Legajo);
ALTER TABLE GRUPO_BASES26.Agente
    ADD CONSTRAINT FK_Localidad_Cod FOREIGN KEY (Localidad_cod)
    REFERENCES GRUPO_BASES26.Localidad (Localidad_cod);

------------------------
CREATE TABLE GRUPO_BASES26.Pais (
    Pais_cod bigint NOT NULL,
    Pais_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Pais
    ADD CONSTRAINT Pais_cod PRIMARY KEY (Pais_Cod);
---------------------------
CREATE TABLE GRUPO_BASES26.Ciudad (
    Ciudad_Cod bigint NOT NULL,
    Pais_cod bigint NOT NULL,
    Ciudad_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Ciudad
    ADD CONSTRAINT Ciudad_Cod PRIMARY KEY (Ciudad_Cod); --hay un error en la primary key dice Pais_Cod, pero es Ciudad_Cod

ALTER TABLE GRUPO_BASES26.Ciudad
    ADD CONSTRAINT Pais_cod FOREIGN KEY (Pais_cod)
    REFERENCES GRUPO_BASES26.Pais(Pais_cod);
-----------------------------
CREATE TABLE GRUPO_BASES26.DetalleCiudad (
    Detalle_Solicitud_cod_Ciudad nvarchar(255) NOT NULL, --acá no entiendo porque nvarchar si es un cod
    Detalle_Solicitud_Ciudad_Cod bigint NOT NULL,
    Detalle_Nro_Solicitud bigint NOT NULL,
    Detalle_Solicitud_Cant_Dias_Aprox int NOT NULL,
    Detalle_Solicitud_Observaciones nvarchar(max) NOT NULL
)

ALTER TABLE GRUPO_BASES26.DetalleCiudad
ADD CONSTRAINT PK_DetalleCiudad PRIMARY KEY (Detalle_Solicitud_cod_Ciudad)

ALTER TABLE GRUPO_BASES26.DetalleCiudad
ADD CONSTRAINT FK_DetalleCiudad_Ciudad 
FOREIGN KEY (Detalle_Solicitud_Ciudad_Cod) 
REFERENCES GRUPO_BASES26.Ciudad (Ciudad_Cod)

ALTER TABLE GRUPO_BASES26.DetalleCiudad
ADD CONSTRAINT FK_DetalleCiudad_Solicitud 
FOREIGN KEY (Detalle_Nro_Solicitud) 
REFERENCES GRUPO_BASES26.SolicitudCotizacion (Nro_Solicitud)
-----------------------
CREATE TABLE GRUPO_BASES26.Canal_Venta (
    Canal_Codigo bigint NOT NULL,
    Canal_Detalle nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Canal_Venta
    ADD CONSTRAINT Canal_Codigo PRIMARY KEY (Canal_Codigo);
---------------------
CREATE TABLE GRUPO_BASES26.Medio_Pago (
    Medio_Codigo bigint NOT NULL,
    Medio_Detalle nvarchar(255) NOT NULL
)

ALTER TABLE GRUPO_BASES26.Medio_Pago
    ADD CONSTRAINT Medio_Codigo PRIMARY KEY (Medio_Detalle);
--------------------
CREATE TABLE GRUPO_BASES26.Aspecto (
    Aspecto_Codigo bigint NOT NULL,
    Aspecto_Descripcion nvarchar(255) NOT NULL
)

ALTER TABLE GRUPO_BASES26.Aspecto
    ADD CONSTRAINT Aspecto_Codigo PRIMARY KEY (Aspecto_Codigo);
----------------
CREATE TABLE GRUPO_BASES26.Provincia (
    Provincia_Cod bigint NOT NULL,
    Provincia_Nombre nvarchar(255) NOT NULL
)

ALTER TABLE GRUPO_BASES26.Provincia
    ADD CONSTRAINT PK_Provincia_Cod PRIMARY KEY (Provincia_Cod);
---------------------
CREATE TABLE GRUPO_BASES26.Localidad (
    Localidad_Cod bigint NOT NULL,
    Provincia_Cod bigint NOT NULL,
    Localidad_Nombre nvarchar(255) NOT NULL
)

ALTER TABLE GRUPO_BASES26.Localidad
    ADD CONSTRAINT PK_Localidad_Cod PRIMARY KEY (Localidad_Cod);

ALTER TABLE GRUPO_BASES26.Localidad
    ADD CONSTRAINT FK_Provincia_Cod FOREIGN KEY (Provincia_Cod)
    REFERENCES GRUPO_BASES26.Provincia(Provincia_Cod);
-----------------------
CREATE TABLE GRUPO_BASES26.Agencia (
    Agencia_Nro_Agencia bigint NOT NULL,
    Localidad_Cod bigint NOT NULL,
    Agencia_Direccion nvarchar(255) NOT NULL,
    Agencia_Telefono nvarchar(255) NOT NULL,
    Agencia_Mail nvarchar(255) NOT NULL,
)

ALTER TABLE GRUPO_BASES26.Agencia
    ADD CONSTRAINT PK_Agencia_Nro_Agencia PRIMARY KEY (Agencia_Nro_Agencia);

ALTER TABLE GRUPO_BASES26.Agencia
    ADD CONSTRAINT FK_Localidad_Cod FOREIGN KEY (Localidad_Cod)
    REFERENCES GRUPO_BASES26.Localidad(Localidad_Cod);
--------------------
CREATE TABLE GRUPO_BASES26.Estado(
     Estado_cod bigint IDENTITY(1,1) NOT NULL,
     Estado_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Estado
    ADD CONSTRAINT PK_Estado_Cod PRIMARY KEY (Estado_cod)
-------------------------
CREATE TABLE GRUPO_BASES26.Alianza(
     Alianza_Cod bigint IDENTITY(1,1) NOT NULL,
     Alianza_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Alianza
    ADD CONSTRAINT PK_Alianza_Cod PRIMARY KEY (Alianza_Cod)
---------------------
CREATE TABLE GRUPO_BASES26.Aerolinea(
    Aerolinea_Codigo nvarchar(255) NOT NULL,
    Aerolinea_Pais_Cod bigint NOT NULL,
    Aerolinea_Alianza_Cod bigint NOT NULL,
    Aerolinea_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aerolinea
    ADD CONSTRAINT PK_Aerolinea_Codigo PRIMARY KEY (Aerolinea_Codigo)
ALTER TABLE GRUPO_BASES26.Aerolinea
    ADD CONSTRAINT FK_Aerolinea_Codigo FOREIGN KEY (Aerolinea_Alianza_Cod)
    REFERENCES GRUPO_BASES26.Alianza(Alianza_Cod);
ALTER TABLE GRUPO_BASES26.Aerolinea
    ADD CONSTRAINT FK_Aerolinea_Pais_Cod FOREIGN KEY (Aerolinea_Pais_Cod)
    REFERENCES GRUPO_BASES26.Pais(Pais_cod);
 -----------------------
CREATE TABLE GRUPO_BASES26.Aeropuerto(
    Aeropuerto_Cod nvarchar(10) NOT NULL,
    Aeropuerto_Descripcion nvarchar(200) NOT NULL,
    Aeropuerto_Ciudad_Cod bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aeropuerto
    ADD CONSTRAINT PK_Aeropuerto_Cod PRIMARY KEY (Aeropuerto_Cod)
ALTER TABLE GRUPO_BASES26.Aeropuerto
    ADD CONSTRAINT FK_Aeropuerto_Ciudad_Cod FOREIGN KEY (Aeropuerto_Ciudad_Cod)
    REFERENCES GRUPO_BASES26.Ciudad(Ciudad_Cod);
 ----------------------
CREATE TABLE GRUPO_BASES26.Vuelo(
    Vuelo_Codigo bigint IDENTITY(1,1) NOT NULL,
    Aerolinea_Codigo nvarchar(255) NOT NULL,
    Aeropuerto_Salida_Codigo nvarchar(10) NOT NULL,
    Aeropuerto_Llegada_Codigo nvarchar(10) NOT NULL,
    Vuelo_Fecha_Salida date NOT NULL,
    Vuelo_Hora_Salida nvarchar(50) NOT NULL,
    Vuelo_Fecha_Llegada date NOT NULL,
    Vuelo_Hora_Llegada nvarchar(50) NOT NULL,
    Vuelo_Duracion int NOT NULL,
    Vuelo_Precio decimal(18,2) NOT NULL,
    Vuelo_Incluye_Carry bit NOT NULL,
    Vuelo_Incluye_Valija bit NOT NULL
)
ALTER TABLE GRUPO_BASES26.Vuelo
    ADD CONSTRAINT PK_Vuelo_Codigo PRIMARY KEY (Vuelo_Codigo)

ALTER TABLE GRUPO_BASES26.Vuelo
    ADD CONSTRAINT Aeropuerto_Salida_Codigo FOREIGN KEY (Aeropuerto_Salida_Codigo)
    REFERENCES GRUPO_BASES26.Aeropuerto(Aeropuerto_Cod);
ALTER TABLE GRUPO_BASES26.Vuelo
    ADD CONSTRAINT Aeropuerto_Llegada_Codigo FOREIGN KEY (Aeropuerto_Llegada_Codigo)
    REFERENCES GRUPO_BASES26.Aeropuerto(Aeropuerto_Cod);
ALTER TABLE GRUPO_BASES26.Vuelo
    ADD CONSTRAINT FK_Aerolinea_Codigo FOREIGN KEY (Aerolinea_Codigo)
    REFERENCES GRUPO_BASES26.Aerolinea(Aerolinea_Codigo);
------------------------------------
CREATE TABLE GRUPO_BASES26.Excursion(
    Excursion_Codigo nvarchar(255) NOT NULL,
    Excursion_Nombre nvarchar(255) NOT NULL,
    Excursion_Descripcion nvarchar(max) NOT NULL,
    Excursion_Horario nvarchar(50) NOT NULL,
    Excursion_Duracion int NOT NULL,
    Excursion_Precio decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Excursion
    ADD CONSTRAINT PK_Excursion_Codigo PRIMARY KEY (Excursion_Codigo)
------------------------------------
CREATE TABLE GRUPO_BASES26.Hospedaje(
    Hospedaje_Codigo nvarchar(255) NOT NULL,
    Hospedaje_Ciudad_Cod bigint NOT NULL,
    Hospedaje_Pais bigint NOT NULL,
    Hospedaje_Nombre nvarchar(255) NOT NULL,
    Hospedaje_Direccion nvarchar(255) NOT NULL,
    Hospedaje_Incluye_Desayuno bit NOT NULL,
    Hospedaje_Check_In nvarchar(50) NOT NULL,
    Hospedaje_Check_Out nvarchar(50) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Hospedaje
    ADD CONSTRAINT PK_Hospedaje_Codigo PRIMARY KEY (Hospedaje_Codigo)
ALTER TABLE GRUPO_BASES26.Hospedaje
    ADD CONSTRAINT FK_Hospedaje_Ciudad_Cod FOREIGN KEY (Hospedaje_Ciudad_Cod)
    REFERENCES GRUPO_BASES26.Ciudad(Ciudad_Cod);
ALTER TABLE GRUPO_BASES26.Hospedaje
    ADD CONSTRAINT FK_Hospedaje_Pais FOREIGN KEY (Hospedaje_Pais)
    REFERENCES GRUPO_BASES26.Pais(Pais_cod);
--------------------------------
CREATE TABLE GRUPO_BASES26.Habitacion(
    Habitacion_Codigo nvarchar(50) NOT NULL,
    Hospedaje_Codigo nvarchar(255) NOT NULL,
    Habitacion_Nombre nvarchar(255) NOT NULL,
    Habitacion_Descripcion nvarchar(max) NOT NULL,
    Habitacion_Precio_Noche decimal(18, 2)
)
ALTER TABLE GRUPO_BASES26.Habitacion
    ADD CONSTRAINT PK_Habitacion_Codigo PRIMARY KEY (Habitacion_Codigo)
ALTER TABLE GRUPO_BASES26.Habitacion
    ADD CONSTRAINT FK_Hospedaje_Codigo FOREIGN KEY (Hospedaje_Codigo)
    REFERENCES GRUPO_BASES26.Hospedaje(Hospedaje_Codigo);
------------------------------------
-- CALIFICACION_POR_ENCUESTA

CREATE TABLE GRUPO_BASES26.Encuesta (
    Encuesta_Codigo bigint NOT NULL,
    Cliente_Cod bigint NOT NULL,
    Agente_Legajo bigint NOT NULL,
    Venta_Nro_Venta bigint NOT NULL,
    Propuesta_Nro_Propuesta bigint NOT NULL,
    Comentario nvarchar(max)
)
ALTER TABLE GRUPO_BASES26.Encuesta
    ADD CONSTRAINT PK_Encuesta_Codigo PRIMARY KEY (Encuesta_Codigo)
ALTER TABLE GRUPO_BASES26.Encuesta
    ADD CONSTRAINT FK_Encuesta_Cliente FOREIGN KEY (Cliente_Cod)
    REFERENCES GRUPO_BASES26.Cliente (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.Encuesta
    ADD CONSTRAINT FK_Encuesta_Agente FOREIGN KEY (Agente_Legajo)
    REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);



CREATE TABLE GRUPO_BASES26.SolicitudCotizacion (
    Solicitud_Nro_Solicitud bigint NOT NULL,
    Solicitud_cod_cliente bigint NOT NULL,
    Solicitud_Agente bigint NOT NULL,
    Solicitud_Fecha_Solicitud date NOT NULL,
    Solicitud_Fecha_Inicio_Tentativa date NOT NULL,
    Solicitud_Fecha_Fin_Tentativa date NOT NULL,
    Solicitud_Cant_Pax int NOT NULL,
    Solicitud_Presupuesto_Estimado decimal(18, 2) NOT NULL
)

ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
    ADD CONSTRAINT PK_SolicitudCotizacion PRIMARY KEY (Solicitud_Nro_Solicitud)

ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
    ADD CONSTRAINT FK_SolicitudCotizacion_Cliente FOREIGN KEY (Solicitud_cod_cliente)
    REFERENCES GRUPO_BASES26.Cliente (Cliente_Cod);

ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
    ADD CONSTRAINT FK_SolicitudCotizacion_Agente FOREIGN KEY (Solicitud_Agente)
    REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);
