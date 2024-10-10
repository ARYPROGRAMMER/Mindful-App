const Redis = require('redis');

const redis = Redis.createClient({
    socket: {
        host: 'redis-15193.c309.us-east-2-1.ec2.redns.redis-cloud.com',
        port: 15193,
    },
    password: 'qJ3EEzX4aQ0LwiPCeP5sMAUZycRiNOK1'
});

(async () => {
    await redis.connect(); 
})();

module.exports = redis;
