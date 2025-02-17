CREATE VIEW gold.customers
AS
SELECT 
    * 
FROM 
    OPENROWSET
        (
            BULK 'https://dpstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Customers/',
            FORMAT = 'PARQUET'
        ) as QUER1


CREATE VIEW gold.returns
AS
SELECT 
    * 
FROM 
    OPENROWSET
        (
            BULK 'https://dpstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Returns/',
            FORMAT = 'PARQUET'
        ) as QUER1

CREATE VIEW gold.sales
AS
SELECT 
    * 
FROM 
    OPENROWSET
        (
            BULK 'https://dpstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Sales/',
            FORMAT = 'PARQUET'
        ) as QUER1


CREATE VIEW gold.subcat
AS
SELECT 
    * 
FROM 
    OPENROWSET
        (
            BULK 'https://dpstoragedatalake.blob.core.windows.net/silver/AdventureWorks_SUbCategories/',
            FORMAT = 'PARQUET'
        ) as QUER1

CREATE VIEW gold.territories
AS
SELECT 
    * 
FROM 
    OPENROWSET
        (
            BULK 'https://dpstoragedatalake.blob.core.windows.net/silver/AdventureWorks_Territories/',
            FORMAT = 'PARQUET'
        ) as QUER1





CREATE MASTER KEY ENCRYPTION BY PASSWORD ='Kinchu*11'


CREATE DATABASE SCOPED CREDENTIAL   cred_prarabdha
WITH
IDENTITY = 'Managed Identity'




CREATE EXTERNAL DATA SOURCE source_silver
WITH(
    LOCATION = 'https://dpstoragedatalake.blob.core.windows.net/silver',
    CREDENTIAL = cred_prarabdha
)




CREATE EXTERNAL DATA SOURCE source_gold
WITH(
    LOCATION = 'https://dpstoragedatalake.blob.core.windows.net/gold',
    CREDENTIAL = cred_prarabdha
)





CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)





CREATE EXTERNAL TABLE gold.estsales
WITH
(
    LOCATION = 'extsales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales
