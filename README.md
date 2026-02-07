# Pharmaceutical Market & Product Portfolio Analysis

---

## Project Overview
This project presents an **end-to-end pharmaceutical market analysis** using multiple raw datasets.  
The objective is to analyze **product distribution, manufacturer dominance, dosage composition, and usage patterns** across different medicine systems.

The project follows a **complete analytics pipeline**, starting from raw data ingestion to business insights using Python, SQL, and Power BI.

---

## Business Objectives
- Understand dominance across different **medicine systems**
- Analyze **dosage form distribution**
- Identify **top manufacturers and brands**
- Study **market concentration**
- Provide **data-driven business recommendations**

---

## Dataset Description
The analysis is based on **5 raw CSV files**, each representing different aspects of pharmaceutical products such as:
- Products data
- Manufacturers data
- Brands data
- Dosage and strength information
- Intended usage and regulatory indicators (DAR)

After cleaning, these were transformed into **modeled analytical tables**.

> *Note:* The dataset does **not** contain sales, revenue, or time-series data.

---

## Data Cleaning Process (Python)
- Removed duplicate and inconsistent records  
- Standardized categorical fields:
- Handled inconsistent values 
- Created clean, analysis-ready datasets from all raw files

---

## Data Modeling Approach
A **Star Schema** was designed to support scalable analytics and dashboarding.

### Dimension Tables
- **dim_manufacturer** – manufacturer-level attributes
- **dim_product** – product, brand, medicine system, dosage details

### Fact Table
- **fact_pharma_products** – central fact table linking all dimensions using product-level records

This approach improves:
- Query performance
- Data consistency
- BI reporting efficiency

---

## Tools & Technologies Used
- **Python** (Pandas, NumPy, Matplotlib, Seaborn) – Data Cleaning & EDA  
- **SQL (MySQL)** – Data validation and modeling  
- **Power BI** – Interactive dashboards and reporting  
- **MySQL Workbench** – ER diagram and schema design  
- **GitHub** – Version control and project hosting  

---

## Power BI Dashboards
### 1. Market Overview
- Total products, brands, manufacturers
- Product distribution by medicine system
- Dosage form analysis
- Top manufacturers by product count

### 2. Manufacturer & Product Composition
- Average products per manufacturer
- Brand dominance
- Dosage type distribution
- Usage-based segmentation

### 3. Insights & Recommendations
- Key analytical insights
- Business recommendations
- Data limitations

---

## Key Insights
- **Allopathic medicines dominate** with ~67% of total products
- **Tablet, Capsule, and Liquid** are the most common dosage forms
- **Human-use medicines** significantly outweigh veterinary products
- The market shows **high manufacturer concentration**

---

## Business Recommendations
- Non-allopathic manufacturers can expand **tablet, capsule, and liquid** portfolios
- Allopathic manufacturers can diversify **human-use dosage formats**
- High market concentration suggests **entry barriers** for smaller manufacturers

---

## Limitations
- No sales, revenue, or time-series data available
- Analysis is based on **product count**, not market share
- Some categorical inconsistencies exist in the original dataset

---

## Repository Structure
pharma
│
├── data
│ ├── raw
│ ├── cleaned
│ └── modeled
│
├── notebooks
│ └── Pharma DA.ipynb
│
├── sql
│ └── pharma_analytics.sql
│
├── powerbi
│ └── pharma_analytics.pbix
│
└── README.md

## Future Scope
- Integrate **sales and revenue data** for market share analysis
- Add **time-series analysis**
- Perform **manufacturer segmentation**
- Apply advanced analytics and forecasting

---

## Author
**Sayali Sanjay Chidrawar**  
Aspiring Data Analyst | Python | SQL | Power BI  

*This project is created for learning, portfolio development, and interview preparation.*
