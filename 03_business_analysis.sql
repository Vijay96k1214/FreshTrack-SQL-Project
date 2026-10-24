
USE FreshTrack;

-- Analysis 1: Expiry risk
SELECT
    ib.batch_id,
    p.product_name,
    s.store_name,
    ib.quantity_remaining,
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
WHERE ib.quantity_remaining > 0
ORDER BY days_to_expiry ASC;


-- Analysis 2: Inventory value exposed to expiry
SELECT
    p.product_name,
    s.store_name,
    ib.quantity_remaining,
    p.cost_price,
    ROUND(ib.quantity_remaining * p.cost_price, 2)
        AS inventory_value_at_risk,
    ib.expiry_date
FROM inventory_batches ib
JOIN products p ON ib.product_id = p.product_id
JOIN stores s ON ib.store_id = s.store_id
WHERE ib.quantity_remaining > 0
  AND ib.expiry_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY)
ORDER BY inventory_value_at_risk DESC;


-- Analysis 3: Waste cost by store
SELECT
    s.store_name,
    SUM(w.quantity_wasted) AS total_units_wasted,
    ROUND(SUM(w.quantity_wasted * p.cost_price), 2)
        AS total_waste_cost
FROM waste_records w
JOIN inventory_batches ib ON w.batch_id = ib.batch_id
JOIN products p ON ib.product_id = p.product_id
JOIN stores s ON ib.store_id = s.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_waste_cost DESC;


-- Analysis 4: Supplier-associated waste
SELECT
    sup.supplier_name,
    COUNT(DISTINCT ib.batch_id) AS total_batches,
    SUM(ib.quantity_received) AS total_units_received,
    SUM(COALESCE(w.quantity_wasted, 0)) AS total_units_wasted,
    ROUND(
        100.0 * SUM(COALESCE(w.quantity_wasted, 0))
        / NULLIF(SUM(ib.quantity_received), 0),
        2
    ) AS waste_percentage
FROM suppliers sup
JOIN inventory_batches ib ON sup.supplier_id = ib.supplier_id
LEFT JOIN waste_records w ON ib.batch_id = w.batch_id
GROUP BY sup.supplier_id, sup.supplier_name
ORDER BY waste_percentage DESC;


-- Analysis 5: Revenue and estimated profit by product
SELECT
    p.product_name,
    SUM(s.quantity_sold) AS total_units_sold,
    ROUND(AVG(s.discount_percent), 2) AS average_discount_percent,
    ROUND(
        SUM(
            s.quantity_sold * p.selling_price
            * (1 - s.discount_percent / 100)
        ), 2
    ) AS estimated_revenue,
    ROUND(
        SUM(s.quantity_sold * p.cost_price), 2
    ) AS estimated_cost,
    ROUND(
        SUM(
            s.quantity_sold * p.selling_price
            * (1 - s.discount_percent / 100)
        ) - SUM(s.quantity_sold * p.cost_price), 2
    ) AS estimated_profit
FROM sales s
JOIN inventory_batches ib ON s.batch_id = ib.batch_id
JOIN products p ON ib.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY estimated_profit DESC;


-- Analysis 6: Executive KPIs
SELECT
    (SELECT COUNT(*) FROM stores) AS total_stores,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM inventory_batches) AS total_batches,
    (SELECT COALESCE(SUM(quantity_remaining), 0)
     FROM inventory_batches) AS units_in_stock,
    (SELECT COALESCE(SUM(quantity_wasted), 0)
     FROM waste_records) AS total_units_wasted,
    (SELECT ROUND(
        COALESCE(SUM(w.quantity_wasted * p.cost_price), 0), 2
     )
     FROM waste_records w
     JOIN inventory_batches ib ON w.batch_id = ib.batch_id
     JOIN products p ON ib.product_id = p.product_id
    ) AS total_waste_cost;
