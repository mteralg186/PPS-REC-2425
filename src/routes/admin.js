const express = require('express');
const router = express.Router();
const adminController = require('../controller/adminController');

function requireAdmin(req, res, next) {
  if (!req.session || !req.session.username) {
    return res.redirect('/login');
  }
  if (req.session.rol !== 'h') {
    return res.status(403).send('Acceso denegado: necesitas ser administrador.');
  }
  next();
}

router.use(requireAdmin);

router.get('/', adminController.getDashboard);

router.post('/usuarios/update/:id', adminController.updateUsuario);
router.post('/usuarios/delete/:id', adminController.deleteUsuario);

router.post('/categorias/update/:id', adminController.updateCategoria);
router.post('/categorias/delete/:id', adminController.deleteCategoria);

router.post('/preguntas/update/:id', adminController.updatePregunta);
router.post('/preguntas/delete/:id', adminController.deletePregunta);

router.post('/respuestas/update/:id', adminController.updateRespuesta);
router.post('/respuestas/delete/:id', adminController.deleteRespuesta);

router.post('/clases/update/:id', adminController.updateClase);
router.post('/clases/delete/:id', adminController.deleteClase);

router.post('/examenes/update/:id', adminController.updateExamen);
router.post('/examenes/delete/:id', adminController.deleteExamen);

module.exports = router;
