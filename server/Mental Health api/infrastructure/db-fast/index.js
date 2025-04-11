const Redis = require('redis');

const redis = Redis.createClient({
    socket: {
        host: 'redis-10414.c264.ap-south-1-1.ec2.redns.redis-cloud.com',
        port: 10414,
    },
    password: 'g4PKzYUBIIhr9fREKkbsJ9R325MyvnOS'
});

(async () => {
    await redis.connect(); 
})();

module.exports = redis;
