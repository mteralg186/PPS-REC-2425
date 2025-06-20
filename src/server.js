const express = require('express');
const session = require('express-session');
const path = require('path');
const helmet = require('helmet');

const loginRoutes = require('./routes/login');
const imageRoutes = require('./routes/image');
const preguntasRoutes = require('./routes/preguntas');
const clasesRoutes = require('./routes/clases');
const examenesRouter = require('./routes/examenes');
const alumnoRoutes = require('./routes/panelAlumno');
const adminRoutes = require('./routes/admin');
const profesorRoutes = require('./routes/panelProfesor');
const app = express();

const port = 3000;

// Middleware para parsear body con Express (sin body-parser)
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(helmet());
// Configurar sesión
app.use(session({
  secret: 'secret', // Cambia esto por algo seguro
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production', // Solo en HTTPS en producción
    sameSite: 'lax'
  }
}));

// Variables locales para vistas
app.use((req, res, next) => {
  res.locals.username = req.session.username || null;
  res.locals.rol = req.session.rol || null;
  res.locals.title = 'TestApp';
  next();
});

// Archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));

// Plantillas
app.set('view engine', 'ejs');
app.set('views', './src/views');

// Rutas 
app.use('/', loginRoutes); // Login y página principal
app.use('/', imageRoutes); // Rutas para imágenes
app.use('/', preguntasRoutes); // Preguntas
app.use('/', clasesRoutes); // Clases
app.use('/', examenesRouter); // Exámenes
app.use('/alumno', alumnoRoutes); // Panel del alumno
app.use('/admin', adminRoutes); // Panel del admin
app.use('/profesor', profesorRoutes);

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
