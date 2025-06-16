const express = require('express');
const router = express.Router();

const preguntasController = require('../controller/preguntasController'); 
const examenController = require('../controller/examenController'); 

router.get('/examenes', examenController.listarExamenes);
router.get('/examen/:idExamen', examenController.mostrarExamen);
router.post('/examen/:idExamen', examenController.corregirExamen);
router.get('/resultadoExamen', examenController.verResultadosAlumno);
// Nueva ruta para el profesor
router.get('/examenesRealizadosProfesor', examenController.verResultadosTodos);

module.exports = router;
