const redis = require('..');

const mooddatainfo = async (username) => {
    try {
      const mooddatas = await redis.get(username); 
      console.log('Raw value:', mooddatas);
      return value;
    } catch (err) {
      console.error('Error fetching the value:', err);
    } 
  }    

module.exports = {mooddatainfo};
