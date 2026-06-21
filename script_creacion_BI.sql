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
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Entre 25 y 35 años')
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Entre 35 y 50 años')
INSERT INTO GRUPO_BASES26.BI_Dim_RangoEtarioCliente (rango_descripcion) VALUES ('Mayores de 50 años')
GO


INSERT INTO GRUPO_BASES26.BI_Dim_TipoServicio (tipo_descripcion) VALUES ('Venta Directa')
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


