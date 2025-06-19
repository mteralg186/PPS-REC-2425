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


-- Usuarios

INSERT INTO usuarios (nombre, apellido, username, contraseña, fecha_nacimiento, telefono, foto_perfil)
VALUES ('Miguel', 'Ternero Algarín', 'miguelt', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.3\\Uploads\\IMG_36290.jpg'));
INSERT INTO usuarios (nombre, apellido, username, contraseña, fecha_nacimiento, telefono, foto_perfil)
VALUES ('María', 'RuiG', 'mariar', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.3\\Uploads\\IMG_36264.jpg'));
INSERT INTO usuarios (nombre, apellido, username, contraseña, fecha_nacimiento, telefono, foto_perfil)
VALUES ('Ronaldo', 'de Assis Moreira', 'Ronaldinho1', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.3\\Uploads\\Ronaldinho.png'));
INSERT INTO usuarios (nombre, apellido, username, contraseña, fecha_nacimiento, telefono, foto_perfil)
VALUES ('Linda', 'Onotanto', 'officialLinda1', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.3\\Uploads\\IMG_36268.jpg'));

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




       INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (100, 'María', 'Jiménez Cruz', 'MaJiCr', 'a', 'MaJiCr2025', '07/10/2008', 668978406, 'MaJiCr.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (431, 'Isabel', 'López Delgado', 'IsLóDe', 'a', 'IsLóDe2025', '28/08/2009', 637729020, 'IsLóDe.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (432, 'Ana', 'Delgado Silva', 'AnDeSi', 'a', 'AnDeSi2025', '04/01/2009', 616432816, 'AnDeSi.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (433, 'Sergio', 'García González', 'SeGaGo', 'a', 'SeGaGo2025', '21/03/2008', 637713243, 'SeGaGo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (443, 'Lucía', 'Castillo Cruz', 'LuCaCr', 'a', 'LuCaCr2025', '15/05/2007', 610778163, 'LuCaCr.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (435, 'Isabel', 'López Morales', 'IsLóMo', 'a', 'IsLóMo2025', '27/09/2008', 696797573, 'IsLóMo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (463, 'Sergio', 'Rodríguez Torres', 'SeRoTo', 'a', 'SeRoTo2025', '20/09/2008', 628919693, 'SeRoTo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (437, 'Diego', 'Flores Vargas', 'DiFlVa', 'a', 'DiFlVa2025', '04/12/2008', 693621426, 'DiFlVa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (438, 'Fernando', 'Flores Torres', 'FeFlTo', 'a', 'FeFlTo2025', '08/06/2007', 644350844, 'FeFlTo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (439, 'Paula', 'Jiménez Flores', 'PaJiFl', 'a', 'PaJiFl2025', '05/08/2007', 695870044, 'PaJiFl.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (530, 'Paula', 'García Martínez', 'PaGaMa', 'a', 'PaGaMa2025', '18/06/2007', 668687550, 'PaGaMa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (531, 'Jorge', 'López Castillo', 'JoLóCa', 'a', 'JoLóCa2025', '17/01/2006', 684305163, 'JoLóCa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (52, 'Lucía', 'López González', 'LuLóGo', 'a', 'LuLóGo2025', '16/12/2008', 696039319, 'LuLóGo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (53, 'Carlos', 'Jiménez Castillo', 'CaJiCa', 'a', 'CaJiCa2025', '10/02/2009', 669011704, 'CaJiCa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (54, 'Pedro', 'Flores Ortega', 'PeFlOr', 'a', 'PeFlOr2025', '18/04/2007', 610651978, 'PeFlOr.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (55, 'Andrés', 'Silva López', 'AnSiLó', 'a', 'AnSiLó2025', '12/06/2009', 637263361, 'AnSiLó.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (56, 'Andrés', 'Ortega Delgado', 'AnOrDe', 'a', 'AnOrDe2025', '20/12/2007', 673423938, 'AnOrDe.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (57, 'Sofía', 'Ramírez Flores', 'SoRaFl', 'a', 'SoRaFl2025', '08/08/2008', 671478007, 'SoRaFl.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (538, 'Laura', 'Jiménez Castillo', 'LaJiCa', 'a', 'LaJiCa2025', '10/04/2006', 615832230, 'LaJiCa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (519, 'Laura', 'Rodríguez Ortega', 'LaRoOr', 'a', 'LaRoOr2025', '08/12/2006', 640282943, 'LaRoOr.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (60, 'Laura', 'Rodríguez Pérez', 'LaRoPé', 'a', 'LaRoPé2025', '22/05/2008', 642155485, 'LaRoPé.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (58, 'Javier', 'López Ramírez', 'JaLóRa', 'a', 'JaLóRa2025', '09/07/2008', 628473910, 'JaLóRa.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (59, 'Natalia', 'García Sánchez', 'NaGaSá', 'a', 'NaGaSá2025', '15/05/2006', 676482309, 'NaGaSá.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (610, 'Pedro', 'Morales Ortega', 'PeMoOr', 'a', 'PeMoOr2025', '12/11/2007', 690284761, 'PeMoOr.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (613, 'Sofía', 'Ramírez Pérez', 'SoRaPé', 'a', 'SoRaPé2025', '02/08/2008', 648273910, 'SoRaPé.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (622, 'Carlos', 'Silva Morales', 'CaSiMo', 'a', 'CaSiMo2025', '20/03/2009', 617493028, 'CaSiMo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (631, 'Lucía', 'González Sánchez', 'LuGoSá', 'a', 'LuGoSá2025', '18/01/2006', 635192847, 'LuGoSá.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (643, 'Andrés', 'Castillo Flores', 'AnCaFl', 'a', 'AnCaFl2025', '27/09/2008', 629473918, 'AnCaFl.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (651, 'Isabel', 'Rodríguez Torres', 'IsRoTo', 'a', 'IsRoTo2025', '14/06/2007', 645928371, 'IsRoTo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (663, 'Jorge', 'Flores Morales', 'JoFlMo', 'a', 'JoFlMo2025', '03/12/2006', 618273945, 'JoFlMo.jpg', '18/06/2025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono, foto_perfil, fecha_registro) VALUES (672, 'Laura', 'Silva Pérez', 'LaSiPé', 'a', 'LaSiPé2025', '25/04/2009', 640128374, 'LaSiPé.jpg', '18/06/2025');



INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro)
VALUES (1344, 'Carlos', 'Ramos Ramirez', 'Carara', 'p', '$2a$10$zOrloFb6RzhHDNTtEbbCoOiRz7lml14niRfW41XRe1i0JGS/2UrAi', '1978-08-12', 633649874, 'foto_carlos.jpg', '2025-06-18');

INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro)
VALUES (3431, 'Alfonso', 'Hernández Delgado', 'Alhede', 'p', '$2a$10$zOrloFb6RzhHDNTtEbbCoOiRz7lml14niRfW41XRe1i0JGS/2UrAi', '1973-11-05', 636854924, 'foto_alfonso.jpg', '2025-06-18');

INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro)
VALUES (1343, 'Daniel', 'Sánchez Jiménez', 'Dasaji', 'p', '$2a$10$zOrloFb6RzhHDNTtEbbCoOiRz7lml14niRfW41XRe1i0JGS/2UrAi', '1984-06-12', 635987494, 'foto_daniel.jpg', '2025-06-18');

INSERT INTO usuarios (id,nombre,apellido,username,rol,contraseña,fecha_nacimiento,telefono,foto_perfil,fecha_registro)
VALUES (1323, 'Gustavo', 'Guillen Guerrero', 'gustavo', 'p', '$2a$10$zOrloFb6RzhHDNTtEbbCoOiRz7lml14niRfW41XRe1i0JGS/2UrAi
', '1969-02-12', 626845694, 'foto_gustavo.jpg', '2025-06-18');


INSERT INTO clases (id_clase, nombre, codigo, id_usuario, fecha_creacion) 
VALUES (1333, 'Redes', '10', 1, '2025-06-18');

INSERT INTO clases (id_clase, nombre, codigo, id_usuario, fecha_creacion) 
VALUES (1222, 'Base de datos', '20', 2, '2025-06-18');

INSERT INTO clases (id_clase, nombre, codigo, id_usuario, fecha_creacion) 
VALUES (1334, 'Administración de Sistemas', '30', 3, '2025-06-18');

INSERT INTO clases (id_clase, nombre, codigo, id_usuario, fecha_creacion) 
VALUES (1223, 'Fundamentos de Hardware', '40', 4, '2025-06-18');

-- Asignar usuarios a clases (clases_asignadas)
INSERT INTO clases_asignadas (id_clase, id_alumno) VALUES
(1333, 1),
(1222, 2),
(1334, 3),
(1223, 4);

-- Crear examenes para cada clase
INSERT INTO examenes (nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin) VALUES
('Examen Redes', 1, 1333, '2025-07-01 09:00:00', '2025-07-01 11:00:00'),
('Examen Base de Datos', 2, 1222, '2025-07-02 09:00:00', '2025-07-02 11:00:00'),
('Examen Administración de Sistemas', 3, 1334, '2025-07-03 09:00:00', '2025-07-03 11:00:00'),
('Examen Fundamentos de Hardware', 4, 1223, '2025-07-04 09:00:00', '2025-07-04 11:00:00');

-- Suponemos que los examenes creados tienen ids 1, 2, 3, 4 respectivamente
-- Añadir preguntas para cada categoría (1 a 4)
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

-- Asociar preguntas a los examenes correspondientes
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);



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
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10000, 'Nombre10000', 'Apellido10000', 'usuario10000', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000000');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10001, 'Nombre10001', 'Apellido10001', 'usuario10001', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000001');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10002, 'Nombre10002', 'Apellido10002', 'usuario10002', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000002');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10003, 'Nombre10003', 'Apellido10003', 'usuario10003', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000003');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10004, 'Nombre10004', 'Apellido10004', 'usuario10004', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000004');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10005, 'Nombre10005', 'Apellido10005', 'usuario10005', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000005');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10006, 'Nombre10006', 'Apellido10006', 'usuario10006', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000006');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10007, 'Nombre10007', 'Apellido10007', 'usuario10007', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000007');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10008, 'Nombre10008', 'Apellido10008', 'usuario10008', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000008');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10009, 'Nombre10009', 'Apellido10009', 'usuario10009', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '600000009');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10010, 'Nombre10010', 'Apellido10010', 'usuario10010', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000010');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10011, 'Nombre10011', 'Apellido10011', 'usuario10011', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000011');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10012, 'Nombre10012', 'Apellido10012', 'usuario10012', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000012');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10013, 'Nombre10013', 'Apellido10013', 'usuario10013', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000013');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10014, 'Nombre10014', 'Apellido10014', 'usuario10014', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000014');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10015, 'Nombre10015', 'Apellido10015', 'usuario10015', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000015');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10016, 'Nombre10016', 'Apellido10016', 'usuario10016', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000016');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10017, 'Nombre10017', 'Apellido10017', 'usuario10017', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000017');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10018, 'Nombre10018', 'Apellido10018', 'usuario10018', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000018');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10019, 'Nombre10019', 'Apellido10019', 'usuario10019', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000019');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10020, 'Nombre10020', 'Apellido10020', 'usuario10020', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000020');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10021, 'Nombre10021', 'Apellido10021', 'usuario10021', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000021');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10022, 'Nombre10022', 'Apellido10022', 'usuario10022', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000022');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10023, 'Nombre10023', 'Apellido10023', 'usuario10023', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000023');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10024, 'Nombre10024', 'Apellido10024', 'usuario10024', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000024');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10025, 'Nombre10025', 'Apellido10025', 'usuario10025', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000025');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10026, 'Nombre10026', 'Apellido10026', 'usuario10026', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000026');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10027, 'Nombre10027', 'Apellido10027', 'usuario10027', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000027');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10028, 'Nombre10028', 'Apellido10028', 'usuario10028', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000028');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10029, 'Nombre10029', 'Apellido10029', 'usuario10029', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000029');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10030, 'Nombre10030', 'Apellido10030', 'usuario10030', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000030');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10031, 'Nombre10031', 'Apellido10031', 'usuario10031', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000031');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10032, 'Nombre10032', 'Apellido10032', 'usuario10032', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000032');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10033, 'Nombre10033', 'Apellido10033', 'usuario10033', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000033');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10034, 'Nombre10034', 'Apellido10034', 'usuario10034', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000034');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10035, 'Nombre10035', 'Apellido10035', 'usuario10035', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000035');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10036, 'Nombre10036', 'Apellido10036', 'usuario10036', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000036');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10037, 'Nombre10037', 'Apellido10037', 'usuario10037', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000037');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10038, 'Nombre10038', 'Apellido10038', 'usuario10038', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000038');
INSERT INTO usuarios (id, nombre, apellido, username, rol, contraseña, fecha_nacimiento, telefono)
VALUES (10039, 'Nombre10039', 'Apellido10039', 'usuario10039', 'a', '$2b$10$HFFf9VhBUlvb/zKFY5.DyeWEJi0d2YkgtWfE5C1HoSz4/TBRSB5a.', '2000-01-01', '6000000039');
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (200, 'Clase200', 'C200', 10000);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (201, 'Clase201', 'C201', 10001);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (202, 'Clase202', 'C202', 10002);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (203, 'Clase203', 'C203', 10003);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (204, 'Clase204', 'C204', 10004);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (205, 'Clase205', 'C205', 10005);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (206, 'Clase206', 'C206', 10006);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (207, 'Clase207', 'C207', 10007);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (208, 'Clase208', 'C208', 10008);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (209, 'Clase209', 'C209', 10009);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (210, 'Clase210', 'C210', 10010);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (211, 'Clase211', 'C211', 10011);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (212, 'Clase212', 'C212', 10012);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (213, 'Clase213', 'C213', 10013);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (214, 'Clase214', 'C214', 10014);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (215, 'Clase215', 'C215', 10015);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (216, 'Clase216', 'C216', 10016);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (217, 'Clase217', 'C217', 10017);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (218, 'Clase218', 'C218', 10018);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (219, 'Clase219', 'C219', 10019);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (220, 'Clase220', 'C220', 10020);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (221, 'Clase221', 'C221', 10021);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (222, 'Clase222', 'C222', 10022);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (223, 'Clase223', 'C223', 10023);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (224, 'Clase224', 'C224', 10024);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (225, 'Clase225', 'C225', 10025);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (226, 'Clase226', 'C226', 10026);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (227, 'Clase227', 'C227', 10027);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (228, 'Clase228', 'C228', 10028);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (229, 'Clase229', 'C229', 10029);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (230, 'Clase230', 'C230', 10030);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (231, 'Clase231', 'C231', 10031);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (232, 'Clase232', 'C232', 10032);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (233, 'Clase233', 'C233', 10033);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (234, 'Clase234', 'C234', 10034);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (235, 'Clase235', 'C235', 10035);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (236, 'Clase236', 'C236', 10036);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (237, 'Clase237', 'C237', 10037);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (238, 'Clase238', 'C238', 10038);
INSERT INTO clases (id_clase, nombre, codigo, id_usuario)
VALUES (239, 'Clase239', 'C239', 10039);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (300, 220, 10020);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (301, 221, 10021);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (302, 222, 10022);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (303, 223, 10023);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (304, 224, 10024);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (305, 225, 10025);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (306, 226, 10026);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (307, 227, 10027);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (308, 228, 10028);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (309, 229, 10029);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (310, 230, 10030);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (311, 231, 10031);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (312, 232, 10032);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (313, 233, 10033);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (314, 234, 10034);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (315, 235, 10035);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (316, 236, 10036);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (317, 237, 10037);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (318, 238, 10038);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (319, 239, 10039);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (320, 200, 10000);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (321, 201, 10001);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (322, 202, 10002);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (323, 203, 10003);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (324, 204, 10004);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (325, 205, 10005);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (326, 206, 10006);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (327, 207, 10007);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (328, 208, 10008);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (329, 209, 10009);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (330, 210, 10010);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (331, 211, 10011);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (332, 212, 10012);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (333, 213, 10013);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (334, 214, 10014);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (335, 215, 10015);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (336, 216, 10016);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (337, 217, 10017);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (338, 218, 10018);
INSERT INTO clases_asignadas (id, id_clase, id_alumno)
VALUES (339, 219, 10019);
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
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (500, 'Examen500', 25, 220, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (501, 'Examen501', 26, 221, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (502, 'Examen502', 27, 222, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (503, 'Examen503', 28, 223, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (504, 'Examen504', 29, 224, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (505, 'Examen505', 30, 225, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (506, 'Examen506', 31, 226, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (507, 'Examen507', 32, 227, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (508, 'Examen508', 33, 228, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (509, 'Examen509', 34, 229, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (510, 'Examen510', 35, 230, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (511, 'Examen511', 36, 231, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (512, 'Examen512', 37, 232, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (513, 'Examen513', 38, 233, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (514, 'Examen514', 39, 234, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (515, 'Examen515', 40, 235, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (516, 'Examen516', 41, 236, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (517, 'Examen517', 42, 237, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (518, 'Examen518', 43, 238, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (519, 'Examen519', 44, 239, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (520, 'Examen520', 5, 200, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (521, 'Examen521', 6, 201, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (522, 'Examen522', 7, 202, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (523, 'Examen523', 8, 203, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (524, 'Examen524', 9, 204, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (525, 'Examen525', 10, 205, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (526, 'Examen526', 11, 206, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (527, 'Examen527', 12, 207, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (528, 'Examen528', 13, 208, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (529, 'Examen529', 14, 209, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (530, 'Examen530', 15, 210, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (531, 'Examen531', 16, 211, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (532, 'Examen532', 17, 212, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (533, 'Examen533', 18, 213, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (534, 'Examen534', 19, 214, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (535, 'Examen535', 20, 215, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (536, 'Examen536', 21, 216, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (537, 'Examen537', 22, 217, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (538, 'Examen538', 23, 218, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examenes (id_examen, nombre, id_categoria, id_clase, fecha_hora_disponible, fecha_hora_fin)
VALUES (539, 'Examen539', 24, 219, '2025-07-01 09:00:00', '2025-07-01 11:00:00');
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (500, 5020);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (501, 5021);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (502, 5022);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (503, 5023);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (504, 5024);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (505, 5025);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (506, 5026);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (507, 5027);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (508, 5028);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (509, 5029);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (510, 5030);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (511, 5031);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (512, 5032);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (513, 5033);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (514, 5034);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (515, 5035);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (516, 5036);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (517, 5037);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (518, 5038);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (519, 5039);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (520, 5000);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (521, 5001);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (522, 5002);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (523, 5003);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (524, 5004);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (525, 5005);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (526, 5006);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (527, 5007);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (528, 5008);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (529, 5009);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (530, 5010);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (531, 5011);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (532, 5012);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (533, 5013);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (534, 5014);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (535, 5015);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (536, 5016);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (537, 5017);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (538, 5018);
INSERT INTO examen_preguntas (id_examen, id_pregunta) VALUES (539, 5019);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10020, 500, 9.37, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10021, 501, 7.06, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10022, 502, 9.59, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10023, 503, 7.42, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10024, 504, 8.82, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10025, 505, 4.36, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10026, 506, 4.12, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10027, 507, 4.67, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10028, 508, 6.93, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10029, 509, 8.27, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10030, 510, 4.04, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10031, 511, 5.7, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10032, 512, 6.25, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10033, 513, 8.14, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10034, 514, 7.83, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10035, 515, 6.71, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10036, 516, 6.7, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10037, 517, 9.35, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10038, 518, 9.58, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10039, 519, 6.68, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10000, 520, 5.4, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10001, 521, 8.03, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10002, 522, 9.01, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10003, 523, 4.2, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10004, 524, 9.83, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10005, 525, 4.18, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10006, 526, 9.51, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10007, 527, 9.33, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10008, 528, 9.39, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10009, 529, 3.87, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10010, 530, 8.23, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10011, 531, 5.88, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10012, 532, 7.55, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10013, 533, 6.02, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10014, 534, 4.09, 0);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10015, 535, 9.69, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10016, 536, 8.48, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10017, 537, 7.59, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10018, 538, 9.95, 1);
INSERT INTO examenes_realizados (id_usuario, id_examen, nota, aprobado) VALUES (10019, 539, 9.22, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10020, 500, 5020, 10020, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10021, 501, 5021, 10021, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10022, 502, 5022, 10022, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10023, 503, 5023, 10023, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10024, 504, 5024, 10024, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10025, 505, 5025, 10025, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10026, 506, 5026, 10026, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10027, 507, 5027, 10027, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10028, 508, 5028, 10028, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10029, 509, 5029, 10029, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10030, 510, 5030, 10030, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10031, 511, 5031, 10031, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10032, 512, 5032, 10032, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10033, 513, 5033, 10033, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10034, 514, 5034, 10034, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10035, 515, 5035, 10035, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10036, 516, 5036, 10036, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10037, 517, 5037, 10037, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10038, 518, 5038, 10038, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10039, 519, 5039, 10039, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10000, 520, 5000, 10040, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10001, 521, 5001, 10041, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10002, 522, 5002, 10042, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10003, 523, 5003, 10043, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10004, 524, 5004, 10044, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10005, 525, 5005, 10045, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10006, 526, 5006, 10046, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10007, 527, 5007, 10047, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10008, 528, 5008, 10048, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10009, 529, 5009, 10049, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10010, 530, 5010, 10050, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10011, 531, 5011, 10051, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10012, 532, 5012, 10052, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10013, 533, 5013, 10053, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10014, 534, 5014, 10054, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10015, 535, 5015, 10055, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10016, 536, 5016, 10056, 1);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10017, 537, 5017, 10057, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10018, 538, 5018, 10058, 0);
INSERT INTO respondidas (id_usuario, id_examen, id_pregunta, respuesta_id, es_correcta) VALUES (10019, 539, 5019, 10059, 0);
