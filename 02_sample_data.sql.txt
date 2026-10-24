
USE FreshTrack;

-- 1. Stores
INSERT INTO stores (store_name, city) VALUES
('FreshMart Central', 'Aurangabad'),
('FreshMart West', 'Pune'),
('FreshMart East', 'Nashik'),
('FreshMart North', 'Mumbai'),
('FreshMart South', 'Nagpur');

-- 2. Products
INSERT INTO products
(product_name, category, cost_price, selling_price, shelf_life_days)
VALUES
('Fresh Milk', 'Dairy', 25.00, 32.00, 7),
('Yogurt', 'Dairy', 18.00, 25.00, 10),
('Brown Bread', 'Bakery', 22.00, 30.00, 4),
('Fresh Paneer', 'Dairy', 80.00, 110.00, 5),
('Apples', 'Fruits', 90.00, 120.00, 14),
('Bananas', 'Fruits', 30.00, 45.00, 5),
('Tomatoes', 'Vegetables', 20.00, 35.00, 6),
('Potatoes', 'Vegetables', 25.00, 40.00, 30),
('Orange Juice', 'Beverages', 45.00, 60.00, 20),
('Cheese', 'Dairy', 100.00, 140.00, 25);

-- 3. Suppliers
INSERT INTO suppliers (supplier_name, city) VALUES
('Fresh Dairy Co.', 'Pune'),
('Green Farm Supplies', 'Nashik'),
('Daily Bread Foods', 'Mumbai'),
('Fruit Basket Traders', 'Nagpur'),
('Nature Fresh Distributors', 'Aurangabad');

-- 4. Inventory batches
INSERT INTO inventory_batches
(product_id, store_id, supplier_id, received_date,
 expiry_date, quantity_received, quantity_remaining)
VALUES
(1, 1, 1, '2026-10-20', '2026-10-25', 100, 35),
(1, 2, 1, '2026-10-19', '2026-10-24', 80, 50),
(2, 1, 1, '2026-10-18', '2026-10-28', 60, 20),
(3, 3, 3, '2026-10-21', '2026-10-24', 90, 45),
(4, 2, 1, '2026-10-20', '2026-10-25', 50, 30),
(5, 4, 4, '2026-10-15', '2026-11-05', 70, 25),
(6, 5, 4, '2026-10-21', '2026-10-26', 100, 40),
(7, 3, 2, '2026-10-20', '2026-10-26', 120, 60),
(8, 4, 2, '2026-10-01', '2026-10-31', 150, 90),
(9, 1, 5, '2026-10-10', '2026-11-10', 60, 30),
(10, 5, 1, '2026-10-12', '2026-11-06', 40, 15),
(3, 1, 3, '2026-10-22', '2026-10-23', 50, 40),
(6, 2, 4, '2026-10-22', '2026-10-24', 80, 65),
(1, 3, 1, '2026-10-21', '2026-10-23', 70, 55),
(5, 5, 4, '2026-10-18', '2026-11-01', 45, 20);

-- 5. Sales
INSERT INTO sales
(batch_id, sale_date, quantity_sold, discount_percent)
VALUES
(1, '2026-10-20', 20, 0),
(1, '2026-10-21', 25, 10),
(2, '2026-10-20', 15, 0),
(2, '2026-10-21', 15, 5),
(3, '2026-10-19', 20, 0),
(4, '2026-10-21', 30, 10),
(4, '2026-10-22', 15, 20),
(5, '2026-10-21', 10, 0),
(6, '2026-10-20', 25, 0),
(7, '2026-10-22', 35, 10),
(8, '2026-10-22', 30, 0),
(9, '2026-10-20', 20, 0),
(10, '2026-10-21', 15, 5),
(11, '2026-10-22', 10, 0),
(12, '2026-10-22', 10, 20),
(13, '2026-10-22', 15, 15),
(14, '2026-10-22', 15, 25),
(15, '2026-10-22', 10, 0);

-- 6. Waste records
INSERT INTO waste_records
(batch_id, waste_date, quantity_wasted, waste_reason)
VALUES
(1, '2026-10-22', 5, 'Expired'),
(3, '2026-10-22', 3, 'Damaged packaging'),
(4, '2026-10-22', 8, 'Expired'),
(6, '2026-10-21', 4, 'Damaged'),
(7, '2026-10-22', 6, 'Expired'),
(8, '2026-10-20', 2, 'Spoilage'),
(12, '2026-10-22', 10, 'Expired'),
(13, '2026-10-22', 5, 'Expired'),
(14, '2026-10-22', 7, 'Spoilage');

-- Verify row counts
SELECT 'stores' AS table_name, COUNT(*) AS total_rows FROM stores
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'inventory_batches', COUNT(*) FROM inventory_batches
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'waste_records', COUNT(*) FROM waste_records;
