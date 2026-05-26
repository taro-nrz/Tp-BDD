USE [GD1C2026]
GO

CREATE SCHEMA [GRUPO_BASES26]
GO

----------------------------
CREATE TABLE GRUPO_BASES26.Pais (
	Pais_Cod bigint IDENTITY(1,1) NOT NULL,
	Pais_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Pais
	ADD CONSTRAINT pk_pais PRIMARY KEY (Pais_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Provincia (
	Provincia_Cod bigint IDENTITY(1,1) NOT NULL,
	Provincia_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Provincia
	ADD CONSTRAINT pk_provincia PRIMARY KEY (Provincia_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Alianza (
	Alianza_Cod bigint IDENTITY(1,1) NOT NULL,
	Alianza_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Alianza
	ADD CONSTRAINT pk_alianza PRIMARY KEY (Alianza_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Estado (
	Estado_Cod bigint IDENTITY(1,1) NOT NULL,
	Estado_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Estado
	ADD CONSTRAINT pk_estado PRIMARY KEY (Estado_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Canal_Venta (
	Canal_Codigo bigint IDENTITY(1,1) NOT NULL,
	Canal_Detalle nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Canal_Venta
	ADD CONSTRAINT pk_canal_venta PRIMARY KEY (Canal_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Medio_Pago (
	Medio_Codigo bigint IDENTITY(1,1) NOT NULL,
	Medio_Detalle nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Medio_Pago
	ADD CONSTRAINT pk_medio_pago PRIMARY KEY (Medio_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Aspecto (
	Aspecto_Codigo bigint IDENTITY(1,1) NOT NULL,
	Aspecto_Descripcion nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aspecto
	ADD CONSTRAINT pk_aspecto PRIMARY KEY (Aspecto_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Proveedor (
	Proveedor_Cod bigint IDENTITY(1,1) NOT NULL,
	Proveedor_Nombre nvarchar(255) NOT NULL,
	Proveedor_Mail nvarchar(255) NOT NULL,
	Proveedor_Telefono nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Proveedor
	ADD CONSTRAINT pk_proveedor PRIMARY KEY (Proveedor_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Ciudad (
	Ciudad_Cod bigint IDENTITY(1,1) NOT NULL,
	Pais_Cod bigint NOT NULL,
	Ciudad_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Ciudad
	ADD CONSTRAINT pk_ciudad PRIMARY KEY (Ciudad_Cod);
ALTER TABLE GRUPO_BASES26.Ciudad
	ADD CONSTRAINT fk_ciudad_pais FOREIGN KEY (Pais_Cod)
	REFERENCES GRUPO_BASES26.Pais (Pais_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Localidad (
	Localidad_Cod bigint IDENTITY(1,1) NOT NULL,
	Provincia_Cod bigint NOT NULL,
	Localidad_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Localidad
	ADD CONSTRAINT pk_localidad PRIMARY KEY (Localidad_Cod);
ALTER TABLE GRUPO_BASES26.Localidad
	ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY (Provincia_Cod)
	REFERENCES GRUPO_BASES26.Provincia (Provincia_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Agencia (
	Agencia_Nro_Agencia bigint NOT NULL,
	Localidad_Cod bigint NOT NULL,
	Agencia_Direccion nvarchar(255) NOT NULL,
	Agencia_Telefono nvarchar(255) NOT NULL,
	Agencia_Mail nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Agencia
	ADD CONSTRAINT pk_agencia PRIMARY KEY (Agencia_Nro_Agencia);
ALTER TABLE GRUPO_BASES26.Agencia
	ADD CONSTRAINT fk_agencia_localidad FOREIGN KEY (Localidad_Cod)
	REFERENCES GRUPO_BASES26.Localidad (Localidad_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Aerolinea (
	Aerolinea_Codigo nvarchar(255) NOT NULL,
	Aerolinea_Pais_Cod bigint NOT NULL,
	Aerolinea_Alianza_Cod bigint NOT NULL,
	Aerolinea_Nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT pk_aerolinea PRIMARY KEY (Aerolinea_Codigo);
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT fk_aerolinea_pais FOREIGN KEY (Aerolinea_Pais_Cod)
	REFERENCES GRUPO_BASES26.Pais (Pais_Cod);
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT fk_aerolinea_alianza FOREIGN KEY (Aerolinea_Alianza_Cod)
	REFERENCES GRUPO_BASES26.Alianza (Alianza_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Aeropuerto (
	Aeropuerto_Cod nvarchar(10) NOT NULL,
	Aeropuerto_Descripcion nvarchar(200) NOT NULL,
	Aeropuerto_Ciudad_Cod bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aeropuerto
	ADD CONSTRAINT pk_aeropuerto PRIMARY KEY (Aeropuerto_Cod);
ALTER TABLE GRUPO_BASES26.Aeropuerto
	ADD CONSTRAINT fk_aeropuerto_ciudad FOREIGN KEY (Aeropuerto_Ciudad_Cod)
	REFERENCES GRUPO_BASES26.Ciudad (Ciudad_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Agente (
	Agente_Legajo bigint NOT NULL,
	Agencia_Nro_Agencia bigint NOT NULL,
	Localidad_Cod bigint NOT NULL,
	Agente_Nombre nvarchar(255) NOT NULL,
	Agente_Apellido nvarchar(255) NOT NULL,
	Agente_Dni nvarchar(255) NOT NULL,
	Agente_Fecha_Nac date NOT NULL,
	Agente_Telefono nvarchar(255) NOT NULL,
	Agente_Mail nvarchar(255) NOT NULL,
	Agente_Direccion nvarchar(255) NULL
)
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT pk_agente PRIMARY KEY (Agente_Legajo);
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT fk_agente_agencia FOREIGN KEY (Agencia_Nro_Agencia)
	REFERENCES GRUPO_BASES26.Agencia (Agencia_Nro_Agencia);
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT fk_agente_localidad FOREIGN KEY (Localidad_Cod)
	REFERENCES GRUPO_BASES26.Localidad (Localidad_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Cliente (
	Cliente_Cod bigint IDENTITY(1,1) NOT NULL,
	Localidad_Cod bigint NOT NULL,
	Cliente_Nombre nvarchar(255) NOT NULL,
	Cliente_Apellido nvarchar(255) NOT NULL,
	Cliente_Dni nvarchar(255) NOT NULL,
	Cliente_Tel nvarchar(255) NOT NULL,
	Cliente_Mail nvarchar(255) NOT NULL,
	Cliente_Direccion nvarchar(255) NOT NULL,
	Cliente_Fecha_Nac date NOT NULL
)
ALTER TABLE GRUPO_BASES26.Cliente
	ADD CONSTRAINT pk_cliente PRIMARY KEY (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.Cliente
	ADD CONSTRAINT fk_cliente_localidad FOREIGN KEY (Localidad_Cod)
	REFERENCES GRUPO_BASES26.Localidad (Localidad_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Hospedaje (
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
	ADD CONSTRAINT pk_hospedaje PRIMARY KEY (Hospedaje_Codigo);
ALTER TABLE GRUPO_BASES26.Hospedaje
	ADD CONSTRAINT fk_hospedaje_ciudad FOREIGN KEY (Hospedaje_Ciudad_Cod)
	REFERENCES GRUPO_BASES26.Ciudad (Ciudad_Cod);
ALTER TABLE GRUPO_BASES26.Hospedaje
	ADD CONSTRAINT fk_hospedaje_pais FOREIGN KEY (Hospedaje_Pais)
	REFERENCES GRUPO_BASES26.Pais (Pais_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Habitacion (
	Habitacion_Codigo nvarchar(50) NOT NULL,
	Hospedaje_Codigo nvarchar(255) NOT NULL,
	Habitacion_Nombre nvarchar(255) NOT NULL,
	Habitacion_Descripcion nvarchar(max) NOT NULL,
	Habitacion_Precio_Noche decimal(18, 2) NULL
)
ALTER TABLE GRUPO_BASES26.Habitacion
	ADD CONSTRAINT pk_habitacion PRIMARY KEY (Habitacion_Codigo, Hospedaje_Codigo);
ALTER TABLE GRUPO_BASES26.Habitacion
	ADD CONSTRAINT fk_habitacion_hospedaje FOREIGN KEY (Hospedaje_Codigo)
	REFERENCES GRUPO_BASES26.Hospedaje (Hospedaje_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Excursion (
	Excursion_Codigo nvarchar(255) NOT NULL,
	Proveedor_Cod bigint NOT NULL,
	Excursion_Nombre nvarchar(255) NOT NULL,
	Excursion_Descripcion nvarchar(max) NOT NULL,
	Excursion_Horario nvarchar(50) NOT NULL,
	Excursion_Duracion int NOT NULL,
	Excursion_Precio decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Excursion
	ADD CONSTRAINT pk_excursion PRIMARY KEY (Excursion_Codigo);
ALTER TABLE GRUPO_BASES26.Excursion
	ADD CONSTRAINT fk_excursion_proveedor FOREIGN KEY (Proveedor_Cod)
	REFERENCES GRUPO_BASES26.Proveedor (Proveedor_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.Vuelo (
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
	ADD CONSTRAINT pk_vuelo PRIMARY KEY (Vuelo_Codigo);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aerolinea FOREIGN KEY (Aerolinea_Codigo)
	REFERENCES GRUPO_BASES26.Aerolinea (Aerolinea_Codigo);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aeropuerto_salida FOREIGN KEY (Aeropuerto_Salida_Codigo)
	REFERENCES GRUPO_BASES26.Aeropuerto (Aeropuerto_Cod);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aeropuerto_llegada FOREIGN KEY (Aeropuerto_Llegada_Codigo)
	REFERENCES GRUPO_BASES26.Aeropuerto (Aeropuerto_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.SolicitudCotizacion (
	Solicitud_Nro_Solicitud bigint NOT NULL,
	Solicitud_cod_cliente bigint NOT NULL,
	Solicitud_Agente bigint NOT NULL,
	Solicitud_Fecha_Solicitud date NOT NULL,
	Solicitud_Fecha_Inicio_Tentativa date NOT NULL,
	Solicitud_Fecha_Fin_Tentativa date NOT NULL,
	Solicitud_Cant_Pax int NOT NULL,
	Solicitud_Observaciones nvarchar(max) NULL,
	Solicitud_Presupuesto_Estimado decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT pk_solicitudcotizacion PRIMARY KEY (Solicitud_Nro_Solicitud);
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT fk_solicitudcotizacion_cliente FOREIGN KEY (Solicitud_cod_cliente)
	REFERENCES GRUPO_BASES26.Cliente (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT fk_solicitudcotizacion_agente FOREIGN KEY (Solicitud_Agente)
	REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);
----------------------------
CREATE TABLE GRUPO_BASES26.DetalleCiudad (
	Detalle_Solicitud_cod_Ciudad bigint IDENTITY(1,1) NOT NULL,
	Detalle_Solicitud_Ciudad_Cod bigint NOT NULL,
	Detalle_Nro_Solicitud bigint NOT NULL,
	Detalle_Solicitud_Cant_Dias_Aprox int NOT NULL,
	Detalle_Solicitud_Observaciones nvarchar(max) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT pk_detalle_ciudad PRIMARY KEY (Detalle_Solicitud_cod_Ciudad);
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT fk_detalle_ciudad_ciudad FOREIGN KEY (Detalle_Solicitud_Ciudad_Cod)
	REFERENCES GRUPO_BASES26.Ciudad (Ciudad_Cod);
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT fk_detalle_ciudad_solicitud FOREIGN KEY (Detalle_Nro_Solicitud)
	REFERENCES GRUPO_BASES26.SolicitudCotizacion (Solicitud_Nro_Solicitud);
----------------------------
CREATE TABLE GRUPO_BASES26.Propuesta (
	Propuesta_Nro_Propuesta bigint NOT NULL,
	Propuesta_Solicitud bigint NOT NULL,
	Propuesta_Agente bigint NOT NULL,
	Propuesta_Estado_Cod bigint NOT NULL,
	Propuesta_Fecha_Emision date NOT NULL,
	Propuesta_Vigencia_Hasta date NOT NULL,
	Propuesta_Fecha_Desde date NOT NULL,
	Propuesta_Fecha_Hasta date NOT NULL,
	Propuesta_Subtotal decimal(18, 2) NOT NULL,
	Propuesta_Descuento decimal(18, 2) NOT NULL,
	Propuesta_Importe_Total decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT pk_propuesta PRIMARY KEY (Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_solicitud FOREIGN KEY (Propuesta_Solicitud)
	REFERENCES GRUPO_BASES26.SolicitudCotizacion (Solicitud_Nro_Solicitud);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_agente FOREIGN KEY (Propuesta_Agente)
	REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_estado FOREIGN KEY (Propuesta_Estado_Cod)
	REFERENCES GRUPO_BASES26.Estado (Estado_Cod);
----------------------------
CREATE TABLE GRUPO_BASES26.DetallePropuestaVuelo (
	Detalle_Propuesta_Cod bigint IDENTITY(1,1) NOT NULL,
	Detalle_Propuesta_Vuelo_Cod_Vuelo bigint NOT NULL,
	Detalle_Propuesta_Cod_Propuesta bigint NOT NULL,
	Detalle_Propuesta_Vuelo_Cant_Pasajes int NOT NULL,
	Detalle_Propuesta_Vuelo_Precio decimal(18, 2) NOT NULL,
	Detalle_Propuesta_Vuelo_Subtotal decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT pk_detalle_propuesta_vuelo PRIMARY KEY (Detalle_Propuesta_Cod);
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT fk_detalle_propuesta_vuelo_propuesta FOREIGN KEY (Detalle_Propuesta_Cod_Propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT fk_detalle_propuesta_vuelo_vuelo FOREIGN KEY (Detalle_Propuesta_Vuelo_Cod_Vuelo)
	REFERENCES GRUPO_BASES26.Vuelo (Vuelo_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.DetallePropuestaHospedaje (
	Detalle_Propuesta_Hospedaje_Cod nvarchar(255) NOT NULL,
	Detalle_Propuesta_Cod_Propuesta bigint NOT NULL,
	Detalle_Propuesta_Hospedaje_Cod_Hospedaje nvarchar(255) NOT NULL,
	Detalle_Propuesta_Hospedaje_Fecha_Desde date NOT NULL,
	Detalle_Propuesta_Hospedaje_Fecha_Hasta date NOT NULL,
	Detalle_Propuesta_Hospedaje_Cant int NOT NULL,
	Detalle_Propuesta_Hospedaje_Precio decimal(18, 2) NOT NULL,
	Detalle_Propuesta_Hospedaje_Subtotal decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT pk_detalle_propuesta_hospedaje PRIMARY KEY (Detalle_Propuesta_Hospedaje_Cod);
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT fk_detalle_propuesta_hospedaje_propuesta FOREIGN KEY (Detalle_Propuesta_Cod_Propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT fk_detalle_propuesta_hospedaje_hospedaje FOREIGN KEY (Detalle_Propuesta_Hospedaje_Cod_Hospedaje)
	REFERENCES GRUPO_BASES26.Hospedaje (Hospedaje_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Venta (
	Venta_Nro_Venta bigint NOT NULL,
	Agencia_Nro_Agencia bigint NOT NULL,
	Nro_cliente bigint NOT NULL,
	Agente_Legajo bigint NOT NULL,
	Venta_Canal_Venta bigint NOT NULL,
	Venta_Medio_Pago bigint NOT NULL,
	Venta_Fecha_Venta date NOT NULL,
	Venta_Subtotal decimal(18, 2) NOT NULL,
	Venta_Descuento decimal(18, 2) NOT NULL,
	Venta_Importe_Total decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT pk_venta PRIMARY KEY (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_agencia FOREIGN KEY (Agencia_Nro_Agencia)
	REFERENCES GRUPO_BASES26.Agencia (Agencia_Nro_Agencia);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (Nro_cliente)
	REFERENCES GRUPO_BASES26.Cliente (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_agente FOREIGN KEY (Agente_Legajo)
	REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_canal_venta FOREIGN KEY (Venta_Canal_Venta)
	REFERENCES GRUPO_BASES26.Canal_Venta (Canal_Codigo);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_medio_pago FOREIGN KEY (Venta_Medio_Pago)
	REFERENCES GRUPO_BASES26.Medio_Pago (Medio_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Venta_Propuesta (
	Venta_Nro_Venta bigint NOT NULL,
	Propuesta_Nro_Propuesta bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT pk_venta_propuesta PRIMARY KEY (Venta_Nro_Venta, Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT fk_venta_propuesta_venta FOREIGN KEY (Venta_Nro_Venta)
	REFERENCES GRUPO_BASES26.Venta (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT fk_venta_propuesta_propuesta FOREIGN KEY (Propuesta_Nro_Propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT uq_venta_propuesta_venta UNIQUE (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT uq_venta_propuesta_propuesta UNIQUE (Propuesta_Nro_Propuesta);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Vuelo (
	Venta_Nro_Venta bigint NOT NULL,
	Vuelo_Codigo bigint NOT NULL,
	Detalle_Venta_Vuelo_Cantidad_Pasajes int NOT NULL,
	Detalle_Venta_Vuelo_Precio_Unitario decimal(18, 2) NOT NULL,
	Detalle_Venta_Vuelo_Subtotal decimal(18, 2) NOT NULL,
	Detalle_Venta_Vuelo_Cod_Reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT pk_detalle_venta_vuelo PRIMARY KEY (Venta_Nro_Venta, Vuelo_Codigo);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT fk_detalle_venta_vuelo_venta FOREIGN KEY (Venta_Nro_Venta)
	REFERENCES GRUPO_BASES26.Venta (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT fk_detalle_venta_vuelo_vuelo FOREIGN KEY (Vuelo_Codigo)
	REFERENCES GRUPO_BASES26.Vuelo (Vuelo_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje (
	Venta_Nro_Venta bigint NOT NULL,
	Habitacion_Codigo nvarchar(50) NOT NULL,
	Hospedaje_Codigo nvarchar(255) NOT NULL,
	Detalle_Venta_Hospedaje_Fecha_Desde date NOT NULL,
	Detalle_Venta_Hospedaje_Fecha_Hasta date NOT NULL,
	Detalle_Venta_Hospedaje_Cantidad int NOT NULL,
	Detalle_Venta_Hospedaje_Precio_Unitario decimal(18, 2) NOT NULL,
	Detalle_Venta_Hospedaje_Subtotal decimal(18, 2) NOT NULL,
	Detalle_Venta_Hospedaje_Cod_Reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT pk_detalle_venta_hospedaje PRIMARY KEY (Venta_Nro_Venta, Habitacion_Codigo, Hospedaje_Codigo);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT fk_detalle_venta_hospedaje_venta FOREIGN KEY (Venta_Nro_Venta)
	REFERENCES GRUPO_BASES26.Venta (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT fk_detalle_venta_hospedaje_habitacion FOREIGN KEY (Habitacion_Codigo, Hospedaje_Codigo)
	REFERENCES GRUPO_BASES26.Habitacion (Habitacion_Codigo, Hospedaje_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Excursion (
	Excursion_Codigo nvarchar(255) NOT NULL,
	Venta_Nro_Venta bigint NOT NULL,
	Detalle_Venta_Excursion_Fecha_Reserva date NOT NULL,
	Detalle_Venta_Excursion_Cant int NOT NULL,
	Detalle_Venta_Excursion_Precio_Unitario decimal(18, 2) NOT NULL,
	Detalle_Venta_Excursion_Subtotal decimal(18, 2) NOT NULL,
	Detalle_Venta_Excursion_Cod_Reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT pk_detalle_venta_excursion PRIMARY KEY (Excursion_Codigo, Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT fk_detalle_venta_excursion_venta FOREIGN KEY (Venta_Nro_Venta)
	REFERENCES GRUPO_BASES26.Venta (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT fk_detalle_venta_excursion_excursion FOREIGN KEY (Excursion_Codigo)
	REFERENCES GRUPO_BASES26.Excursion (Excursion_Codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.Encuesta (
	Encuesta_Codigo bigint NOT NULL,
	Cliente_Cod bigint NOT NULL,
	Agente_Legajo bigint NOT NULL,
	Venta_Nro_Venta bigint NULL,
	Propuesta_Nro_Propuesta bigint NULL,
	Encuesta_Fecha_Encuesta date NOT NULL,
	Encuesta_Comentarios nvarchar(max) NULL
)
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT pk_encuesta PRIMARY KEY (Encuesta_Codigo);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_cliente FOREIGN KEY (Cliente_Cod)
	REFERENCES GRUPO_BASES26.Cliente (Cliente_Cod);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_agente FOREIGN KEY (Agente_Legajo)
	REFERENCES GRUPO_BASES26.Agente (Agente_Legajo);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_venta FOREIGN KEY (Venta_Nro_Venta)
	REFERENCES GRUPO_BASES26.Venta (Venta_Nro_Venta);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_propuesta FOREIGN KEY (Propuesta_Nro_Propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (Propuesta_Nro_Propuesta);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT chk_encuesta_venta_o_propuesta CHECK (Venta_Nro_Venta IS NOT NULL OR Propuesta_Nro_Propuesta IS NOT NULL);
----------------------------
CREATE TABLE GRUPO_BASES26.CalificacionPorEncuesta (
	Encuesta_Codigo bigint NOT NULL,
	Aspecto_Codigo bigint NOT NULL,
	Aspecto_Calificacion int NOT NULL
)
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT pk_calificacion_por_encuesta PRIMARY KEY (Encuesta_Codigo, Aspecto_Codigo);
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT fk_calificacion_por_encuesta_encuesta FOREIGN KEY (Encuesta_Codigo)
	REFERENCES GRUPO_BASES26.Encuesta (Encuesta_Codigo);
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT fk_calificacion_por_encuesta_aspecto FOREIGN KEY (Aspecto_Codigo)
	REFERENCES GRUPO_BASES26.Aspecto (Aspecto_Codigo);
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT chk_calificacion_aspecto CHECK (Aspecto_Calificacion BETWEEN 1 AND 5);
