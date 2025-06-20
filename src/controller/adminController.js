const connection = require('../conexion'); // Ajusta tu conexión mysql

// Mostrar dashboard con todas las tablas
const getDashboard = async (req, res) => {
  const db = connection.promise();
  const queries = {
    usuarios: await db.query('SELECT * FROM usuarios'),
    categorias: await db.query('SELECT * FROM categoria'),
    preguntas: await db.query('SELECT * FROM preguntas'),
    respuestas: await db.query('SELECT * FROM respuestas'),
    clases: await db.query('SELECT * FROM clases'),
    examenes: await db.query('SELECT * FROM examenes')
  };

  console.log('Dashboard data:', queries);

  const [usuarios] = queries.usuarios;
  const [categorias] = queries.categorias;
  const [preguntas] = queries.preguntas;
  const [respuestas] = queries.respuestas;
  const [clases] = queries.clases;
  const [examenes] = queries.examenes;

  // Formato fecha
  examenes.forEach(ex => {
    ex.fecha_hora_disponible = ex.fecha_hora_disponible ? new Date(ex.fecha_hora_disponible).toISOString().slice(0,16) : '';
    ex.fecha_hora_fin = ex.fecha_hora_fin ? new Date(ex.fecha_hora_fin).toISOString().slice(0,16) : '';
  });

  res.render('admin', { username: req.session.username, rol: req.session.rol,usuarios, categorias, preguntas, respuestas, clases, examenes });
};


// Helpers para UPDATE y DELETE

// UPDATE usuarios
const updateUsuario = async (req, res) => {
  const { id } = req.params;
  const { nombre, apellido, username, rol, telefono } = req.body;
  try {
    await connection.promise().query(
      `UPDATE usuarios SET nombre=?, apellido=?, username=?, rol=?, telefono=? WHERE id=?`,
      [nombre, apellido, username, rol, telefono, id]
    );
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando usuario');
  }
};

// DELETE usuarios
const deleteUsuario = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM usuarios WHERE id=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando usuario');
  }
};

// UPDATE categoria
const updateCategoria = async (req, res) => {
  const { id } = req.params;
  const { nombre } = req.body;
  try {
    await connection.promise().query('UPDATE categoria SET nombre=? WHERE id=?', [nombre, id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando categoría');
  }
};

// DELETE categoria
const deleteCategoria = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM categoria WHERE id=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando categoría');
  }
};

// UPDATE preguntas
const updatePregunta = async (req, res) => {
  const { id } = req.params;
  const { nombre, id_categoria } = req.body;
  try {
    await connection.promise().query('UPDATE preguntas SET nombre=?, id_categoria=? WHERE id=?', [nombre, id_categoria, id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando pregunta');
  }
};

// DELETE preguntas
const deletePregunta = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM preguntas WHERE id=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando pregunta');
  }
};

// UPDATE respuestas
const updateRespuesta = async (req, res) => {
  const { id } = req.params;
  const { id_pregunta, nombre, esCorrecta } = req.body;
  const correcta = esCorrecta === 'on' ? 1 : 0;
  try {
    await connection.promise().query('UPDATE respuestas SET id_pregunta=?, nombre=?, esCorrecta=? WHERE id=?', [id_pregunta, nombre, correcta, id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando respuesta');
  }
};

// DELETE respuestas
const deleteRespuesta = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM respuestas WHERE id=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando respuesta');
  }
};

// UPDATE clases
const updateClase = async (req, res) => {
  const { id } = req.params;
  const { nombre, codigo, id_usuario } = req.body;
  try {
    await connection.promise().query('UPDATE clases SET nombre=?, codigo=?, id_usuario=? WHERE id_clase=?', [nombre, codigo, id_usuario, id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando clase');
  }
};

// DELETE clases
const deleteClase = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM clases WHERE id_clase=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando clase');
  }
};

// UPDATE examenes
const updateExamen = async (req, res) => {
  const { id } = req.params;
  const { nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin } = req.body;
  try {
    await connection.promise().query(
      `UPDATE examenes SET nombre=?, id_categoria=?, id_clase=?, fecha_hora_disponible=?, fecha_hora_fin=? WHERE id_examen=?`,
      [nombre, id_categoria, id_clase, fecha_hora_disponible || null, fecha_hora_fin || null, id]
    );
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error actualizando examen');
  }
};

// DELETE examenes
const deleteExamen = async (req, res) => {
  const { id } = req.params;
  try {
    await connection.promise().query('DELETE FROM examenes WHERE id_examen=?', [id]);
    res.redirect('/admin');
  } catch (e) {
    res.status(500).send('Error eliminando examen');
  }
};

module.exports = {
  getDashboard,
  updateUsuario,
  deleteUsuario,
  updateCategoria,
  deleteCategoria,
  updatePregunta,
  deletePregunta,
  updateRespuesta,
  deleteRespuesta,
  updateClase,
  deleteClase,
  updateExamen,
  deleteExamen
};
