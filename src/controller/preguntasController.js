const connection = require('../conexion');

const getquestion = (req, res) => {
    console.log(req.body);
sql = 'SELECT p.*, r.* FROM ( SELECT id FROM preguntas ORDER BY RAND() LIMIT 5 ) AS random_ids JOIN preguntas p ON p.id = random_ids.id JOIN respuestas r ON r.id_pregunta = p.id where p.id_categoria IN ?';
res.render('crearTest',{ preguntas});
return preguntas;
};

const getCrearPreguntas = (req, res) => {
    if(req.session.loggedIn == true){
    res.render('crearTest', {
        title: 'crearTest',
        mensaje: '' ,
        username: req.session.username
    });
    }else{
        res.render('index', {
            title: 'Inicio',
            mensaje: 'No inicio sesión',
            username: ''
        });
    };
};

const postEnviarTest = (req, res) => {
    console.log(req.body);

};


// Exporta las funciones y el enrutador
module.exports = {
    getquestion,
    getCrearPreguntas,
    postEnviarTest
};