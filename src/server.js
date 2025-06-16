const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
//importamos las rutas
const loginRoutes = require('./routes/login');
const imageRoutes = require('./routes/image');
const preguntasRoutes = require('./routes/preguntas')
const clasesRoutes = require('./routes/clases')


const app = express();
const port = 3001;


// Middleware

// Configurar el directorio de archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(session({
    secret: 'secret', // Cambia esta cadena secreta
    resave: false,
    saveUninitialized: true
}));

app.use((req, res, next) => {
  res.locals.username = req.session.username || null;
  res.locals.title = 'FranApp'; 
  next();
});

// Configuración para servir archivos estáticos
console.log(__dirname);
app.use(express.static(__dirname));
//plantillas
app.set('view engine', 'ejs');
app.set('views', './src/views');

// Routes
app.use('/', loginRoutes);
app.use('/', imageRoutes);
app.use('/', clasesRoutes);
//tester
app.use('/', preguntasRoutes);

app.get('/profesor', (req, res) => {
  res.render('profesor', {
  title: 'Panel del Profesor',
  username: req.session.username 
});
});

app.get('/alumno', (req, res) => {
  res.render('alumno', {
  title: 'Panel del alumno',
  username: req.session.username 
});
});

app.get('/crear-clase', (req, res) => {
    res.render('crear-clase', { title: 'Crear Clase' });
});

app.get('/tester', (req, res) => {
    res.render('tester', { title: 'test' });
});

app.get('/crearTest', (req, res) => {
    res.render('crearTest', { title: 'Crear Ctest' });
});

app.get('/gestionar-alumnos', (req, res) => {
    res.render('gestionar-alumnos', { title: 'Gestionar Alumnos' });
});

app.get('/unirse', (req, res) => {
    res.render('unirse', { title: 'Gestionar Alumnos' });
});

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});