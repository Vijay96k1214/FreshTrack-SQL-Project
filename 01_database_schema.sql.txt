
CREATE DATABASE IF NOT EXISTS FreshTrack;
USE FreshTrack;

CREATE TABLE IF NOT EXISTS stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    shelf_life_days INT NOT NULL
);

CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS inventory_batches (
    batch_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    supplier_id INT NOT NULL,
    received_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    quantity_received INT NOT NULL,
    quantity_remaining INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    CHECK (quantity_received >= 0),
    CHECK (quantity_remaining >= 0),
    CHECK (quantity_remaining <= quantity_received),
    CHECK (expiry_date >= received_date)
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity_sold INT NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id),
    CHECK (quantity_sold > 0),
    CHECK (discount_percent BETWEEN 0 AND 100)
);

CREATE TABLE IF NOT EXISTS waste_records (
    waste_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_id INT NOT NULL,
    waste_date DATE NOT NULL,
    quantity_wasted INT NOT NULL,
    waste_reason VARCHAR(100) NOT NULL,
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id),
    CHECK (quantity_wasted > 0)
);

SHOW TABLES;
