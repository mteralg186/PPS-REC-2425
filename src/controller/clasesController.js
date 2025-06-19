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
    INSERT INTO clases (nombre, codigo, id_usuario)
    VALUES (?, ?, ?)
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
  const idClaseFiltro = req.query.id_clase; // leer filtro (puede estar vacío)

  try {
    // Obtener clases del profesor para el filtro
    const [clases] = await connection.promise().query(`
      SELECT id_clase, nombre FROM clases WHERE id_usuario = ?
    `, [idProfesor]);

    // Consultar alumnos, con filtro si viene idClaseFiltro
    let query = `
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
    `;
    let params = [idProfesor];

    if (idClaseFiltro && idClaseFiltro !== '') {
      query += ' AND ca.id_clase = ?';
      params.push(idClaseFiltro);
    }

    query += ' ORDER BY c.nombre, u.nombre';

    const [alumnos] = await connection.promise().query(query, params);

    res.render('gestionar-alumnos', {
      title: 'Gestionar Alumnos',
      alumnos,
      clases,
      idClaseFiltro 
    });
  } catch (error) {
    console.error('Error al obtener alumnos:', error.message);
    res.render('gestionar-alumnos', {
      title: 'Gestionar Alumnos',
      alumnos: [],
      clases: [],
      idClaseFiltro: '',
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

const MisClases = (req, res) => {
    if (!req.session.loggedIn) {
        return res.redirect('/');
    }

    const userId = req.session.userId;

    const query = `
        SELECT c.nombre, c.codigo, COUNT(ca.id_alumno) AS cantidad_alumnos
        FROM clases c
        LEFT JOIN clases_asignadas ca ON c.id_clase = ca.id_clase
        WHERE c.id_usuario = ?
        GROUP BY c.id_clase, c.nombre, c.codigo
    `;

    connection.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al obtener las clases del usuario:', err);
            return res.status(500).send('Error al obtener las clases');
        }

        res.render('misclases', {
            title: 'Mis Clases',
            username: req.session.username,
            clases: results
        });
    });
};

// Mostrar clases asignadas al alumno con filtro opcional
const verClasesAsignadasAlumno = async (req, res) => {
  if (!req.session.loggedIn) {
    return res.redirect('/login'); // o donde quieras redirigir si no está logueado
  }

  try {
    const idAlumno = req.session.userId;
    const idClaseFiltro = req.query.id_clase || '';

    // Obtener clases asignadas al alumno, con nombre de la clase
    let query = `
      SELECT ca.id, c.id_clase, c.nombre AS nombre_clase, c.codigo, ca.fecha_asignacion
      FROM clases_asignadas ca
      JOIN clases c ON ca.id_clase = c.id_clase
      WHERE ca.id_alumno = ?
    `;

    const params = [idAlumno];

    if (idClaseFiltro && idClaseFiltro !== '') {
      query += ' AND c.id_clase = ?';
      params.push(idClaseFiltro);
    }

    query += ' ORDER BY ca.fecha_asignacion DESC';

    const [clasesAsignadas] = await connection.promise().query(query, params);

    // Para el filtro, obtener todas las clases asignadas sin filtro para el select
    const [clasesParaFiltro] = await connection.promise().query(`
      SELECT DISTINCT c.id_clase, c.nombre 
      FROM clases_asignadas ca
      JOIN clases c ON ca.id_clase = c.id_clase
      WHERE ca.id_alumno = ?
    `, [idAlumno]);

    res.render('clasesAsignadasAlumno', {
      title: 'Mis clases asignadas',
      username: req.session.username,
      clasesAsignadas,
      clasesParaFiltro,
      idClaseFiltro,
      mensaje: ''
    });

  } catch (error) {
    console.error('Error al obtener clases asignadas:', error.message);
    res.render('clasesAsignadasAlumno', {
      title: 'Mis clases asignadas',
      username: req.session.username,
      clasesAsignadas: [],
      clasesParaFiltro: [],
      idClaseFiltro: '',
      mensaje: 'Error al cargar las clases asignadas.'
    });
  }
};

// Eliminar asignación de clase (desasignarse)
const eliminarClaseAsignada = async (req, res) => {
  if (!req.session.loggedIn) {
    return res.status(401).json({ mensaje: 'No autorizado' });
  }

  try {
    const idAlumno = req.session.userId;
    const idAsignacion = req.params.idAsignacion; // id de la fila en clases_asignadas

    // Verificar que la asignación existe y pertenece al alumno
    const [rows] = await connection.promise().query(`
      SELECT * FROM clases_asignadas WHERE id = ? AND id_alumno = ?
    `, [idAsignacion, idAlumno]);

    if (rows.length === 0) {
      return res.status(404).json({ mensaje: 'Asignación no encontrada' });
    }

    // Borrar la asignación
    await connection.promise().query(`
      DELETE FROM clases_asignadas WHERE id = ?
    `, [idAsignacion]);

    res.json({ mensaje: 'Clase eliminada correctamente' });
  } catch (error) {
    console.error('Error al eliminar clase asignada:', error.message);
    res.status(500).json({ mensaje: 'Error al eliminar la clase asignada' });
  }
};

const eliminarClase = async (req, res) => {
  try {
    const idClase = req.params.id;
    const idProfesor = req.session.userId;

    // Verificar que la clase pertenece al profesor
    const [clase] = await connection.promise().query(
      'SELECT id_clase FROM clases WHERE id_clase = ? AND id_usuario = ?',
      [idClase, idProfesor]
    );

    if (clase.length === 0) {
      return res.status(403).json({ error: 'No autorizado para eliminar esta clase.' });
    }

    // Eliminar clase (ON DELETE CASCADE eliminará exámenes, etc.)
    await connection.promise().query('DELETE FROM clases WHERE id_clase = ?', [idClase]);

    return res.json({ success: true });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al eliminar la clase.' });
  }
};

const eliminarExamen = async (req, res) => {
  try {
    const idExamen = req.params.id;
    const idProfesor = req.session.userId;

    // Verificar que el examen pertenece a una clase del profesor
    const [examen] = await connection.promise().query(
      `SELECT e.id_examen 
       FROM examenes e
       JOIN clases c ON e.id_clase = c.id_clase
       WHERE e.id_examen = ? AND c.id_usuario = ?`,
      [idExamen, idProfesor]
    );

    if (examen.length === 0) {
      return res.status(403).json({ error: 'No autorizado para eliminar este examen.' });
    }

    // Eliminar examen (cascade eliminará preguntas asociadas)
    await connection.promise().query('DELETE FROM examenes WHERE id_examen = ?', [idExamen]);

    return res.json({ success: true });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al eliminar el examen.' });
  }
};

const verGestionProfesor = async (req, res) => {
  try {
    const idProfesor = req.session.userId;
    const idClaseFiltro = req.query.id_clase || '';

    // Obtener clases del profesor, con posible filtro
    let queryClases = `SELECT id_clase, nombre, codigo, fecha_creacion FROM clases WHERE id_usuario = ?`;
    const paramsClases = [idProfesor];

    if (idClaseFiltro) {
      queryClases += ' AND id_clase = ?';
      paramsClases.push(idClaseFiltro);
    }

    const [clases] = await connection.promise().query(queryClases, paramsClases);

    // Obtener exámenes del profesor (uniendo con la clase para mostrar nombre de clase)
    let queryExamenes = `
      SELECT e.id_examen, e.nombre, e.fecha_creacion, e.fecha_hora_disponible, e.fecha_hora_fin, c.nombre AS nombre_clase
      FROM examenes e
      JOIN clases c ON e.id_clase = c.id_clase
      WHERE c.id_usuario = ?
    `;
    const paramsExamenes = [idProfesor];

    if (idClaseFiltro) {
      queryExamenes += ' AND c.id_clase = ?';
      paramsExamenes.push(idClaseFiltro);
    }

    const [examenes] = await connection.promise().query(queryExamenes, paramsExamenes);

    res.render('clases_examen_delete', {
      title: 'Gestión de Clases y Exámenes',
      clases,
      examenes,
      idClaseFiltro
    });

  } catch (error) {
    console.error('Error al cargar gestión profesor:', error);
    res.status(500).send('Error al cargar la página de gestión.');
  }
};
// Exporta las funciones y el enrutador
module.exports = {
    crearClase,
    crearClasePost,
    unirseClaseGet,
    unirseClasePost,
    verAlumnosProfesor,
    eliminarAlumnoDeClase,
    MisClases,
    verClasesAsignadasAlumno,
    eliminarClaseAsignada,
    eliminarClase,
    eliminarExamen,
    verGestionProfesor

};