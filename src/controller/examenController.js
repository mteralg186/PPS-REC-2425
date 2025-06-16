const connection = require('../conexion');

const mostrarExamen = (req, res) => {
  const idExamen = req.params.idExamen;

  const query = `
    SELECT e.nombre AS examen_nombre, p.id AS pregunta_id, p.nombre AS pregunta_texto, r.id AS respuesta_id, r.nombre AS respuesta_texto, r.esCorrecta
    FROM examenes e
    JOIN examen_preguntas ep ON e.id_examen = ep.id_examen
    JOIN preguntas p ON ep.id_pregunta = p.id
    JOIN respuestas r ON p.id = r.id_pregunta
    WHERE e.id_examen = ? 
    ORDER BY p.id, r.id
  `;

  connection.query(query, [idExamen], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Error al obtener el examen');
    }

    if (results.length === 0) {
      return res.status(404).send('Examen no encontrado');
    }

    // Organizar preguntas con sus respuestas
    const examen = {
      nombre: results[0].examen_nombre,
      preguntas: []
    };

    let currentPreguntaId = null;
    let currentPregunta = null;

    results.forEach(row => {
      if (row.pregunta_id !== currentPreguntaId) {
        if (currentPregunta) {
          examen.preguntas.push(currentPregunta);
        }
        currentPreguntaId = row.pregunta_id;
        currentPregunta = {
          id: row.pregunta_id,
          texto: row.pregunta_texto,
          respuestas: []
        };
      }
      currentPregunta.respuestas.push({
        id: row.respuesta_id,
        texto: row.respuesta_texto,
      });
    });

    if (currentPregunta) {
      examen.preguntas.push(currentPregunta);
    }

    res.render('examen', {
  examen,
  examenId: idExamen
});
  });
};

// Corregir respuestas
const corregirExamen = (req, res) => {
  const respuestasEnviadas = req.body; // pregunta_id: respuesta_id
  const idExamen = req.params.idExamen;
  const userId = req.session.userId;

  if (!userId) {
    return res.redirect('/');
  }

  // Primero sacamos las respuestas correctas del examen
  const query = `
    SELECT p.id AS pregunta_id, r.id AS respuesta_id, r.esCorrecta
    FROM examen_preguntas ep
    JOIN preguntas p ON ep.id_pregunta = p.id
    JOIN respuestas r ON p.id = r.id_pregunta
    WHERE ep.id_examen = ?
  `;

  connection.query(query, [idExamen], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Error al corregir el examen');
    }

    // pregunta_id -> respuesta correcta
    const respuestasCorrectas = {};
    results.forEach(r => {
      if (r.esCorrecta) {
        respuestasCorrectas[r.pregunta_id] = r.respuesta_id;
      }
    });

    let totalPreguntas = Object.keys(respuestasCorrectas).length;
    let correctas = 0;
    const respuestasAInsertar = [];

    // Preparamos respuestas para guardar en la tabla
    for (const preguntaId in respuestasCorrectas) {
      const idPregunta = parseInt(preguntaId);
      const idRespuesta = parseInt(respuestasEnviadas[preguntaId]);
      const esCorrecta = idRespuesta === respuestasCorrectas[preguntaId];

      if (esCorrecta) correctas++;

      respuestasAInsertar.push([
        userId,
        idExamen,
        idPregunta,
        idRespuesta,
        esCorrecta ? 1 : 0
      ]);
    }

    const porcentaje = (correctas / totalPreguntas) * 100;
    const aprobado = porcentaje >= 50;

    // Guardar respuestas individuales en `respondidas`
    const insertRespuestas = `
      INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta)
      VALUES ?
      ON DUPLICATE KEY UPDATE
        respuesta_id = VALUES(respuesta_id),
        es_correcta = VALUES(es_correcta)
    `;

    connection.query(insertRespuestas, [respuestasAInsertar], (err) => {
      if (err) console.error('Error al guardar respuestas respondidas:', err);
    });

    // Guardar nota final en `examenes_realizados`
    const insertNota = `
      INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado)
      VALUES (?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE nota = VALUES(nota), aprobado = VALUES(aprobado)
    `;

    connection.query(insertNota, [userId, idExamen, porcentaje, aprobado], (err) => {
      if (err) console.error('Error al guardar nota final:', err);
    });

    // Mostrar resultado al usuario
    res.render('resultadoExamen', {
      totalPreguntas,
      correctas,
      porcentaje,
      aprobado
    });
  });
};

// Función para listar todos los exámenes
const listarExamenes = (req, res) => {
  const idAlumno = req.session.userId; 

  if (!idAlumno) {
    return res.redirect('/');
  }

  const sql = `
    SELECT e.id_examen, e.nombre AS nombre_examen, c.nombre AS nombre_clase
    FROM examenes e
    JOIN clases c ON e.id_clase = c.id_clase
    JOIN clases_asignadas ca ON ca.id_clase = c.id_clase
    WHERE ca.id_alumno = ?
  `;

  connection.query(sql, [idAlumno], (err, resultados) => {
    if (err) {
      console.error('Error al obtener exámenes:', err);
      return res.status(500).send('Error en el servidor');
    }

    res.render('listaExamenes', {
      examenes: resultados,
      title: 'Tus Exámenes',
      mensaje: resultados.length > 0 ? '' : 'No tienes exámenes asignados.'
    });
  });
};
// Mostrar resultados de exámenes del usuario logueado
const verResultadosAlumno = async (req, res) => {
  if (!req.session.loggedIn) {
    return res.render('index', {
      title: 'Inicio',
      mensaje: 'Debes iniciar sesión para ver tus resultados.',
      username: ''
    });
  }

  try {
    const [resultados] = await connection.promise().query(`
      SELECT er.*, e.nombre AS nombre_examen
      FROM examenes_realizados er
      JOIN examenes e ON er.id_examen = e.id_examen
      WHERE er.id_usuario = ?
      ORDER BY er.fecha DESC
    `, [req.session.userId]);

    res.render('examenesRealizados', {
      title: 'Resultados de mis exámenes',
      username: req.session.username,
      resultados,
      mensaje: ''  // <-- Aquí envías mensaje vacío para evitar error en la vista
    });

  } catch (error) {
    console.error('Error al obtener resultados del alumno:', error.message);
    res.render('examenesRealizados', {
      title: 'Resultados de mis exámenes',
      username: req.session.username,
      mensaje: 'Hubo un error al recuperar tus resultados.',
      resultados: []
    });
  }
};
// Mostrar todos los exámenes realizados (para profesor)
const verResultadosTodos = async (req, res) => {
  try {
    const idProfesor = req.session.userId; // <- Este es el ID correcto según tu login

    if (!idProfesor) {
      return res.render('examenesRealizadosProfesor', {
        title: 'Resultados de tus exámenes',
        resultados: [],
        mensaje: 'No has iniciado sesión como profesor.'
      });
    }

    const [resultados] = await connection.promise().query(`
      SELECT 
        er.*, 
        e.nombre AS nombre_examen, 
        u.username AS nombre_alumno
      FROM examenes_realizados er
      JOIN examenes e ON er.id_examen = e.id_examen
      JOIN usuarios u ON er.id_usuario = u.id
      JOIN clases c ON e.id_clase = c.id_clase
      WHERE c.id_usuario = ?
      ORDER BY er.fecha DESC
    `, [idProfesor]);

    res.render('examenesRealizadosProfesor', {
      title: 'Resultados de tus exámenes',
      resultados
    });

  } catch (error) {
    console.error('Error al obtener resultados de tus alumnos:', error.message);
    res.render('examenesRealizadosProfesor', {
      title: 'Resultados de tus exámenes',
      resultados: [],
      mensaje: 'Error al cargar los datos.'
    });
  }
};


module.exports = {
  listarExamenes,
  mostrarExamen,
  corregirExamen,
  verResultadosAlumno,
  verResultadosTodos
};