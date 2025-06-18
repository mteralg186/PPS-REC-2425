const connection = require('../conexion');

const mostrarExamen = (req, res) => {
  const idExamen = req.params.idExamen;
  const userId = req.session.userId;

  if (!userId) {
    return res.redirect('/');
  }

  // Verificar si ya hizo el examen
  const checkQuery = `SELECT * FROM examenes_realizados WHERE id_usuario = ? AND id_examen = ?`;

  connection.query(checkQuery, [userId, idExamen], (err, rows) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Error al verificar examen realizado');
    }

    if (rows.length > 0) {
      // Ya hizo el examen, no permitir repetir
      return res.render('examen', {
        error: 'Ya has realizado este examen y no puedes repetirlo.',
        examen: null,
        examenId: idExamen
      });
    }

    // Si no lo hizo, cargar el examen normalmente
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
        error: null,
        examen,
        examenId: idExamen
      });
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

  // Verificar si ya hizo el examen
  const checkQuery = `SELECT * FROM examenes_realizados WHERE id_usuario = ? AND id_examen = ?`;

  connection.query(checkQuery, [userId, idExamen], (err, rows) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Error al verificar examen realizado');
    }

    if (rows.length > 0) {
      return res.render('mensaje', {
        mensaje: 'Ya has realizado este examen y no puedes repetirlo.'
      });
    }

    // Si no lo hizo, continuar con corrección y guardado

    // ... aquí sigue el código que tienes para obtener respuestas correctas y guardar resultados

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

      const insertNota = `
        INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE nota = VALUES(nota), aprobado = VALUES(aprobado)
      `;

      connection.query(insertNota, [userId, idExamen, porcentaje, aprobado], (err) => {
        if (err) console.error('Error al guardar nota final:', err);
      });

      res.render('resultadoExamen', {
        totalPreguntas,
        correctas,
        porcentaje,
        aprobado
      });
    });
  });
};


// Función para listar todos los exámenes
const listarExamenes = (req, res) => {
  const idAlumno = req.session.userId;
  const { fechaInicio, fechaFin } = req.query; // Ej: '2025-06-17 15:30:00'

  if (!idAlumno) {
    return res.redirect('/');
  }

  let sql = `
    SELECT e.id_examen, e.nombre AS nombre_examen, c.nombre AS nombre_clase, e.fecha_hora_disponible
    FROM examenes e
    JOIN clases c ON e.id_clase = c.id_clase
    JOIN clases_asignadas ca ON ca.id_clase = c.id_clase
    WHERE ca.id_alumno = ?
  `;

  const params = [idAlumno];

  if (fechaInicio && fechaFin) {
    sql += ` AND e.fecha_hora_disponible BETWEEN ? AND ? `;
    params.push(fechaInicio, fechaFin);
  } else if (fechaInicio) {
    sql += ` AND e.fecha_hora_disponible >= ? `;
    params.push(fechaInicio);
  } else if (fechaFin) {
    sql += ` AND e.fecha_hora_disponible <= ? `;
    params.push(fechaFin);
  } else {
    // Si no envías ninguna fecha, puedes decidir qué hacer:
    // Por ejemplo, mostrar sólo exámenes ya disponibles
    sql += ` AND e.fecha_hora_disponible <= NOW()`;
  }

  connection.query(sql, params, (err, resultados) => {
    if (err) {
      console.error('Error al obtener exámenes:', err);
      return res.status(500).send('Error en el servidor');
    }

    res.render('listaExamenes', {
      examenes: resultados,
      title: 'Tus Exámenes',
      mensaje: resultados.length > 0 ? '' : 'No tienes exámenes disponibles en este momento.'
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
    const idUsuario = req.session.userId;
    const idExamenFiltro = req.query.id_examen || '';

    // Obtener exámenes disponibles que el alumno ha realizado para filtro
    const [examenesDisponibles] = await connection.promise().query(`
      SELECT DISTINCT e.id_examen, e.nombre
      FROM examenes e
      JOIN examenes_realizados er ON e.id_examen = er.id_examen
      WHERE er.id_usuario = ?
    `, [idUsuario]);

    let query = `
      SELECT er.*, e.nombre AS nombre_examen
      FROM examenes_realizados er
      JOIN examenes e ON er.id_examen = e.id_examen
      WHERE er.id_usuario = ?
    `;

    const params = [idUsuario];

    if (idExamenFiltro && idExamenFiltro !== '') {
      query += ' AND er.id_examen = ?';
      params.push(idExamenFiltro);
    }

    query += ' ORDER BY er.fecha DESC';

    const [resultados] = await connection.promise().query(query, params);

    res.render('examenesRealizados', {
      title: 'Resultados de mis exámenes',
      username: req.session.username,
      resultados,
      examenesDisponibles,
      idExamenFiltro,
      mensaje: ''
    });
  } catch (error) {
    console.error('Error al obtener resultados del alumno:', error.message);
    res.render('examenesRealizados', {
      title: 'Resultados de mis exámenes',
      username: req.session.username,
      mensaje: 'Hubo un error al recuperar tus resultados.',
      resultados: [],
      examenesDisponibles: [],
      idExamenFiltro: ''
    });
  }
};


// Mostrar todos los exámenes realizados (para profesor)
const verResultadosTodos = async (req, res) => {
  try {
    const idProfesor = req.session.userId; 
    const idExamenFiltro = req.query.id_examen || '';

    if (!idProfesor) {
      return res.render('examenesRealizadosProfesor', {
        title: 'Resultados de tus exámenes',
        resultados: [],
        examenesDisponibles: [],
        idExamenFiltro: '',
        mensaje: 'No has iniciado sesión como profesor.'
      });
    }

    // Obtener los exámenes disponibles para las clases del profesor
    const [examenesDisponibles] = await connection.promise().query(`
      SELECT e.id_examen, e.nombre 
      FROM examenes e
      JOIN clases c ON e.id_clase = c.id_clase
      WHERE c.id_usuario = ?
    `, [idProfesor]);

    let query = `
      SELECT 
        er.*, 
        e.nombre AS nombre_examen, 
        u.nombre AS nombre_alumno,
        u.apellido AS apellido_alumno
      FROM examenes_realizados er
      JOIN examenes e ON er.id_examen = e.id_examen
      JOIN usuarios u ON er.id_usuario = u.id
      JOIN clases c ON e.id_clase = c.id_clase
      WHERE c.id_usuario = ?
    `;

    let params = [idProfesor];

    if (idExamenFiltro && idExamenFiltro !== '') {
      query += ' AND er.id_examen = ?';
      params.push(idExamenFiltro);
    }

    query += ' ORDER BY er.fecha DESC';

    const [resultados] = await connection.promise().query(query, params);

    res.render('examenesRealizadosProfesor', {
      title: 'Resultados de tus exámenes',
      resultados,
      examenesDisponibles,
      idExamenFiltro,
      mensaje: ''
    });

  } catch (error) {
    console.error('Error al obtener resultados de tus alumnos:', error.message);
    res.render('examenesRealizadosProfesor', {
      title: 'Resultados de tus exámenes',
      resultados: [],
      examenesDisponibles: [],
      idExamenFiltro: '',
      mensaje: 'Error al cargar los datos.'
    });
  }
};

//Función examenes basado en la tabla respondidas
const obtenerExamenFalladas = (req, res) => {
  const usuarioId = req.session.userId;

  if (!req.session.loggedIn) {
    return res.redirect('/');
  }

  const obtenerPreguntasRespondidas = () => {
    return new Promise((resolve, reject) => {
      connection.query(`
        SELECT DISTINCT p.id, p.nombre
        FROM respondidas r
        JOIN preguntas p ON r.id_pregunta = p.id
        WHERE r.id_usuario = ?
      `, [usuarioId], (error, results) => {
        if (error) reject(error);
        else resolve(results);
      });
    });
  };

  const obtenerRespuestas = (idPregunta) => {
    return new Promise((resolve, reject) => {
      connection.query(`
        SELECT id AS id_respuesta, nombre AS texto, esCorrecta
        FROM respuestas
        WHERE id_pregunta = ?
      `, [idPregunta], (error, results) => {
        if (error) reject(error);
        else resolve(results);
      });
    });
  };

  obtenerPreguntasRespondidas()
    .then(async (preguntasRespondidas) => {
      if (preguntasRespondidas.length === 0) {
        return res.render('examenRespondidas', { 
          error: 'No hay preguntas respondidas para generar un examen.', 
          examen: null 
        });
      }

      const preguntasConRespuestas = [];
      for (const pregunta of preguntasRespondidas) {
        const respuestas = await obtenerRespuestas(pregunta.id);
        preguntasConRespuestas.push({
          id: pregunta.id,
          texto: pregunta.nombre,
          respuestas
        });
      }

      res.render('examenRespondidas', {
        error: null,
        examen: {
          nombre: 'Preguntas respondidas anteriormente',
          preguntas: preguntasConRespuestas
        }
      });
    })
    .catch((error) => {
      console.error('Error al generar el examen:', error);
      res.render('examenRespondidas', { 
        error: 'Error al generar el examen: ' + error.message, 
        examen: null 
      });
    });
};

const procesarRespuestasExamen = (req, res) => {
  if (!req.session.loggedIn) {
    return res.redirect('/');
  }

  const respuestasUsuario = req.body;

  const verificarRespuesta = (idRespuesta) => {
    return new Promise((resolve, reject) => {
      connection.query(`
        SELECT esCorrecta
        FROM respuestas
        WHERE id = ?
      `, [idRespuesta], (error, results) => {
        if (error) reject(error);
        else resolve(results[0].esCorrecta);
      });
    });
  };

  const promesas = Object.entries(respuestasUsuario).map(async ([idPregunta, idRespuesta]) => {
    const esCorrecta = await verificarRespuesta(idRespuesta);
    return {
      idPregunta,
      idRespuesta,
      esCorrecta
    };
  });

  Promise.all(promesas)
    .then(resultados => {
      res.render('resultado', {
        title: 'Resultados del Examen',
        username: req.session.username,
        resultados
      });
    })
    .catch(error => {
      console.error('Error al procesar respuestas:', error);
      res.render('examenRespondidas', { 
        error: 'Error al procesar las respuestas: ' + error.message, 
        examen: null 
      });
    });
};
module.exports = {
  listarExamenes,
  mostrarExamen,
  corregirExamen,
  verResultadosAlumno,
  verResultadosTodos,
  obtenerExamenFalladas,
  procesarRespuestasExamen
};