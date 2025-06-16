const express = require('express');
const session = require('express-session');
const path = require('path');

const loginRoutes = require('./routes/login');
const imageRoutes = require('./routes/image');
const preguntasRoutes = require('./routes/preguntas');
const clasesRoutes = require('./routes/clases');
const examenesRouter = require('./routes/examenes');

const app = express();
const port = 3001;

// Middleware para parsear body con Express (sin body-parser)
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Configurar sesión
app.use(session({
    secret: 'secret', // Cambia esto por algo seguro
    resave: false,
    saveUninitialized: true
}));

// Variables locales para vistas
app.use((req, res, next) => {
  res.locals.username = req.session.username || null;
  res.locals.title = 'FranApp'; 
  next();
});

// Archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));

// Plantillas
app.set('view engine', 'ejs');
app.set('views', './src/views');

// Rutas (sin duplicados)
app.use('/', loginRoutes);
app.use('/', imageRoutes);
app.use('/', clasesRoutes);
app.use('/', preguntasRoutes);
app.use('/', examenesRouter);

// Rutas específicas
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

app.get('/gestionar-alumnos', (req, res) => {
  res.render('gestionar-alumnos', { title: 'Gestionar Alumnos' });
});

app.get('/unirse', (req, res) => {
  res.render('unirse', { title: 'Gestionar Alumnos' });
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
