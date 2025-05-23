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
    contraseña CHAR(60) NOT NULL,
    fecha_nacimiento date,
    telefono varchar(100),
    foto_perfil LONGBLOB,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo boolean
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
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);

DROP TABLE IF EXISTS respuestas;
-- Creación de la tabla preguntas
CREATE TABLE IF NOT EXISTS respuestas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta int,
    nombre VARCHAR(255) NOT NULL,
    esCorrecta boolean,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id)
);


DROP TABLE IF EXISTS respondidas;
-- Creación de la tabla preguntas
CREATE TABLE IF NOT EXISTS respondidas (
    id_usuario int,
    id_pregunta int,
    mostrada int,
    correcta int,
    fallada int,
    PRIMARY KEY (id_usuario, id_pregunta),
    FOREIGN key (id_usuario) REFERENCES usuarios(id),
    FOREIGN key (id_pregunta) REFERENCES preguntas(id)
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