-- Creación de la base de datos

CREATE DATABASE IF NOT EXISTS tester;

-- Usar la base de datos
USE tester;

DROP TABLE IF EXISTS usuarios;

-- Creación de la tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) not null,
    username varchar(100) not null unique,
    rol varchar(1) NOT NULL,
    contraseña CHAR(60) NOT NULL,
    fecha_nacimiento date,
    telefono varchar(100),
    foto_perfil LONGBLOB,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



DROP TABLE IF EXISTS categoria;
-- Creación de la tabla categoria
CREATE TABLE IF NOT EXISTS categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS preguntas;
-- Creación de la tabla preguntas
CREATE TABLE IF NOT EXISTS preguntas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    id_categoria int,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS respuestas;
-- Creación de la tabla preguntas
CREATE TABLE IF NOT EXISTS respuestas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta int,
    nombre VARCHAR(255) NOT NULL,
    esCorrecta boolean,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS respondidas;

CREATE TABLE `respondidas` (
  `id_usuario` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `respuesta_id` int(11) DEFAULT NULL,
  `es_correcta` tinyint(1) DEFAULT NULL,
  `fecha_respuesta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Creación de la tabla de Clases
CREATE TABLE IF NOT EXISTS clases (
    id_clase INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo VARCHAR(10),
    id_usuario int,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN key (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS clases_asignadas;

CREATE TABLE IF NOT EXISTS clases_asignadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_clase INT NOT NULL,
    id_alumno INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    FOREIGN KEY (id_alumno) REFERENCES usuarios(id) ON DELETE CASCADE,
    UNIQUE KEY (id_clase, id_alumno)
);
-- Creación de la tabla de Examenes
DROP TABLE IF EXISTS examenes;
CREATE TABLE IF NOT EXISTS examenes (
    id_examen INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    id_categoria INT,
    id_clase INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_hora_disponible DATETIME NULL,
    fecha_hora_fin DATETIME NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE CASCADE,
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE
);

DROP TABLE IF EXISTS examen_preguntas;
CREATE TABLE IF NOT EXISTS examen_preguntas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_examen INT,
  id_pregunta INT,
  FOREIGN KEY (id_examen) REFERENCES examenes(id_examen) ON DELETE CASCADE,
  FOREIGN KEY (id_pregunta) REFERENCES preguntas(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS examenes_realizados (
    id_usuario INT,
    id_examen INT,
    nota DECIMAL(5,2),
    aprobado BOOLEAN,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_examen),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_examen) REFERENCES examenes(id_examen) ON DELETE CASCADE
);

-- usuarios

-- Profesores
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1100, 'Paco', 'Perez Gomez', 'perez', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 626845694, 'foto_perez.jpg', '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1101, 'Alvaro', 'Guerrero Garcia', 'alvaro', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 626845694, 'foto_alvaro.jpg', '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1102, 'Ana', 'Rodriguez Dianez', 'ana', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 626845694, 'foto_ana.jpg', '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1103, 'Gustavo', 'Guillen Guerrero', 'gustavo', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 626845694, 'foto_gustavo.jpg', '1985-10-20');

-- Alumnos
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES
(1200, 'Carlos', 'López Martínez', 'carloslm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-03-15', 628765432, 'foto_carlos.jpg', '2025-06-19'),
(1201, 'María', 'Pérez Gómez', 'mariapg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-07-22', 617654321, 'foto_maria.jpg', '2025-06-19'),
(1202, 'Javier', 'García Sánchez', 'javiergs', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-11-02', 619876543, 'foto_javier.jpg', '2025-06-19'),
(1203, 'Lucía', 'Fernández Ruiz', 'luciafr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1995-04-10', 622345678, 'foto_lucia.jpg', '2025-06-19'),
(1204, 'Sergio', 'Hernández Díaz', 'sergiohd', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1987-01-25', 624567890, 'foto_sergio.jpg', '2025-06-19'),
(1205, 'Ana', 'Ramírez Torres', 'anart', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-08-13', 629876543, 'foto_ana.jpg', '2025-06-19'),
(1206, 'Pablo', 'Gómez López', 'pablogl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-05-19', 621234567, 'foto_pablo.jpg', '2025-06-19'),
(1207, 'Claudia', 'Ruiz Martín', 'claudiarm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1994-10-21', 623456789, 'foto_claudia.jpg', '2025-06-19'),
(1208, 'Jorge', 'Santos García', 'jorgesg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-02-18', 627654321, 'foto_jorge.jpg', '2025-06-19'),
(1209, 'Marta', 'Jiménez Díaz', 'martajd', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-12-07', 626543210, 'foto_marta.jpg', '2025-06-19'),
(1210, 'Luis', 'Navarro Vega', 'luisnv', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-03-09', 625432198, 'foto_luis.jpg', '2025-06-19'),
(1211, 'Sara', 'Moreno Torres', 'saramt', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-06-23', 624789012, 'foto_sara.jpg', '2025-06-19'),
(1212, 'Iván', 'Martínez Gómez', 'ivanmg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-09-15', 628901234, 'foto_ivan.jpg', '2025-06-19'),
(1213, 'Elena', 'Ortiz Fernández', 'elenaof', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-11-19', 627098765, 'foto_elena.jpg', '2025-06-19'),
(1214, 'Fernando', 'Lara Gómez', 'fernandolg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-01-30', 625890123, 'foto_fernando.jpg', '2025-06-19'),
(1215, 'Isabel', 'Ramos Pérez', 'isabelrp', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1987-08-08', 624567809, 'foto_isabel.jpg', '2025-06-19'),
(1216, 'Manuel', 'Gil Hernández', 'manuelgh', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-04-20', 629012345, 'foto_manuel.jpg', '2025-06-19'),
(1217, 'Alicia', 'Sanz Martínez', 'aliciasm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-05-15', 622345098, 'foto_alicia.jpg', '2025-06-19'),
(1218, 'Gabriel', 'Molina Gómez', 'gabrielmg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-10-10', 623210987, 'foto_gabriel.jpg', '2025-06-19'),
(1219, 'Laura', 'Cano López', 'lauracl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-12-25', 624098765, 'foto_laura.jpg', '2025-06-19'),
(1220, 'Pedro', 'Blanco Torres', 'pedrobt', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-03-11', 629876012, 'foto_pedro.jpg', '2025-06-19'),
(1221, 'Laura', 'Cruz González', 'lauracg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-04-04', 630123456, 'foto_laura_cruz.jpg', '2025-06-19'),
(1222, 'David', 'Ramírez Jiménez', 'davidrj', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-07-25', 629987654, 'foto_david.jpg', '2025-06-19'),
(1223, 'Mónica', 'Herrera López', 'monicalh', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-11-17', 628654789, 'foto_monica.jpg', '2025-06-19'),
(1224, 'Antonio', 'Rojas Sánchez', 'antoniorj', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-09-29', 627432198, 'foto_antonio.jpg', '2025-06-19'),
(1225, 'Patricia', 'Soler Gómez', 'patriciasg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-02-18', 626789012, 'foto_patricia.jpg', '2025-06-19'),
(1226, 'Ricardo', 'Campos Martín', 'ricardocm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-06-15', 625098764, 'foto_ricardo.jpg', '2025-06-19'),
(1227, 'Angela', 'Martín Pérez', 'angelamp', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-03-24', 624567890, 'foto_angela.jpg', '2025-06-19'),
(1228, 'Eduardo', 'Ramírez López', 'eduardorl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-05-13', 623456789, 'foto_eduardo.jpg', '2025-06-19'),
(1229, 'Nuria', 'Hidalgo Torres', 'nuriahg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-12-10', 622345678, 'foto_nuria.jpg', '2025-06-19'),
(1230, 'Francisco', 'López García', 'franciscolg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-01-21', 621234567, 'foto_francisco.jpg', '2025-06-19'),
(1231, 'Beatriz', 'Sánchez Ruiz', 'beatrizsr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-07-19', 629876543, 'foto_beatriz.jpg', '2025-06-19'),
(1232, 'Victor', 'Martínez Torres', 'victormt', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-03-14', 628765432, 'foto_victor.jpg', '2025-06-19'),
(1233, 'Natalia', 'Gómez Jiménez', 'nataliagj', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-08-05', 627654321, 'foto_natalia.jpg', '2025-06-19'),
(1234, 'Raúl', 'Mendoza Sánchez', 'raulms', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-02-26', 626543210, 'foto_raul.jpg', '2025-06-19'),
(1235, 'Victoria', 'Jiménez Ramírez', 'victoriajr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-11-16', 625432198, 'foto_victoria.jpg', '2025-06-19'),
(1236, 'Diego', 'Ortega González', 'diegog', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-09-01', 624789012, 'foto_diego.jpg', '2025-06-19'),
(1237, 'Sandra', 'López Fernández', 'sandralf', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-04-18', 623456789, 'foto_sandra.jpg', '2025-06-19'),
(1238, 'Alejandro', 'González López', 'alejandrogl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-06-10', 622345678, 'foto_alejandro.jpg', '2025-06-19'),
(1239, 'Marina', 'Gutiérrez Sánchez', 'marinags', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-08-30', 621234567, 'foto_marina.jpg', '2025-06-19'),
(1240, 'Daniel', 'Morales Jiménez', 'danielmj', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-03-12', 628345987, 'foto_daniel.jpg', '2025-06-19'),
(1241, 'Silvia', 'Rojas Fernández', 'silviarf', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-05-20', 623456098, 'foto_silvia.jpg', '2025-06-19'),
(1242, 'Carlos', 'Torres Gómez', 'carlostg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-07-15', 627890123, 'foto_carlos.jpg', '2025-06-19'),
(1243, 'Lorena', 'Martínez Ruiz', 'lorenamr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-09-03', 621567890, 'foto_lorena.jpg', '2025-06-19'),
(1244, 'Raquel', 'Fernández López', 'raquelfl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-01-18', 626098734, 'foto_raquel.jpg', '2025-06-19'),
(1245, 'Tomás', 'García Díaz', 'tomasgd', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-11-23', 624567890, 'foto_tomas.jpg', '2025-06-19'),
(1246, 'Nerea', 'Cruz Martín', 'nereacm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-03-08', 628098765, 'foto_nerea.jpg', '2025-06-19'),
(1247, 'Rubén', 'Hernández Pérez', 'rubenhp', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-04-25', 627654321, 'foto_ruben.jpg', '2025-06-19'),
(1248, 'Miriam', 'Vega García', 'miriamvg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-12-14', 623456789, 'foto_miriam.jpg', '2025-06-19'),
(1249, 'José', 'Álvarez Torres', 'joseat', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-05-09', 629098765, 'foto_jose.jpg', '2025-06-19'),
(1250, 'Patricia', 'Roldán López', 'patriciarl', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-07-15', 622567890, 'foto_patricia.jpg', '2025-06-19'),
(1251, 'Alberto', 'Gómez Ruiz', 'albertogr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1987-06-21', 627098654, 'foto_alberto.jpg', '2025-06-19'),
(1252, 'Clara', 'Domínguez Ruiz', 'claradr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-07-14', 629012346, 'foto_clara.jpg', '2025-06-19'),
(1253, 'Enrique', 'Vega Morales', 'enriquemv', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-11-22', 628765433, 'foto_enrique.jpg', '2025-06-19'),
(1254, 'Rocío', 'Santos Ruiz', 'rociors', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-05-07', 627654322, 'foto_rocio.jpg', '2025-06-19'),
(1255, 'Tomás', 'Cruz Herrera', 'tomasch', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-02-17', 626543211, 'foto_tomas.jpg', '2025-06-19'),
(1256, 'Inés', 'Medina López', 'inesml', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-09-03', 625432199, 'foto_ines.jpg', '2025-06-19'),
(1257, 'Miguel', 'Castillo García', 'miguelcg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-12-12', 624789013, 'foto_miguel.jpg', '2025-06-19'),
(1258, 'Natalia', 'Vargas Torres', 'nataliavt', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-03-25', 623456780, 'foto_natalia2.jpg', '2025-06-19'),
(1259, 'Sergio', 'Herrera Molina', 'sergiohm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-10-19', 622345679, 'foto_sergio2.jpg', '2025-06-19'),
(1260, 'Cristina', 'García Navarro', 'cristinagn', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-06-21', 621234568, 'foto_cristina.jpg', '2025-06-19'),
(1261, 'David', 'Morales López', 'davidml', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-04-29', 629876011, 'foto_david2.jpg', '2025-06-19'),
(1262, 'Eva', 'Ramírez Sánchez', 'evars', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-08-08', 628765434, 'foto_eva.jpg', '2025-06-19'),
(1263, 'Héctor', 'Navarro Ruiz', 'hectornr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-12-11', 627654323, 'foto_hector.jpg', '2025-06-19'),
(1264, 'Lorena', 'Sánchez Morales', 'lorenasm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-01-20', 626543212, 'foto_lorena.jpg', '2025-06-19'),
(1265, 'Raúl', 'Gómez Fernández', 'raulgf', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1988-06-04', 625432200, 'foto_raul2.jpg', '2025-06-19'),
(1266, 'Miriam', 'Castro Ruiz', 'miriamcr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-11-17', 624789014, 'foto_miriam.jpg', '2025-06-19'),
(1267, 'Óscar', 'Pérez García', 'oscarpg', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1993-04-03', 623456781, 'foto_oscar.jpg', '2025-06-19'),
(1268, 'Silvia', 'Moreno López', 'silvialm', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-08-19', 622345680, 'foto_silvia.jpg', '2025-06-19'),
(1269, 'Rubén', 'Ortiz Torres', 'rubento', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1989-05-10', 621234569, 'foto_ruben.jpg', '2025-06-19'),
(1270, 'Paula', 'Jiménez Díaz', 'paulajd', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1992-10-23', 629876010, 'foto_paula.jpg', '2025-06-19'),
(1271, 'Javier', 'Molina Sánchez', 'javierms', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1991-07-12', 628765435, 'foto_javier2.jpg', '2025-06-19'),
(1272, 'Natalia', 'González Ruiz', 'nataliagr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1990-02-28', 627654324, 'foto_natalia3.jpg', '2025-06-19');


-- categorias
INSERT INTO categoria (id, nombre)
VALUES
    (200, 'Sistemas Operativos'),
    (201, 'Redes y Comunicaciones'),
    (202, 'HLC'),
    (203, 'Seguridad Informática'),
    (204, 'Desarrollo Web'),
    (300, 'Matemáticas Básicas'),
    (301, 'Física Aplicada'),
    (302, 'Química General'),
    (303, 'Estadística'),
    (400, 'Música y Composición'),
    (401, 'Historia del Arte'),
    (402, 'Literatura Universal'),
    (403, 'Cine y Teatro');

#POPULANDO BD

-- clases Ana
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES 
(100, '1A', 'A01', 1102),
(101, '1B', 'B01', 1102),
(102, '2A', 'C01', 1102),
(103, '2B', 'D01', 1102);

-- clases Alvaro
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES 
(200, '3A', 'j02', 1101),
(201, '3B', 'Ejj', 1101),
(202, '4A', 'jv2', 1101),
(203, '4B', 'jk2', 1101);

-- clases paco
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES 
(300, '5A', 'xas', 1100),
(301, '5B', 'xed3', 1100),
(302, '6A', '34ax', 1100),
(303, '6B', 'Sxear', 1100);

-- clases Gustavo
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES 
(400, '7A', 'Z01', 1103),
(401, '7B', 'Z21', 1103),
(402, '8A', 'CZ1', 1103),
(403, '8B', 'S01', 1103);

-- Asignar alumnos a las clases

-- Alumnos-Clases Ana
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(100, 1200), (100, 1201), (100, 1203), (100, 1204), 
(101, 1205), (101, 1206), (101, 1207), (101, 1208), 
(102, 1209), (100, 1210), (102, 1211), (102, 1212), 
(103, 1213), (103, 1214), (103, 1215), (103, 1216); 

-- Alumnos-Clases Alvaro
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(200, 1217), (200, 1218), (200, 1219), (200, 1220), 
(201, 1221), (201, 1222), (201, 1223), (201, 1224), 
(202, 1225), (200, 1226), (202, 1227), (202, 1228), 
(203, 1229), (203, 1230), (203, 1231), (203, 1232); 

-- Alumnos-Clases Paco
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(300, 1233), (300, 1234), (300, 1235), (300, 1236), 
(301, 1237), (301, 1238), (301, 1239), (301, 1240), 
(302, 1241), (302, 1242), (302, 1243), (302, 1244), 
(303, 1245), (303, 1246), (303, 1247), (303, 1248); 

-- Alumnos-Clases Gustavo
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(400, 1248), (400, 1249), (400, 1250), (400, 1251), 
(401, 1252), (401, 1253), (401, 1254), (401, 1255), 
(402, 1256), (402, 1257), (402, 1258), (402, 1259), 
(403, 1260), (403, 1261), (403, 1262), (403, 1263), 
(403, 1264), (403, 1265), (403, 1266), (403, 1267), 
(403, 1268), (403, 1269), (403, 1270), (403, 1271), 
(403, 1272);


-- -- Crear examenes para cada clase de Ana
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Examen SO', 200, 100, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Windows', 200, 100, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Examen Redes', 201, 101, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Cisco', 201, 101, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Programacion', 202, 103, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Aplicacion', 202, 103, '2025-07-03 09:00:00', '2025-07-03 11:00:00');

-- -- Crear examenes para Clase Alvaro
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Zap', 203, 200, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Autopsy', 203, 200, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('python', 204, 201, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('java', 204, 201, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('C++', 204, 203, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Javascript', 204, 203, '2025-07-03 09:00:00', '2025-07-03 11:00:00');

-- -- Crear examenes para Clase Paco
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Ecuaciones', 300, 300, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Estadistica', 301, 300, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('tabla periodica', 302, 301, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('probabilidad', 303, 301, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Graficas', 303, 302, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Matrices', 204, 303, '2025-07-03 09:00:00', '2025-07-03 11:00:00');

-- -- Crear examenes para Clase gustavo
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Musicos', 400, 400, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Escritores', 401, 401, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Autores', 402, 401, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Obras', 403, 402, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Actores', 403, 403, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Peliculas', 403, 403, '2025-07-03 09:00:00', '2025-07-03 11:00:00');

-- Preguntas para Sistemas Operativos
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(201, '¿Qué es un sistema operativo?', 200),
(202, '¿Cómo se configura un servicio en Linux?', 200);

-- Respuestas para preguntas de Sistemas Operativos
INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(201, 'Es un software que gestiona el hardware', 1),
(201, 'Es un tipo de hardware', 0),
(201, 'Es un navegador web', 0),
(202, 'Editando el archivo de configuración en /etc', 1),
(202, 'Instalando un paquete sin más', 0),
(202, 'Reiniciando el sistema', 0);

-- Preguntas para Redes y Comunicaciones
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(203, '¿Qué significa TCP?', 201),
(204, '¿Qué es una dirección IP?', 201);

-- Respuestas para preguntas de Redes y Comunicaciones
INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(203, 'Protocolo de control de transmisión', 1),
(203, 'Protocolo de comunicaciones temporales', 0),
(203, 'Protocolo de conexión de terminales', 0),
(204, 'Es un identificador único para dispositivos en una red', 1),
(204, 'Es el nombre de un archivo en un servidor', 0),
(204, 'Es un puerto de comunicación', 0);

-- Preguntas para Matemáticas Básicas
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(205, '¿Qué es una ecuación cuadrática?', 300),
(206, '¿Cuál es el resultado de 2+2?', 300);

-- Respuestas para preguntas de Matemáticas Básicas
INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(205, 'Una ecuación de grado 2', 1),
(205, 'Una ecuación de grado 1', 0),
(205, 'Una ecuación que no tiene variables', 0),
(206, '4', 1),
(206, '5', 0),
(206, '3', 0);

-- Preguntas para Historia del Arte
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(207, '¿Qué caracteriza al estilo gótico?', 401),
(208, '¿Quién pintó La Última Cena?', 401);

-- Respuestas para preguntas de Historia del Arte
INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(207, 'Altas catedrales con vitrales elaborados', 1),
(207, 'Cúpulas circulares', 0),
(207, 'Edificios bajos y anchos', 0),
(208, 'Leonardo da Vinci', 1),
(208, 'Miguel Ángel', 0),
(208, 'Rafael', 0);

-- Preguntas y respuestas para Redes y Comunicaciones (201)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(209, '¿Qué es una máscara de subred?', 201),
(210, '¿Cuál es la función del protocolo DHCP?', 201);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(209, 'Determina la parte de la red y la parte del host en una IP', 1),
(209, 'Es un tipo de firewall', 0),
(209, 'Es un servidor de correo', 0),
(210, 'Asignar direcciones IP automáticamente', 1),
(210, 'Encriptar datos en la red', 0),
(210, 'Monitorear el tráfico de red', 0);

-- Preguntas y respuestas para HLC (202)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(211, '¿Qué es un registro en un procesador?', 202),
(212, '¿Qué función cumple la unidad aritmético lógica (ALU)?', 202);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(211, 'Pequeña unidad de almacenamiento dentro del CPU', 1),
(211, 'Memoria RAM externa', 0),
(211, 'Un tipo de disco duro', 0),
(212, 'Realiza operaciones matemáticas y lógicas', 1),
(212, 'Gestiona la alimentación eléctrica', 0),
(212, 'Controla la velocidad del reloj', 0);

-- Preguntas y respuestas para Seguridad Informática (203)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(213, '¿Qué es un firewall?', 203),
(214, '¿Para qué se utiliza la criptografía?', 203);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(213, 'Filtrar y controlar el tráfico de red', 1),
(213, 'Es un tipo de virus', 0),
(213, 'Un programa de edición de imágenes', 0),
(214, 'Proteger la información mediante cifrado', 1),
(214, 'Eliminar virus del sistema', 0),
(214, 'Mejorar la velocidad de conexión', 0);

-- Preguntas y respuestas para Desarrollo Web (204)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(215, '¿Qué es HTML?', 204),
(216, '¿Para qué sirve CSS?', 204);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(215, 'Lenguaje para estructurar páginas web', 1),
(215, 'Un sistema operativo', 0),
(215, 'Un tipo de base de datos', 0),
(216, 'Para dar estilo a las páginas web', 1),
(216, 'Para programar la lógica del servidor', 0),
(216, 'Para almacenar datos', 0);

-- Preguntas y respuestas para Matemáticas Básicas (300)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(217, '¿Qué es un número primo?', 300),
(218, '¿Cuál es la fórmula del área del círculo?', 300);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(217, 'Número divisible solo entre 1 y sí mismo', 1),
(217, 'Número divisible entre 2 y 3', 0),
(217, 'Número par mayor que 10', 0),
(218, 'π por radio al cuadrado', 1),
(218, '2 por π por radio', 0),
(218, 'Base por altura dividido entre 2', 0);

-- Preguntas y respuestas para Física Aplicada (301)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(219, '¿Qué es la ley de la inercia?', 301),
(220, '¿Cuál es la unidad de medida de la fuerza?', 301);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(219, 'Un objeto en reposo o movimiento constante mantiene su estado', 1),
(219, 'La fuerza es igual a la masa por la aceleración', 0),
(219, 'La energía no se crea ni se destruye', 0),
(220, 'Newton (N)', 1),
(220, 'Joule (J)', 0),
(220, 'Watt (W)', 0);

-- Preguntas y respuestas para Química General (302)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(221, '¿Qué es un enlace covalente?', 302),
(222, '¿Cuál es el símbolo químico del sodio?', 302);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(221, 'Compartir electrones entre átomos', 1),
(221, 'Transferencia de electrones', 0),
(221, 'Fuerza entre iones de carga opuesta', 0),
(222, 'Na', 1),
(222, 'So', 0),
(222, 'Sd', 0);

-- Preguntas y respuestas para Estadística (303)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(223, '¿Qué es la media aritmética?', 303),
(224, '¿Qué representa la desviación estándar?', 303);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(223, 'El promedio de un conjunto de datos', 1),
(223, 'El valor más frecuente', 0),
(223, 'El valor central de los datos', 0),
(224, 'La dispersión o variabilidad de los datos', 1),
(224, 'El número total de datos', 0),
(224, 'El valor mínimo de los datos', 0);

-- Preguntas y respuestas para Música y Composición (400)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(225, '¿Qué es una escala musical?', 400),
(226, '¿Qué función tiene un compás en la música?', 400);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(225, 'Conjunto ordenado de notas musicales', 1),
(225, 'Un instrumento de cuerda', 0),
(225, 'Un tipo de ritmo', 0),
(226, 'Dividir el tiempo en partes iguales', 1),
(226, 'El volumen de una canción', 0),
(226, 'La melodía principal', 0);

-- Preguntas y respuestas para Historia del Arte (401)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(227, '¿Quién fue Pablo Picasso?', 401),
(228, '¿Qué caracteriza al barroco?', 401);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(227, 'Pintor y escultor español, fundador del cubismo', 1),
(227, 'Un arquitecto renacentista', 0),
(227, 'Un compositor barroco', 0),
(228, 'Estilo con mucho detalle y dramatismo', 1),
(228, 'Estilo simple y minimalista', 0),
(228, 'Arte abstracto', 0);

-- Preguntas y respuestas para Literatura Universal (402)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(229, '¿Quién escribió "Don Quijote de la Mancha"?', 402),
(230, '¿Qué es una metáfora?', 402);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(229, 'Miguel de Cervantes', 1),
(229, 'Gabriel García Márquez', 0),
(229, 'Pablo Neruda', 0),
(230, 'Figura retórica que compara sin usar "como"', 1),
(230, 'Una rima consonante', 0),
(230, 'Un tipo de narrador', 0);

-- Preguntas y respuestas para Cine y Teatro (403)
INSERT INTO preguntas (id, nombre, id_categoria) VALUES
(231, '¿Qué es un guion en cine?', 403),
(232, '¿Quién fue William Shakespeare?', 403);

INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
(231, 'Documento que contiene el diálogo y acciones de la película', 1),
(231, 'El director de fotografía', 0),
(231, 'Un tipo de cámara', 0),
(232, 'Dramaturgo y poeta inglés, autor de Hamlet', 1),
(232, 'Actor de cine mudo', 0),
(232, 'Director de cine italiano', 0);


INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES
-- Examenes SO (categoria 200)
(1, 201),
(1, 202),
(2, 201),
(2, 202),

-- Examenes Redes (categoria 201)
(3, 203),
(3, 204),
(3, 209),
(3, 210),
(4, 203),
(4, 204),
(4, 209),
(4, 210),

-- Examenes HLC (categoria 202)
(5, 211),
(5, 212),
(6, 211),
(6, 212),

-- Examenes Seguridad (categoria 203)
(7, 213),
(7, 214),
(8, 213),
(8, 214),

-- Examenes Desarrollo Web (categoria 204)
(9, 215),
(9, 216),
(10, 215),
(10, 216),
(11, 215),
(11, 216),
(12, 215),
(12, 216),
(18, 215),
(18, 216),

-- Examenes Matematicas (categoria 300)
(13, 205),
(13, 206),

-- Examenes Estadistica y Física Aplicada (categorias 301, 303)
(14, 219),
(14, 220),
(16, 223),
(16, 224),
(17, 223),
(17, 224),

-- Examen Quimica General (categoria 302)
(15, 221),
(15, 222),

-- Examenes Musica (categoria 400)
(19, 225),
(19, 226),

-- Examenes Historia del Arte (categoria 401)
(20, 227),
(20, 228),

-- Examen Literatura Universal (categoria 402)
(21, 229),
(21, 230),

-- Examenes Cine y Teatro (categoria 403)
(22, 231),
(22, 232),
(23, 231),
(23, 232),
(24, 231),
(24, 232)
;


INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES
(1200, 1, 5.0, TRUE),
(1201, 1, 5.0, TRUE),
(1203, 1, 10.0, TRUE),
(1204, 1, 0.0, FALSE),
(1210, 1, 5.0, TRUE),
(1200, 2, 5.0, TRUE),
(1201, 2, 0.0, FALSE),
(1203, 2, 5.0, TRUE),
(1204, 2, 5.0, TRUE),
(1210, 2, 0.0, FALSE),
(1205, 3, 2.5, FALSE),
(1206, 3, 2.5, FALSE),
(1207, 3, 2.5, FALSE),
(1208, 3, 2.5, FALSE),
(1205, 4, 0.0, FALSE),
(1206, 4, 5.0, TRUE),
(1207, 4, 0.0, FALSE),
(1208, 4, 0.0, FALSE),
(1213, 5, 0.0, FALSE),
(1214, 5, 10.0, TRUE),
(1215, 5, 5.0, TRUE),
(1216, 5, 0.0, FALSE),
(1213, 6, 5.0, TRUE),
(1214, 6, 5.0, TRUE),
(1215, 6, 10.0, TRUE),
(1216, 6, 0.0, FALSE),
(1217, 7, 5.0, TRUE),
(1218, 7, 0.0, FALSE),
(1219, 7, 5.0, TRUE),
(1220, 7, 5.0, TRUE),
(1226, 7, 5.0, TRUE),
(1217, 8, 0.0, FALSE),
(1218, 8, 5.0, TRUE),
(1219, 8, 0.0, FALSE),
(1220, 8, 5.0, TRUE),
(1226, 8, 5.0, TRUE),
(1221, 9, 5.0, TRUE),
(1222, 9, 0.0, FALSE),
(1223, 9, 5.0, TRUE),
(1224, 9, 10.0, TRUE),
(1221, 10, 0.0, FALSE),
(1222, 10, 0.0, FALSE),
(1223, 10, 10.0, TRUE),
(1224, 10, 0.0, FALSE),
(1229, 11, 5.0, TRUE),
(1230, 11, 0.0, FALSE),
(1231, 11, 0.0, FALSE),
(1232, 11, 10.0, TRUE),
(1229, 12, 5.0, TRUE),
(1230, 12, 10.0, TRUE),
(1231, 12, 5.0, TRUE),
(1232, 12, 5.0, TRUE),
(1233, 13, 10.0, TRUE),
(1234, 13, 5.0, TRUE),
(1235, 13, 10.0, TRUE),
(1236, 13, 5.0, TRUE),
(1233, 14, 5.0, TRUE),
(1234, 14, 10.0, TRUE),
(1235, 14, 5.0, TRUE),
(1236, 14, 5.0, TRUE),
(1237, 15, 5.0, TRUE),
(1238, 15, 5.0, TRUE),
(1239, 15, 0.0, FALSE),
(1240, 15, 0.0, FALSE),
(1237, 16, 0.0, FALSE),
(1238, 16, 5.0, TRUE),
(1239, 16, 0.0, FALSE),
(1240, 16, 5.0, TRUE),
(1241, 17, 0.0, FALSE),
(1242, 17, 5.0, TRUE),
(1243, 17, 0.0, FALSE),
(1244, 17, 5.0, TRUE),
(1245, 18, 0.0, FALSE),
(1246, 18, 10.0, TRUE),
(1247, 18, 0.0, FALSE),
(1248, 18, 5.0, TRUE),
(1248, 19, 0.0, FALSE),
(1249, 19, 5.0, TRUE),
(1250, 19, 0.0, FALSE),
(1251, 19, 5.0, TRUE),
(1252, 20, 10.0, TRUE),
(1253, 20, 0.0, FALSE),
(1254, 20, 5.0, TRUE),
(1255, 20, 5.0, TRUE),
(1256, 21, 0.0, FALSE),
(1257, 21, 5.0, TRUE),
(1258, 21, 5.0, TRUE),
(1259, 21, 5.0, TRUE),
(1260, 22, 0.0, FALSE),
(1261, 22, 0.0, FALSE),
(1262, 22, 5.0, TRUE),
(1263, 22, 5.0, TRUE),
(1264, 22, 0.0, FALSE),
(1265, 22, 5.0, TRUE),
(1266, 22, 5.0, TRUE),
(1267, 22, 5.0, TRUE),
(1268, 22, 0.0, FALSE),
(1269, 22, 5.0, TRUE),
(1270, 22, 5.0, TRUE),
(1271, 22, 5.0, TRUE),
(1272, 22, 0.0, FALSE),
(1260, 23, 10.0, TRUE),
(1261, 23, 5.0, TRUE),
(1262, 23, 10.0, TRUE),
(1263, 23, 0.0, FALSE),
(1264, 23, 5.0, TRUE),
(1265, 23, 5.0, TRUE),
(1266, 23, 5.0, TRUE),
(1267, 23, 5.0, TRUE),
(1268, 23, 5.0, TRUE),
(1269, 23, 5.0, TRUE),
(1270, 23, 5.0, TRUE),
(1271, 23, 0.0, FALSE),
(1272, 23, 0.0, FALSE),
(1260, 24, 5.0, TRUE),
(1261, 24, 5.0, TRUE),
(1262, 24, 5.0, TRUE),
(1263, 24, 5.0, TRUE),
(1264, 24, 0.0, FALSE),
(1265, 24, 0.0, FALSE),
(1266, 24, 0.0, FALSE),
(1267, 24, 10.0, TRUE),
(1268, 24, 0.0, FALSE),
(1269, 24, 5.0, TRUE),
(1270, 24, 10.0, TRUE),
(1271, 24, 0.0, FALSE),
(1272, 24, 0.0, FALSE);

INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES
(1200, 1, 201, 2, 0),
(1200, 1, 202, 4, 1),
(1201, 1, 201, 2, 0),
(1201, 1, 202, 4, 1),
(1203, 1, 201, 1, 1),
(1203, 1, 202, 4, 1),
(1204, 1, 201, 2, 0),
(1204, 1, 202, 5, 0),
(1210, 1, 201, 1, 1),
(1210, 1, 202, 5, 0),
(1200, 2, 201, 1, 1),
(1200, 2, 202, 5, 0),
(1201, 2, 201, 2, 0),
(1201, 2, 202, 5, 0),
(1203, 2, 201, 1, 1),
(1203, 2, 202, 5, 0),
(1204, 2, 201, 2, 0),
(1204, 2, 202, 4, 1),
(1210, 2, 201, 2, 0),
(1210, 2, 202, 5, 0),
(1205, 3, 203, 8, 0),
(1205, 3, 204, 11, 0),
(1205, 3, 209, 26, 0),
(1205, 3, 210, 28, 1),
(1206, 3, 203, 8, 0),
(1206, 3, 204, 10, 1),
(1206, 3, 209, 26, 0),
(1206, 3, 210, 29, 0),
(1207, 3, 203, 8, 0),
(1207, 3, 204, 10, 1),
(1207, 3, 209, 26, 0),
(1207, 3, 210, 29, 0),
(1208, 3, 203, 8, 0),
(1208, 3, 204, 10, 1),
(1208, 3, 209, 26, 0),
(1208, 3, 210, 29, 0),
(1205, 4, 203, 8, 0),
(1205, 4, 204, 11, 0),
(1205, 4, 209, 26, 0),
(1205, 4, 210, 29, 0),
(1206, 4, 203, 7, 1),
(1206, 4, 204, 11, 0),
(1206, 4, 209, 26, 0),
(1206, 4, 210, 28, 1),
(1207, 4, 203, 8, 0),
(1207, 4, 204, 11, 0),
(1207, 4, 209, 26, 0),
(1207, 4, 210, 29, 0),
(1208, 4, 203, 8, 0),
(1208, 4, 204, 11, 0),
(1208, 4, 209, 26, 0),
(1208, 4, 210, 29, 0),
(1213, 5, 211, 32, 0),
(1213, 5, 212, 35, 0),
(1214, 5, 211, 31, 1),
(1214, 5, 212, 34, 1),
(1215, 5, 211, 31, 1),
(1215, 5, 212, 35, 0),
(1216, 5, 211, 32, 0),
(1216, 5, 212, 35, 0),
(1213, 6, 211, 31, 1),
(1213, 6, 212, 35, 0),
(1214, 6, 211, 31, 1),
(1214, 6, 212, 35, 0),
(1215, 6, 211, 31, 1),
(1215, 6, 212, 34, 1),
(1216, 6, 211, 32, 0),
(1216, 6, 212, 35, 0),
(1217, 7, 213, 37, 1),
(1217, 7, 214, 41, 0),
(1218, 7, 213, 38, 0),
(1218, 7, 214, 41, 0),
(1219, 7, 213, 37, 1),
(1219, 7, 214, 41, 0),
(1220, 7, 213, 38, 0),
(1220, 7, 214, 40, 1),
(1226, 7, 213, 38, 0),
(1226, 7, 214, 40, 1),
(1217, 8, 213, 38, 0),
(1217, 8, 214, 41, 0),
(1218, 8, 213, 38, 0),
(1218, 8, 214, 40, 1),
(1219, 8, 213, 38, 0),
(1219, 8, 214, 41, 0),
(1220, 8, 213, 37, 1),
(1220, 8, 214, 41, 0),
(1226, 8, 213, 38, 0),
(1226, 8, 214, 40, 1),
(1221, 9, 215, 43, 1),
(1221, 9, 216, 47, 0),
(1222, 9, 215, 44, 0),
(1222, 9, 216, 47, 0),
(1223, 9, 215, 44, 0),
(1223, 9, 216, 46, 1),
(1224, 9, 215, 43, 1),
(1224, 9, 216, 46, 1),
(1221, 10, 215, 44, 0),
(1221, 10, 216, 47, 0),
(1222, 10, 215, 44, 0),
(1222, 10, 216, 47, 0),
(1223, 10, 215, 43, 1),
(1223, 10, 216, 46, 1),
(1224, 10, 215, 44, 0),
(1224, 10, 216, 47, 0),
(1229, 11, 215, 44, 0),
(1229, 11, 216, 46, 1),
(1230, 11, 215, 44, 0),
(1230, 11, 216, 47, 0),
(1231, 11, 215, 44, 0),
(1231, 11, 216, 47, 0),
(1232, 11, 215, 43, 1),
(1232, 11, 216, 46, 1),
(1229, 12, 215, 43, 1),
(1229, 12, 216, 47, 0),
(1230, 12, 215, 43, 1),
(1230, 12, 216, 46, 1),
(1231, 12, 215, 43, 1),
(1231, 12, 216, 47, 0),
(1232, 12, 215, 43, 1),
(1232, 12, 216, 47, 0),
(1233, 13, 205, 13, 1),
(1233, 13, 206, 16, 1),
(1234, 13, 205, 13, 1),
(1234, 13, 206, 17, 0),
(1235, 13, 205, 13, 1),
(1235, 13, 206, 16, 1),
(1236, 13, 205, 13, 1),
(1236, 13, 206, 17, 0),
(1233, 14, 219, 56, 0),
(1233, 14, 220, 58, 1),
(1234, 14, 219, 55, 1),
(1234, 14, 220, 58, 1),
(1235, 14, 219, 55, 1),
(1235, 14, 220, 59, 0),
(1236, 14, 219, 56, 0),
(1236, 14, 220, 58, 1),
(1237, 15, 221, 61, 1),
(1237, 15, 222, 65, 0),
(1238, 15, 221, 62, 0),
(1238, 15, 222, 64, 1),
(1239, 15, 221, 62, 0),
(1239, 15, 222, 65, 0),
(1240, 15, 221, 62, 0),
(1240, 15, 222, 65, 0),
(1237, 16, 223, 68, 0),
(1237, 16, 224, 71, 0),
(1238, 16, 223, 67, 1),
(1238, 16, 224, 71, 0),
(1239, 16, 223, 68, 0),
(1239, 16, 224, 71, 0),
(1240, 16, 223, 67, 1),
(1240, 16, 224, 71, 0),
(1241, 17, 223, 68, 0),
(1241, 17, 224, 71, 0),
(1242, 17, 223, 67, 1),
(1242, 17, 224, 71, 0),
(1243, 17, 223, 68, 0),
(1243, 17, 224, 71, 0),
(1244, 17, 223, 68, 0),
(1244, 17, 224, 70, 1),
(1245, 18, 215, 44, 0),
(1245, 18, 216, 47, 0),
(1246, 18, 215, 43, 1),
(1246, 18, 216, 46, 1),
(1247, 18, 215, 44, 0),
(1247, 18, 216, 47, 0),
(1248, 18, 215, 44, 0),
(1248, 18, 216, 46, 1),
(1248, 19, 225, 74, 0),
(1248, 19, 226, 77, 0),
(1249, 19, 225, 74, 0),
(1249, 19, 226, 76, 1),
(1250, 19, 225, 74, 0),
(1250, 19, 226, 77, 0),
(1251, 19, 225, 74, 0),
(1251, 19, 226, 76, 1),
(1252, 20, 227, 79, 1),
(1252, 20, 228, 82, 1),
(1253, 20, 227, 80, 0),
(1253, 20, 228, 83, 0),
(1254, 20, 227, 80, 0),
(1254, 20, 228, 82, 1),
(1255, 20, 227, 79, 1),
(1255, 20, 228, 83, 0),
(1256, 21, 229, 86, 0),
(1256, 21, 230, 89, 0),
(1257, 21, 229, 85, 1),
(1257, 21, 230, 89, 0),
(1258, 21, 229, 85, 1),
(1258, 21, 230, 89, 0),
(1259, 21, 229, 86, 0),
(1259, 21, 230, 88, 1),
(1260, 22, 231, 92, 0),
(1260, 22, 232, 95, 0),
(1261, 22, 231, 92, 0),
(1261, 22, 232, 95, 0),
(1262, 22, 231, 92, 0),
(1262, 22, 232, 94, 1),
(1263, 22, 231, 91, 1),
(1263, 22, 232, 95, 0),
(1264, 22, 231, 92, 0),
(1264, 22, 232, 95, 0),
(1265, 22, 231, 91, 1),
(1265, 22, 232, 95, 0),
(1266, 22, 231, 91, 1),
(1266, 22, 232, 95, 0),
(1267, 22, 231, 91, 1),
(1267, 22, 232, 95, 0),
(1268, 22, 231, 92, 0),
(1268, 22, 232, 95, 0),
(1269, 22, 231, 91, 1),
(1269, 22, 232, 95, 0),
(1270, 22, 231, 92, 0),
(1270, 22, 232, 94, 1),
(1271, 22, 231, 91, 1),
(1271, 22, 232, 95, 0),
(1272, 22, 231, 92, 0),
(1272, 22, 232, 95, 0),
(1260, 23, 231, 91, 1),
(1260, 23, 232, 94, 1),
(1261, 23, 231, 92, 0),
(1261, 23, 232, 94, 1),
(1262, 23, 231, 91, 1),
(1262, 23, 232, 94, 1),
(1263, 23, 231, 92, 0),
(1263, 23, 232, 95, 0),
(1264, 23, 231, 92, 0),
(1264, 23, 232, 94, 1),
(1265, 23, 231, 91, 1),
(1265, 23, 232, 95, 0),
(1266, 23, 231, 91, 1),
(1266, 23, 232, 95, 0),
(1267, 23, 231, 92, 0),
(1267, 23, 232, 94, 1),
(1268, 23, 231, 92, 0),
(1268, 23, 232, 94, 1),
(1269, 23, 231, 92, 0),
(1269, 23, 232, 94, 1),
(1270, 23, 231, 91, 1),
(1270, 23, 232, 95, 0),
(1271, 23, 231, 92, 0),
(1271, 23, 232, 95, 0),
(1272, 23, 231, 92, 0),
(1272, 23, 232, 95, 0),
(1260, 24, 231, 92, 0),
(1260, 24, 232, 94, 1),
(1261, 24, 231, 91, 1),
(1261, 24, 232, 95, 0),
(1262, 24, 231, 92, 0),
(1262, 24, 232, 94, 1),
(1263, 24, 231, 92, 0),
(1263, 24, 232, 94, 1),
(1264, 24, 231, 92, 0),
(1264, 24, 232, 95, 0),
(1265, 24, 231, 92, 0),
(1265, 24, 232, 95, 0),
(1266, 24, 231, 92, 0),
(1266, 24, 232, 95, 0),
(1267, 24, 231, 91, 1),
(1267, 24, 232, 94, 1),
(1268, 24, 231, 92, 0),
(1268, 24, 232, 95, 0),
(1269, 24, 231, 91, 1),
(1269, 24, 232, 95, 0),
(1270, 24, 231, 91, 1),
(1270, 24, 232, 94, 1),
(1271, 24, 231, 92, 0),
(1271, 24, 232, 95, 0),
(1272, 24, 231, 92, 0),
(1272, 24, 232, 95, 0);
