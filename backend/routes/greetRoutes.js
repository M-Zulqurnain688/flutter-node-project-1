// routes/greetRoutes.js
const express = require('express');
const router = express.Router();
const { getHello, postGreet } = require('../controllers/greetConroller');
const validateGreet = require('../middlewares/validateGreet');



// GET /hello
router.get('/hello', getHello);

// POST /greet
router.post('/greet', validateGreet, postGreet);

module.exports = router;
