/*
=========================================================
TOPIC: CREATING, ALTERING AND DROPPING DATABASE
=========================================================

Purpose:
    Learn how to create, rename, use and drop databases.

WARNING:
    DROP DATABASE is destructive.
    Only use this with a learning/test database.

=========================================================
*/


-- ======================================================
-- 1. CREATE DATABASE
-- ======================================================

CREATE DATABASE SQLPlayground;
GO


-- ======================================================
-- 2. VIEW ALL DATABASES
-- ======================================================

SELECT name
FROM sys.databases;
GO


-- ======================================================
-- 3. SWITCH TO DATABASE
-- ======================================================

USE SQLPlayground;
GO


-- Check current database
SELECT DB_NAME() AS CurrentDatabase;
GO


-- ======================================================
-- 4. RENAME DATABASE
-- ======================================================

USE master;
GO

ALTER DATABASE SQLPlayground
MODIFY NAME = SQLPlaygroundDemo;
GO


-- Verify rename
SELECT name
FROM sys.databases
WHERE name = 'SQLPlaygroundDemo';
GO


-- ======================================================
-- 5. DROP DATABASE
-- ======================================================

USE master;
GO

ALTER DATABASE SQLPlaygroundDemo
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE SQLPlaygroundDemo;
GO
