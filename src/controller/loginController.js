const bcrypt = require('bcryptjs');// Añade la importación de bcrypt
const connection = require('../conexion');



const getIndex = (req, res) => {
    res.render('index', {
        title: 'Inicio',
        mensaje: '' ,
        username: ''
    });
};



const logout = (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.error('Error destroying session:', err);
        }
        
        res.redirect('/');
    });
};

const getDashboard = (req, res) => {

    if(req.session.loggedIn == true){
        const query = 'SELECT * FROM categoria';
        connection.query(query, (err, results) => {
            if (err) {
                console.error('Error al obtener las categorias', err);
                res.status(500).send('Error al obtener publicaciones');
                return;
            }
            if (req.session.loggedIn && results.length > 0) {
                res.render('dashboard', {
                    title: 'Home',
                    username: req.session.username,
                    categorias: results,
                    mensaje: ''});
            } else {
                res.render('error');
            }
        });

    }else{
        res.render('index', {
            title: 'Inicio',
            mensaje: 'No inicio sesión',
            username: ''
        });
}

 };

 const postRegister = async (req, res) => {
    const { name, apellido, username, rol, password, fecha_nacimiento, phone } = req.body;
    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    const insertQuery ='INSERT INTO usuarios (nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)';
    const values = [name, apellido, username, rol, hashedPassword, fecha_nacimiento, phone];
    // Ejecutar la consulta INSERT
    connection.query(insertQuery, values, function(error, results, fields) {
    if (error) {
        if (error.sqlMessage.startsWith("Duplicate entry")) {
            res.render('registro',
            {
                title: 'Registro',
                mensaje: 'Usuario '+ username + ' ya existe.',
                username: ''
            });
        }

    }else{
        res.render('index',
        {
            
            title: 'Inicio',
            mensaje: 'Usuario creado',
            username: ''
        });
    }

    });
};

async function VerificarPass(password, encriptPassword) {
    // verificamos de forma asincrona si dos contraseñas una encriptada y otra sin encriptar son correctas
    try {
        const validPassword = await bcrypt.compare(password, encriptPassword);
        return validPassword; 
        // Puedes continuar con más código aquí...
    } catch (error) {
        // Manejar cualquier error que pueda ocurrir durante la comparación
        console.error(error);
        return false;
    }
}

const postLogin = (req, res) => {
  const username = req.body.username;
  const password = req.body.contraseña;
  const query = 'SELECT * FROM usuarios WHERE username = ?';

  connection.query(query, [username], async (err, results) => {
    if (err || results.length === 0) {
      return res.render('index', { mensaje: 'Usuario no válido' });
    }

    const user = results[0];
    const validPassword = await VerificarPass(password, user.contraseña);

    if (!validPassword) {
      return res.render('index', { mensaje: 'Contraseña inválida' });
    }

    req.session.loggedIn = true;
    req.session.username = user.username;
    req.session.userId = user.id;
    req.session.rol = user.rol;

    switch (user.rol) {
      case 'p':
        return res.redirect('/profesor');
      case 'a':
        return res.redirect('/alumno');
      case 'h':
        return res.redirect('/admin');
      default:
        return res.redirect('/'); // o una ruta por defecto
    }
  });
};


const getRegistro = (req, res) => {
    res.render('registro',
    {
        title: 'Registro',
        mensaje: '' ,
        username: ''
    });
};



const getError = (req, res) => {
    res.render('error');
};

const getPerfil = (req, res) => {
    const username = req.session.username;
    const mensaje = req.query.mensaje;
    // Consulta SQL para obtener los datos del perfil del usuario
    const sql = 'SELECT * FROM usuarios WHERE username = ?';
    connection.query(sql, [username], (err, results) => {
        if (err) {
            console.error('Error al obtener datos del perfil:', err);
            res.status(500).send('Error al obtener datos del perfil');
            return;
        }
        const usuario = results[0];
        // Comprobar si se encontraron resultados
        if (results.length > 0) {
            // Renderizar la plantilla 'perfil' con los datos del usuario
            res.render('perfil', {
                title: 'Inicio',
                mensaje: '' ,
                username: username,
                rol: req.session.rol,
                usuario
            }); 
            //, { username, usuario, mensaje}
        } else {
            res.status(404).send('Usuario no encontrado');
        }
    });
};

const getPerfilalumno = (req, res) => {
    const username = req.session.username;
    const mensaje = req.query.mensaje;
    // Consulta SQL para obtener los datos del perfil del usuario
    const sql = 'SELECT * FROM usuarios WHERE username = ?';
    connection.query(sql, [username], (err, results) => {
        if (err) {
            console.error('Error al obtener datos del perfil:', err);
            res.status(500).send('Error al obtener datos del perfil');
            return;
        }
        const usuario = results[0];
        // Comprobar si se encontraron resultados
        if (results.length > 0) {
            // Renderizar la plantilla 'perfil' con los datos del usuario
            res.render('perfilalumno', {
                title: 'Inicio',
                mensaje: '' ,
                username: username,
                rol: req.session.rol,
                usuario
            }); 
            //, { username, usuario, mensaje}
        } else {
            res.status(404).send('Usuario no encontrado');
        }
    });
};
const getPoliticaCookies = (req, res) => {
    res.render('politica-de-cookies', {
    title: 'politica de cookies',
    username: req.session.username,
    rol: req.session.rol
  });
};
// Exporta las funciones y el enrutador
module.exports = {
    getIndex,
    logout,
    getDashboard,
    postLogin,
    getRegistro,
    postRegister,
    getError,
    getPerfil,
    getPerfilalumno,
    getPoliticaCookies

};