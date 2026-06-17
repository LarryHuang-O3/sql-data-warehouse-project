/*
==========================================================
CREATE DATABASE AND SCHEMAS FOR DATA WAREHOUSE PROJECT
==========================================================
Script Purpose:
        This script create a new database called DataWarehouse after checking if it already exists. 
        If the database already exists, it will be dropped and recreated.Then it creates three schemas:
        bronze, silver, and gold.
Warining:
        Running this script will drop the existing DataWarehouse database and all its contents.
        All data in the DataWarehouse database will be lost. Please ensure you have backups if needed.
*/

USE master;
GO

-- Drop and recreate the DataWarehouse database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create the schemas: bronze, silver, and gold
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
