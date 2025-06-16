const connection = require('../conexion');

// Obtener preguntas aleatorias (ejemplo, pendiente de completar según categorías)
const getquestion = (req, res) => {
  console.log(req.body);
  const sql = `SELECT p.*, r.* FROM 
    (SELECT id FROM preguntas ORDER BY RAND() LIMIT 5) AS random_ids 
    JOIN preguntas p ON p.id = random_ids.id 
    JOIN respuestas r ON r.id_pregunta = p.id 
    WHERE p.id_categoria IN ?`;
  // Aquí debería ir la consulta real con connection.promise() y devolver resultados
  // Por ejemplo:
  // connection.promise().query(sql, [arrayCategorias])
  //   .then(([rows]) => res.json(rows))
  //   .catch(err => res.status(500).json({ error: err.message }));
};

// Renderizar formulario para crear test con categorías y clases (solo para usuarios logueados)
const getCrearPreguntas = async (req, res) => {
  if (req.session.loggedIn == true) {
    try {
      const [categorias] = await connection.promise().query('SELECT * FROM categoria');
      const [clases] = await connection.promise().query(
        'SELECT * FROM clases WHERE id_usuario = ?',
        [req.session.userId]
      );

      res.render('crearTest', {
        title: 'crearTest',
        mensaje: '',
        username: req.session.username,
        categorias,
        clases
      });
    } catch (error) {
      console.error(error);
      res.render('crearTest', {
        title: 'crearTest',
        mensaje: 'Error cargando categorías o clases',
        username: req.session.username,
        categorias: [],
        clases: []
      });
    }
  } else {
    res.render('index', {
      title: 'Inicio',
      mensaje: 'No inicio sesión',
      username: ''
    });
  }
};

// Recibir y manejar el envío del test desde el front (opcional, solo log para ahora)
const postEnviarTest = (req, res) => {
  console.log(req.body);
  res.status(200).send('Recibido');
};

// Función para crear examen con preguntas y respuestas (usa transacciones)
async function crearExamen(req, res) {
  const { nombreExamen, id_categoria, id_clase, questions } = req.body;

  if (!nombreExamen || !id_categoria || !id_clase || !Array.isArray(questions) || questions.length === 0) {
    return res.status(400).json({ error: 'Datos incompletos o preguntas inválidas' });
  }

  try {
    await connection.promise().beginTransaction();

    // Insertar examen
    const [examenResult] = await connection.promise().query(
      'INSERT INTO examenes (nombre, id_categoria, id_clase) VALUES (?, ?, ?)',
      [nombreExamen, id_categoria, id_clase]
    );
    const id_examen = examenResult.insertId;

    // Insertar preguntas y respuestas
    for (const q of questions) {
      const nombrePregunta = q.question;
      const respuestasTexto = q.answers;
      const respuestaCorrectaTexto = q.correctAnswer;

      if (!respuestasTexto.includes(respuestaCorrectaTexto)) {
        throw new Error(`La respuesta correcta "${respuestaCorrectaTexto}" no está en las respuestas de la pregunta "${nombrePregunta}"`);
      }

      // Insertar pregunta
      const [preguntaResult] = await connection.promise().query(
        'INSERT INTO preguntas (nombre, id_categoria) VALUES (?, ?)',
        [nombrePregunta, id_categoria]
      );
      const id_pregunta = preguntaResult.insertId;

      // Insertar respuestas
      const respuestasInsert = respuestasTexto.map(r => [
        id_pregunta,
        r,
        r === respuestaCorrectaTexto ? 1 : 0
      ]);
      await connection.promise().query(
        'INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES ?',
        [respuestasInsert]
      );

      // Asociar pregunta con examen
      await connection.promise().query(
        'INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (?, ?)',
        [id_examen, id_pregunta]
      );
    }

    await connection.promise().commit();

    return res.status(201).json({ mensaje: 'Examen creado con éxito', id_examen });

  } catch (error) {
    await connection.promise().rollback();
    console.error('Error creando examen:', error);
    return res.status(500).json({ error: error.message });
  }
}

module.exports = {
  getquestion,
  getCrearPreguntas,
  postEnviarTest,
  crearExamen
};
