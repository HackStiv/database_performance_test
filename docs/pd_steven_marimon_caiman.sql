-- Database Performance Test - Steven Marimon
-- Database Schema for pd_steven_marimon_caiman

-- Create database
CREATE DATABASE IF NOT EXISTS pd_steven_marimon_caiman;
USE pd_steven_marimon_caiman;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS platforms;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    number_identity VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(150) UNIQUE,
    address TEXT,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create platforms table
CREATE TABLE platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Create invoices table
CREATE TABLE invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(100) UNIQUE NOT NULL,
    billing_period VARCHAR(50) NOT NULL,
    amount_billed DECIMAL(15,2) NOT NULL,
    customer_id INT NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Create transactions table
CREATE TABLE transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    transaction_datetime DATETIME NOT NULL,
    transaction_amount DECIMAL(15,2) NOT NULL,
    transaction_status VARCHAR(50) NOT NULL,
    transaction_type VARCHAR(50),
    customer_id INT NOT NULL,
    platform_id INT,
    invoice_id INT,
    amount_paid DECIMAL(15,2) NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (platafom_id) REFERENCES platforms(platform_id) ON DELETE SET NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id) ON DELETE SET NULL
);

-- Create indexes for better performance
CREATE INDEX idx_customers_identity ON customers(number_identity);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_invoices_customer ON invoices(customer_id);
CREATE INDEX idx_invoices_number ON invoices(invoice_number);
CREATE INDEX idx_transactions_customer ON transactions(customer_id);
CREATE INDEX idx_transactions_platform ON transactions(platform_id);
CREATE INDEX idx_transactions_invoice ON transactions(invoice_id);
CREATE INDEX idx_transactions_datetime ON transactions(transaction_datetime);

-- Insert sample platforms
INSERT INTO platforms (name) VALUES 
('PayPal'),
('Stripe'),
('MercadoPago'),
('Credit Card'),
('Bank Transfer');

-- Insert sample customers
INSERT INTO customers (full_name, number_identity, phone, email, address) VALUES 
('John Doe', '12345678', '3001234567', 'john.doe@email.com', '123 Main Street, City'),
('Jane Smith', '87654321', '3007654321', 'jane.smith@email.com', '456 Oak Avenue, Town'),
('Carlos Rodriguez', '11223344', '3001122334', 'carlos.rodriguez@email.com', '789 Pine Road, Village');

-- Insert sample invoices
INSERT INTO invoices (invoice_number, billing_period, amount_billed, customer_id) VALUES 
('INV-2024-001', '2024-01', 500000.00, 1),
('INV-2024-002', '2024-01', 750000.00, 2),
('INV-2024-003', '2024-02', 300000.00, 3);

-- Insert sample transactions
INSERT INTO transactions (transaction_id, transaction_datetime, transaction_amount, transaction_status, transaction_type, customer_id, platform_id, invoice_id, amount_paid) VALUES 
('TXN-2024-001', '2024-01-15 10:30:00', 500000.00, 'completed', 'payment', 1, 1, 1, 500000.00),
('TXN-2024-002', '2024-01-20 14:45:00', 750000.00, 'completed', 'payment', 2, 2, 2, 750000.00),
('TXN-2024-003', '2024-02-01 09:15:00', 300000.00, 'pending', 'payment', 3, 3, 3, 150000.00);

-- Show table structure
DESCRIBE customers;
DESCRIBE platforms;
DESCRIBE invoices;
DESCRIBE transactions;

-- Show relationships
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    REFERENCED_TABLE_SCHEMA = 'pd_steven_marimon_caiman'
    AND REFERENCED_TABLE_NAME IS NOT NULL;