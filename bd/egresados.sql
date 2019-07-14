-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-07-2019 a las 10:41:55
-- Versión del servidor: 10.1.40-MariaDB
-- Versión de PHP: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `egresados`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividadeconomica`
--

CREATE TABLE `actividadeconomica` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `actividadeconomica`
--

INSERT INTO `actividadeconomica` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Mineria', 'Actividad economica del sector primario representada por la explotacion o extraccion de los minerales que se han acumulado en el suelo y subsuelo en forma de yacimientos.', 0),
(2, 'Pesca', 'Actividad que se realiza para extraer peces. Puede realizarse en aguas continentales o maritimas.', 0),
(3, 'Ganaderia', 'Actividad economica de origen muy antiguo que consiste en el manejo y explotacion de animales domesticables con fines de produccion, para su aprovechamiento.', 0),
(4, 'Industria', 'Actividad que tiene como finalidad de transformar las materias primas en productos elaborados o semielaborados utilizando una fuente de energia.', 0),
(5, 'Agricultura', 'Conjunto de tecnicas, conocimientos y saberes para cultivar la tierra y la parte del sector primario que se dedica a ello. En ella se engloban los diferentes trabajos de tratamiento del suelo y los cultivos de vegetales.', 0),
(6, 'Turismo', 'Actividad que realizan las personas durante sus viajes y estancias en lugares distintos a su entorno habitual durante un periodo de tiempo inferior a un ano, con fines de ocio, negocios u otros', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividadeconomica`
--
ALTER TABLE `actividadeconomica`
  ADD PRIMARY KEY (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividadeconomica`
--
ALTER TABLE `actividadeconomica`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
