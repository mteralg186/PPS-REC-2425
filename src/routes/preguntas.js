const express = require('express');
const router = express.Router();
//
const preguntasController = require('../controller/preguntasController');

router
    .post('/crearTestr', preguntasController.getquestion)
    .get('/crearTest', preguntasController.getCrearPreguntas)
    .post('/crearTest',preguntasController.postEnviarTest);

module.exports = router;