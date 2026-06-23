USE GD1C2026
GO

-- ============================================================
    -- CREACION DE TABLAS DIMENSIONALES
    -- ============================================================


    CREATE TABLE GRUPO_BASES26.BI_Dim_Tiempo (
    tiempo_id bigint IDENTITY(1,1) NOT NULL,
        anio int NOT NULL,
        cuatrimestre int NOT NULL,
        mes int NOT NULL
    )
GO

ALTER TABLE GRUPO_BASES26.BI_Dim_Tiempo
ADD CONSTRAINT pk_bi_dim_tiempo PRIMARY KEY (tiempo_id)
GO


ALTER TABLE GRUPO_BASES26.BI_Dim_Tiempo
ADD CONSTRAINT uq_bi_dim_tiempo_anio_mes UNIQUE (anio, mes)
GO

-- No se usa identity pq es una tabla ya existente en el modelo transaccional y se reutilizan
    CREATE TABLE GRUPO_BASES26.BI_Dim_Canal (
    canal_id  bigint NOT NULL,
        canal_detalle nvarchar(255) NOT NULL
    )
GO

ALTER TABLE GRUPO_BASES26.BI_Dim_Canal
ADD CONSTRAINT pk_bi_dim_canal PRIMARY KEY (canal_id)
GO

CREATE TABLE GRUPO_BASES26.BI_Dim_RangoEtarioCliente (
    rango_etario_cliente_id bigint IDENTITY(1,1) NOT NULL,
    rango_descripcion nvarchar(50)  NOT NULL
    )
GO

ALTER TABLE GRUPO_BASES26.BI_Dim_RangoEtarioCliente
ADD CONSTRAINT pk_bi_dim_rango_cli PRIMARY KEY (rango_etario_cliente_id)
GO


CREATE TABLE GRUPO_BASES26.BI_Dim_TipoServicio (
    tipo_servicio_id bigint IDENTITY(1,1) NOT NULL,
        tipo_descripcion nvarchar(50) NOT NULL
    )
GO
ALTER TABLE GRUPO_BASES26.BI_Dim_TipoServicio
ADD CONSTRAINT pk_bi_dim_tipo_servicio PRIMARY KEY (tipo_servicio_id)
GO


-- ============================================================
    -- TABLA DE HECHOS: VENTAS
    -- ============================================================

    CREATE TABLE GRUPO_BASES26.BI_Hechos_Ventas (
    tiempo_id  bigint NOT NULL,
        canal_id bigint NOT NULL,
        rango_et_cli_id bigint NOT NULL,
        tipo_servicio_id bigint NOT NULL,
    importe_total decimal(18,2) NOT NULL,
        cantidad_ventas int NOT NULL
    )
GO

ALTER TABLE GRUPO_BASES26.BI_Hechos_Ventas
    ADD CONSTRAINT pk_bi_hechos_ventas
    PRIMARY KEY (tiempo_id, canal_id, rango_et_cli_id, tipo_servicio_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Ventas
    ADD CONSTRAINT fk_bi_hv_tiempo FOREIGN KEY (tiempo_id)
    REFERENCES GRUPO_BASES26.BI_Dim_Tiempo (tiempo_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Ventas
    ADD CONSTRAINT fk_bi_hv_canal FOREIGN KEY (canal_id)
    REFERENCES GRUPO_BASES26.BI_Dim_Canal (canal_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Ventas
    ADD CONSTRAINT fk_bi_hv_rango_cli FOREIGN KEY (rango_et_cli_id)
    REFERENCES GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_etario_cliente_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Ventas
    ADD CONSTRAINT fk_bi_hv_tipo_srv FOREIGN KEY (tipo_servicio_id)
    REFERENCES GRUPO_BASES26.BI_Dim_TipoServicio (tipo_servicio_id)
GO


-- ============================================================
-- INDICES para performance en consultas
-- ============================================================
    CREATE INDEX ix_bi_hv_tiempo ON GRUPO_BASES26.BI_Hechos_Ventas (tiempo_id)
GO
CREATE INDEX ix_bi_hv_canal ON GRUPO_BASES26.BI_Hechos_Ventas (canal_id)
GO
CREATE INDEX ix_bi_hv_rango ON GRUPO_BASES26.BI_Hechos_Ventas (rango_et_cli_id)
GO
CREATE INDEX ix_bi_hv_tiposrv ON GRUPO_BASES26.BI_Hechos_Ventas (tipo_servicio_id)
GO


-- ============================================================
    -- CARGA DE DIMENSIONES
    -- ============================================================


INSERT INTO GRUPO_BASES26.BI_Dim_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(venta_fecha),
    CASE
        WHEN MONTH(venta_fecha) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(venta_fecha) BETWEEN 5 AND 8 THEN 2
        ELSE 3
    END,
    MONTH(venta_fecha)
FROM GRUPO_BASES26.Venta
ORDER BY 1, 3
GO


INSERT INTO GRUPO_BASES26.BI_Dim_Canal (canal_id, canal_detalle)
SELECT canal_id, canal_detalle
FROM GRUPO_BASES26.Canal_Venta
GO


INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Menores de 25 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Entre 25 y 35 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Entre 35 y 50 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Mayores de 50 años')
GO


INSERT INTO GRUPO_BASES26.BI_Dim_TipoServicio (tipo_descripcion) VALUES ('Venta Directa')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_TipoServicio (tipo_descripcion) VALUES ('Propuesta a Medida')
GO

-- ============================================================
-- CARGA DEL HECHO VENTAS
-- ============================================================

INSERT INTO GRUPO_BASES26.BI_Hechos_Ventas (
    tiempo_id, canal_id, rango_et_cli_id, tipo_servicio_id,
    importe_total, cantidad_ventas
    )
SELECT
    T.tiempo_id,
    V.venta_canal AS canal_id,
    RC.rango_etario_cliente_id AS rango_et_cli_id,
    TS.tipo_servicio_id,
    SUM(V.venta_importe_total) AS importe_total,
    COUNT(V.venta_id) AS cantidad_ventas
FROM GRUPO_BASES26.Venta V
INNER JOIN GRUPO_BASES26.Cliente C
    ON C.cliente_id = V.venta_cliente
INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T
    ON  T.anio = YEAR(V.venta_fecha)
    AND T.mes  = MONTH(V.venta_fecha)
INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioCliente RC
    ON RC.rango_descripcion = CASE
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, V.venta_fecha) < 25
            THEN 'Menores de 25 años'
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, V.venta_fecha) BETWEEN 25 AND 35
            THEN 'Entre 25 y 35 años'
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, V.venta_fecha) BETWEEN 36 AND 50
            THEN 'Entre 35 y 50 años'
        ELSE 'Mayores de 50 años'
    END
INNER JOIN GRUPO_BASES26.BI_Dim_TipoServicio TS
    ON TS.tipo_descripcion = CASE
        WHEN EXISTS (
            SELECT 1
            FROM GRUPO_BASES26.Venta_Propuesta VP
            WHERE VP.venta_prop_venta = V.venta_id
        ) THEN 'Propuesta a Medida'
        ELSE 'Venta Directa'
    END
GROUP BY
    T.tiempo_id,
    V.venta_canal,
    RC.rango_etario_cliente_id,
    TS.tipo_servicio_id
GO


-- ============================================================
    -- VISTAS DE NEGOCIO
    -- ============================================================

    -- Vista 1: Ticket Promedio
    CREATE VIEW GRUPO_BASES26.BI_Vista_Ticket_Promedio AS
SELECT
    T.anio AS ANIO,
    T.mes AS MES,
    RC.rango_descripcion AS RANGO_ETARIO_CLIENTE,
    BC.canal_detalle AS CANAL_VENTA,
    SUM(H.importe_total) / NULLIF(SUM(H.cantidad_ventas), 0) AS TICKET_PROMEDIO
FROM GRUPO_BASES26.BI_Hechos_Ventas H
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_id
    INNER JOIN GRUPO_BASES26.BI_Dim_Canal BC ON BC.canal_id = H.canal_id
    INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioCliente RC ON RC.rango_etario_cliente_id = H.rango_et_cli_id
GROUP BY T.anio, T.mes, RC.rango_descripcion, BC.canal_detalle
GO


-- Vista 2: Distribucion de Facturacion
    CREATE VIEW GRUPO_BASES26.BI_Vista_Distribucion_Facturacion AS
SELECT
    T.anio AS ANIO,
    T.cuatrimestre AS CUATRIMESTRE,
    TS.tipo_descripcion AS TIPO_SERVICIO,
    SUM(H.importe_total) AS FACTURACION_TIPO,
    SUM(H.importe_total) * 100.0
        / NULLIF(
            SUM(SUM(H.importe_total)) OVER (PARTITION BY T.anio, T.cuatrimestre), 0) AS PORCENTAJE_FACTURACION
FROM GRUPO_BASES26.BI_Hechos_Ventas H
INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T  ON T.tiempo_id = H.tiempo_id
    INNER JOIN GRUPO_BASES26.BI_Dim_TipoServicio TS ON TS.tipo_servicio_id = H.tipo_servicio_id
GROUP BY T.anio, T.cuatrimestre, TS.tipo_descripcion
GO 


-- ============================================================
-- DIMENSION: TEMPORADAS
-- ============================================================
CREATE TABLE GRUPO_BASES26.BI_Dim_Temporadas (
        temporada_id bigint IDENTITY(1, 1) NOT NULL,
        temporada_descripcion nvarchar(50) NOT NULL
    )
GO
ALTER TABLE GRUPO_BASES26.BI_Dim_Temporadas
ADD CONSTRAINT pk_bi_dim_temporadas PRIMARY KEY (temporada_id)
GO

-- ============================================================
-- TABLA DE HECHOS: SOLICITUDES
-- ============================================================
CREATE TABLE GRUPO_BASES26.BI_Hechos_Solicitud (
    tiempo_id bigint NOT NULL,
    rango_et_cli_id bigint NOT NULL,
    temporada_id bigint NOT NULL,
    dias_anticipacion int NOT NULL,
    cantidad_solicitudes int NOT NULL
)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Solicitud
ADD CONSTRAINT pk_bi_hechos_solicitud PRIMARY KEY (tiempo_id, rango_et_cli_id, temporada_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Solicitud
ADD CONSTRAINT fk_bi_hs_tiempo FOREIGN KEY (tiempo_id) REFERENCES GRUPO_BASES26.BI_Dim_Tiempo (tiempo_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Solicitud
ADD CONSTRAINT fk_bi_hs_rango_cli FOREIGN KEY (rango_et_cli_id) REFERENCES GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_etario_cliente_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Solicitud
ADD CONSTRAINT fk_bi_hs_temporada FOREIGN KEY (temporada_id) REFERENCES GRUPO_BASES26.BI_Dim_Temporadas (temporada_id)
GO 
-- Indices para performance
CREATE INDEX ix_bi_hs_tiempo ON GRUPO_BASES26.BI_Hechos_Solicitud (tiempo_id)
GO 
CREATE INDEX ix_bi_hs_rango ON GRUPO_BASES26.BI_Hechos_Solicitud (rango_et_cli_id)
GO 
CREATE INDEX ix_bi_hs_temporada ON GRUPO_BASES26.BI_Hechos_Solicitud (temporada_id)
GO 

-- ============================================================
-- CARGA DIMENSION TEMPORADAS
-- ============================================================
INSERT INTO GRUPO_BASES26.BI_Dim_Temporadas (temporada_descripcion)
VALUES ('Verano') -- Dic, Ene, Feb
INSERT INTO GRUPO_BASES26.BI_Dim_Temporadas (temporada_descripcion)
VALUES ('Otonio') -- Mar, Abr, May
INSERT INTO GRUPO_BASES26.BI_Dim_Temporadas (temporada_descripcion)
VALUES ('Invierno') -- Jun, Jul, Ago
INSERT INTO GRUPO_BASES26.BI_Dim_Temporadas (temporada_descripcion)
VALUES ('Primavera') -- Sep, Oct, Nov
GO 
-- ============================================================
-- CARGA DIMENSION TIEMPO (complemento con meses de Solicitud)
-- Inserta meses que existan en Solicitud pero no en Venta
-- ============================================================
INSERT INTO GRUPO_BASES26.BI_Dim_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT YEAR(S.solicitud_fecha),
    CASE
        WHEN MONTH(S.solicitud_fecha) BETWEEN 1 AND 4 THEN 1
        WHEN MONTH(S.solicitud_fecha) BETWEEN 5 AND 8 THEN 2
        ELSE 3
    END,
    MONTH(S.solicitud_fecha)
FROM GRUPO_BASES26.SolicitudCotizacion S
WHERE NOT EXISTS (
        SELECT 1
        FROM GRUPO_BASES26.BI_Dim_Tiempo T2
        WHERE T2.anio = YEAR(S.solicitud_fecha)
            AND T2.mes = MONTH(S.solicitud_fecha)
    )
GO 
-- ============================================================
-- CARGA DEL HECHO SOLICITUDES
-- ============================================================
INSERT INTO GRUPO_BASES26.BI_Hechos_Solicitud (
        tiempo_id,
        rango_et_cli_id,
        temporada_id,
        dias_anticipacion,
        cantidad_solicitudes
    )
SELECT T.tiempo_id,
    RC.rango_etario_cliente_id AS rango_et_cli_id,
    TMP.temporada_id,
    SUM(
        DATEDIFF(DAY, S.solicitud_fecha, S.solicitud_fecha_inicio)
    ) AS dias_anticipacion,
    COUNT(*) AS cantidad_solicitudes
FROM GRUPO_BASES26.SolicitudCotizacion S
    INNER JOIN GRUPO_BASES26.Cliente C ON C.cliente_id = S.solicitud_cliente
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.anio = YEAR(S.solicitud_fecha)
    AND T.mes = MONTH(S.solicitud_fecha)
    INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioCliente RC ON RC.rango_descripcion = CASE
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, S.solicitud_fecha) < 25 THEN 'Menores de 25 años'
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, S.solicitud_fecha) BETWEEN 25 AND 35 THEN 'Entre 25 y 35 años'
        WHEN DATEDIFF(YEAR, C.cliente_fecha_nac, S.solicitud_fecha) BETWEEN 36 AND 50 THEN 'Entre 35 y 50 años'
        ELSE 'Mayores de 50 años'
    END
INNER JOIN GRUPO_BASES26.BI_Dim_Temporadas TMP ON TMP.temporada_descripcion = CASE
        WHEN MONTH(S.solicitud_fecha_inicio) BETWEEN 1 and 3 then 'Verano'
        WHEN MONTH(S.solicitud_fecha_inicio) BETWEEN  4 and 6 THEN 'Otonio'
        WHEN MONTH(S.solicitud_fecha_inicio) BETWEEN 7 and 9 THEN 'Invierno'
        ELSE 'Primavera'
    END
GROUP BY T.tiempo_id,
    RC.rango_etario_cliente_id,
    TMP.temporada_id
GO 
-- ============================================================
-- VISTAS DE NEGOCIO - SOLICITUDES
-- ============================================================
-- Vista 3: Ranking de solicitudes por temporadas
-- Cantidad de solicitudes agrupadas por temporada de cada año y rango etario del cliente
CREATE VIEW GRUPO_BASES26.BI_Vista_Ranking_Solicitudes_Temporada AS
SELECT T.anio AS ANIO,
    TMP.temporada_descripcion AS TEMPORADA,
    RC.rango_descripcion AS RANGO_ETARIO_CLIENTE,
    SUM(H.cantidad_solicitudes) AS CANTIDAD_SOLICITUDES
FROM GRUPO_BASES26.BI_Hechos_Solicitud H
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_id
    INNER JOIN GRUPO_BASES26.BI_Dim_Temporadas TMP ON TMP.temporada_id = H.temporada_id
    INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioCliente RC ON RC.rango_etario_cliente_id = H.rango_et_cli_id
GROUP BY T.anio,
    TMP.temporada_descripcion,
    RC.rango_descripcion
GO -- Vista 4: Anticipación promedio de solicitudes
    -- Promedio de días de anticipación (solicitud_fecha → solicitud_fecha_inicio),
    -- segmentado por rango etario del cliente y cuatrimestre
CREATE VIEW GRUPO_BASES26.BI_Vista_Anticipacion_Promedio_Solicitudes AS
SELECT T.anio AS ANIO,
    T.cuatrimestre AS CUATRIMESTRE,
    RC.rango_descripcion AS RANGO_ETARIO_CLIENTE,
    SUM(H.dias_anticipacion) * 1.0 / NULLIF(SUM(H.cantidad_solicitudes), 0) AS ANTICIPACION_PROMEDIO_DIAS
FROM GRUPO_BASES26.BI_Hechos_Solicitud H
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_id
    INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioCliente RC ON RC.rango_etario_cliente_id = H.rango_et_cli_id
GROUP BY T.anio,
    T.cuatrimestre,
    RC.rango_descripcion
GO

SELECT COUNT(*) FROM GRUPO_BASES26.BI_Hechos_Solicitud;
SELECT COUNT(*) FROM GRUPO_BASES26.SolicitudCotizacion;
SELECT DISTINCT YEAR(solicitud_fecha), MONTH(solicitud_fecha)
FROM GRUPO_BASES26.SolicitudCotizacion;
SELECT * FROM GRUPO_BASES26.BI_Dim_Temporadas;

SELECT * FROM  GRUPO_BASES26.BI_Vista_Ranking_Solicitudes_Temporada 
SELECT * FROM GRUPO_BASES26.BI_Vista_Anticipacion_Promedio_Solicitudes

-- ============================================================
-- DIMENSIÓN: ESTADO DE PROPUESTA
-- ============================================================
CREATE TABLE GRUPO_BASES26.BI_Dim_Estado_Propuesta (
   estado_id bigint IDENTITY(1,1) NOT NULL,
   estado_nombre nvarchar(255) NOT NULL
)
GO

ALTER TABLE GRUPO_BASES26.BI_Dim_Estado_Propuesta
ADD CONSTRAINT pk_bi_dim_estado_prop PRIMARY KEY (estado_id)
GO

-- ============================================================
-- DIMENSIÓN: RANGO ETARIO AGENTE
-- ============================================================
CREATE TABLE GRUPO_BASES26.BI_Dim_RangoEtarioAgente (
    rango_etario_agente_id bigint IDENTITY(1,1) NOT NULL,
    rango_descripcion nvarchar(50) NOT NULL
)
GO

ALTER TABLE GRUPO_BASES26.BI_Dim_RangoEtarioAgente
ADD CONSTRAINT pk_bi_dim_rango_agente PRIMARY KEY (rango_etario_agente_id)
GO

-- ============================================================
-- TABLA DE HECHOS: PROPUESTAS
-- ============================================================
CREATE TABLE GRUPO_BASES26.BI_Hechos_Propuestas (
    tiempo_emision_id bigint NOT NULL,
    tiempo_solicitud_id bigint NOT NULL,
    tiempo_inicio_viaje_id bigint NOT NULL,
    temporada_id bigint NOT NULL,
    rango_et_age_id bigint NOT NULL,
    estado_propuesta_id bigint NOT NULL,
    importe_total decimal(18,2) NOT NULL,
    presupuesto_estimado decimal(18,2) NOT NULL,
    dias_respuesta int NOT NULL,
    cantidad_propuestas int NOT NULL
)
GO

ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas
ADD CONSTRAINT pk_bi_hechos_propuestas
PRIMARY KEY (tiempo_emision_id, tiempo_solicitud_id, tiempo_inicio_viaje_id, temporada_id, rango_et_age_id, estado_propuesta_id)
GO

-- Claves foráneas del hecho de propuestas
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_emision FOREIGN KEY (tiempo_emision_id) REFERENCES GRUPO_BASES26.BI_Dim_Tiempo (tiempo_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_solicitud FOREIGN KEY (tiempo_solicitud_id) REFERENCES GRUPO_BASES26.BI_Dim_Tiempo (tiempo_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_inicio FOREIGN KEY (tiempo_inicio_viaje_id) REFERENCES GRUPO_BASES26.BI_Dim_Tiempo (tiempo_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_temporada FOREIGN KEY (temporada_id) REFERENCES GRUPO_BASES26.BI_Dim_Temporadas (temporada_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_rango_age FOREIGN KEY (rango_et_age_id) REFERENCES GRUPO_BASES26.BI_Dim_RangoEtarioAgente (rango_etario_agente_id)
GO
ALTER TABLE GRUPO_BASES26.BI_Hechos_Propuestas ADD CONSTRAINT fk_bi_hp_estado FOREIGN KEY (estado_propuesta_id) REFERENCES GRUPO_BASES26.BI_Dim_Estado_Propuesta (estado_id)
GO

-- Indices de Propuestas
CREATE INDEX ix_bi_hp_emision ON GRUPO_BASES26.BI_Hechos_Propuestas (tiempo_emision_id)
GO
CREATE INDEX ix_bi_hp_solicitud ON GRUPO_BASES26.BI_Hechos_Propuestas (tiempo_solicitud_id)
GO
CREATE INDEX ix_bi_hp_inicio ON GRUPO_BASES26.BI_Hechos_Propuestas (tiempo_inicio_viaje_id)
GO
CREATE INDEX ix_bi_hp_temporada ON GRUPO_BASES26.BI_Hechos_Propuestas (temporada_id)
GO
CREATE INDEX ix_bi_hp_rango ON GRUPO_BASES26.BI_Hechos_Propuestas (rango_et_age_id)
GO
CREATE INDEX ix_bi_hp_estado ON GRUPO_BASES26.BI_Hechos_Propuestas (estado_propuesta_id)
GO

-- ============================================================
-- CARGA DE DIMENSIONES: PROPUESTAS
-- ============================================================

-- Carga de BI_Dim_Estado_Propuesta
INSERT INTO GRUPO_BASES26.BI_Dim_Estado_Propuesta (estado_nombre)
SELECT estado_nombre FROM GRUPO_BASES26.Estado
    GO

-- Carga de BI_Dim_RangoEtarioAgente
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioAgente (rango_descripcion) VALUES ('Menores de 25 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioAgente (rango_descripcion) VALUES ('Entre 25 y 35 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioAgente (rango_descripcion) VALUES ('Entre 35 y 50 años')
GO
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioAgente (rango_descripcion) VALUES ('Mayores de 50 años')
GO

-- Complemento de BI_Dim_Tiempo: Nos aseguramos que las fechas de emisión y desde existan
INSERT INTO GRUPO_BASES26.BI_Dim_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT YEAR(P.propuesta_fecha_emision),
    CASE
    WHEN MONTH(P.propuesta_fecha_emision) BETWEEN 1 AND 4 THEN 1
    WHEN MONTH(P.propuesta_fecha_emision) BETWEEN 5 AND 8 THEN 2
    ELSE 3
END,
    MONTH(P.propuesta_fecha_emision)
FROM GRUPO_BASES26.Propuesta P
WHERE NOT EXISTS (
    SELECT 1 FROM GRUPO_BASES26.BI_Dim_Tiempo T2
    WHERE T2.anio = YEAR(P.propuesta_fecha_emision) AND T2.mes = MONTH(P.propuesta_fecha_emision)
)
GO

INSERT INTO GRUPO_BASES26.BI_Dim_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT YEAR(P.propuesta_fecha_desde),
    CASE
    WHEN MONTH(P.propuesta_fecha_desde) BETWEEN 1 AND 4 THEN 1
    WHEN MONTH(P.propuesta_fecha_desde) BETWEEN 5 AND 8 THEN 2
    ELSE 3
END,
    MONTH(P.propuesta_fecha_desde)
FROM GRUPO_BASES26.Propuesta P
WHERE NOT EXISTS (
    SELECT 1 FROM GRUPO_BASES26.BI_Dim_Tiempo T2
    WHERE T2.anio = YEAR(P.propuesta_fecha_desde) AND T2.mes = MONTH(P.propuesta_fecha_desde)
)
GO

-- ============================================================
-- CARGA DEL HECHO PROPUESTAS
-- ============================================================
INSERT INTO GRUPO_BASES26.BI_Hechos_Propuestas (
    tiempo_emision_id,
    tiempo_solicitud_id,
    tiempo_inicio_viaje_id,
    temporada_id,
    rango_et_age_id,
    estado_propuesta_id,
    importe_total,
    presupuesto_estimado,
    dias_respuesta,
    cantidad_propuestas
)
SELECT
    T_EMI.tiempo_id,
    T_SOL.tiempo_id,
    T_INI.tiempo_id,
    TMP.temporada_id,
    RA.rango_etario_agente_id,
    EP.estado_id,
    SUM(P.propuesta_importe_total),
    SUM(S.solicitud_presupuesto),
    SUM(DATEDIFF(DAY, S.solicitud_fecha, P.propuesta_fecha_emision)),
    COUNT(P.propuesta_id)
FROM GRUPO_BASES26.Propuesta P
    INNER JOIN GRUPO_BASES26.SolicitudCotizacion S ON S.solicitud_id = P.propuesta_solicitud
    INNER JOIN GRUPO_BASES26.Agente A ON A.agente_legajo = P.propuesta_agente
    INNER JOIN GRUPO_BASES26.Estado E ON E.estado_id = P.propuesta_estado
    INNER JOIN GRUPO_BASES26.BI_Dim_Estado_Propuesta EP ON EP.estado_nombre = E.estado_nombre
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T_EMI ON T_EMI.anio = YEAR(P.propuesta_fecha_emision) AND T_EMI.mes = MONTH(P.propuesta_fecha_emision)
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T_SOL ON T_SOL.anio = YEAR(S.solicitud_fecha) AND T_SOL.mes = MONTH(S.solicitud_fecha)
    INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T_INI ON T_INI.anio = YEAR(P.propuesta_fecha_desde) AND T_INI.mes = MONTH(P.propuesta_fecha_desde)
    INNER JOIN GRUPO_BASES26.BI_Dim_Temporadas TMP ON TMP.temporada_descripcion = CASE
    WHEN MONTH(P.propuesta_fecha_desde) BETWEEN 1 and 3 then 'Verano'
    WHEN MONTH(P.propuesta_fecha_desde) BETWEEN 4 and 6 THEN 'Otonio'
    WHEN MONTH(P.propuesta_fecha_desde) BETWEEN 7 and 9 THEN 'Invierno'
    ELSE 'Primavera'
END
INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioAgente RA ON RA.rango_descripcion = CASE
    WHEN DATEDIFF(YEAR, A.agente_fecha_nac, P.propuesta_fecha_emision) < 25 THEN 'Menores de 25 años'
    WHEN DATEDIFF(YEAR, A.agente_fecha_nac, P.propuesta_fecha_emision) BETWEEN 25 AND 35 THEN 'Entre 25 y 35 años'
    WHEN DATEDIFF(YEAR, A.agente_fecha_nac, P.propuesta_fecha_emision) BETWEEN 36 AND 50 THEN 'Entre 35 y 50 años'
    ELSE 'Mayores de 50 años'
END
GROUP BY
    T_EMI.tiempo_id,
    T_SOL.tiempo_id,
    T_INI.tiempo_id,
    TMP.temporada_id,
    RA.rango_etario_agente_id,
    EP.estado_id
GO
-- ============================================================
-- VISTAS DE NEGOCIO - PROPUESTAS
-- ============================================================

-- Vista 5: Tasa de aceptación de propuestas (Porcentaje sobre el total, por cuatrimestre)
CREATE VIEW GRUPO_BASES26.BI_Vista_Tasa_Aceptacion_Propuestas AS
SELECT
    T.anio AS ANIO,
    T.cuatrimestre AS CUATRIMESTRE,
    (SUM(CASE WHEN EP.estado_nombre = 'Aceptada' THEN H.cantidad_propuestas ELSE 0 END) * 100.0) /
    NULLIF(SUM(H.cantidad_propuestas), 0) AS TASA_ACEPTACION_PORCENTAJE
FROM GRUPO_BASES26.BI_Hechos_Propuestas H
         INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_emision_id
         INNER JOIN GRUPO_BASES26.BI_Dim_Estado_Propuesta EP ON EP.estado_id = H.estado_propuesta_id
GROUP BY T.anio, T.cuatrimestre
    GO

-- Vista 6: Cotización promedio por temporada y año (inicio del viaje).
CREATE VIEW GRUPO_BASES26.BI_Vista_Cotizacion_Promedio_Temporada AS
SELECT
    T.anio AS ANIO_INICIO_VIAJE,
    TMP.temporada_descripcion AS TEMPORADA,
    SUM(H.importe_total) / NULLIF(SUM(H.cantidad_propuestas), 0) AS COTIZACION_PROMEDIO
FROM GRUPO_BASES26.BI_Hechos_Propuestas H
         INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_inicio_viaje_id
         INNER JOIN GRUPO_BASES26.BI_Dim_Temporadas TMP ON TMP.temporada_id = H.temporada_id
GROUP BY T.anio, TMP.temporada_descripcion
    GO

-- Vista 7: Tiempo promedio de respuesta (solicitud vs emisión segmentado por rango etario agente y mes)
CREATE VIEW GRUPO_BASES26.BI_Vista_Tiempo_Respuesta_Promedio AS
SELECT
    T.anio AS ANIO_SOLICITUD,
    T.mes AS MES_SOLICITUD,
    RA.rango_descripcion AS RANGO_ETARIO_AGENTE,
    SUM(H.dias_respuesta) * 1.0 / NULLIF(SUM(H.cantidad_propuestas), 0) AS TIEMPO_PROMEDIO_RESPUESTA_DIAS
FROM GRUPO_BASES26.BI_Hechos_Propuestas H
         INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_solicitud_id
         INNER JOIN GRUPO_BASES26.BI_Dim_RangoEtarioAgente RA ON RA.rango_etario_agente_id = H.rango_et_age_id
GROUP BY T.anio, T.mes, RA.rango_descripcion
GO

-- Vista 8: Desvío de presupuesto (Diferencia promedio entre presupuesto inicial e importe final)
CREATE VIEW GRUPO_BASES26.BI_Vista_Desvio_Presupuesto_Promedio AS
SELECT
    T.anio AS ANIO_EMISION,
    T.cuatrimestre AS CUATRIMESTRE_EMISION,
    SUM(H.importe_total - H.presupuesto_estimado) / NULLIF(SUM(H.cantidad_propuestas), 0) AS DESVIO_PROMEDIO
FROM GRUPO_BASES26.BI_Hechos_Propuestas H
         INNER JOIN GRUPO_BASES26.BI_Dim_Tiempo T ON T.tiempo_id = H.tiempo_emision_id
GROUP BY T.anio, T.cuatrimestre
GO

-- para probar
--SELECT * FROM GRUPO_BASES26.BI_Vista_Tasa_Aceptacion_Propuestas
--SELECT * FROM GRUPO_BASES26.BI_Vista_Cotizacion_Promedio_Temporada
--SELECT * FROM GRUPO_BASES26.BI_Vista_Tiempo_Respuesta_Promedio
--SELECT * FROM GRUPO_BASES26.BI_Vista_Desvio_Presupuesto_Promedio
--GO