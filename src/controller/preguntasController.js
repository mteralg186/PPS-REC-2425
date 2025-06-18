const connection = require('../conexion');

// Obtener preguntas aleatorias (ejemplo, pendiente de completar según categorías)
const getquestion = (req, res) => {
  console.log(req.body);
  const sql = `SELECT p.*, r.* FROM 
    (SELECT id FROM preguntas ORDER BY RAND() LIMIT 5) AS random_ids 
    JOIN preguntas p ON p.id = random_ids.id 
    JOIN respuestas r ON r.id_pregunta = p.id 
    WHERE p.id_categoria IN ?`;

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
  let { nombreExamen, id_categoria, nueva_categoria, id_clase, questions, fechaDisponible } = req.body;

  if (
    !nombreExamen ||
    !id_clase ||
    !Array.isArray(questions) ||
    questions.length === 0
  ) {
    return res.status(400).json({ error: 'Datos incompletos o preguntas inválidas' });
  }

  try {
    await connection.promise().beginTransaction();

    if (
      (!id_categoria || id_categoria === '' || id_categoria === '0') &&
      nueva_categoria?.trim()
    ) {
      const nombreCategoria = nueva_categoria.trim();
      const [categoriaResult] = await connection.promise().query(
        'INSERT INTO categoria (nombre) VALUES (?)',
        [nombreCategoria]
      );
      id_categoria = categoriaResult.insertId;
    }

    if (!id_categoria) {
      throw new Error('No se ha proporcionado una categoría válida.');
    }

    if (typeof fechaDisponible === 'string' && fechaDisponible.trim() !== '') {
      fechaDisponible = fechaDisponible.replace('T', ' ') + ':00';

      if (new Date(fechaDisponible) < new Date()) {
        throw new Error('La fecha de disponibilidad debe ser en el futuro.');
      }
    } else {
      fechaDisponible = null;
    }

    const [examenResult] = await connection.promise().query(
      'INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible) VALUES (?, ?, ?, ?)',
      [nombreExamen, id_categoria, id_clase, fechaDisponible]
    );
    const id_examen = examenResult.insertId;

    for (const q of questions) {
      const nombrePregunta = q.question;
      const respuestasTexto = q.answers;
      const respuestaCorrectaTexto = q.correctAnswer;

      if (!respuestasTexto.includes(respuestaCorrectaTexto)) {
        throw new Error(`La respuesta correcta "${respuestaCorrectaTexto}" no está en las respuestas de la pregunta "${nombrePregunta}"`);
      }

      const [preguntaResult] = await connection.promise().query(
        'INSERT INTO preguntas (nombre, id_categoria) VALUES (?, ?)',
        [nombrePregunta, id_categoria]
      );
      const id_pregunta = preguntaResult.insertId;

      const respuestasInsert = respuestasTexto.map(r => [
        id_pregunta,
        r,
        r === respuestaCorrectaTexto ? 1 : 0
      ]);
      await connection.promise().query(
        'INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES ?',
        [respuestasInsert]
      );

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
