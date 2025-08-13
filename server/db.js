// server/db.js - Database connection configuration
const mysql = require('mysql2/promise');
require('dotenv').config();

const dbConnection = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'pd_steven_marimon_caiman',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = dbConnection;
