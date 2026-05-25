USE [GD1C2026]
GO

CREATE SCHEMA [GRUPO_BASES26]
GO

CREATE TABLE Pais (
    Pais_cod bigint NOT NULL,
    Pais_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE Pais
    ADD CONSTRAINT Pais_cod PRIMARY KEY (Pais_Cod);

CREATE TABLE Ciudad (
    Ciudad_Cod bigint NOT NULL,
    Pais_cod bigint NOT NULL,
    Ciudad_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE Ciudad
    ADD CONSTRAINT Ciudad_Cod PRIMARY KEY (Pais_Cod);

ALTER TABLE Ciudad
    ADD CONSTRAINT Pais_cod FOREIGN KEY (Pais_cod)
    REFERENCES Ciudad(Pais_cod);

CREATE TABLE DetalleCiudad (
    Detalle_Solicitud_cod_Ciudad nvarchar(255) NOT NULL,
    Detalle_Solicitud_Ciudad_Cod bigint NOT NULL,
    Detalle_Nro_Solicitud bigint NOT NULL,
    Detalle_Solicitud_Cant_Dias_Aprox int NOT NULL,
    Detalle_Solicitud_Observaciones nvarchar(max) NOT NULL
)

ALTER TABLE DetalleCiudad
ADD CONSTRAINT PK_DetalleCiudad PRIMARY KEY (Detalle_Solicitud_cod_Ciudad)

ALTER TABLE DetalleCiudad 
ADD CONSTRAINT FK_DetalleCiudad_Ciudad 
FOREIGN KEY (Detalle_Solicitud_Ciudad_Cod) 
REFERENCES Ciudad (Ciudad_Cod)

ALTER TABLE DetalleCiudad
ADD CONSTRAINT FK_DetalleCiudad_Solicitud 
FOREIGN KEY (Detalle_Nro_Solicitud) 
REFERENCES SolicitudCotizacion (Nro_Solicitud)

CREATE TABLE Canal_Venta (
    Canal_Codigo bigint NOT NULL,
    Canal_Detalle nvarchar(255) NOT NULL
)
ALTER TABLE Canal_Venta
    ADD CONSTRAINT Canal_Codigo PRIMARY KEY (Canal_Codigo);

CREATE TABLE Medio_Pago (
    Medio_Codigo bigint NOT NULL,
    Medio_Detalle nvarchar(255) NOT NULL
)

ALTER TABLE Medio_Pago
    ADD CONSTRAINT Medio_Codigo PRIMARY KEY (Medio_Detalle);

CREATE TABLE Aspecto (
    Aspecto_Codigo bigint NOT NULL,
    Aspecto_Descripcion nvarchar(255) NOT NULL
)

ALTER TABLE Aspecto
    ADD CONSTRAINT Aspecto_Codigo PRIMARY KEY (Aspecto_Codigo);

CREATE TABLE Provincia (
    Provincia_Cod bigint NOT NULL,
    Provincia_Nombre nvarchar(255) NOT NULL
)

ALTER TABLE Provincia
    ADD CONSTRAINT PK_Provincia_Cod PRIMARY KEY (Provincia_Cod);

CREATE TABLE Localidad (
    Localidad_Cod bigint NOT NULL,
    Provincia_Cod bigint NOT NULL,
    Localidad_Nombre nvarchar(255) NOT NULL
)

ALTER TABLE Localidad
    ADD CONSTRAINT PK_Localidad_Cod PRIMARY KEY (Localidad_Cod);

ALTER TABLE Localidad
    ADD CONSTRAINT FK_Provincia_Cod FOREIGN KEY (Provincia_Cod)
    REFERENCES Provincia(Provincia_Cod);

CREATE TABLE Agencia (
    Agencia_Nro_Agencia bigint NOT NULL,
    Localidad_Cod bigint NOT NULL,
    Agencia_Direccion nvarchar(255) NOT NULL,
    Agencia_Telefono nvarchar(255) NOT NULL,
    Agencia_Mail nvarchar(255) NOT NULL,
)

ALTER TABLE Agencia
    ADD CONSTRAINT PK_Agencia_Nro_Agencia PRIMARY KEY (Agencia_Nro_Agencia);

ALTER TABLE Agencia
    ADD CONSTRAINT FK_Localidad_Cod FOREIGN KEY (Localidad_Cod)
    REFERENCES Localidad(Localidad_Cod);

-- CALIFICACION_POR_ENCUESTA

CREATE TABLE Encuesta (
    Encuesta_Codigo bigint NOT NULL,
    Cliente_Cod bigint NOT NULL,
    Agente_Legajo bigint NOT NULL,
    Venta_Nro_Venta bigint NOT NULL,
    Propuesta_Nro_Propuesta bigint NOT NULL,
    Comentario nvarchar(max)
)
ALTER TABLE Encuesta
    ADD CONSTRAINT 




CREATE TABLE SolicitudCotizacion (
    Solicitud_Nro_Solicitud bigint NOT NULL,
    Solicitud_cod_cliente bigint NOT NULL,
    Solicitud_Agente bigint NOT NULL,
    Solicitud_Fecha_Solicitud date NOT NULL,
    Solicitud_Fecha_Inicio_Tentativa date NOT NULL,
    Solicitud_Fecha_Fin_Tentativa date NOT NULL,
    Solicitud_Cant_Pax int NOT NULL,
    Solicitud_Presupuesto_Estimado decimal(18, 2) NOT NULL
)

ALTER TABLE SolicitudCotizacion
ADD CONSTRAINT PK_SolicitudCotizacion PRIMARY KEY (Solicitud_Nro_Solicitud)


ALTER TABLE SolicitudCotizacion
ADD CONSTRAINT FK_SolicitudCotizacion_Cliente 
FOREIGN KEY (Solicitud_cod_cliente) 
REFERENCES Cliente (cod_cliente);


ALTER TABLE SolicitudCotizacion
ADD CONSTRAINT FK_SolicitudCotizacion_Agente 
FOREIGN KEY (Solicitud_Agente) 
REFERENCES Agente (cod_agente);
