#----------------------------------------------------------------#
#        PROJECT: PHARMACEUTICAL PRODUCT ANALYTICS
#----------------------------------------------------------------#

-- Create Database for systems of medicine
CREATE database pharma_analytics;
use pharma_analytics;

-- Import tables of systems of medicine
SELECT COUNT(*) FROM allopathy_clean;
SELECT COUNT(*) FROM ayurveda_clean;
SELECT COUNT(*) FROM herbal_clean;
SELECT COUNT(*) FROM homeopathy_clean;
SELECT COUNT(*) FROM unani_clean;

-- Create dimension table of medicine system 
-- It creates ID for each medicine system

CREATE TABLE dim_medicine_system (
    medicine_system_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_system VARCHAR(50) UNIQUE
);
SELECT * FROM dim_medicine_system;

-- Insert values into dimension table 

INSERT INTO dim_medicine_system (medicine_system)
SELECT DISTINCT medicine_system FROM allopathy_clean
UNION
SELECT DISTINCT medicine_system FROM ayurveda_clean
UNION
SELECT DISTINCT medicine_system FROM herbal_clean
UNION
SELECT DISTINCT medicine_system FROM homeopathy_clean
UNION
SELECT DISTINCT medicine_system FROM unani_clean;

-- Create dimension table of dimension manufacturer
-- It creates ID for each manufacturer

CREATE TABLE dim_manufacturer (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name_of_the_manufacturer VARCHAR(255) UNIQUE
);
SELECT * FROM dim_manufacturer;

-- Insert values into dimension table 

INSERT INTO dim_manufacturer (name_of_the_manufacturer)
SELECT DISTINCT name_of_the_manufacturer FROM allopathy_clean
UNION
SELECT DISTINCT name_of_the_manufacturer FROM ayurveda_clean
UNION
SELECT DISTINCT name_of_the_manufacturer FROM herbal_clean
UNION
SELECT DISTINCT name_of_the_manufacturer FROM homeopathy_clean
UNION
SELECT DISTINCT name_of_the_manufacturer FROM unani_clean;


-- Create fact table which is central table connected to dimension table

CREATE TABLE Fact_Drugs (
    drug_id INT AUTO_INCREMENT PRIMARY KEY,    
    manufacturer_id INT,   # we used ID's over name because they are faster , to avoid spelling mismatch 
    medicine_system_id INT,
    brand_name VARCHAR(255),
    generic_name_and_strength TEXT,
    dosages_description VARCHAR(255),
    use_for VARCHAR(255),
    dar VARCHAR(100),

    FOREIGN KEY (manufacturer_id)
        REFERENCES dim_manufacturer(manufacturer_id),

    FOREIGN KEY (medicine_system_id)
        REFERENCES dim_medicine_system(medicine_system_id)
);

-- Insert all medicine system into fact table 
-- Inserted all values once as the schema is identical 
-- UNION ALL is used instead of UNION to retain all records 
-- without removing duplicates across different medicine systems

INSERT INTO Fact_Drugs (
    manufacturer_id,
    medicine_system_id,
    brand_name,
    generic_name_and_strength,
    dosages_description,
    use_for,
    dar
)
SELECT
    dm.manufacturer_id,
    dms.medicine_system_id,
    c.brand_name,
    c.generic_name_and_strength,
    c.dosages_description,
    c.use_for,
    c.dar
FROM (
    SELECT
        name_of_the_manufacturer,
        brand_name,
        generic_name_and_strength,
        dosages_description,
        use_for,
        dar,
        medicine_system
    FROM allopathy_clean

    UNION ALL

    SELECT
        name_of_the_manufacturer,
        brand_name,
        generic_name_and_strength,
        dosages_description,
        use_for,
        dar,
        medicine_system
    FROM ayurveda_clean

    UNION ALL

    SELECT
        name_of_the_manufacturer,
        brand_name,
        generic_name_and_strength,
        dosages_description,
        use_for,
        dar,
        medicine_system
    FROM herbal_clean

    UNION ALL

    SELECT
        name_of_the_manufacturer,
        brand_name,
        generic_name_and_strength,
        dosages_description,
        use_for,
        dar,
        medicine_system
    FROM homeopathy_clean

    UNION ALL

    SELECT
        name_of_the_manufacturer,
        brand_name,
        generic_name_and_strength,
        dosages_description,
        use_for,
        dar,
        medicine_system
    FROM unani_clean
) c

JOIN dim_manufacturer dm
    ON c.name_of_the_manufacturer = dm.name_of_the_manufacturer
JOIN dim_medicine_system dms
    ON c.medicine_system = dms.medicine_system;
    
    
-- To verify the data load
SELECT * FROM Fact_Drugs;
SELECT COUNT(*) FROM Fact_Drugs;   #53584

#===========================BUSINESS QUESTIONS==============================#

-- 1. Which medicine system dominates the market?
SELECT ms.medicine_system, COUNT(*) AS total_products
FROM Fact_Drugs f
JOIN dim_medicine_system ms
ON f.medicine_system_id = ms.medicine_system_id
GROUP BY ms.medicine_system
ORDER BY total_products DESC;

-- 2. Top 10 manufacturers by product presence
SELECT m.name_of_the_manufacturer, COUNT(*) AS product_count
FROM Fact_Drugs f
JOIN dim_manufacturer m
ON f.manufacturer_id = m.manufacturer_id
GROUP BY m.name_of_the_manufacturer
ORDER BY product_count DESC
LIMIT 10;

-- 3. Product distribution across medicine systems
SELECT ms.medicine_system, COUNT(DISTINCT f.brand_name) AS distinct_brands, COUNT(*) AS total_products
FROM Fact_Drugs f
JOIN dim_medicine_system ms
ON f.medicine_system_id = ms.medicine_system_id
GROUP BY ms.medicine_system;

-- 4. How many brand does each manufacturers manage?
SELECT m.name_of_the_manufacturer, COUNT(DISTINCT f.brand_name) AS brand_count
FROM Fact_Drugs f
JOIN dim_manufacturer m
ON f.manufacturer_id = m.manufacturer_id
GROUP BY m.name_of_the_manufacturer
ORDER BY brand_count DESC
LIMIT 10;

-- 5. What dosage types are most widely used?
SELECT dosages_description, COUNT(*) AS usage_count
FROM Fact_Drugs
GROUP BY dosages_description
ORDER BY usage_count DESC
LIMIT 10;

-- 6.Who leads in each category?
SELECT ms.medicine_system, m.name_of_the_manufacturer, COUNT(*) AS product_count
FROM Fact_Drugs f
JOIN dim_manufacturer m
ON f.manufacturer_id = m.manufacturer_id
JOIN dim_medicine_system ms
ON f.medicine_system_id = ms.medicine_system_id
GROUP BY ms.medicine_system, m.name_of_the_manufacturer
ORDER BY ms.medicine_system, product_count DESC;

/*-----------------------------------------------------------------------
    				 BUSINESS INSIGHT 
-------------------------------------------------------------------------
1. Allopathy has the dominating Market on the basis of product count.
2. Product count of Incepta manufacturer is higher among all manufacturers.
3. The most commonly used dosage are Table , Capsule , Liquid among all 
   dosage description.
4. Top manufacturers are 
   'INCEPTA PHARMACEUTICALS LTD.(Allopathy)' , 
   'SHADHONA AUSHADHALAYA LTD. (AYURVEDIC)' , 
   'TOTAL HERBAL AND NUTRACEUTICALS (Herbal)' ,
   'MAXFAIR & COMPANY LTD. HOMOEO (Homeopathic)', 
   'HAMDARD LABORATORIES (WAQF) BANGLADESH (UNANI)'
-------------------------------------------------------------------------*/
