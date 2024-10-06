const UserController =  require('../../adapters/controllers/userController');

const router = require('express').Router();

router.get('/:username',UserController.usernames);

module.exports = router;