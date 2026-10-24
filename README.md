# FreshTrack SQL — Smart Inventory & Food Waste Analytics

## Project Overview
FreshTrack SQL is a MySQL-based data analytics project designed to analyze grocery inventory, identify products nearing expiry, and measure food waste costs. It helps businesses understand inventory risks and make data-driven decisions.

## Business Problem
Grocery stores can lose money when products expire before being sold. This project uses SQL to analyze inventory batches, expiry dates, sales, and waste records to identify potential risks and business improvement opportunities.

## Tools Used
- MySQL
- MySQL Workbench
- SQL

## Database Tables
- **stores:** Store details and locations
- **products:** Product categories, prices, and shelf life
- **suppliers:** Supplier information
- **inventory_batches:** Received stock, remaining quantities, and expiry dates
- **sales:** Sales quantities and discounts
- **waste_records:** Wasted quantities and reasons

## Key SQL Analyses
1. **Expiry Risk Analysis:** Identifies expired products and products nearing expiry.
2. **Inventory Monitoring:** Tracks remaining stock and inventory at risk.
3. **Waste Cost Analysis:** Calculates estimated costs associated with wasted products.
4. **Supplier-Associated Waste:** Examines waste recorded against batches supplied by different suppliers.
5. **Business KPIs:** Summarizes inventory and waste metrics for decision-making.
6. **Analytical Views:** Organizes query results into reusable SQL views.

## Project Files
- `01_database_schema.sql` — Creates the database tables.
- `02_sample_data.sql` — Inserts sample data.
- `03_business_analysis.sql` — Contains business analysis queries.
- `04_analytical_views.sql` — Creates analytical views.
- `.png files is screenshots/` — Contains screenshots of SQL queries and results.

## Key Learnings
- Writing SQL queries using SELECT, WHERE, ORDER BY, and GROUP BY
- Joining multiple tables
- Using aggregate functions such as SUM and COUNT
- Applying CASE statements and date functions
- Creating views for reusable analysis

## Data Disclaimer
This project uses sample data for learning and demonstration purposes. The results are illustrative and should not be treated as actual business performance.

## Future Improvements
- Analyze discount effectiveness using sales data.
- Build a Power BI dashboard connected to the database.
- Add automated expiry alerts and inventory recommendations.

## Author
Data Analytics Project | MySQL
