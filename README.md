# Database Performance Test

## System Overview

A comprehensive web application for efficient customer, invoice, and transaction management. This system enables users to perform full CRUD operations on customer records while managing related invoices and transactions. Features include bulk data import from CSV files and advanced business intelligence queries.

---

## Technology Stack

- **Frontend:** HTML5, CSS3, JavaScript ES6+, Bootstrap 5
- **Backend:** Node.js, Express.js
- **Database:** MySQL 8.0
- **Tools:** dotenv, nodemon, express-validator, Postman

---

## Quick Start Guide

### 1. Repository Setup
```bash
git clone https://github.com/HackStiv/database_performance_test.git
cd database_performance_test
```

### 2. Dependencies Installation
```bash
npm install
```

### 3. Environment Configuration
Create a `.env` file in the root directory:
```env
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=pd_steven_marimon_caiman
PORT=3000
```

### 4. Database Setup
- Create database and tables according to the relational model
- Optional: Place CSV file in `server/data/data.csv` for bulk import

### 5. Server Launch
```bash
npm run dev
```

### 6. Application Access
Open browser at: [http://localhost:3000](http://localhost:3000)

---

## Database Architecture

### Normalization Strategy
The database follows **Third Normal Form (3NF)** principles to ensure data integrity and eliminate redundancy:

- **customers table:** Stores unique customer information
- **invoices table:** References customers through foreign keys
- **transactions table:** Links invoices, customers, and platforms
- **platforms table:** Normalizes transaction platform data

### Entity Relationship Diagram
```
+-------------+      +-----------+      +--------------+      +-----------+
|  customers  |<-----| invoices  |<-----| transactions |----->| platforms |
+-------------+      +-----------+      +--------------+      +-----------+
| customer_id |      | invoice_id|      | transaction_id|      |platform_id|
| full_name   |      |customer_id|      | invoice_id    |      | name      |
| number_identity|   | ...       |      | customer_id   |      | ...       |
+-------------+      +-----------+      | platafom_id   |      +-----------+
                                        | ...           |
                                        +---------------+
```

**Key Differences from Original Schema:**
- `name` → `full_name`
- `identification_number` → `number_identity`
- `address` → `adress` (intentional typo)
- `platform_id` → `platafom_id` (intentional typo)
- Enhanced indexing for better performance

---

## REST API Documentation

### Customer Management Endpoints

#### Retrieve All Customers
```
GET /api/customers
GET /api/customers?page=1&limit=10
```

#### Get Customer by ID
```
GET /api/customers/:id
```

#### Create New Customer
```
POST /api/customers
Content-Type: application/json

{
  "name": "Customer Name",
  "identification_number": "12345678",
  "email": "customer@email.com",
  "phone": "3001234567",
  "address": "Customer Address"
}
```

#### Update Customer
```
PUT /api/customers/:id
Content-Type: application/json

{
  "name": "Updated Name",
  "email": "updated@email.com"
}
```

#### Delete Customer
```
DELETE /api/customers/:id
```

### Data Import Endpoint
```
POST /api/seed
```
Imports data from `server/data/data.csv`

---

## Advanced Analytics Queries (Postman Collection)

### 1. Customer Payment Analytics
**Endpoint:** `GET /api/reports/total_paid_by_customer`

**Purpose:** Generates comprehensive payment analysis for all customers.

**Expected Response:**
```json
[
  {
    "customer_id": 1,
    "name": "John Doe",
    "identification_number": "12345678",
    "total_paid": 1500000.00
  }
]
```

**Postman Configuration:**
- Method: GET
- URL: `http://localhost:3000/api/reports/total_paid_by_customer`
- Headers: None required

---

### 2. Outstanding Balance Report
**Endpoint:** `GET /api/reports/pending_invoices`

**Purpose:** Identifies all invoices with outstanding balances and associated customer information.

**Expected Response:**
```json
[
  {
    "invoice_id": 1,
    "invoice_number": "INV-001",
    "billing_period": "2024-01",
    "amount_billed": 500000.00,
    "total_paid": 300000.00,
    "balance": 200000.00,
    "customer_id": 1,
    "customer_name": "Jane Smith",
    "identification_number": "87654321"
  }
]
```

**Postman Configuration:**
- Method: GET
- URL: `http://localhost:3000/api/reports/pending_invoices`
- Headers: None required

---

### 3. Platform Transaction Analysis
**Endpoint:** `GET /api/reports/transactions_by_platform/:platform`

**Purpose:** Filters and analyzes transactions by specific payment platform.

**Parameters:**
- `:platform` - Platform name (e.g., "PayPal", "Stripe", "MercadoPago")

**Expected Response:**
```json
[
  {
    "transaction_id": "TXN-001",
    "transaction_datetime": "2024-01-15T10:30:00",
    "transaction_amount": 500000.00,
    "amount_paid": 500000.00,
    "transaction_status": "completed",
    "customer_id": 1,
    "customer_name": "Carlos Rodriguez",
    "invoice_id": 1,
    "invoice_number": "INV-001"
  }
]
```

**Postman Configuration:**
- Method: GET
- URL: `http://localhost:3000/api/reports/transactions_by_platform/PayPal`
- Headers: None required

---

## CSV Data Import Process

### Import Workflow

1. **File Preparation:**
   - Place CSV file in `server/data/data.csv`
   - Ensure proper column structure: Customer Name, Identification Number, etc.

2. **Import Execution:**
   - Start the server
   - Click **"Import CSV Data"** in the web interface
   - Backend processes CSV and populates database

3. **Verification:**
   - Check server console for processing details
   - Verify data in web interface

---

## System Features

### Frontend Capabilities
- ✅ Responsive interface with Bootstrap 5
- ✅ Modern design with gradients and visual effects
- ✅ Complete customer management (CRUD)
- ✅ CSV data import functionality
- ✅ Real-time alerts and notifications

### Backend Capabilities
- ✅ Complete RESTful API
- ✅ Data validation with express-validator
- ✅ Robust error handling
- ✅ Optimized SQL queries
- ✅ Secure database transactions

### Database Capabilities
- ✅ 3NF normalization
- ✅ Foreign keys and constraints
- ✅ Optimized indexes
- ✅ Referential integrity

---

## Developer Information

- **Name:** Steven Daniel Marimon Delgado
- **Clan:** caimán
- **Email:** stivsitoo17@gmail.com
- **Repository:** [https://github.com/HackStiv/database_performance_test.git](https://github.com/HackStiv/database_performance_test.git)

---

## License

This project is licensed under the MIT License.