USE GD1C2026
GO

-- 1. Eliminar todas las FK constraints del schema (para poder dropear tablas en cualquier orden)
DECLARE @sql nvarchar(max) = N'';
SELECT @sql += 'ALTER TABLE ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.name)
               + ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + ';' + CHAR(10)
FROM sys.foreign_keys fk
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id
WHERE SCHEMA_NAME(t.schema_id) = 'GRUPO_BASES26';
IF LEN(@sql) > 0 EXEC sp_executesql @sql;
GO

-- 2. Eliminar todas las tablas del schema
DECLARE @sql nvarchar(max) = N'';
SELECT @sql += 'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(10)
FROM sys.tables
WHERE SCHEMA_NAME(schema_id) = 'GRUPO_BASES26';
IF LEN(@sql) > 0 EXEC sp_executesql @sql;
GO

-- 3. Eliminar todos los stored procedures del schema
DECLARE @sql nvarchar(max) = N'';
SELECT @sql += 'DROP PROCEDURE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ';' + CHAR(10)
FROM sys.procedures
WHERE SCHEMA_NAME(schema_id) = 'GRUPO_BASES26';
IF LEN(@sql) > 0 EXEC sp_executesql @sql;
GO

-- 4. Eliminar el schema
IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'GRUPO_BASES26')
    DROP SCHEMA GRUPO_BASES26;
GO

