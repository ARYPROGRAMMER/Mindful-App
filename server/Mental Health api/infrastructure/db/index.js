const { query } = require('express');
const {Pool} = require('pg');
const pool = new Pool({
    connectionString: "postgresql://user:KyeXR56XfqizsVv7VrclmDtkBnKhU6sl@dpg-crspehrtq21c73dhu4qg-a.oregon-postgres.render.com/music_afie",
    ssl: {
        rejectUnauthorized: false
    }
});

module.exports = {
    query: (text, params) => pool.query(text, params),

};

