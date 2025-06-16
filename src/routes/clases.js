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
  .post('/gestionar-alumnos/eliminar', clasesController.eliminarAlumnoDeClase);
  

module.exports = router;