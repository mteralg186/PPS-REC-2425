const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
//importamos las rutas
const loginRoutes = require('./routes/login');
const imageRoutes = require('./routes/image');
const preguntasRoutes = require('./routes/preguntas')

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


// Configuración para servir archivos estáticos
console.log(__dirname);
app.use(express.static(__dirname));
//plantillas
app.set('view engine', 'ejs');
app.set('views', './src/views');

// Routes
app.use('/', loginRoutes);
app.use('/', imageRoutes);
//tester
app.use('/', preguntasRoutes);

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});