USE GD1C2026
GO

-- 1. Eliminar vistas BI
IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Ticket_Promedio', 'V') IS NOT NULL
    DROP VIEW GRUPO_BASES26.BI_Vista_Ticket_Promedio;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Distribucion_Facturacion', 'V') IS NOT NULL
    DROP VIEW GRUPO_BASES26.BI_Vista_Distribucion_Facturacion;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Ranking_Solicitudes_Temporada', 'V') IS NOT NULL
    DROP VIEW GRUPO_BASES26.BI_Vista_Ranking_Solicitudes_Temporada;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Anticipacion_Promedio_Solicitudes', 'V') IS NOT NULL
    DROP VIEW GRUPO_BASES26.BI_Vista_Anticipacion_Promedio_Solicitudes;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Tasa_Aceptacion_Propuestas', 'V') IS NOT NULL
DROP VIEW GRUPO_BASES26.BI_Vista_Tasa_Aceptacion_Propuestas;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Cotizacion_Promedio_Temporada', 'V') IS NOT NULL
DROP VIEW GRUPO_BASES26.BI_Vista_Cotizacion_Promedio_Temporada;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Tiempo_Respuesta_Promedio', 'V') IS NOT NULL
DROP VIEW GRUPO_BASES26.BI_Vista_Tiempo_Respuesta_Promedio;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Vista_Desvio_Presupuesto_Promedio', 'V') IS NOT NULL
DROP VIEW GRUPO_BASES26.BI_Vista_Desvio_Presupuesto_Promedio;
GO

-- 2. Eliminar tabla de hechos (tiene FKs a las dimensiones)
IF OBJECT_ID('GRUPO_BASES26.BI_Hechos_Ventas', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Hechos_Ventas;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Hechos_Solicitud', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Hechos_Solicitud;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Hechos_Propuestas', 'U') IS NOT NULL
DROP TABLE GRUPO_BASES26.BI_Hechos_Propuestas;
GO

-- 3. Eliminar tablas dimensionales
IF OBJECT_ID('GRUPO_BASES26.BI_Dim_Tiempo', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Dim_Tiempo;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_Canal', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Dim_Canal;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_RangoEtarioCliente', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Dim_RangoEtarioCliente;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_TipoServicio', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Dim_TipoServicio;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_Temporadas', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Dim_Temporadas;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_Estado_Propuesta', 'U') IS NOT NULL
DROP TABLE GRUPO_BASES26.BI_Dim_Estado_Propuesta;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Dim_RangoEtarioAgente', 'U') IS NOT NULL
DROP TABLE GRUPO_BASES26.BI_Dim_RangoEtarioAgente;
GO