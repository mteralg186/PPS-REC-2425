const express = require('express');
const router = express.Router();

router.get('/profesor', (req, res) => {
  res.render('profesor', {
    title: 'Panel del Profesor',
    username: req.session.username 
  });
});

router.get('/alumno', (req, res) => {
  res.render('alumno', {
    title: 'Panel del alumno',
    username: req.session.username 
  });
});

router.get('/crear-clase', (req, res) => {
  res.render('crear-clase', { title: 'Crear Clase' });
});

router.get('/tester', (req, res) => {
  res.render('tester', { title: 'test' });
});

router.get('/gestionar-alumnos', (req, res) => {
  res.render('gestionar-alumnos', { title: 'Gestionar Alumnos' });
});

router.get('/unirse', (req, res) => {
  res.render('unirse', { title: 'Gestionar Alumnos' });
});

module.exports = router;
