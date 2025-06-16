const connection = require('../conexion');

const crearClase = (req, res) => {
  if (req.session.loggedIn === true) {
    const query = 'SELECT id, nombre FROM categoria'; 

    connection.query(query, (err, categorias) => {
      if (err) {
        console.error('Error al obtener categorías:', err);
        return res.render('crear-clase', {
          title: 'Crear Clase',
          mensaje: 'Error al cargar categorías',
          username: req.session.username,
          categorias: []
        });
      }

      res.render('crear-clase', {
        title: 'Crear Clase',
        mensaje: '',
        username: req.session.username,
        categorias: categorias  
      });
    });

  } else {
    res.render('index', {
      title: 'Inicio',
      mensaje: 'No has iniciado sesión',
      username: ''
    });
  }
};

const crearClasePost = (req, res) => {
  if (!req.session.loggedIn) {
    return res.redirect('/');
  }

  const { nombre, categoria } = req.body;
  const codigo = Math.random().toString(36).substring(2, 8).toUpperCase(); // Código aleatorio
  const id_usuario = req.session.userId;

  const insertQuery = `
    INSERT INTO clases (nombre, codigo, id_usuario, id_categoria)
    VALUES (?, ?, ?, ?)
  `;

  connection.query(insertQuery, [nombre, codigo, id_usuario, categoria], (err) => {
    if (err) {
      console.error('Error al crear clase:', err);
      
      return connection.query('SELECT id, nombre FROM categoria', (err2, categorias) => {
        return res.render('crear-clase', {
          title: 'Crear Clase',
          mensaje: 'Error al crear la clase',
          username: req.session.username,
          categorias: categorias || []
        });
      });
    }

    connection.query('SELECT id, nombre FROM categoria', (err2, categorias) => {
      res.render('crear-clase', {
        title: 'Crear Clase',
        mensaje: `Clase creada correctamente. Código: ${codigo}`,
        username: req.session.username,
        categorias: categorias || []
      });
    });
  });
};


// Mostrar formulario
const unirseClaseGet = (req, res) => {
  res.render('unirse', {
    title: 'Unirse a una clase',
    mensaje: ''
  });
};

const unirseClasePost = (req, res) => {
  const codigoIngresado = req.body.codigo;
  const idAlumno = req.session.userId;

  if (!idAlumno) {
    return res.redirect('/');
  }

  const queryClase = 'SELECT id_clase, id_usuario FROM clases WHERE codigo = ?';

  connection.query(queryClase, [codigoIngresado], (err, resultados) => {
    if (err) {
      console.error('Error al buscar clase:', err);
      return res.render('unirse', {
        title: 'Unirse a una clase',
        mensaje: 'Error al buscar la clase.'
      });
    }

    if (resultados.length === 0) {
      return res.render('unirse', {
        title: 'Unirse a una clase',
        mensaje: 'Código no válido. Inténtalo de nuevo.'
      });
    }

    const idClase = resultados[0].id_clase;
    const idDocente = resultados[0].id_usuario; 

    // Verificar si ya está inscrito
    const checkQuery = `
      SELECT * FROM clases_asignadas 
      WHERE id_clase = ? AND id_alumno = ?
    `;

    connection.query(checkQuery, [idClase, idAlumno], (errCheck, existe) => {
      if (errCheck) {
        console.error('Error verificando inscripción:', errCheck);
        return res.render('unirse', {
          title: 'Unirse a una clase',
          mensaje: 'Error al verificar inscripción.'
        });
      }

      if (existe.length > 0) {
        return res.render('unirse', {
          title: 'Unirse a una clase',
          mensaje: 'Ya estás inscrito en esta clase.'
        });
      }

      // Insertar en clases_asignadas
      const insertQuery = `
        INSERT INTO clases_asignadas (id_clase, id_alumno)
        VALUES (?, ?)
      `;

      connection.query(insertQuery, [idClase, idAlumno], (err2) => {
        if (err2) {
          console.error('Error al asignar clase:', err2);
          return res.render('unirse', {
            title: 'Unirse a una clase',
            mensaje: 'Ocurrió un error al asignar la clase.'
          });
        }

        res.render('unirse', {
          title: 'Unirse a una clase',
          mensaje: 'Te has unido a la clase exitosamente.'
        });
      });
    });
  });
};

const verAlumnosProfesor = async (req, res) => {
  const idProfesor = req.session.userId;

  try {
    const [alumnos] = await connection.promise().query(`
      SELECT 
        u.id AS id_alumno,
        u.nombre,
        u.apellido,
        u.username,
        c.nombre AS nombre_clase,
        ca.id_clase
      FROM clases_asignadas ca
      JOIN usuarios u ON ca.id_alumno = u.id
      JOIN clases c ON ca.id_clase = c.id_clase
      WHERE c.id_usuario = ?
      ORDER BY c.nombre, u.nombre
    `, [idProfesor]);

    res.render('gestionar-alumnos', {
      title: 'Gestionar Alumnos',
      alumnos
    });
  } catch (error) {
    console.error('Error al obtener alumnos:', error.message);
    res.render('gestionar-alumnos', {
      title: 'Gestionar Alumnos',
      alumnos: [],
      mensaje: 'Hubo un error al cargar los alumnos.'
    });
  }
};

// DELETE alumno
const eliminarAlumnoDeClase = async (req, res) => {
  const { id_alumno, id_clase } = req.body;

  try {
    await connection.promise().query(`
      DELETE FROM clases_asignadas
      WHERE id_alumno = ? AND id_clase = ?
    `, [id_alumno, id_clase]);

    res.redirect('/gestionar-alumnos');
  } catch (error) {
    console.error('Error al eliminar alumno:', error.message);
    res.redirect('/gestionar-alumnos');
  }
};


// Exporta las funciones y el enrutador
module.exports = {
    crearClase,
    crearClasePost,
    unirseClaseGet,
    unirseClasePost,
    verAlumnosProfesor,
    eliminarAlumnoDeClase
};