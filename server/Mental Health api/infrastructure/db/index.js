const { query } = require('express');
const {Pool} = require('pg');
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'music',
    password: '',
    port: 5432,
});

module.exports = {
    query: (text, params) => pool.query(text, params),

};
