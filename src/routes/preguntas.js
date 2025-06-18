const express = require('express');
const router = express.Router();
//
const preguntasController = require('../controller/preguntasController');

router
    .post('/test', preguntasController.getquestion)
    .get('/preguntas', preguntasController.getCrearPreguntas)
    .post('/enviaTest',preguntasController.postEnviarTest)
    .post('/crearTest', preguntasController.getquestion)
    .get('/crearTest', preguntasController.getCrearPreguntas)
    .post('/crearTest',preguntasController.postEnviarTest);

module.exports = router;