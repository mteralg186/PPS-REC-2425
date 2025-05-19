const express = require('express');
const router = express.Router();
//
const preguntasController = require('../controller/preguntasController');

router
    .post('/test', preguntasController.getquestion)
    .get('/preguntas', preguntasController.getCrearPreguntas)
    .post('/enviaTest',preguntasController.postEnviarTest);

module.exports = router;