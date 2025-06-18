const express = require('express');
const router = express.Router();
const preguntasController = require('../controller/preguntasController');

router
    .get('/getquestion', preguntasController.getquestion)
    .get('/crearTest', preguntasController.getCrearPreguntas)
    .post('/enviaTest', preguntasController.crearExamen);

module.exports = router;