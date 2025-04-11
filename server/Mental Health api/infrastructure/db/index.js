const { query } = require('express');
const {Pool} = require('pg');
const pool = new Pool({
  connectionString: "postgresql://mental_health_app_primary_db_user:NATFLXr30V4UwD79F1Z9dllAuXK6YzAN@dpg-cvsbg824d50c738cma40-a.oregon-postgres.render.com/mental_health_app_primary_db",
    ssl: {
        rejectUnauthorized: false
    }
});

module.exports = {
    query: (text, params) => pool.query(text, params),

};

