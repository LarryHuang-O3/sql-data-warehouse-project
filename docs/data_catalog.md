# Data Dictonaty For Gold Layer
## Overview
This gold layer is the business-level data representation, structured to support analytical and reporting use cases. It contains dimension tables and fact tables for specific business metrics.
_________________________________________
1. gold.dim_customers
   - Purpose : store customer details enriched with demographic and geographic data
   - Columns :

|Column Name|Data Type|Description|
|-----------|--------|------|
|customer_key|INT|Surrogate key uniquely identifying each customer record in dimension table|
|customer_id|INT|Unique numerical identifier assigned to each customer|
|customer_number|NVARCHAR(50)|Alphanumeric identifier representing the customer, used for tracking and referencing|
|first_name|NVARCHAR(50)|
|last_name|NVARCHAR(50)|
|country|NVARCHAR(50)|
|marital_status|NVARCHAR(50)|
|gender|NVARCHAR(50)|
|birthdate|DATE|fromatted as YYYY-MM-DD|
|create_date|DATE|Date and time when customer record was created in the database|
___________________________________________________________________________________________________________________________
2. gold.dim_products
   - Purpose : provide information about the product and their arrtibutes
   - Columns :

|Column Name|Data Type|Description|
|-----------|---------|-----------|
|product_key|INT|Surrogate key uniquely identifying each product record in dimension table|
|product_id|INT|Unique identifier assigned to each customer, used for tracking and referencing|
|product_number|NVARCHAR(50)|A structrued alphanumeric code representing the product, often used for categorization or inventory|
|product_name|NVARCHAR(50)|Name of the product including type, color and size
|category_id|NVARCHAR(50)|Unique identifier for product's category, linking to its high level classification|
|category|NVARCHAR(50)|The border classification of the product (eg.Bike,Components) to the related items|
|subcategory|NVARCHAR(50)|The more detailed classification of the product within the category, such as product type|
|maintenance_required|NVARCHAR(50)|
|cost|INT|
|product_line|NVARCHAR(50)|a specific product line or series to which product belong(eg. Road,Mountain)|
|start_date|DATE|The date when the product became available for sale|
___________________________________________________________________________________________________________________________
3. gold.fact_sales
   - Purpose : Store transactional sales data for analytical purposes
   - Columns :

|Column Name|Data Type|Description|
|-----------|---------|-----------|
|order_number|INT|
|product_key|INT|Surrogate key linking the order to the product dimension table
|customer_key|INT|Surrogate key linking the order to the customer dimension table
|order_date|DATE|
|shipping_date|DATE|
|due_date|DATE|
|sales_amount|INT|
|quantity|INT|
|price|INT|

   

