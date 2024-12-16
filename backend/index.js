const express = require('express');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Nastavení připojení k databázi
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Testovací endpoint pro ověření připojení k DB
app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW();');
    res.status(200).json({ message: 'Database connected', time: result.rows[0] });
  } catch (error) {
    res.status(500).json({ message: 'dawdaw connecting to the database', error });
  }
});

// Endpoint pro získání uživatelů z databáze
app.get('/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM Users');
    res.status(200).json(result.rows);
  } catch (error) {
    res.status(500).json({ message: 'test fetching users', error });
  }
});

// Spuštění serveru
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
