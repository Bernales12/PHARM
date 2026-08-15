-- ============================================================
-- Pharmacy Inventory System — MySQL schema
-- Run this once to create the database, or just create the
-- database yourself and let inventory.php create the tables
-- automatically on first load.
-- ============================================================

CREATE DATABASE IF NOT EXISTS pharmacy_inventory
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE pharmacy_inventory;

CREATE TABLE IF NOT EXISTS medicines (
    sku VARCHAR(20) PRIMARY KEY,
    inventory_name VARCHAR(255) NOT NULL,
    strength VARCHAR(50) NOT NULL DEFAULT '',
    unit VARCHAR(20) NOT NULL DEFAULT 'mg',
    dosage_form VARCHAR(50) NOT NULL DEFAULT '',
    generic_name VARCHAR(255) NOT NULL DEFAULT '',
    quantity INT NOT NULL DEFAULT 0,
    batch_number VARCHAR(100) NOT NULL DEFAULT '',
    expiration_date DATE NULL,
    category VARCHAR(100) NOT NULL DEFAULT 'General',
    low_stock_threshold INT NOT NULL DEFAULT 200,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS dispense_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dispense_date DATE NOT NULL,
    inventory_name VARCHAR(255) NOT NULL,
    batch_number VARCHAR(100) NOT NULL DEFAULT '',
    qty_out INT NOT NULL DEFAULT 0,
    recipient VARCHAR(255) NOT NULL DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Starter data (inventory.php will also insert this automatically
-- the first time it runs against an empty medicines table).

INSERT INTO medicines (sku, inventory_name, strength, unit, dosage_form, generic_name, quantity, batch_number, expiration_date, category, low_stock_threshold)
VALUES
    ('M001', 'Paracetamol', '500', 'mg', 'Tablet', 'Paracetamol (Acetaminophen)', 150, 'BCH-2026-01A', '2028-05-15', 'Analgesics', 200),
    ('M002', 'Amoxicillin', '500', 'mg', 'Capsule', 'Amoxicillin Trihydrate', 12, 'BCH-2025-09C', '2027-11-20', 'Antibiotics', 20),
    ('M003', 'Cetirizine', '10', 'mg', 'Tablet', 'Cetirizine Dihydrochloride', 8, 'BCH-2026-03X', '2028-01-10', 'Antihistamines', 15)
ON DUPLICATE KEY UPDATE sku = sku;

INSERT INTO dispense_logs (dispense_date, inventory_name, batch_number, qty_out, recipient)
VALUES ('2026-05-20', 'Paracetamol 500 mg Tablet', 'BCH-2026-01A', 10, 'John Doe');
