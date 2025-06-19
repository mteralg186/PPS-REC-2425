const express = require('express');
const router = express.Router();


function requireProfesor(req, res, next) {
  if (!req.session || !req.session.username) {
    return res.redirect('/');
  }
  if (req.session.rol !== 'p') {
    return res.status(403).send('Acceso denegado: necesitas ser profesor.');
  }
  next();
}

router.use(requireProfesor);

router.get('/', (req, res) => {
  res.render('profesor', {
    title: 'Panel del Profesor',
    username: req.session.username 
  });
});


router.get('/crear-clase', (req, res) => {
  res.render('crear-clase', { title: 'Crear Clase' });
});

router.get('/crearTest', (req, res) => {
  res.render('crearTest', { title: 'Crear Examen' });
});


router.get('/misclases', (req, res) => {
  res.render('misclases', { title: 'Mis clases' });
});

router.get('/gestionar-alumnos', (req, res) => {
  res.render('gestionar-alumnos', { title: 'Gestionar Alumnos' });
});

router.get('/examenesRealizadosProfesor', (req, res) => {
  res.render('examenesRealizadosProfesor', { title: 'Resultado de tus examenes' });
});

router.get('/clases_examen_deleter', (req, res) => {
  res.render('clases_examen_delete', { title: 'Gestión de Clases y Exámenes' });
});



module.exports = router;
