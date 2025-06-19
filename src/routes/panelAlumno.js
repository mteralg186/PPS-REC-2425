const express = require('express');
const router = express.Router();

function requireAlumno(req, res, next) {
  if (!req.session || !req.session.username) {
    return res.redirect('/');
  }
  if (req.session.rol !== 'a') {
    return res.status(403).send('Acceso denegado: necesitas ser Alumno.');
  }
  next();
}

router.use(requireAlumno);


router.get('/', (req, res) => {
  res.render('alumno', {
    title: 'Panel del alumno',
    username: req.session.username 
  });
});
router.get('/unirse', (req, res) => {
  res.render('unirse', { title: 'Unirse a una CLase' });
});

router.get('/examenRespondidas', (req, res) => {
  res.render('examenRespondidas', { title: 'Examen para Practicar' });
});


router.get('/examenes', (req, res) => {
  res.render('examenes', { title: 'examenes' });
});

router.get('/resultadoExamen', (req, res) => {
  res.render('resultadoExamen', { title: 'Resultado examenes' });
});

router.get('/clasesAsignadasAlumno', (req, res) => {
  res.render('clasesAsignadasAlumno', { title: 'Mis Clases' });
});


module.exports = router;
