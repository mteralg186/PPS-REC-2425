const express = require('express');
const router = express.Router();
//
const loginController = require('../controller/loginController');

router
    //borrar logout
    .get("/logout", loginController.logout)
    .get('/', loginController.getIndex)
    .get('/dashboard',loginController.getDashboard)
    .post('/login', loginController.postLogin)
    .post('/register',loginController.postRegister)
    .get('/registro',loginController.getRegistro)
    .get('/perfil',loginController.getPerfil)
    .get('/perfilalumno',loginController.getPerfilalumno)
    .get('/error',loginController.getError);

module.exports = router;