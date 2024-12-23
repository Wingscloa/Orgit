const { Pool } = require('pg');

const pool = new Pool({
    host: 'db',
    port: 5432,
    user: 'root',
    password: '99tablet',
    database: 'ScoutApp'
}); 


module.exports = pool;