const { query } = require('express');
const {Pool} = require('pg');
const pool = new Pool({
    connectionString: "postgresql://music_ba5v_user:t5rq6wdxcIGLL9FKJPmpLeCUmGsAj5fK@dpg-csrrk8l2ng1s73acqcd0-a.oregon-postgres.render.com/music_ba5v",
    ssl: {
        rejectUnauthorized: false
    }
});

module.exports = {
    query: (text, params) => pool.query(text, params),

};

