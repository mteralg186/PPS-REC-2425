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


#POPULANDO BD

INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1344, 'Carlos', 'Ramos Ramirez', 'Carara', 'p',				'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 633649874, 'foto_carlos.jpg',  '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (3431, 'Alfonso', 'Hernández Delgado', 'Alhede', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 636854924, 'foto_alfonso.jpg', '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1343, 'Daniel', 'Sánchez Jiménez', 'Dasaji', 'p', 			'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 635987494, 'foto_daniel.jpg',  '1985-10-20');
INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro) VALUES (1323, 'Gustavo', 'Guillen Guerrero', 'gustavo', 'p', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 626845694, 'foto_gustavo.jpg', '1985-10-20');

-- Usuarios

INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (100, 'María', 'Jiménez Cruz', 'MaJiCr', 'a', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 668978406, 'MaJiCr.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (431, 'Isabel', 'López Delgado', 'IsLóDe', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 637729020, 'IsLóDe.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (432, 'Ana', 'Delgado Silva', 'AnDeSi', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 616432816, 'AnDeSi.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (433, 'Sergio', 'García González', 'SeGaGo', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 637713243, 'SeGaGo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (443, 'Lucía', 'Castillo Cruz', 'LuCaCr', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 610778163, 'LuCaCr.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (435, 'Isabel', 'López Morales', 'IsLóMo', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 696797573, 'IsLóMo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (463, 'Sergio', 'Rodríguez Torres', 'SeRoTo', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 628919693, 'SeRoTo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (437, 'Diego', 'Flores Vargas', 'DiFlVa', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 693621426, 'DiFlVa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (438, 'Fernando', 'Flores Torres', 'FeFlTo', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 644350844, 'FeFlTo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (439, 'Paula', 'Jiménez Flores', 'PaJiFl', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 695870044, 'PaJiFl.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (530, 'Paula', 'García Martínez', 'PaGaMa', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 668687550, 'PaGaMa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (531, 'Jorge', 'López Castillo', 'JoLóCa', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 684305163, 'JoLóCa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (52, 'Lucía', 'López González', 'LuLóGo', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 696039319, 'LuLóGo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (53, 'Carlos', 'Jiménez Castillo', 'CaJiCa', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 669011704, 'CaJiCa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (54, 'Pedro', 'Flores Ortega', 'PeFlOr', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 610651978, 'PeFlOr.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (55, 'Andrés', 'Silva López', 'AnSiLó', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 637263361, 'AnSiLó.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (56, 'Andrés', 'Ortega Delgado', 'AnOrDe', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 673423938, 'AnOrDe.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (57, 'Sofía', 'Ramírez Flores', 'SoRaFl', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 671478007, 'SoRaFl.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (538, 'Laura', 'Jiménez Castillo', 'LaJiCa', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 615832230, 'LaJiCa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (519, 'Laura', 'Rodríguez Ortega', 'LaRoOr', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 640282943, 'LaRoOr.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (60, 'Laura', 'Rodríguez Pérez', 'LaRoPé', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 642155485, 'LaRoPé.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (58, 'Javier', 'López Ramírez', 'JaLóRa', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 628473910, 'JaLóRa.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (59, 'Natalia', 'García Sánchez', 'NaGaSá', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 676482309, 'NaGaSá.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (610, 'Pedro', 'Morales Ortega', 'PeMoOr', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 690284761, 'PeMoOr.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (613, 'Sofía', 'Ramírez Pérez', 'SoRaPé', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 648273910, 'SoRaPé.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (622, 'Carlos', 'Silva Morales', 'CaSiMo', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 617493028, 'CaSiMo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (631, 'Lucía', 'González Sánchez', 'LuGoSá', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 635192847, 'LuGoSá.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (643, 'Andrés', 'Castillo Flores', 'AnCaFl', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 629473918, 'AnCaFl.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (651, 'Isabel', 'Rodríguez Torres', 'IsRoTo', 'a', 	'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 645928371, 'IsRoTo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (663, 'Jorge', 'Flores Morales', 'JoFlMo', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 618273945, 'JoFlMo.jpg', '1985-10-20');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (672, 'Laura', 'Silva Pérez', 'LaSiPé', 'a', 		'$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', 640128374, 'LaSiPé.jpg', '1985-10-20');

-- Categorias
insert into categoria (nombre) values ('Bash');
insert into categoria (nombre) values ('Mysql');
insert into categoria (nombre) values ('IPv6');
insert into categoria (nombre) values ('Redes');



-- Preguntas
	-- pregunta 1
insert into preguntas (nombre,id_categoria) values('echo [opciones] cadenas ¿Que resultado se obtiene con EJEMPLO: echo "\tHola, ¿Qué tal?"?',1);
insert into preguntas (nombre,id_categoria) values('¿Como  creo un archivo vacio y lo ejecuto una distribucion linux?',1);
insert into preguntas (nombre,id_categoria) values('¿Qué contiene la variable $? ?',1);
insert into preguntas (nombre,id_categoria) values('¿Qué contiene la variable $$ ?',1);
insert into preguntas (nombre,id_categoria) values('¿Qué contiene la variable $@ ?',1);
insert into preguntas (nombre,id_categoria) values('¿Qué contiene la variable $* ?',1);



-- Respuesta
 -- respuestas pregunta 1
insert into respuestas (id_pregunta,nombre, esCorrecta) values (1,'\tHola, ¿Qué tal?',1),
												  (1,'Hola, ¿Qué tal?',0),
												  (1,'      Hola, ¿Qué tal?',0),
												  (1,' =>Hola, ¿Qué tal?',0);
 -- respuestas pregunta 2
 insert into respuestas (id_pregunta,nombre, esCorrecta) values (2,'touch vacio.sh chmod 755 vacio.sh ./vacio.sh',1),
												  (2,'gedit vacio.txt chmod 755 vacio.txt ./vacio.txt',0),
												  (2,'gedit vacio.sh chmod 555 vacio.sh ./vacio.sh',0),
												  (2,'gedit vacio.sh chmod 755 vacio.sh run vacio.sh',0);										 
 -- respuestas pregunta 3
insert into respuestas (id_pregunta,nombre, esCorrecta) 
values (3,'Estado de salida del último comando o script ejecutado.',1),
	   (3,'El PID de la shell.',0),
	   (3,'Los parámetros pasados al script.',0),
	   (3,'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.',0),
	   (3,'Corresponde a los primeros 9 parámetros con los que se llamó el script.',0),
	   (3,'el nombre del script.',0);
 -- respuestas pregunta 4
insert into respuestas (id_pregunta,nombre, esCorrecta) 
values (4,'Estado de salida del último comando o script ejecutado.',0),
	   (4,'El PID de la shell.',1),
	   (4,'Los parámetros pasados al script.',0),
	   (4,'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.',0),
	   (4,'Corresponde a los primeros 9 parámetros con los que se llamó el script.',0),
	   (4,'el nombre del script.',0);
 -- respuestas pregunta 5
insert into respuestas (id_pregunta,nombre, esCorrecta) 
values (5,'Estado de salida del último comando o script ejecutado.',0),
	   (5,'El PID de la shell.',0),
	   (5,'Los parámetros pasados al script.',1),
	   (5,'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.',0),
	   (5,'Corresponde a los primeros 9 parámetros con los que se llamó el script.',0),
	   (5,'el nombre del script.',0);
 -- respuestas pregunta 6
insert into respuestas (id_pregunta,nombre, esCorrecta) 
values (5,'Estado de salida del último comando o script ejecutado.',0),
	   (5,'El PID de la shell.',0),
	   (5,'Los parámetros pasados al script.',1),
	   (5,'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.',0),
	   (5,'Corresponde a los primeros 9 parámetros con los que se llamó el script.',0),
	   (5,'el nombre del script.',0);	


INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES 
(1323, 'Clase A', 'A01', 1323),
(1343, 'Clase B', 'B01', 1343),
(1344, 'Clase C', 'C01', 1344),
(3431, 'Clase D', 'D01', 3431);


INSERT INTO clases (id_clase, nombre, codigo, id_usuario) VALUES
(4001, 'Clase E', 'E01', 1323),
(4002, 'Clase F', 'F01', 1323),
(4003, 'Clase G', 'G01', 1323),
(4004, 'Clase H', 'H01', 1323);




-- Asignar usuarios a clases (clases_asignadas)



-- Asignar alumnos a las clases
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(1323, 52), (1323, 53), (1323, 54), -- Clase A
(1343, 55), (1343, 56), (1343, 57), -- Clase B
(1344, 58), (1344, 59), (1344, 60), -- Clase C
(3431, 100), (3431, 431), (3431, 432); -- Clase D

INSERT IGNORE INTO clases_asignadas (id_clase, id_alumno)
VALUES
(1323, 100),
(1323, 431),
(1323, 432),
(1323, 433),
(1323, 443),
(1323, 435),
(1323, 463),
(1323, 437),
(1323, 438),
(1323, 439),
(1323, 530),
(1323, 531),
(1323, 52),
(1323, 53),
(1323, 54),
(1323, 55),
(1323, 56),
(1323, 57),
(1323, 538),
(1323, 519),
(1323, 60),
(1323, 58),
(1323, 59),
(1323, 610),
(1323, 613),
(1323, 622),
(1323, 631),
(1323, 643),
(1323, 651),
(1323, 663),
(1323, 672);
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
((SELECT id_clase FROM clases WHERE codigo = 'E01'), 52),
((SELECT id_clase FROM clases WHERE codigo = 'E01'), 53),
((SELECT id_clase FROM clases WHERE codigo = 'F01'), 54),
((SELECT id_clase FROM clases WHERE codigo = 'F01'), 55),
((SELECT id_clase FROM clases WHERE codigo = 'G01'), 56),
((SELECT id_clase FROM clases WHERE codigo = 'G01'), 57),
((SELECT id_clase FROM clases WHERE codigo = 'H01'), 58),
((SELECT id_clase FROM clases WHERE codigo = 'H01'), 59);


-- Crear examenes para cada clase
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Examen Redes', 1, 1323, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Examen Base de Datos', 2, 1343, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Examen Administración de Sistemas', 3, 1344, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Examen Fundamentos de Hardware', 4, 3431, '2025-07-04 09:00:00', '2025-07-04 11:00:00');

INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('html', 1, 4001, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('css', 2, 4002, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('php', 3, 4003, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('docker', 4, 4004, '2025-07-04 09:00:00', '2025-07-04 11:00:00');


-- Suponemos que los examenes creados tienen ids 1, 2, 3, 4 respectivamente
-- Añadir preguntas para cada categoría (1 a 4)
INSERT INTO preguntas (nombre, id_categoria) VALUES
('¿Qué protocolo se usa en la capa de red?', 1),
('¿Qué sentencia SQL sirve para obtener datos?', 2),
('¿Cómo reiniciar un servicio en Linux?', 3),
('¿Qué componente almacena datos de forma volátil?', 4);
INSERT INTO preguntas (nombre, id_categoria) VALUES
('¿Qué protocolo se usa en la capa de red?', 1),
('¿Qué sentencia SQL sirve para obtener datos?', 2),
('¿Cómo reiniciar un servicio en Linux?', 3),
('¿Qué componente almacena datos de forma volátil?', 4);


-- Suponemos que estas preguntas tienen ids 1, 2, 3, 4 respectivamente

-- Insertar respuestas para cada pregunta, una correcta marcada con esCorrecta=1
INSERT INTO respuestas (id_pregunta, nombre, esCorrecta) VALUES
-- Pregunta 1 (Redes)
(1, 'TCP/IP', 0),
(1, 'IP', 1),
(1, 'HTTP', 0),
(1, 'FTP', 0),

-- Pregunta 2 (Base de Datos)
(2, 'SELECT', 1),
(2, 'UPDATE', 0),
(2, 'DELETE', 0),
(2, 'INSERT', 0),

-- Pregunta 3 (Administración de Sistemas)
(3, 'systemctl restart servicio', 1),
(3, 'start servicio', 0),
(3, 'restart servicio', 0),
(3, 'service stop servicio', 0),

-- Pregunta 4 (Hardware)
(4, 'RAM', 1),
(4, 'ROM', 0),
(4, 'Disco Duro', 0),
(4, 'CPU', 0);

INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(4, 9),
(4, 10);

INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES
(1, 1),  -- Pregunta 1 para examen html
(2, 2),  -- Pregunta 2 para examen css
(3, 3),  -- Pregunta 3 para examen php
(4, 4);  -- Pregunta 4 para examen docker


-- === INSERCIÓN DE DATOS ADICIONALES ===

INSERT INTO categoria (nombre) VALUES ('CategoriaExtra5');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra6');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra7');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra8');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra9');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra10');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra11');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra12');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra13');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra14');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra15');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra16');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra17');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra18');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra19');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra20');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra21');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra22');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra23');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra24');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra25');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra26');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra27');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra28');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra29');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra30');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra31');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra32');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra33');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra34');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra35');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra36');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra37');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra38');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra39');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra40');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra41');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra42');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra43');
INSERT INTO categoria (nombre) VALUES ('CategoriaExtra44');

INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5000, '¿Pregunta extra de la categoría 5?', 5);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10000, 5000, 'Respuesta 1 para pregunta 5000', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10001, 5000, 'Respuesta 2 para pregunta 5000', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10002, 5000, 'Respuesta 3 para pregunta 5000', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10003, 5000, 'Respuesta 4 para pregunta 5000', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5001, '¿Pregunta extra de la categoría 6?', 6);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10004, 5001, 'Respuesta 1 para pregunta 5001', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10005, 5001, 'Respuesta 2 para pregunta 5001', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10006, 5001, 'Respuesta 3 para pregunta 5001', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10007, 5001, 'Respuesta 4 para pregunta 5001', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5002, '¿Pregunta extra de la categoría 7?', 7);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10008, 5002, 'Respuesta 1 para pregunta 5002', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10009, 5002, 'Respuesta 2 para pregunta 5002', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10010, 5002, 'Respuesta 3 para pregunta 5002', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10011, 5002, 'Respuesta 4 para pregunta 5002', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5003, '¿Pregunta extra de la categoría 8?', 8);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10012, 5003, 'Respuesta 1 para pregunta 5003', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10013, 5003, 'Respuesta 2 para pregunta 5003', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10014, 5003, 'Respuesta 3 para pregunta 5003', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10015, 5003, 'Respuesta 4 para pregunta 5003', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5004, '¿Pregunta extra de la categoría 9?', 9);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10016, 5004, 'Respuesta 1 para pregunta 5004', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10017, 5004, 'Respuesta 2 para pregunta 5004', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10018, 5004, 'Respuesta 3 para pregunta 5004', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10019, 5004, 'Respuesta 4 para pregunta 5004', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5005, '¿Pregunta extra de la categoría 10?', 10);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10020, 5005, 'Respuesta 1 para pregunta 5005', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10021, 5005, 'Respuesta 2 para pregunta 5005', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10022, 5005, 'Respuesta 3 para pregunta 5005', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10023, 5005, 'Respuesta 4 para pregunta 5005', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5006, '¿Pregunta extra de la categoría 11?', 11);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10024, 5006, 'Respuesta 1 para pregunta 5006', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10025, 5006, 'Respuesta 2 para pregunta 5006', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10026, 5006, 'Respuesta 3 para pregunta 5006', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10027, 5006, 'Respuesta 4 para pregunta 5006', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5007, '¿Pregunta extra de la categoría 12?', 12);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10028, 5007, 'Respuesta 1 para pregunta 5007', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10029, 5007, 'Respuesta 2 para pregunta 5007', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10030, 5007, 'Respuesta 3 para pregunta 5007', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10031, 5007, 'Respuesta 4 para pregunta 5007', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5008, '¿Pregunta extra de la categoría 13?', 13);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10032, 5008, 'Respuesta 1 para pregunta 5008', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10033, 5008, 'Respuesta 2 para pregunta 5008', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10034, 5008, 'Respuesta 3 para pregunta 5008', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10035, 5008, 'Respuesta 4 para pregunta 5008', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5009, '¿Pregunta extra de la categoría 14?', 14);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10036, 5009, 'Respuesta 1 para pregunta 5009', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10037, 5009, 'Respuesta 2 para pregunta 5009', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10038, 5009, 'Respuesta 3 para pregunta 5009', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10039, 5009, 'Respuesta 4 para pregunta 5009', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5010, '¿Pregunta extra de la categoría 15?', 15);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10040, 5010, 'Respuesta 1 para pregunta 5010', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10041, 5010, 'Respuesta 2 para pregunta 5010', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10042, 5010, 'Respuesta 3 para pregunta 5010', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10043, 5010, 'Respuesta 4 para pregunta 5010', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5011, '¿Pregunta extra de la categoría 16?', 16);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10044, 5011, 'Respuesta 1 para pregunta 5011', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10045, 5011, 'Respuesta 2 para pregunta 5011', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10046, 5011, 'Respuesta 3 para pregunta 5011', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10047, 5011, 'Respuesta 4 para pregunta 5011', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5012, '¿Pregunta extra de la categoría 17?', 17);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10048, 5012, 'Respuesta 1 para pregunta 5012', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10049, 5012, 'Respuesta 2 para pregunta 5012', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10050, 5012, 'Respuesta 3 para pregunta 5012', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10051, 5012, 'Respuesta 4 para pregunta 5012', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5013, '¿Pregunta extra de la categoría 18?', 18);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10052, 5013, 'Respuesta 1 para pregunta 5013', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10053, 5013, 'Respuesta 2 para pregunta 5013', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10054, 5013, 'Respuesta 3 para pregunta 5013', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10055, 5013, 'Respuesta 4 para pregunta 5013', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5014, '¿Pregunta extra de la categoría 19?', 19);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10056, 5014, 'Respuesta 1 para pregunta 5014', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10057, 5014, 'Respuesta 2 para pregunta 5014', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10058, 5014, 'Respuesta 3 para pregunta 5014', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10059, 5014, 'Respuesta 4 para pregunta 5014', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5015, '¿Pregunta extra de la categoría 20?', 20);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10060, 5015, 'Respuesta 1 para pregunta 5015', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10061, 5015, 'Respuesta 2 para pregunta 5015', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10062, 5015, 'Respuesta 3 para pregunta 5015', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10063, 5015, 'Respuesta 4 para pregunta 5015', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5016, '¿Pregunta extra de la categoría 21?', 21);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10064, 5016, 'Respuesta 1 para pregunta 5016', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10065, 5016, 'Respuesta 2 para pregunta 5016', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10066, 5016, 'Respuesta 3 para pregunta 5016', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10067, 5016, 'Respuesta 4 para pregunta 5016', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5017, '¿Pregunta extra de la categoría 22?', 22);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10068, 5017, 'Respuesta 1 para pregunta 5017', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10069, 5017, 'Respuesta 2 para pregunta 5017', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10070, 5017, 'Respuesta 3 para pregunta 5017', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10071, 5017, 'Respuesta 4 para pregunta 5017', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5018, '¿Pregunta extra de la categoría 23?', 23);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10072, 5018, 'Respuesta 1 para pregunta 5018', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10073, 5018, 'Respuesta 2 para pregunta 5018', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10074, 5018, 'Respuesta 3 para pregunta 5018', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10075, 5018, 'Respuesta 4 para pregunta 5018', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5019, '¿Pregunta extra de la categoría 24?', 24);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10076, 5019, 'Respuesta 1 para pregunta 5019', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10077, 5019, 'Respuesta 2 para pregunta 5019', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10078, 5019, 'Respuesta 3 para pregunta 5019', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10079, 5019, 'Respuesta 4 para pregunta 5019', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5020, '¿Pregunta extra de la categoría 25?', 25);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10080, 5020, 'Respuesta 1 para pregunta 5020', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10081, 5020, 'Respuesta 2 para pregunta 5020', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10082, 5020, 'Respuesta 3 para pregunta 5020', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10083, 5020, 'Respuesta 4 para pregunta 5020', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5021, '¿Pregunta extra de la categoría 26?', 26);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10084, 5021, 'Respuesta 1 para pregunta 5021', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10085, 5021, 'Respuesta 2 para pregunta 5021', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10086, 5021, 'Respuesta 3 para pregunta 5021', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10087, 5021, 'Respuesta 4 para pregunta 5021', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5022, '¿Pregunta extra de la categoría 27?', 27);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10088, 5022, 'Respuesta 1 para pregunta 5022', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10089, 5022, 'Respuesta 2 para pregunta 5022', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10090, 5022, 'Respuesta 3 para pregunta 5022', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10091, 5022, 'Respuesta 4 para pregunta 5022', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5023, '¿Pregunta extra de la categoría 28?', 28);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10092, 5023, 'Respuesta 1 para pregunta 5023', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10093, 5023, 'Respuesta 2 para pregunta 5023', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10094, 5023, 'Respuesta 3 para pregunta 5023', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10095, 5023, 'Respuesta 4 para pregunta 5023', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5024, '¿Pregunta extra de la categoría 29?', 29);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10096, 5024, 'Respuesta 1 para pregunta 5024', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10097, 5024, 'Respuesta 2 para pregunta 5024', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10098, 5024, 'Respuesta 3 para pregunta 5024', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10099, 5024, 'Respuesta 4 para pregunta 5024', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5025, '¿Pregunta extra de la categoría 30?', 30);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10100, 5025, 'Respuesta 1 para pregunta 5025', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10101, 5025, 'Respuesta 2 para pregunta 5025', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10102, 5025, 'Respuesta 3 para pregunta 5025', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10103, 5025, 'Respuesta 4 para pregunta 5025', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5026, '¿Pregunta extra de la categoría 31?', 31);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10104, 5026, 'Respuesta 1 para pregunta 5026', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10105, 5026, 'Respuesta 2 para pregunta 5026', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10106, 5026, 'Respuesta 3 para pregunta 5026', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10107, 5026, 'Respuesta 4 para pregunta 5026', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5027, '¿Pregunta extra de la categoría 32?', 32);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10108, 5027, 'Respuesta 1 para pregunta 5027', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10109, 5027, 'Respuesta 2 para pregunta 5027', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10110, 5027, 'Respuesta 3 para pregunta 5027', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10111, 5027, 'Respuesta 4 para pregunta 5027', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5028, '¿Pregunta extra de la categoría 33?', 33);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10112, 5028, 'Respuesta 1 para pregunta 5028', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10113, 5028, 'Respuesta 2 para pregunta 5028', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10114, 5028, 'Respuesta 3 para pregunta 5028', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10115, 5028, 'Respuesta 4 para pregunta 5028', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5029, '¿Pregunta extra de la categoría 34?', 34);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10116, 5029, 'Respuesta 1 para pregunta 5029', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10117, 5029, 'Respuesta 2 para pregunta 5029', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10118, 5029, 'Respuesta 3 para pregunta 5029', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10119, 5029, 'Respuesta 4 para pregunta 5029', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5030, '¿Pregunta extra de la categoría 35?', 35);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10120, 5030, 'Respuesta 1 para pregunta 5030', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10121, 5030, 'Respuesta 2 para pregunta 5030', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10122, 5030, 'Respuesta 3 para pregunta 5030', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10123, 5030, 'Respuesta 4 para pregunta 5030', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5031, '¿Pregunta extra de la categoría 36?', 36);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10124, 5031, 'Respuesta 1 para pregunta 5031', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10125, 5031, 'Respuesta 2 para pregunta 5031', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10126, 5031, 'Respuesta 3 para pregunta 5031', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10127, 5031, 'Respuesta 4 para pregunta 5031', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5032, '¿Pregunta extra de la categoría 37?', 37);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10128, 5032, 'Respuesta 1 para pregunta 5032', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10129, 5032, 'Respuesta 2 para pregunta 5032', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10130, 5032, 'Respuesta 3 para pregunta 5032', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10131, 5032, 'Respuesta 4 para pregunta 5032', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5033, '¿Pregunta extra de la categoría 38?', 38);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10132, 5033, 'Respuesta 1 para pregunta 5033', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10133, 5033, 'Respuesta 2 para pregunta 5033', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10134, 5033, 'Respuesta 3 para pregunta 5033', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10135, 5033, 'Respuesta 4 para pregunta 5033', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5034, '¿Pregunta extra de la categoría 39?', 39);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10136, 5034, 'Respuesta 1 para pregunta 5034', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10137, 5034, 'Respuesta 2 para pregunta 5034', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10138, 5034, 'Respuesta 3 para pregunta 5034', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10139, 5034, 'Respuesta 4 para pregunta 5034', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5035, '¿Pregunta extra de la categoría 40?', 40);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10140, 5035, 'Respuesta 1 para pregunta 5035', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10141, 5035, 'Respuesta 2 para pregunta 5035', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10142, 5035, 'Respuesta 3 para pregunta 5035', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10143, 5035, 'Respuesta 4 para pregunta 5035', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5036, '¿Pregunta extra de la categoría 41?', 41);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10144, 5036, 'Respuesta 1 para pregunta 5036', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10145, 5036, 'Respuesta 2 para pregunta 5036', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10146, 5036, 'Respuesta 3 para pregunta 5036', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10147, 5036, 'Respuesta 4 para pregunta 5036', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5037, '¿Pregunta extra de la categoría 42?', 42);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10148, 5037, 'Respuesta 1 para pregunta 5037', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10149, 5037, 'Respuesta 2 para pregunta 5037', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10150, 5037, 'Respuesta 3 para pregunta 5037', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10151, 5037, 'Respuesta 4 para pregunta 5037', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5038, '¿Pregunta extra de la categoría 43?', 43);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10152, 5038, 'Respuesta 1 para pregunta 5038', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10153, 5038, 'Respuesta 2 para pregunta 5038', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10154, 5038, 'Respuesta 3 para pregunta 5038', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10155, 5038, 'Respuesta 4 para pregunta 5038', 0);
INSERT INTO preguntas (id, nombre, id_categoria) VALUES (5039, '¿Pregunta extra de la categoría 44?', 44);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10156, 5039, 'Respuesta 1 para pregunta 5039', 1);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10157, 5039, 'Respuesta 2 para pregunta 5039', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10158, 5039, 'Respuesta 3 para pregunta 5039', 0);
INSERT INTO respuestas (id, id_pregunta, nombre, esCorrecta) VALUES (10159, 5039, 'Respuesta 4 para pregunta 5039', 0);

-- Insertar preguntas en exámenes (preguntas del 1 al 10 y exámenes del 1 al 4)
-- Insertar preguntas en exámenes (preguntas del 1 al 10 y exámenes del 1 al 4)
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(4, 9),
(4, 10);

-- Insertar respuestas respondidas por usuarios
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES
(52, 1, 1, 20001, TRUE),  -- correcta
(53, 1, 2, 20002, FALSE), -- incorrecta
(54, 1, 3, 20003, TRUE),  -- correcta
(55, 2, 4, 20004, FALSE), -- incorrecta
(56, 2, 5, 20005, TRUE),  -- correcta
(57, 2, 6, 20006, FALSE), -- incorrecta
(58, 3, 7, 20007, TRUE),  -- correcta
(59, 3, 8, 20008, FALSE), -- incorrecta
(60, 4, 9, 20009, TRUE),  -- correcta
(100, 4, 10, 20010, FALSE); -- incorrecta

-- Respuestas del alumno 52
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES
(52, 1, 1, 2, TRUE),   -- correcta
(52, 1, 2, 6, FALSE),  -- incorrecta
(52, 1, 3, 10, TRUE);  -- correcta

INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES
(52, 1, 6.66, TRUE);

-- Respuestas del alumno 53
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES
(53, 1, 1, 1, FALSE),  -- incorrecta
(53, 1, 2, 7, TRUE),   -- correcta
(53, 1, 3, 9, FALSE);  -- incorrecta

INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES
(53, 1, 3.33, FALSE);

-- Respuestas del alumno 54
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES
(54, 1, 1, 2, TRUE),   -- correcta
(54, 1, 2, 7, TRUE),   -- correcta
(54, 1, 3, 13, FALSE); -- incorrecta

-- Insertar resultados para otros alumnos
-- Insertar o actualizar resultados para otros alumnos
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) 
VALUES
(52, 1, 7.50, TRUE),
(53, 1, 5.00, TRUE),
(54, 1, 4.50, FALSE),
(55, 1, 8.00, TRUE),
(56, 1, 6.00, TRUE),
(57, 1, 7.75, TRUE),
(58, 1, 9.00, TRUE),
(59, 1, 3.25, FALSE),
(60, 1, 6.50, TRUE),
(100, 1, 5.75, TRUE),
(431, 1, 8.50, TRUE),
(432, 1, 9.75, TRUE),
(433, 1, 6.25, TRUE),
(435, 1, 4.75, FALSE),
(437, 1, 5.50, TRUE),
(438, 1, 3.00, FALSE),
(439, 1, 7.25, TRUE),
(443, 1, 8.75, TRUE),
(463, 1, 9.25, TRUE),
(519, 1, 6.50, TRUE),
(530, 1, 7.00, TRUE),
(531, 1, 6.75, TRUE),
(538, 1, 8.25, TRUE),
(610, 1, 5.25, TRUE)
ON DUPLICATE KEY UPDATE
nota = VALUES(nota),
aprobado = VALUES(aprobado);

INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES
-- Examen 2 (Base de Datos)
(56, 2, 6.00, TRUE),
(57, 2, 7.75, TRUE),
(58, 2, 9.00, TRUE),
(59, 2, 3.25, FALSE),

-- Examen 3 (Admin. Sistemas)
(60, 3, 6.50, TRUE),
(100, 3, 5.75, TRUE),
(431, 3, 8.50, TRUE),
(432, 3, 9.75, TRUE),

-- Examen 4 (Fundamentos Hardware)
(433, 4, 6.25, TRUE),
(435, 4, 4.75, FALSE),
(437, 4, 5.50, TRUE),
(438, 4, 3.00, FALSE),

-- Algunos más en otros exámenes
(519, 2, 6.50, TRUE),
(530, 3, 7.00, TRUE),
(531, 4, 6.75, TRUE),
(610, 2, 5.25, TRUE)

ON DUPLICATE KEY UPDATE
nota = VALUES(nota),
aprobado = VALUES(aprobado);



INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES
-- Examen 5 (simulación)
(56, 5, 7.20, TRUE),
(57, 5, 5.50, TRUE),
(58, 5, 8.00, TRUE),
(59, 5, 4.00, FALSE),

-- Examen 6 (simulación)
(60, 6, 6.75, TRUE),
(100, 6, 5.00, TRUE),
(431, 6, 9.00, TRUE),
(432, 6, 7.50, TRUE),

-- Examen 7 (simulación)
(433, 7, 6.00, TRUE),
(435, 7, 3.75, FALSE),
(437, 7, 5.25, TRUE),
(438, 7, 2.50, FALSE),

-- Examen 8 (simulación)
(519, 8, 7.25, TRUE),
(530, 8, 6.00, TRUE),
(531, 8, 4.75, FALSE),
(610, 8, 5.50, TRUE)

ON DUPLICATE KEY UPDATE
nota = VALUES(nota),
aprobado = VALUES(aprobado);




