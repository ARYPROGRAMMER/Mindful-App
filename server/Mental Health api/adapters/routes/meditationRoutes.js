const MeditationController = new require('../controllers/MeditationController');

const router = require('express').Router();


router.get('/dailyQuotes',MeditationController.dailyQuotes);
router.get('/myMood/:mood',MeditationController.myMood);

module.exports = router;
