const redis = require('..');

const mooddatainfo = async (username) => {
    try {
      const mooddatas = await redis.get(username); 
      return JSON.parse(mooddatas);

    } catch (err) {
      console.error('Error fetching the value:', err);
    } 
  }    

module.exports = {mooddatainfo};
