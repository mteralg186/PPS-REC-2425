const express = require('express');
const router = express.Router();
//
const clasesController = require('../controller/clasesController');

router
    //crear clases
  .get('/crear-clase', clasesController.crearClase)
  .post('/crear-clase', clasesController.crearClasePost)
  .get('/unirse', clasesController.unirseClaseGet)
  .post('/unirse', clasesController.unirseClasePost);
  

module.exports = router;