const SongController = require('../controllers/SongController');

const router = require('express').Router();

router.get('/all',SongController.all);

module.exports = router;