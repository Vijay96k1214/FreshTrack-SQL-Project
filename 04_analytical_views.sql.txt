
USE FreshTrack;

-- View 1: Inventory expiry risk
CREATE OR REPLACE VIEW vw_expiry_risk AS
SELECT
    ib.batch_id,
    p.product_name,
    s.store_name,
    ib.quantity_remaining,
    p.cost_price,
    ib.expiry_date,
    DATEDIFF(ib.expiry_date, CURRENT_DATE()) AS days_to_expiry,
    CASE
        WHEN ib.expiry_date < CURRENT_DATE()
            THEN 'Expired'
        WHEN ib.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY)
            THEN 'High Risk'
        WHEN ib.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
            THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS expiry_risk
FROM inventory_batches ib
JOIN products p ON ib.product_id = p.product_id
JOIN stores s ON ib.store_id = s.store_id
WHERE ib.quantity_remaining > 0;


-- View 2: Food waste analysis
CREATE OR REPLACE VIEW vw_waste_analysis AS
SELECT
    w.waste_id,
    w.waste_date,
    p.product_name,
    s.store_name,
    sup.supplier_name,
    w.quantity_wasted,
    w.waste_reason,
    p.cost_price,
    ROUND(w.quantity_wasted * p.cost_price, 2) AS waste_cost
FROM waste_records w
JOIN inventory_batches ib ON w.batch_id = ib.batch_id
JOIN products p ON ib.product_id = p.product_id
JOIN stores s ON ib.store_id = s.store_id
JOIN suppliers sup ON ib.supplier_id = sup.supplier_id;


-- Verify both views
SELECT * FROM vw_expiry_risk;

SELECT *
FROM vw_waste_analysis
ORDER BY waste_cost DESC;
