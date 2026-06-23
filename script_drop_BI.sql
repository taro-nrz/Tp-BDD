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

-- 2. Eliminar tabla de hechos (tiene FKs a las dimensiones)
IF OBJECT_ID('GRUPO_BASES26.BI_Hechos_Ventas', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Hechos_Ventas;
GO

IF OBJECT_ID('GRUPO_BASES26.BI_Hechos_Solicitud', 'U') IS NOT NULL
    DROP TABLE GRUPO_BASES26.BI_Hechos_Solicitud;
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