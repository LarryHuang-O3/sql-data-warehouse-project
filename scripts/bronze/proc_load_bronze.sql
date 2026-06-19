/*
    =========================================================================================
    Stored Procedure: Load Bronze Layer (Source -> Bronze)
    =========================================================================================
    Script Purpose:
        This stored procedure loads data from the external CSV files into the bronze layer tables.
        IT performs the following steps:
        1. Truncates the existing data in the bronze layer tables.
        2. Use BULK INSERT to load data from the CSV files into the corresponding bronze layer tables.

    Parameters:
        None
        This stored procedure does not require any input parameters.
    
    Usage Instructions:
        To execute the stored procedure, use the following command:
        EXEC bronze.load_bronze;
    =========================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '==============================================';
        PRINT 'Loading Bronze Layer Tables';
        PRINT '==============================================';

        PRINT '------------------------------------------------';
        PRINT 'LOADING FROM SOURCE CRM DATASET';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_cust_info table';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'Inserting data into bronze.crm_cust_info table';
        BULK INSERT bronze.crm_cust_info
        FROM '/sql-data/datasets/source_crm/cust_info.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_prd_info table';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT 'Inserting data into bronze.crm_prd_info table';
        BULK INSERT bronze.crm_prd_info
        FROM '/sql-data/datasets/source_crm/prd_info.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );  
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_sales_details table';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT 'Inserting data into bronze.crm_sales_details table';
        BULK INSERT bronze.crm_sales_details
        FROM '/sql-data/datasets/source_crm/sales_details.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );  
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        PRINT '------------------------------------------------';
        PRINT 'LOADING FROM SOURCE ERP DATASET';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.erp_loc_a101 table';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT 'Inserting data into bronze.erp_loc_a101 table';
        BULK INSERT bronze.erp_loc_a101
        FROM '/sql-data/datasets/source_erp/loc_a101.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );  
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';
    
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.erp_cust_az12 table';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT 'Inserting data into bronze.erp_cust_az12 table';
        BULK INSERT bronze.erp_cust_az12
        FROM '/sql-data/datasets/source_erp/cust_az12.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.erp_px_cat_g1v2 table';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT 'Inserting data into bronze.erp_px_cat_g1v2 table';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/sql-data/datasets/source_erp/px_cat_g1v2.csv'
        WITH ( 
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- LOADING DURATION : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '------------------------------------------------';

        SET @batch_end_time = GETDATE();
        PRINT '==============================================';
        PRINT 'BRONZE LAYER TABLES LOADED SUCCESSFULLY';
        PRINT '-- TOTAL DURATION : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==============================================';

    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while loading Bronze Layer Tables:';
        PRINT 'ERROR MESSAGE : ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE : ' + CAST(ERROR_STATE() AS NVARCHAR);
    END CATCH
END;
