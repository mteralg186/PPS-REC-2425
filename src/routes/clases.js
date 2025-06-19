const express = require('express');
const router = express.Router();
//
const clasesController = require('../controller/clasesController');

router
    //crear clases
  .get('/crear-clase', clasesController.crearClase)
  .post('/crear-clase', clasesController.crearClasePost)
  .get('/unirse', clasesController.unirseClaseGet)
  .post('/unirse', clasesController.unirseClasePost)
  .get('/gestionar-alumnos',clasesController.verAlumnosProfesor)
  .post('/gestionar-alumnos/eliminar', clasesController.eliminarAlumnoDeClase)
  .get('/misclases', clasesController.MisClases)
  .get('/clasesAsignadasAlumno', clasesController.verClasesAsignadasAlumno)
  .delete('/alumno/clases-asignadas/:idAsignacion', clasesController.eliminarClaseAsignada)
  .get('/clases_examen_delete', clasesController.verGestionProfesor)
  .delete('/profesor/clases/:id', clasesController.eliminarClase)
  .delete('/profesor/examenes/:id', clasesController.eliminarExamen);
  

module.exports = router;