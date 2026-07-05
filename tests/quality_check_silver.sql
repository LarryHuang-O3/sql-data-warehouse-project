/*
===================================================================================
Quality Check Scripts: Silver Layer Tables
===================================================================================
Script Purpose: 
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys
    - Unwanted spaces in string filds
    - Data standardization and consistency
    - Invalid ranges and orders
    - Data consistency between related fields

Usage Notes:
    - Run these checks after loading silver layer
    - Investigate and resolve any discrepanices found during the checks

===================================================================================
*/

-- ===============================================================
-- Checks for Silver Layer Table: silver.crm_cust_info
-- ===============================================================

-- Check Null and Duplicate in Primary Key Column cst_id
-- Expected Result: No Result

SELECT 
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces in string columns
-- Expected Result: No Result

SELECT
    cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT 
    cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Data Standardization and Consistency Checks

SELECT DISTINCT
    cst_gndr
FROM silver.crm_cust_info;

-- Final Check

SELECT * FROM silver.crm_cust_info;

-----------------------------------------------------------------------------------------------

-- ==============================================================
-- Checks for Silver Layer Table: silver.crm_prd_info
-- ===============================================================

-- Check Null and Duplicate in Primary Key Column cst_id
-- Expected Result: No Result

SELECT 
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces in string columns
-- Expected Result: No Result

SELECT 
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for Null and Negative Numbers 
-- Expected Result: No Result

SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Data Standardization and Consistency Checks

SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;

-- Check Invalid Date orders

SELECT
    *
FROM silver.crm_prd_info
WHERE prd_stard_dt > prd_end_dt;

-- Final Check

SELECT * FROM silver.crm_prd_info;

-------------------------------------------------------------------------------------------------

--=============================================================
-- Checks for Silver Layer Table: silver.crm_sales_details
--==============================================================

-- Check for invalid dates order

SELECT
    *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_dt;


SELECT DISTINCT
    sls_sales,
    sls_quantity,   
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- Final Check

SELECT *
FROM silver.crm_sales_details

--------------------------------------------------------------------------------------------------

--=============================================================
-- Checks for Silver Layer Table: silver.erp_loc_a101
--==============================================================

-- Data Standardization and Consistency Checks

SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101;

-- Final Check

SELECT * FROM silver.erp_loc_a101;

--------------------------------------------------------------------------------------------------

--=============================================================
-- Checks for Silver Layer Table: silver.erp_cust_az12
--==============================================================

-- Identify out-of-range birth dates
-- Expected Result: Birthdates between 1924-01-01 and current date

SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Data Standardization and Consistency Checks

SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;

-- Final Check
SELECT * FROM silver.erp_cust_az12;

---------------------------------------------------------------------------------------------------

--=============================================================
-- Checks for Silver Layer Table: silver.erp_px_cat_g1v2
--==============================================================

-- Check for unwanted spaces
-- Expected Result: No Result

SELECT 
    *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
OR subcat != TRIM(subcat) 
OR maintenance != TRIM(maintenance);

-- Data Standardization and Consistency Checks

SELECT DISTINCT
    maintenance
FROM silver.erp_px_cat_g1v2;
