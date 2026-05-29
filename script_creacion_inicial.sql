USE GD1C2026
GO

CREATE SCHEMA [GRUPO_BASES26]
GO

----------------------------
CREATE TABLE GRUPO_BASES26.Pais (
	pais_id bigint IDENTITY(1,1) NOT NULL,
	pais_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Pais
	ADD CONSTRAINT pk_pais PRIMARY KEY (pais_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Provincia (
	provincia_id bigint IDENTITY(1,1) NOT NULL,
	provincia_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Provincia
	ADD CONSTRAINT pk_provincia PRIMARY KEY (provincia_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Alianza (
	alianza_id bigint IDENTITY(1,1) NOT NULL,
	alianza_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Alianza
	ADD CONSTRAINT pk_alianza PRIMARY KEY (alianza_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Estado (
	estado_id bigint IDENTITY(1,1) NOT NULL,
	estado_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Estado
	ADD CONSTRAINT pk_estado PRIMARY KEY (estado_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Canal_Venta (
	canal_id bigint IDENTITY(1,1) NOT NULL,
	canal_detalle nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Canal_Venta
	ADD CONSTRAINT pk_canal_venta PRIMARY KEY (canal_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Medio_Pago (
	medio_pago_id bigint IDENTITY(1,1) NOT NULL,
	medio_pago_detalle nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Medio_Pago
	ADD CONSTRAINT pk_medio_pago PRIMARY KEY (medio_pago_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Aspecto (
	aspecto_id bigint IDENTITY(1,1) NOT NULL,
	aspecto_descripcion nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aspecto
	ADD CONSTRAINT pk_aspecto PRIMARY KEY (aspecto_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Proveedor (
	proveedor_id bigint IDENTITY(1,1) NOT NULL,
	proveedor_nombre nvarchar(255) NOT NULL,
	proveedor_mail nvarchar(255) NOT NULL,
	proveedor_telefono nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Proveedor
	ADD CONSTRAINT pk_proveedor PRIMARY KEY (proveedor_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Ciudad (
	ciudad_id bigint IDENTITY(1,1) NOT NULL,
	ciudad_pais bigint NOT NULL,
	ciudad_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Ciudad
	ADD CONSTRAINT pk_ciudad PRIMARY KEY (ciudad_id);
ALTER TABLE GRUPO_BASES26.Ciudad
	ADD CONSTRAINT fk_ciudad_pais FOREIGN KEY (ciudad_pais)
	REFERENCES GRUPO_BASES26.Pais (pais_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Localidad (
	localidad_id bigint IDENTITY(1,1) NOT NULL,
	localidad_provincia bigint NOT NULL,
	localidad_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Localidad
	ADD CONSTRAINT pk_localidad PRIMARY KEY (localidad_id);
ALTER TABLE GRUPO_BASES26.Localidad
	ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY (localidad_provincia)
	REFERENCES GRUPO_BASES26.Provincia (provincia_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Agencia (
	agencia_id bigint NOT NULL,
	agencia_localidad bigint NOT NULL,
	agencia_direccion nvarchar(255) NOT NULL,
	agencia_telefono nvarchar(255) NOT NULL,
	agencia_mail nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Agencia
	ADD CONSTRAINT pk_agencia PRIMARY KEY (agencia_id);
ALTER TABLE GRUPO_BASES26.Agencia
	ADD CONSTRAINT fk_agencia_localidad FOREIGN KEY (agencia_localidad)
	REFERENCES GRUPO_BASES26.Localidad (localidad_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Aerolinea (
	aerolinea_codigo nvarchar(255) NOT NULL,
	aerolinea_pais bigint NOT NULL,
	aerolinea_alianza bigint NOT NULL,
	aerolinea_nombre nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT pk_aerolinea PRIMARY KEY (aerolinea_codigo);
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT fk_aerolinea_pais FOREIGN KEY (aerolinea_pais)
	REFERENCES GRUPO_BASES26.Pais (pais_id);
ALTER TABLE GRUPO_BASES26.Aerolinea
	ADD CONSTRAINT fk_aerolinea_alianza FOREIGN KEY (aerolinea_alianza)
	REFERENCES GRUPO_BASES26.Alianza (alianza_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Aeropuerto (
	aeropuerto_codigo nvarchar(10) NOT NULL,
	aeropuerto_descripcion nvarchar(200) NOT NULL,
	aeropuerto_ciudad bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Aeropuerto
	ADD CONSTRAINT pk_aeropuerto PRIMARY KEY (aeropuerto_codigo);
ALTER TABLE GRUPO_BASES26.Aeropuerto
	ADD CONSTRAINT fk_aeropuerto_ciudad FOREIGN KEY (aeropuerto_ciudad)
	REFERENCES GRUPO_BASES26.Ciudad (ciudad_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Agente (
	agente_legajo bigint NOT NULL,
	agente_agencia bigint NOT NULL,
	agente_localidad bigint NOT NULL,
	agente_nombre nvarchar(255) NOT NULL,
	agente_apellido nvarchar(255) NOT NULL,
	agente_dni nvarchar(255) NOT NULL,
	agente_fecha_nac date NOT NULL,
	agente_telefono nvarchar(255) NOT NULL,
	agente_mail nvarchar(255) NOT NULL,
	agente_direccion nvarchar(255) NULL
)
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT pk_agente PRIMARY KEY (agente_legajo);
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT fk_agente_agencia FOREIGN KEY (agente_agencia)
	REFERENCES GRUPO_BASES26.Agencia (agencia_id);
ALTER TABLE GRUPO_BASES26.Agente
	ADD CONSTRAINT fk_agente_localidad FOREIGN KEY (agente_localidad)
	REFERENCES GRUPO_BASES26.Localidad (localidad_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Cliente (
	cliente_id bigint IDENTITY(1,1) NOT NULL,
	cliente_localidad bigint NOT NULL,
	cliente_nombre nvarchar(255) NOT NULL,
	cliente_apellido nvarchar(255) NOT NULL,
	cliente_dni nvarchar(255) NOT NULL,
	cliente_telefono nvarchar(255) NOT NULL,
	cliente_mail nvarchar(255) NOT NULL,
	cliente_direccion nvarchar(255) NOT NULL,
	cliente_fecha_nac date NOT NULL
)
ALTER TABLE GRUPO_BASES26.Cliente
	ADD CONSTRAINT pk_cliente PRIMARY KEY (cliente_id);
ALTER TABLE GRUPO_BASES26.Cliente
	ADD CONSTRAINT fk_cliente_localidad FOREIGN KEY (cliente_localidad)
	REFERENCES GRUPO_BASES26.Localidad (localidad_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Hospedaje (
	hospedaje_id bigint IDENTITY(1,1) NOT NULL,
	hospedaje_ciudad bigint NOT NULL,
	hospedaje_pais bigint NOT NULL,
	hospedaje_nombre nvarchar(255) NOT NULL,
	hospedaje_direccion nvarchar(255) NOT NULL,
	hospedaje_incluye_desayuno bit NOT NULL,
	hospedaje_check_in nvarchar(50) NOT NULL,
	hospedaje_check_out nvarchar(50) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Hospedaje
	ADD CONSTRAINT pk_hospedaje PRIMARY KEY (hospedaje_id);
ALTER TABLE GRUPO_BASES26.Hospedaje
	ADD CONSTRAINT fk_hospedaje_ciudad FOREIGN KEY (hospedaje_ciudad)
	REFERENCES GRUPO_BASES26.Ciudad (ciudad_id);
ALTER TABLE GRUPO_BASES26.Hospedaje
	ADD CONSTRAINT fk_hospedaje_pais FOREIGN KEY (hospedaje_pais)
	REFERENCES GRUPO_BASES26.Pais (pais_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Habitacion (
	habitacion_id bigint IDENTITY(1,1) NOT NULL,
	habitacion_hospedaje bigint NOT NULL,
	habitacion_nombre nvarchar(255) NOT NULL,
	habitacion_descripcion nvarchar(max) NOT NULL,
	habitacion_precio_noche decimal(18, 2) NULL
)
ALTER TABLE GRUPO_BASES26.Habitacion
	ADD CONSTRAINT pk_habitacion PRIMARY KEY (habitacion_id, habitacion_hospedaje);
ALTER TABLE GRUPO_BASES26.Habitacion
	ADD CONSTRAINT fk_habitacion_hospedaje FOREIGN KEY (habitacion_hospedaje)
	REFERENCES GRUPO_BASES26.Hospedaje (hospedaje_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Excursion (
	excursion_id bigint IDENTITY(1,1) NOT NULL,
	excursion_proveedor bigint NOT NULL,
	excursion_nombre nvarchar(255) NOT NULL,
	excursion_descripcion nvarchar(max) NOT NULL,
	excursion_horario nvarchar(50) NOT NULL,
	excursion_duracion int NOT NULL,
	excursion_precio decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Excursion
	ADD CONSTRAINT pk_excursion PRIMARY KEY (excursion_id);
ALTER TABLE GRUPO_BASES26.Excursion
	ADD CONSTRAINT fk_excursion_proveedor FOREIGN KEY (excursion_proveedor)
	REFERENCES GRUPO_BASES26.Proveedor (proveedor_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Vuelo (
	vuelo_id bigint IDENTITY(1,1) NOT NULL,
	vuelo_aerolinea nvarchar(255) NOT NULL,
	vuelo_apto_salida nvarchar(10) NOT NULL,
	vuelo_apto_llegada nvarchar(10) NOT NULL,
	vuelo_fecha_salida date NOT NULL,
	vuelo_hora_salida nvarchar(50) NOT NULL,
	vuelo_fecha_llegada date NOT NULL,
	vuelo_hora_llegada nvarchar(50) NOT NULL,
	vuelo_duracion int NOT NULL,
	vuelo_precio decimal(18,2) NOT NULL,
	vuelo_incluye_carry bit NOT NULL,
	vuelo_incluye_valija bit NOT NULL
)
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT pk_vuelo PRIMARY KEY (vuelo_id);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aerolinea FOREIGN KEY (vuelo_aerolinea)
	REFERENCES GRUPO_BASES26.Aerolinea (aerolinea_codigo);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aeropuerto_salida FOREIGN KEY (vuelo_apto_salida)
	REFERENCES GRUPO_BASES26.Aeropuerto (aeropuerto_codigo);
ALTER TABLE GRUPO_BASES26.Vuelo
	ADD CONSTRAINT fk_vuelo_aeropuerto_llegada FOREIGN KEY (vuelo_apto_llegada)
	REFERENCES GRUPO_BASES26.Aeropuerto (aeropuerto_codigo);
----------------------------
CREATE TABLE GRUPO_BASES26.SolicitudCotizacion (
	solicitud_id bigint NOT NULL,
	solicitud_cliente bigint NOT NULL,
	solicitud_agente bigint NOT NULL,
	solicitud_fecha date NOT NULL,
	solicitud_fecha_inicio date NOT NULL,
	solicitud_fecha_fin date NOT NULL,
	solicitud_cant_pax int NOT NULL,
	solicitud_observaciones nvarchar(max) NULL,
	solicitud_presupuesto decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT pk_solicitudcotizacion PRIMARY KEY (solicitud_id);
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT fk_solicitudcotizacion_cliente FOREIGN KEY (solicitud_cliente)
	REFERENCES GRUPO_BASES26.Cliente (cliente_id);
ALTER TABLE GRUPO_BASES26.SolicitudCotizacion
	ADD CONSTRAINT fk_solicitudcotizacion_agente FOREIGN KEY (solicitud_agente)
	REFERENCES GRUPO_BASES26.Agente (agente_legajo);
----------------------------
CREATE TABLE GRUPO_BASES26.DetalleCiudad (
	det_ciudad_id bigint IDENTITY(1,1) NOT NULL,
	det_ciudad_ciudad bigint NOT NULL,
	det_ciudad_solicitud bigint NOT NULL,
	det_ciudad_cant_dias int NOT NULL,
	det_ciudad_observaciones nvarchar(max) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT pk_detalle_ciudad PRIMARY KEY (det_ciudad_id);
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT fk_detalle_ciudad_ciudad FOREIGN KEY (det_ciudad_ciudad)
	REFERENCES GRUPO_BASES26.Ciudad (ciudad_id);
ALTER TABLE GRUPO_BASES26.DetalleCiudad
	ADD CONSTRAINT fk_detalle_ciudad_solicitud FOREIGN KEY (det_ciudad_solicitud)
	REFERENCES GRUPO_BASES26.SolicitudCotizacion (solicitud_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Propuesta (
	propuesta_id bigint NOT NULL,
	propuesta_solicitud bigint NOT NULL,
	propuesta_agente bigint NOT NULL,
	propuesta_estado bigint NOT NULL,
	propuesta_fecha_emision date NOT NULL,
	propuesta_vigencia date NOT NULL,
	propuesta_fecha_desde date NOT NULL,
	propuesta_fecha_hasta date NOT NULL,
	propuesta_subtotal decimal(18, 2) NOT NULL,
	propuesta_descuento decimal(18, 2) NOT NULL,
	propuesta_importe_total decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT pk_propuesta PRIMARY KEY (propuesta_id);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_solicitud FOREIGN KEY (propuesta_solicitud)
	REFERENCES GRUPO_BASES26.SolicitudCotizacion (solicitud_id);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_agente FOREIGN KEY (propuesta_agente)
	REFERENCES GRUPO_BASES26.Agente (agente_legajo);
ALTER TABLE GRUPO_BASES26.Propuesta
	ADD CONSTRAINT fk_propuesta_estado FOREIGN KEY (propuesta_estado)
	REFERENCES GRUPO_BASES26.Estado (estado_id);
----------------------------
CREATE TABLE GRUPO_BASES26.DetallePropuestaVuelo (
	det_prop_vuelo_id bigint IDENTITY(1,1) NOT NULL,
	det_prop_vuelo_vuelo bigint NOT NULL,
	det_prop_vuelo_propuesta bigint NOT NULL,
	det_prop_vuelo_cantidad int NOT NULL,
	det_prop_vuelo_precio_unitario decimal(18, 2) NOT NULL,
	det_prop_vuelo_subtotal decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT pk_detalle_propuesta_vuelo PRIMARY KEY (det_prop_vuelo_id);
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT fk_detalle_propuesta_vuelo_propuesta FOREIGN KEY (det_prop_vuelo_propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (propuesta_id);
ALTER TABLE GRUPO_BASES26.DetallePropuestaVuelo
	ADD CONSTRAINT fk_detalle_propuesta_vuelo_vuelo FOREIGN KEY (det_prop_vuelo_vuelo)
	REFERENCES GRUPO_BASES26.Vuelo (vuelo_id);
----------------------------
CREATE TABLE GRUPO_BASES26.DetallePropuestaHospedaje (
	det_prop_hosp_id bigint IDENTITY(1,1) NOT NULL,
	det_prop_hosp_propuesta bigint NOT NULL,
	det_prop_hosp_habitacion bigint NOT NULL,
	det_prop_hosp_hospedaje bigint NOT NULL,
	det_prop_hosp_fecha_desde date NOT NULL,
	det_prop_hosp_fecha_hasta date NOT NULL,
	det_prop_hosp_cantidad int NOT NULL,
	det_prop_hosp_precio_unitario decimal(18, 2) NOT NULL,
	det_prop_hosp_subtotal decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT pk_detalle_propuesta_hospedaje PRIMARY KEY (det_prop_hosp_id);
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT fk_detalle_propuesta_hospedaje_propuesta FOREIGN KEY (det_prop_hosp_propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (propuesta_id);
ALTER TABLE GRUPO_BASES26.DetallePropuestaHospedaje
	ADD CONSTRAINT fk_detalle_propuesta_hospedaje_habitacion FOREIGN KEY (det_prop_hosp_habitacion, det_prop_hosp_hospedaje)
	REFERENCES GRUPO_BASES26.Habitacion (habitacion_id, habitacion_hospedaje);
----------------------------
CREATE TABLE GRUPO_BASES26.Venta (
	venta_id bigint NOT NULL,
	venta_agencia bigint NOT NULL,
	venta_cliente bigint NOT NULL,
	venta_agente bigint NOT NULL,
	venta_canal bigint NOT NULL,
	venta_medio_pago bigint NOT NULL,
	venta_fecha date NOT NULL,
	venta_subtotal decimal(18, 2) NOT NULL,
	venta_descuento decimal(18, 2) NOT NULL,
	venta_importe_total decimal(18, 2) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT pk_venta PRIMARY KEY (venta_id);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_agencia FOREIGN KEY (venta_agencia)
	REFERENCES GRUPO_BASES26.Agencia (agencia_id);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (venta_cliente)
	REFERENCES GRUPO_BASES26.Cliente (cliente_id);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_agente FOREIGN KEY (venta_agente)
	REFERENCES GRUPO_BASES26.Agente (agente_legajo);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_canal_venta FOREIGN KEY (venta_canal)
	REFERENCES GRUPO_BASES26.Canal_Venta (canal_id);
ALTER TABLE GRUPO_BASES26.Venta
	ADD CONSTRAINT fk_venta_medio_pago FOREIGN KEY (venta_medio_pago)
	REFERENCES GRUPO_BASES26.Medio_Pago (medio_pago_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Venta_Propuesta (
	venta_prop_venta bigint NOT NULL,
	venta_prop_propuesta bigint NOT NULL
)
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT pk_venta_propuesta PRIMARY KEY (venta_prop_venta, venta_prop_propuesta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT fk_venta_propuesta_venta FOREIGN KEY (venta_prop_venta)
	REFERENCES GRUPO_BASES26.Venta (venta_id);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT fk_venta_propuesta_propuesta FOREIGN KEY (venta_prop_propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (propuesta_id);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT uq_venta_propuesta_venta UNIQUE (venta_prop_venta);
ALTER TABLE GRUPO_BASES26.Venta_Propuesta
	ADD CONSTRAINT uq_venta_propuesta_propuesta UNIQUE (venta_prop_propuesta);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Vuelo (
	det_vta_vuelo_venta bigint NOT NULL,
	det_vta_vuelo_vuelo bigint NOT NULL,
	det_vta_vuelo_cantidad int NOT NULL,
	det_vta_vuelo_precio_unitario decimal(18, 2) NOT NULL,
	det_vta_vuelo_subtotal decimal(18, 2) NOT NULL,
	det_vta_vuelo_cod_reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT pk_detalle_venta_vuelo PRIMARY KEY (det_vta_vuelo_venta, det_vta_vuelo_vuelo);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT fk_detalle_venta_vuelo_venta FOREIGN KEY (det_vta_vuelo_venta)
	REFERENCES GRUPO_BASES26.Venta (venta_id);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Vuelo
	ADD CONSTRAINT fk_detalle_venta_vuelo_vuelo FOREIGN KEY (det_vta_vuelo_vuelo)
	REFERENCES GRUPO_BASES26.Vuelo (vuelo_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje (
	det_vta_hosp_venta bigint NOT NULL,
	det_vta_hosp_habitacion bigint NOT NULL,
	det_vta_hosp_hospedaje bigint NOT NULL,
	det_vta_hosp_fecha_desde date NOT NULL,
	det_vta_hosp_fecha_hasta date NOT NULL,
	det_vta_hosp_cantidad int NOT NULL,
	det_vta_hosp_precio_unitario decimal(18, 2) NOT NULL,
	det_vta_hosp_subtotal decimal(18, 2) NOT NULL,
	det_vta_hosp_cod_reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT pk_detalle_venta_hospedaje PRIMARY KEY (det_vta_hosp_venta, det_vta_hosp_habitacion, det_vta_hosp_hospedaje);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT fk_detalle_venta_hospedaje_venta FOREIGN KEY (det_vta_hosp_venta)
	REFERENCES GRUPO_BASES26.Venta (venta_id);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Hospedaje
	ADD CONSTRAINT fk_detalle_venta_hospedaje_habitacion FOREIGN KEY (det_vta_hosp_habitacion, det_vta_hosp_hospedaje)
	REFERENCES GRUPO_BASES26.Habitacion (habitacion_id, habitacion_hospedaje);
----------------------------
CREATE TABLE GRUPO_BASES26.Detalle_Venta_Excursion (
	det_vta_excur_excursion bigint NOT NULL,
	det_vta_excur_venta bigint NOT NULL,
	det_vta_excur_fecha_reserva date NOT NULL,
	det_vta_excur_cantidad int NOT NULL,
	det_vta_excur_precio_unitario decimal(18, 2) NOT NULL,
	det_vta_excur_subtotal decimal(18, 2) NOT NULL,
	det_vta_excur_cod_reserva nvarchar(255) NOT NULL
)
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT pk_detalle_venta_excursion PRIMARY KEY (det_vta_excur_excursion, det_vta_excur_venta);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT fk_detalle_venta_excursion_venta FOREIGN KEY (det_vta_excur_venta)
	REFERENCES GRUPO_BASES26.Venta (venta_id);
ALTER TABLE GRUPO_BASES26.Detalle_Venta_Excursion
	ADD CONSTRAINT fk_detalle_venta_excursion_excursion FOREIGN KEY (det_vta_excur_excursion)
	REFERENCES GRUPO_BASES26.Excursion (excursion_id);
----------------------------
CREATE TABLE GRUPO_BASES26.Encuesta (
	encuesta_id bigint NOT NULL,
	encuesta_cliente bigint NOT NULL,
	encuesta_agente bigint NOT NULL,
	encuesta_venta bigint NULL,
	encuesta_propuesta bigint NULL,
	encuesta_fecha date NOT NULL,
	encuesta_comentarios nvarchar(max) NULL
)
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT pk_encuesta PRIMARY KEY (encuesta_id);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_cliente FOREIGN KEY (encuesta_cliente)
	REFERENCES GRUPO_BASES26.Cliente (cliente_id);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_agente FOREIGN KEY (encuesta_agente)
	REFERENCES GRUPO_BASES26.Agente (agente_legajo);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_venta FOREIGN KEY (encuesta_venta)
	REFERENCES GRUPO_BASES26.Venta (venta_id);
ALTER TABLE GRUPO_BASES26.Encuesta
	ADD CONSTRAINT fk_encuesta_propuesta FOREIGN KEY (encuesta_propuesta)
	REFERENCES GRUPO_BASES26.Propuesta (propuesta_id);

----------------------------
CREATE TABLE GRUPO_BASES26.CalificacionPorEncuesta (
	calificacion_encuesta bigint NOT NULL,
	calificacion_aspecto bigint NOT NULL,
	calificacion_valor int NOT NULL
)
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT pk_calificacion_por_encuesta PRIMARY KEY (calificacion_encuesta, calificacion_aspecto);
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT fk_calificacion_por_encuesta_encuesta FOREIGN KEY (calificacion_encuesta)
	REFERENCES GRUPO_BASES26.Encuesta (encuesta_id);
ALTER TABLE GRUPO_BASES26.CalificacionPorEncuesta
	ADD CONSTRAINT fk_calificacion_por_encuesta_aspecto FOREIGN KEY (calificacion_aspecto)
	REFERENCES GRUPO_BASES26.Aspecto (aspecto_id);


--==================================================
-- Indices
--==================================================

-- Geografía
CREATE INDEX ix_ciudad_pais          ON GRUPO_BASES26.Ciudad     (ciudad_pais);
CREATE INDEX ix_localidad_provincia  ON GRUPO_BASES26.Localidad  (localidad_provincia);

-- Aerolíneas y aeropuertos
CREATE INDEX ix_aerolinea_pais       ON GRUPO_BASES26.Aerolinea  (aerolinea_pais);
CREATE INDEX ix_aerolinea_alianza    ON GRUPO_BASES26.Aerolinea  (aerolinea_alianza);
CREATE INDEX ix_aeropuerto_ciudad    ON GRUPO_BASES26.Aeropuerto (aeropuerto_ciudad);

-- Hospedaje
CREATE INDEX ix_hospedaje_ciudad     ON GRUPO_BASES26.Hospedaje  (hospedaje_ciudad);
CREATE INDEX ix_hospedaje_pais       ON GRUPO_BASES26.Hospedaje  (hospedaje_pais);
CREATE INDEX ix_habitacion_hospedaje ON GRUPO_BASES26.Habitacion (habitacion_hospedaje);

-- Excursion
CREATE INDEX ix_excursion_proveedor  ON GRUPO_BASES26.Excursion  (excursion_proveedor);

-- Vuelo
CREATE INDEX ix_vuelo_aerolinea      ON GRUPO_BASES26.Vuelo (vuelo_aerolinea);
CREATE INDEX ix_vuelo_apto_salida    ON GRUPO_BASES26.Vuelo (vuelo_apto_salida);
CREATE INDEX ix_vuelo_apto_llegada   ON GRUPO_BASES26.Vuelo (vuelo_apto_llegada);
CREATE INDEX ix_vuelo_fecha_salida   ON GRUPO_BASES26.Vuelo (vuelo_fecha_salida);

-- Agencia y agentes
CREATE INDEX ix_agencia_localidad    ON GRUPO_BASES26.Agencia (agencia_localidad);
CREATE INDEX ix_agente_agencia       ON GRUPO_BASES26.Agente  (agente_agencia);
CREATE INDEX ix_agente_localidad     ON GRUPO_BASES26.Agente  (agente_localidad);
CREATE INDEX ix_agente_fecha_nac     ON GRUPO_BASES26.Agente  (agente_fecha_nac);

-- Cliente
CREATE INDEX ix_cliente_localidad    ON GRUPO_BASES26.Cliente (cliente_localidad);
CREATE INDEX ix_cliente_dni          ON GRUPO_BASES26.Cliente (cliente_dni);
CREATE INDEX ix_cliente_fecha_nac    ON GRUPO_BASES26.Cliente (cliente_fecha_nac);

-- Solicitud de cotización
CREATE INDEX ix_solicitud_cliente    ON GRUPO_BASES26.SolicitudCotizacion (solicitud_cliente);
CREATE INDEX ix_solicitud_agente     ON GRUPO_BASES26.SolicitudCotizacion (solicitud_agente);
CREATE INDEX ix_solicitud_fecha      ON GRUPO_BASES26.SolicitudCotizacion (solicitud_fecha);
CREATE INDEX ix_det_ciudad_ciudad    ON GRUPO_BASES26.DetalleCiudad       (det_ciudad_ciudad);
CREATE INDEX ix_det_ciudad_solicitud ON GRUPO_BASES26.DetalleCiudad       (det_ciudad_solicitud);

-- Propuesta
CREATE INDEX ix_propuesta_solicitud      ON GRUPO_BASES26.Propuesta                 (propuesta_solicitud);
CREATE INDEX ix_propuesta_agente         ON GRUPO_BASES26.Propuesta                 (propuesta_agente);
CREATE INDEX ix_propuesta_estado         ON GRUPO_BASES26.Propuesta                 (propuesta_estado);
CREATE INDEX ix_propuesta_fecha_emision  ON GRUPO_BASES26.Propuesta                 (propuesta_fecha_emision);
CREATE INDEX ix_det_prop_vuelo_vuelo     ON GRUPO_BASES26.DetallePropuestaVuelo     (det_prop_vuelo_vuelo);
CREATE INDEX ix_det_prop_vuelo_propuesta ON GRUPO_BASES26.DetallePropuestaVuelo     (det_prop_vuelo_propuesta);
CREATE INDEX ix_det_prop_hosp_propuesta  ON GRUPO_BASES26.DetallePropuestaHospedaje (det_prop_hosp_propuesta);
CREATE INDEX ix_det_prop_hosp_habitacion ON GRUPO_BASES26.DetallePropuestaHospedaje (det_prop_hosp_habitacion);
CREATE INDEX ix_det_prop_hosp_hospedaje  ON GRUPO_BASES26.DetallePropuestaHospedaje (det_prop_hosp_hospedaje);

-- Venta
CREATE INDEX ix_venta_agencia           ON GRUPO_BASES26.Venta                   (venta_agencia);
CREATE INDEX ix_venta_cliente           ON GRUPO_BASES26.Venta                   (venta_cliente);
CREATE INDEX ix_venta_agente            ON GRUPO_BASES26.Venta                   (venta_agente);
CREATE INDEX ix_venta_canal             ON GRUPO_BASES26.Venta                   (venta_canal);
CREATE INDEX ix_venta_medio_pago        ON GRUPO_BASES26.Venta                   (venta_medio_pago);
CREATE INDEX ix_venta_fecha             ON GRUPO_BASES26.Venta                   (venta_fecha);
CREATE INDEX ix_det_vta_vuelo_vuelo     ON GRUPO_BASES26.Detalle_Venta_Vuelo     (det_vta_vuelo_vuelo);
CREATE INDEX ix_det_vta_hosp_habitacion ON GRUPO_BASES26.Detalle_Venta_Hospedaje (det_vta_hosp_habitacion);
CREATE INDEX ix_det_vta_hosp_hospedaje  ON GRUPO_BASES26.Detalle_Venta_Hospedaje (det_vta_hosp_hospedaje);
CREATE INDEX ix_det_vta_excur_venta     ON GRUPO_BASES26.Detalle_Venta_Excursion (det_vta_excur_venta);

-- Encuesta
CREATE INDEX ix_encuesta_cliente     ON GRUPO_BASES26.Encuesta                (encuesta_cliente);
CREATE INDEX ix_encuesta_agente      ON GRUPO_BASES26.Encuesta                (encuesta_agente);
CREATE INDEX ix_encuesta_venta       ON GRUPO_BASES26.Encuesta                (encuesta_venta);
CREATE INDEX ix_encuesta_propuesta   ON GRUPO_BASES26.Encuesta                (encuesta_propuesta);
CREATE INDEX ix_encuesta_fecha       ON GRUPO_BASES26.Encuesta                (encuesta_fecha);
CREATE INDEX ix_calificacion_aspecto ON GRUPO_BASES26.CalificacionPorEncuesta (calificacion_aspecto);
GO
--==================================================
-- Migracion - Stored Procedures
--==================================================

-- NIVEL 1: Tablas sin dependencias

CREATE PROCEDURE GRUPO_BASES26.Migrar_Pais(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Pais (pais_nombre)
            SELECT Aerolinea_Pais FROM gd_esquema.Maestra WHERE Aerolinea_Pais IS NOT NULL
            UNION
            SELECT Aeropuerto_Salida_Pais FROM gd_esquema.Maestra WHERE Aeropuerto_Salida_Pais IS NOT NULL
            UNION
            SELECT Aeropuerto_Llegada_Pais FROM gd_esquema.Maestra WHERE Aeropuerto_Llegada_Pais IS NOT NULL
            UNION
            SELECT Hospedaje_Pais FROM gd_esquema.Maestra WHERE Hospedaje_Pais IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Provincia(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Provincia (provincia_nombre)
            SELECT Agente_Provincia FROM gd_esquema.Maestra WHERE Agente_Provincia IS NOT NULL
            UNION
            SELECT Agencia_Provincia FROM gd_esquema.Maestra WHERE Agencia_Provincia IS NOT NULL
            UNION
            SELECT Cliente_Provincia FROM gd_esquema.Maestra WHERE Cliente_Provincia IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Alianza(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Alianza (alianza_nombre)
            SELECT DISTINCT Aerolinea_Alianza FROM gd_esquema.Maestra WHERE Aerolinea_Alianza IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Estado(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Estado (estado_nombre)
            SELECT DISTINCT Propuesta_Estado FROM gd_esquema.Maestra WHERE Propuesta_Estado IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_CanalVenta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Canal_Venta (canal_detalle)
            SELECT DISTINCT Venta_Canal_Venta FROM gd_esquema.Maestra WHERE Venta_Canal_Venta IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_MedioPago(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Medio_Pago (medio_pago_detalle)
            SELECT DISTINCT Venta_Medio_Pago FROM gd_esquema.Maestra WHERE Venta_Medio_Pago IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Aspecto(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Aspecto (aspecto_descripcion)
            SELECT DISTINCT Aspecto_Aspecto FROM gd_esquema.Maestra WHERE Aspecto_Aspecto IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Proveedor(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Proveedor (proveedor_nombre, proveedor_mail, proveedor_telefono)
            SELECT DISTINCT Proveedor_Nombre, Proveedor_Mail, Proveedor_Telefono
            FROM gd_esquema.Maestra WHERE Proveedor_Nombre IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 2: Ciudad (->Pais), Localidad (->Provincia)

CREATE PROCEDURE GRUPO_BASES26.Migrar_Ciudad(@salida int OUTPUT)
AS
BEGIN
    CREATE TABLE #TempCiudadPais (Ciudad_Nombre nvarchar(255), Pais_Nombre nvarchar(255));
    INSERT INTO #TempCiudadPais (Ciudad_Nombre, Pais_Nombre)
    SELECT DISTINCT Aeropuerto_Salida_Ciudad, Aeropuerto_Salida_Pais
    FROM gd_esquema.Maestra WHERE Aeropuerto_Salida_Ciudad IS NOT NULL AND Aeropuerto_Salida_Pais IS NOT NULL
    UNION
    SELECT DISTINCT Aeropuerto_Llegada_Ciudad, Aeropuerto_Llegada_Pais
    FROM gd_esquema.Maestra WHERE Aeropuerto_Llegada_Ciudad IS NOT NULL AND Aeropuerto_Llegada_Pais IS NOT NULL
    UNION
    SELECT DISTINCT Hospedaje_Ciudad, Hospedaje_Pais
    FROM gd_esquema.Maestra WHERE Hospedaje_Ciudad IS NOT NULL AND Hospedaje_Pais IS NOT NULL;
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Ciudad (ciudad_pais, ciudad_nombre)
            SELECT DISTINCT p.pais_id, t.Ciudad_Nombre
            FROM #TempCiudadPais t
            INNER JOIN GRUPO_BASES26.Pais p ON p.pais_nombre = t.Pais_Nombre;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
    DROP TABLE #TempCiudadPais;
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Localidad(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Localidad (localidad_provincia, localidad_nombre)
            SELECT DISTINCT p.provincia_id, m.Agente_Localidad
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Agente_Provincia
            WHERE m.Agente_Localidad IS NOT NULL
            UNION
            SELECT DISTINCT p.provincia_id, m.Agencia_Localidad
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Agencia_Provincia
            WHERE m.Agencia_Localidad IS NOT NULL
            UNION
            SELECT DISTINCT p.provincia_id, m.Cliente_Localidad
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Cliente_Provincia
            WHERE m.Cliente_Localidad IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 3: Agencia (->Localidad), Aerolinea (->Pais,Alianza), Aeropuerto (->Ciudad), Hospedaje (->Ciudad,Pais)

CREATE PROCEDURE GRUPO_BASES26.Migrar_Agencia(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Agencia (agencia_id, agencia_localidad, agencia_direccion, agencia_telefono, agencia_mail)
            SELECT DISTINCT m.Agencia_Nro_Agencia, l.localidad_id, m.Agencia_Direccion, m.Agencia_Telefono, m.Agencia_Mail
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Agencia_Provincia
            INNER JOIN GRUPO_BASES26.Localidad l ON l.localidad_nombre = m.Agencia_Localidad AND l.localidad_provincia = p.provincia_id
            WHERE m.Agencia_Nro_Agencia IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Aerolinea(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Aerolinea (aerolinea_codigo, aerolinea_nombre, aerolinea_alianza, aerolinea_pais)
            SELECT DISTINCT m.Aerolinea_Codigo, m.Aerolinea_Nombre, a.alianza_id, p.pais_id
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Alianza a ON a.alianza_nombre = m.Aerolinea_Alianza
            INNER JOIN GRUPO_BASES26.Pais p ON p.pais_nombre = m.Aerolinea_Pais
            WHERE m.Aerolinea_Codigo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Aeropuerto(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Aeropuerto (aeropuerto_codigo, aeropuerto_descripcion, aeropuerto_ciudad)
            SELECT m.Aeropuerto_Salida_Codigo, m.Aeropuerto_Salida_Descripcion, c.ciudad_id
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Ciudad c ON c.ciudad_nombre = m.Aeropuerto_Salida_Ciudad
            WHERE m.Aeropuerto_Salida_Codigo IS NOT NULL
            UNION
            SELECT m.Aeropuerto_Llegada_Codigo, m.Aeropuerto_Llegada_Descripcion, c.ciudad_id
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Ciudad c ON c.ciudad_nombre = m.Aeropuerto_Llegada_Ciudad
            WHERE m.Aeropuerto_Llegada_Codigo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Hospedaje(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Hospedaje (hospedaje_ciudad, hospedaje_pais, hospedaje_nombre,
                                                  hospedaje_direccion, hospedaje_incluye_desayuno,
                                                  hospedaje_check_in, hospedaje_check_out)
            SELECT DISTINCT c.ciudad_id, c.ciudad_pais, m.Hospedaje_Nombre,
                            m.Hospedaje_Direccion, m.Hospedaje_Incluye_Desayuno,
                            m.Hospedaje_Check_In, m.Hospedaje_Check_Out
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Pais p ON p.pais_nombre = m.Hospedaje_Pais
            INNER JOIN GRUPO_BASES26.Ciudad c ON c.ciudad_nombre = m.Hospedaje_Ciudad AND c.ciudad_pais = p.pais_id
            WHERE m.Hospedaje_Nombre IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 4: Agente, Cliente, Habitacion, Excursion, Vuelo

CREATE PROCEDURE GRUPO_BASES26.Migrar_Agente(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Agente (agente_legajo, agente_agencia, agente_localidad, agente_nombre,
                                               agente_apellido, agente_dni, agente_fecha_nac,
                                               agente_telefono, agente_mail, agente_direccion)
            SELECT DISTINCT m.Agente_Legajo, m.Agencia_Nro_Agencia, l.localidad_id, m.Agente_Nombre,
                            m.Agente_Apellido, m.Agente_Dni, m.Agente_Fecha_Nac,
                            m.Agente_Telefono, m.Agente_Mail, m.Agente_Direccion
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Agente_Provincia
            INNER JOIN GRUPO_BASES26.Localidad l ON l.localidad_nombre = m.Agente_Localidad AND l.localidad_provincia = p.provincia_id
            WHERE m.Agente_Legajo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Cliente(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Cliente (cliente_localidad, cliente_nombre, cliente_apellido,
                                               cliente_dni, cliente_telefono, cliente_mail,
                                               cliente_direccion, cliente_fecha_nac)
            SELECT DISTINCT l.localidad_id, m.Cliente_Nombre, m.Cliente_Apellido,
                            m.Cliente_Dni, m.Cliente_Tel, m.Cliente_Mail,
                            m.Cliente_Direccion, m.Cliente_Fecha_Nac
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Provincia p ON p.provincia_nombre = m.Cliente_Provincia
            INNER JOIN GRUPO_BASES26.Localidad l ON l.localidad_nombre = m.Cliente_Localidad AND l.localidad_provincia = p.provincia_id
            WHERE m.Cliente_Dni IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Habitacion(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Habitacion (habitacion_hospedaje, habitacion_nombre,
                                                   habitacion_descripcion, habitacion_precio_noche)
            SELECT DISTINCT h.hospedaje_id, m.Habitacion_Nombre,
                            m.Habitacion_Descripcion, m.Habitacion_Precio_Noche
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Hospedaje h
                ON h.hospedaje_nombre = m.Hospedaje_Nombre AND h.hospedaje_direccion = m.Hospedaje_Direccion
            WHERE m.Habitacion_Nombre IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Excursion(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Excursion (excursion_proveedor, excursion_nombre, excursion_descripcion,
                                                  excursion_horario, excursion_duracion, excursion_precio)
            SELECT DISTINCT p.proveedor_id, m.Excursion_Nombre, m.Excursion_Descripcion,
                            m.Excursion_Horario, m.Excursion_Duracion, m.Excursion_Precio
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Proveedor p ON p.proveedor_nombre = m.Proveedor_Nombre
            WHERE m.Excursion_Nombre IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Vuelo(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Vuelo (vuelo_aerolinea, vuelo_apto_salida, vuelo_apto_llegada,
                                              vuelo_fecha_salida, vuelo_hora_salida, vuelo_fecha_llegada,
                                              vuelo_hora_llegada, vuelo_duracion, vuelo_precio,
                                              vuelo_incluye_carry, vuelo_incluye_valija)
            SELECT DISTINCT Aerolinea_Codigo, Aeropuerto_Salida_Codigo, Aeropuerto_Llegada_Codigo,
                            Vuelo_Fecha_Salida, Vuelo_Horario_Salida, Vuelo_Fecha_Llegada,
                            Vuelo_Horario_Llegada, Vuelo_Duracion, Vuelo_Precio,
                            Vuelo_Incluye_Carry, Vuelo_Incluye_Valija
            FROM gd_esquema.Maestra
            WHERE Aerolinea_Codigo IS NOT NULL AND Aeropuerto_Salida_Codigo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 5: SolicitudCotizacion (->Cliente,Agente), Venta (->Agencia,Cliente,Agente,CanalVenta,MedioPago)

CREATE PROCEDURE GRUPO_BASES26.Migrar_SolicitudCotizacion(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.SolicitudCotizacion (
                solicitud_id, solicitud_cliente, solicitud_agente, solicitud_fecha,
                solicitud_fecha_inicio, solicitud_fecha_fin, solicitud_cant_pax,
                solicitud_observaciones, solicitud_presupuesto
            )
            SELECT DISTINCT
                m.Solicitud_Nro_Solicitud, c.cliente_id, m.Agente_Legajo,
                m.Solicitud_Fecha_Solicitud, m.Solicitud_Fecha_Inicio_Tentativa,
                m.Solicitud_Fecha_Fin_Tentativa, m.Solicitud_Cant_Pax,
                m.Solicitud_Observaciones, m.Solicitud_Presupuesto_Estimado
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Cliente c
                ON c.cliente_dni = m.Cliente_Dni AND c.cliente_nombre = m.Cliente_Nombre AND c.cliente_apellido = m.Cliente_Apellido
            WHERE m.Solicitud_Nro_Solicitud IS NOT NULL AND m.Agente_Legajo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Venta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Venta (
                venta_id, venta_agencia, venta_cliente, venta_agente, venta_canal,
                venta_medio_pago, venta_fecha, venta_subtotal, venta_descuento, venta_importe_total
            )
            SELECT DISTINCT
                m.Venta_Nro_Venta, m.Agencia_Nro_Agencia, c.cliente_id, m.Agente_Legajo,
                cv.canal_id, mp.medio_pago_id, m.Venta_Fecha_Venta,
                m.Venta_Subtotal, m.Venta_Descuento, m.Venta_Importe_Total
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Cliente c
                ON c.cliente_dni = m.Cliente_Dni AND c.cliente_nombre = m.Cliente_Nombre AND c.cliente_apellido = m.Cliente_Apellido
            INNER JOIN GRUPO_BASES26.Canal_Venta cv ON cv.canal_detalle = m.Venta_Canal_Venta
            INNER JOIN GRUPO_BASES26.Medio_Pago mp ON mp.medio_pago_detalle = m.Venta_Medio_Pago
            WHERE m.Venta_Nro_Venta IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 6: DetalleCiudad (->Ciudad,SolicitudCotizacion), Propuesta (->SolicitudCotizacion,Agente,Estado)

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetalleCiudad(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.DetalleCiudad (det_ciudad_ciudad, det_ciudad_solicitud, det_ciudad_cant_dias, det_ciudad_observaciones)
            SELECT DISTINCT ci.ciudad_id, m.Solicitud_Nro_Solicitud, m.Detalle_Solicitud_Cant_Dias_Aprox, m.Detalle_Solicitud_Observaciones
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Ciudad ci ON ci.ciudad_nombre = m.Detalle_Solicitud_Ciudad
            WHERE m.Solicitud_Nro_Solicitud IS NOT NULL AND m.Detalle_Solicitud_Ciudad IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_Propuesta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Propuesta (
                propuesta_id, propuesta_solicitud, propuesta_agente, propuesta_estado,
                propuesta_fecha_emision, propuesta_vigencia, propuesta_fecha_desde, propuesta_fecha_hasta,
                propuesta_subtotal, propuesta_descuento, propuesta_importe_total
            )
            SELECT DISTINCT
                m.Propuesta_Nro_Propuesta, m.Solicitud_Nro_Solicitud, m.Agente_Legajo, e.estado_id,
                m.Propuesta_Fecha_Emision, m.Propuesta_Vigencia_Hasta, m.Propuesta_Fecha_Desde, m.Propuesta_Fecha_Hasta,
                m.Propuesta_Subtotal, m.Propuesta_Descuento, m.Propuesta_Importe_Total
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Estado e ON e.estado_nombre = m.Propuesta_Estado
            WHERE m.Propuesta_Nro_Propuesta IS NOT NULL AND m.Solicitud_Nro_Solicitud IS NOT NULL AND m.Agente_Legajo IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 7: Detalles de Propuesta y Venta

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetallePropuestaVuelo(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.DetallePropuestaVuelo (
                det_prop_vuelo_vuelo, det_prop_vuelo_propuesta, det_prop_vuelo_cantidad,
                det_prop_vuelo_precio_unitario, det_prop_vuelo_subtotal
            )
            SELECT DISTINCT
                v.vuelo_id, m.Propuesta_Nro_Propuesta, m.Detalle_Propuesta_Vuelo_Cant_Pasajes,
                m.Detalle_Propuesta_Vuelo_Precio, m.Detalle_Propuesta_Vuelo_Subtotal
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Vuelo v
                ON v.vuelo_aerolinea = m.Aerolinea_Codigo AND v.vuelo_apto_salida = m.Aeropuerto_Salida_Codigo
                AND v.vuelo_apto_llegada = m.Aeropuerto_Llegada_Codigo AND v.vuelo_fecha_salida = m.Vuelo_Fecha_Salida
            WHERE m.Propuesta_Nro_Propuesta IS NOT NULL AND m.Detalle_Propuesta_Vuelo_Cant_Pasajes IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetallePropuestaHospedaje(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.DetallePropuestaHospedaje (
                det_prop_hosp_propuesta, det_prop_hosp_habitacion, det_prop_hosp_hospedaje,
                det_prop_hosp_fecha_desde, det_prop_hosp_fecha_hasta, det_prop_hosp_cantidad,
                det_prop_hosp_precio_unitario, det_prop_hosp_subtotal
            )
            SELECT DISTINCT m.Propuesta_Nro_Propuesta, hab.habitacion_id, h.hospedaje_id,
                m.Detalle_Propuesta_Hospedaje_Fecha_Desde, m.Detalle_Propuesta_Hospedaje_Fecha_Hasta,
                m.Detalle_Propuesta_Hospedaje_Cant, m.Detalle_Propuesta_Hospedaje_Precio, m.Detalle_Propuesta_Hospedaje_Subtotal
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Hospedaje h
                ON h.hospedaje_nombre = m.Hospedaje_Nombre AND h.hospedaje_direccion = m.Hospedaje_Direccion
            INNER JOIN GRUPO_BASES26.Habitacion hab
                ON hab.habitacion_hospedaje = h.hospedaje_id AND hab.habitacion_nombre = m.Habitacion_Nombre
            WHERE m.Propuesta_Nro_Propuesta IS NOT NULL AND m.Detalle_Propuesta_Hospedaje_Fecha_Desde IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_VentaPropuesta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Venta_Propuesta (venta_prop_venta, venta_prop_propuesta)
            SELECT DISTINCT m.Venta_Nro_Venta, m.Propuesta_Nro_Propuesta
            FROM gd_esquema.Maestra m
            WHERE m.Venta_Nro_Venta IS NOT NULL AND m.Propuesta_Nro_Propuesta IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetalleVentaVuelo(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Detalle_Venta_Vuelo (
                det_vta_vuelo_venta, det_vta_vuelo_vuelo, det_vta_vuelo_cantidad,
                det_vta_vuelo_precio_unitario, det_vta_vuelo_subtotal, det_vta_vuelo_cod_reserva
            )
            SELECT DISTINCT m.Venta_Nro_Venta, v.vuelo_id, m.Detalle_Venta_Vuelo_Cantidad_Pasajes,
                m.Detalle_Venta_Vuelo_Precio_Unitario, m.Detalle_Venta_Vuelo_Subtotal, m.Detalle_Venta_Vuelo_Cod_Reserva
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Vuelo v
                ON v.vuelo_aerolinea = m.Aerolinea_Codigo AND v.vuelo_apto_salida = m.Aeropuerto_Salida_Codigo
                AND v.vuelo_apto_llegada = m.Aeropuerto_Llegada_Codigo AND v.vuelo_fecha_salida = m.Vuelo_Fecha_Salida
            WHERE m.Venta_Nro_Venta IS NOT NULL AND m.Detalle_Venta_Vuelo_Cantidad_Pasajes IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetalleVentaHospedaje(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Detalle_Venta_Hospedaje (
                det_vta_hosp_venta, det_vta_hosp_habitacion, det_vta_hosp_hospedaje,
                det_vta_hosp_fecha_desde, det_vta_hosp_fecha_hasta, det_vta_hosp_cantidad,
                det_vta_hosp_precio_unitario, det_vta_hosp_subtotal, det_vta_hosp_cod_reserva
            )
            SELECT Venta_Nro_Venta, habitacion_id, hospedaje_id,
                Detalle_Venta_Hospedaje_Fecha_Desde, Detalle_Venta_Hospedaje_Fecha_Hasta,
                Detalle_Venta_Hospedaje_Cantidad, Detalle_Venta_Hospedaje_Precio_Unitario,
                Detalle_Venta_Hospedaje_Subtotal, Detalle_Venta_Hospedaje_Cod_Reserva
            FROM (
                SELECT m.Venta_Nro_Venta, hab.habitacion_id, h.hospedaje_id,
                    m.Detalle_Venta_Hospedaje_Fecha_Desde, m.Detalle_Venta_Hospedaje_Fecha_Hasta,
                    m.Detalle_Venta_Hospedaje_Cantidad, m.Detalle_Venta_Hospedaje_Precio_Unitario,
                    m.Detalle_Venta_Hospedaje_Subtotal, m.Detalle_Venta_Hospedaje_Cod_Reserva,
                    ROW_NUMBER() OVER (PARTITION BY m.Venta_Nro_Venta, hab.habitacion_id, h.hospedaje_id ORDER BY (SELECT NULL)) AS rn
                FROM gd_esquema.Maestra m
                INNER JOIN GRUPO_BASES26.Hospedaje h
                    ON h.hospedaje_nombre = m.Hospedaje_Nombre AND h.hospedaje_direccion = m.Hospedaje_Direccion
                INNER JOIN GRUPO_BASES26.Habitacion hab
                    ON hab.habitacion_hospedaje = h.hospedaje_id AND hab.habitacion_nombre = m.Habitacion_Nombre
                WHERE m.Venta_Nro_Venta IS NOT NULL AND m.Detalle_Venta_Hospedaje_Fecha_Desde IS NOT NULL
            ) sub
            WHERE rn = 1;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

CREATE PROCEDURE GRUPO_BASES26.Migrar_DetalleVentaExcursion(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Detalle_Venta_Excursion (
                det_vta_excur_excursion, det_vta_excur_venta, det_vta_excur_fecha_reserva,
                det_vta_excur_cantidad, det_vta_excur_precio_unitario,
                det_vta_excur_subtotal, det_vta_excur_cod_reserva
            )
            SELECT excursion_id, Venta_Nro_Venta, Detalle_Venta_Excursion_Fecha_Reserva,
                Detalle_Venta_Excursion_Cant, Detalle_Venta_Excursion_Precio_Unitario,
                Detalle_Venta_Excursion_Subtotal, Detalle_Venta_Excursion_Cod_Reserva
            FROM (
                SELECT e.excursion_id, m.Venta_Nro_Venta, m.Detalle_Venta_Excursion_Fecha_Reserva,
                    m.Detalle_Venta_Excursion_Cant, m.Detalle_Venta_Excursion_Precio_Unitario,
                    m.Detalle_Venta_Excursion_Subtotal, m.Detalle_Venta_Excursion_Cod_Reserva,
                    ROW_NUMBER() OVER (PARTITION BY e.excursion_id, m.Venta_Nro_Venta ORDER BY (SELECT NULL)) AS rn
                FROM gd_esquema.Maestra m
                INNER JOIN GRUPO_BASES26.Excursion e ON e.excursion_nombre = m.Excursion_Nombre
                WHERE m.Venta_Nro_Venta IS NOT NULL AND m.Excursion_Nombre IS NOT NULL
            ) sub
            WHERE rn = 1;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 8: Encuesta (->Cliente,Agente,Venta,Propuesta)

CREATE PROCEDURE GRUPO_BASES26.Migrar_Encuesta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.Encuesta (
                encuesta_id, encuesta_cliente, encuesta_agente, encuesta_venta,
                encuesta_propuesta, encuesta_fecha, encuesta_comentarios
            )
            SELECT DISTINCT m.Encuesta_Codigo_Encuesta, c.cliente_id, m.Agente_Legajo,
                m.Venta_Nro_Venta, m.Propuesta_Nro_Propuesta, m.Encuesta_Fecha_Encuesta, m.Encuesta_Comentarios
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Cliente c
                ON c.cliente_dni = m.Cliente_Dni AND c.cliente_nombre = m.Cliente_Nombre AND c.cliente_apellido = m.Cliente_Apellido
            WHERE m.Encuesta_Codigo_Encuesta IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

-- NIVEL 9: CalificacionPorEncuesta (->Encuesta,Aspecto)

CREATE PROCEDURE GRUPO_BASES26.Migrar_CalificacionPorEncuesta(@salida int OUTPUT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO GRUPO_BASES26.CalificacionPorEncuesta (calificacion_encuesta, calificacion_aspecto, calificacion_valor)
            SELECT DISTINCT m.Encuesta_Codigo_Encuesta, a.aspecto_id, m.Detalle_Encuesta_Puntaje
            FROM gd_esquema.Maestra m
            INNER JOIN GRUPO_BASES26.Aspecto a ON a.aspecto_descripcion = m.Aspecto_Aspecto
            WHERE m.Encuesta_Codigo_Encuesta IS NOT NULL AND m.Aspecto_Aspecto IS NOT NULL;
            SET @salida = @@ROWCOUNT
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SET @salida = -1
    END CATCH
END
GO

--==================================================
-- Ejecucion de migraciones en orden de dependencia
--==================================================

DECLARE @resultado int

-- Nivel 1
EXEC GRUPO_BASES26.Migrar_Pais @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Pais - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Provincia @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Provincia - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Alianza @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Alianza - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Estado @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Estado - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_CanalVenta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_CanalVenta - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_MedioPago @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_MedioPago - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Aspecto @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Aspecto - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Proveedor @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Proveedor - Filas insertadas';

-- Nivel 2
EXEC GRUPO_BASES26.Migrar_Ciudad @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Ciudad - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Localidad @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Localidad - Filas insertadas';

-- Nivel 3
EXEC GRUPO_BASES26.Migrar_Agencia @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Agencia - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Aerolinea @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Aerolinea - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Aeropuerto @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Aeropuerto - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Hospedaje @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Hospedaje - Filas insertadas';

-- Nivel 4
EXEC GRUPO_BASES26.Migrar_Agente @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Agente - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Cliente @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Cliente - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Habitacion @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Habitacion - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Excursion @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Excursion - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Vuelo @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Vuelo - Filas insertadas';

-- Nivel 5
EXEC GRUPO_BASES26.Migrar_SolicitudCotizacion @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_SolicitudCotizacion - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Venta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Venta - Filas insertadas';

-- Nivel 6
EXEC GRUPO_BASES26.Migrar_DetalleCiudad @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetalleCiudad - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_Propuesta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Propuesta - Filas insertadas';

-- Nivel 7
EXEC GRUPO_BASES26.Migrar_DetallePropuestaVuelo @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetallePropuestaVuelo - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_DetallePropuestaHospedaje @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetallePropuestaHospedaje - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_VentaPropuesta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_VentaPropuesta - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_DetalleVentaVuelo @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetalleVentaVuelo - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_DetalleVentaHospedaje @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetalleVentaHospedaje - Filas insertadas';
EXEC GRUPO_BASES26.Migrar_DetalleVentaExcursion @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_DetalleVentaExcursion - Filas insertadas';

-- Nivel 8
EXEC GRUPO_BASES26.Migrar_Encuesta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_Encuesta - Filas insertadas';

-- Nivel 9
EXEC GRUPO_BASES26.Migrar_CalificacionPorEncuesta @salida = @resultado OUTPUT; SELECT @resultado AS 'Migrar_CalificacionPorEncuesta - Filas insertadas';
