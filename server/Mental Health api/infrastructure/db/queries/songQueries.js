const db = require('..');
const getAllSongs = async () => {
    const result = await db.query('SELECT * FROM songs');
    
    return result.rows;
};


module.exports = {getAllSongs};                             
