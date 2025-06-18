-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-06-2025 a las 16:39:51
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tester`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(1, 'Bash'),
(2, 'Mysql'),
(3, 'IPv6'),
(4, 'Redes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases`
--

CREATE TABLE `clases` (
  `id_clase` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clases`
--

INSERT INTO `clases` (`id_clase`, `nombre`, `codigo`, `id_usuario`, `id_categoria`, `fecha_creacion`) VALUES
(1, 'fran', 'ZP3MSU', 5, 1, '2025-06-15 16:28:03'),
(2, 'clasedos', 'PDDDL2', 5, 4, '2025-06-15 18:04:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases_asignadas`
--

CREATE TABLE `clases_asignadas` (
  `id` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `fecha_asignacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clases_asignadas`
--

INSERT INTO `clases_asignadas` (`id`, `id_clase`, `id_alumno`, `fecha_asignacion`) VALUES
(1, 2, 6, '2025-06-15 18:16:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes`
--

CREATE TABLE `examenes` (
  `id_examen` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_clase` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `examenes`
--

INSERT INTO `examenes` (`id_examen`, `nombre`, `id_categoria`, `id_clase`, `fecha_creacion`) VALUES
(2, 'dasdasd', 1, 1, '2025-06-15 16:28:22'),
(3, 'yeaa', 1, 1, '2025-06-15 16:29:45'),
(4, 'araere', 1, 1, '2025-06-15 18:03:15'),
(5, 'esteexamennuevo', 3, 1, '2025-06-15 18:03:41'),
(6, 'nuevotest', 2, 2, '2025-06-15 18:04:26'),
(7, 'xaaaa', 3, 2, '2025-06-15 22:25:30'),
(8, 'Untest Nuevo', 3, 2, '2025-06-16 13:32:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_realizados`
--

CREATE TABLE `examenes_realizados` (
  `id_usuario` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  `nota` decimal(5,2) DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `examenes_realizados`
--

INSERT INTO `examenes_realizados` (`id_usuario`, `id_examen`, `nota`, `aprobado`, `fecha`) VALUES
(6, 2, 100.00, 1, '2025-06-15 19:22:16'),
(6, 3, 100.00, 1, '2025-06-15 19:17:19'),
(6, 4, 100.00, 1, '2025-06-15 19:22:54'),
(6, 5, 0.00, 0, '2025-06-15 19:20:09'),
(7, 6, 100.00, 1, '2025-06-16 14:18:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen_preguntas`
--

CREATE TABLE `examen_preguntas` (
  `id` int(11) NOT NULL,
  `id_examen` int(11) DEFAULT NULL,
  `id_pregunta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `examen_preguntas`
--

INSERT INTO `examen_preguntas` (`id`, `id_examen`, `id_pregunta`) VALUES
(1, 2, 7),
(2, 3, 8),
(3, 4, 9),
(4, 5, 10),
(5, 6, 11),
(6, 7, 12),
(7, 8, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id`, `nombre`, `id_categoria`) VALUES
(1, 'echo [opciones] cadenas ¿Que resultado se obtiene con EJEMPLO: echo \"	Hola, ¿Qué tal?\"?', 1),
(2, '¿Como  creo un archivo vacio y lo ejecuto una distribucion linux?', 1),
(3, '¿Qué contiene la variable $? ?', 1),
(4, '¿Qué contiene la variable $$ ?', 1),
(5, '¿Qué contiene la variable $@ ?', 1),
(6, '¿Qué contiene la variable $* ?', 1),
(7, 'a', 1),
(8, 'este es bueno', 1),
(9, 'asdasd', 1),
(10, 'aedaed', 3),
(11, 'aeraeraer', 2),
(12, 'eres eres', 3),
(13, 'esta es no es', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respondidas`
--

CREATE TABLE `respondidas` (
  `id_usuario` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `respuesta_id` int(11) DEFAULT NULL,
  `es_correcta` tinyint(1) DEFAULT NULL,
  `fecha_respuesta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respondidas`
--

INSERT INTO `respondidas` (`id_usuario`, `id_examen`, `id_pregunta`, `respuesta_id`, `es_correcta`, `fecha_respuesta`) VALUES
(6, 2, 7, 33, 1, '2025-06-15 19:22:16'),
(6, 3, 8, 35, 1, '2025-06-15 19:17:19'),
(6, 4, 9, 37, 1, '2025-06-15 19:22:54'),
(6, 5, 10, 40, 0, '2025-06-15 19:20:09'),
(7, 6, 11, 41, 1, '2025-06-16 14:18:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `id_pregunta` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `esCorrecta` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `id_pregunta`, `nombre`, `esCorrecta`) VALUES
(1, 1, '	Hola, ¿Qué tal?', 1),
(2, 1, 'Hola, ¿Qué tal?', 0),
(3, 1, '      Hola, ¿Qué tal?', 0),
(4, 1, ' =>Hola, ¿Qué tal?', 0),
(5, 2, 'touch vacio.sh chmod 755 vacio.sh ./vacio.sh', 1),
(6, 2, 'gedit vacio.txt chmod 755 vacio.txt ./vacio.txt', 0),
(7, 2, 'gedit vacio.sh chmod 555 vacio.sh ./vacio.sh', 0),
(8, 2, 'gedit vacio.sh chmod 755 vacio.sh run vacio.sh', 0),
(9, 3, 'Estado de salida del último comando o script ejecutado.', 1),
(10, 3, 'El PID de la shell.', 0),
(11, 3, 'Los parámetros pasados al script.', 0),
(12, 3, 'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.', 0),
(13, 3, 'Corresponde a los primeros 9 parámetros con los que se llamó el script.', 0),
(14, 3, 'el nombre del script.', 0),
(15, 4, 'Estado de salida del último comando o script ejecutado.', 0),
(16, 4, 'El PID de la shell.', 1),
(17, 4, 'Los parámetros pasados al script.', 0),
(18, 4, 'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.', 0),
(19, 4, 'Corresponde a los primeros 9 parámetros con los que se llamó el script.', 0),
(20, 4, 'el nombre del script.', 0),
(21, 5, 'Estado de salida del último comando o script ejecutado.', 0),
(22, 5, 'El PID de la shell.', 0),
(23, 5, 'Los parámetros pasados al script.', 1),
(24, 5, 'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.', 0),
(25, 5, 'Corresponde a los primeros 9 parámetros con los que se llamó el script.', 0),
(26, 5, 'el nombre del script.', 0),
(27, 5, 'Estado de salida del último comando o script ejecutado.', 0),
(28, 5, 'El PID de la shell.', 0),
(29, 5, 'Los parámetros pasados al script.', 1),
(30, 5, 'Número de parámetros con los que se ha invocado el script. Es muy útil paracomprobar el número de argumentos pasados en la ejecución de un Shell script.', 0),
(31, 5, 'Corresponde a los primeros 9 parámetros con los que se llamó el script.', 0),
(32, 5, 'el nombre del script.', 0),
(33, 7, 's', 1),
(34, 7, 'c', 0),
(35, 8, 'este es clave', 1),
(36, 8, 'este no es clave', 0),
(37, 9, 'a', 1),
(38, 9, 'b', 0),
(39, 10, 'ead', 1),
(40, 10, 'asdd', 0),
(41, 11, 'aaaa', 1),
(42, 11, 'adad', 0),
(43, 12, 'a', 0),
(44, 12, 'c', 1),
(45, 13, 'aa', 1),
(46, 13, 'bb', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `rol` varchar(1) NOT NULL,
  `contraseña` char(60) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `foto_perfil` longblob DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `username`, `rol`, `contraseña`, `fecha_nacimiento`, `telefono`, `foto_perfil`, `fecha_registro`) VALUES
(1, 'Miguel', 'Ternero Algarín', 'miguelt', '', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', NULL, '2025-06-15 16:21:43'),
(2, 'María', 'RuiG', 'mariar', '', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', NULL, '2025-06-15 16:21:43'),
(3, 'Ronaldo', 'de Assis Moreira', 'Ronaldinho1', '', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', NULL, '2025-06-15 16:21:43'),
(4, 'Linda', 'Onotanto', 'officialLinda1', '', '$2a$10$DxvoLNDuQpgNbheGIRb7ZuKoJA91o24LllzbEGp4fpt.JFqLJ8QUC', '1985-10-20', '987654321', NULL, '2025-06-15 16:21:43'),
(5, 'fran', 'fran', 'fran', 'p', '$2a$10$dYx99R9EszRwMtEGwNcICejkboIaRV4zCGShE.zh3/a2y2yg3ROT.', '1993-12-10', '673224112', NULL, '2025-06-15 16:22:08'),
(6, 'test', 'test', 'test', 'a', '$2a$10$XehhInoSX2fR/aJRGlYGe.DFgfLaP6/Z26GBWltqzFWf2Uni5NTV2', '1993-12-10', '673224112', NULL, '2025-06-15 18:05:53'),
(7, 'test23', 'test23', 'test23', 'a', '$2a$10$fcONZZ9fyygoyFUawQ2Pf.5hNmAyU.vz53LexW7Y5LD0gdjTs.EgW', '2025-05-29', '673224112', NULL, '2025-06-15 18:43:24');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clases`
--
ALTER TABLE `clases`
  ADD PRIMARY KEY (`id_clase`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `clases_asignadas`
--
ALTER TABLE `clases_asignadas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_clase` (`id_clase`,`id_alumno`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD PRIMARY KEY (`id_examen`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_clase` (`id_clase`);

--
-- Indices de la tabla `examenes_realizados`
--
ALTER TABLE `examenes_realizados`
  ADD PRIMARY KEY (`id_usuario`,`id_examen`),
  ADD KEY `id_examen` (`id_examen`);

--
-- Indices de la tabla `examen_preguntas`
--
ALTER TABLE `examen_preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_examen` (`id_examen`),
  ADD KEY `id_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `respondidas`
--
ALTER TABLE `respondidas`
  ADD PRIMARY KEY (`id_usuario`,`id_examen`,`id_pregunta`),
  ADD KEY `id_examen` (`id_examen`),
  ADD KEY `id_pregunta` (`id_pregunta`),
  ADD KEY `respuesta_id` (`respuesta_id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clases`
--
ALTER TABLE `clases`
  MODIFY `id_clase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clases_asignadas`
--
ALTER TABLE `clases_asignadas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `examenes`
--
ALTER TABLE `examenes`
  MODIFY `id_examen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `examen_preguntas`
--
ALTER TABLE `examen_preguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clases`
--
ALTER TABLE `clases`
  ADD CONSTRAINT `clases_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `clases_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `clases_asignadas`
--
ALTER TABLE `clases_asignadas`
  ADD CONSTRAINT `clases_asignadas_ibfk_1` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`) ON DELETE CASCADE,
  ADD CONSTRAINT `clases_asignadas_ibfk_2` FOREIGN KEY (`id_alumno`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `examenes`
--
ALTER TABLE `examenes`
  ADD CONSTRAINT `examenes_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `examenes_ibfk_2` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`) ON DELETE CASCADE;

--
-- Filtros para la tabla `examenes_realizados`
--
ALTER TABLE `examenes_realizados`
  ADD CONSTRAINT `examenes_realizados_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `examenes_realizados_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `examenes` (`id_examen`);

--
-- Filtros para la tabla `examen_preguntas`
--
ALTER TABLE `examen_preguntas`
  ADD CONSTRAINT `examen_preguntas_ibfk_1` FOREIGN KEY (`id_examen`) REFERENCES `examenes` (`id_examen`) ON DELETE CASCADE,
  ADD CONSTRAINT `examen_preguntas_ibfk_2` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respondidas`
--
ALTER TABLE `respondidas`
  ADD CONSTRAINT `respondidas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `respondidas_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `examenes` (`id_examen`) ON DELETE CASCADE,
  ADD CONSTRAINT `respondidas_ibfk_3` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `respondidas_ibfk_4` FOREIGN KEY (`respuesta_id`) REFERENCES `respuestas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
