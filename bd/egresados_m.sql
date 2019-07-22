-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-07-2019 a las 11:08:54
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.3

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
(1, 'Mineria', 'Actividad econÃ³mica del sector primario representada por la explotaciÃ³n o extracciÃ³n de los minerales.', 1),
(2, 'Pesca', 'Actividad que se realiza para extraer peces. Puede realizarse en aguas continentales o mar&iacute;timas.', 1),
(3, 'Ganaderia', 'Actividad econÃ³mica que consiste en el manejo y explotaciÃ³n de animales domesticables.', 1),
(4, 'Industria', 'Actividad que tiene como finalidad transformar las materias primas en productos elaborados o semielaborados.', 1),
(5, 'Agricultura', 'Conjunto de tÃ©cnicas, conocimientos y saberes para cultivar la tierra y la parte del sector primario que se dedica a ello.', 1),
(6, 'Turismo', 'Actividad que realizan las personas durante sus viajes y estancias en lugares distintos a su entorno habitual durante un periodo de tiempo inferior a un ano, con fines de ocio, negocios u otros', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admision`
--

CREATE TABLE `admision` (
  `codigo` int(11) NOT NULL,
  `codigoEscuela` int(11) NOT NULL,
  `fechaAdmision` date NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `codigoModalidad` int(11) NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `admision`
--

INSERT INTO `admision` (`codigo`, `codigoEscuela`, `fechaAdmision`, `nombre`, `codigoModalidad`, `vigencia`) VALUES
(1, 1, '2016-04-24', '2016-I', 1, 1),
(2, 1, '2016-07-12', '2016-II', 1, 1),
(3, 1, '2016-04-17', '2016-I', 3, 1),
(4, 1, '2015-12-20', '2016-I', 4, 1),
(5, 4, '2016-07-08', '2016-II', 1, 1),
(6, 6, '2019-07-20', '2019-II', 3, 1),
(7, 7, '2019-07-22', '2019-II', 1, 1),
(8, 8, '2019-07-22', '2019-II', 3, 1),
(9, 2, '2019-07-22', '2019-III', 1, 1),
(10, 9, '2019-07-22', '2019-II', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centroestudios`
--

CREATE TABLE `centroestudios` (
  `codigo` int(11) NOT NULL,
  `razonSocial` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `centroestudios`
--

INSERT INTO `centroestudios` (`codigo`, `razonSocial`, `vigencia`) VALUES
(1, 'CETI', 1),
(2, 'SENATI', 1),
(3, 'EIGER', 1),
(4, 'CERTUS', 1),
(5, 'EDUSOL', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centrolaboral`
--

CREATE TABLE `centrolaboral` (
  `codigo` int(11) NOT NULL,
  `codigoActividad` int(11) NOT NULL,
  `codigoDistrito` int(11) NOT NULL,
  `RUC` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `razonSocial` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `centrolaboral`
--

INSERT INTO `centrolaboral` (`codigo`, `codigoActividad`, `codigoDistrito`, `RUC`, `razonSocial`, `vigencia`) VALUES
(1, 1, 14, '78293462364283423523', 'Catamarca', 1),
(2, 3, 3, '24343657654756867867', 'Gloria', 1),
(3, 2, 2, '97239423524654456743', 'El Muelle', 1),
(4, 6, 8, '28974982365237469342', 'AirTour', 1),
(5, 4, 1, '3534645745671235346', 'Coolbox', 1),
(6, 5, 11, '24365869543534564572', 'Natura', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colegiatura`
--

CREATE TABLE `colegiatura` (
  `codigoEgresado` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `colegiatura`
--

INSERT INTO `colegiatura` (`codigoEgresado`, `codigo`, `fecha`, `vigencia`) VALUES
(1, 2021010001, '2021-04-21', 1),
(2, 20210, '2021-04-21', 1),
(3, 2021010003, '2021-04-21', 1),
(4, 2021010004, '2021-04-21', 1),
(5, 2021010005, '2021-04-21', 1),
(8, 0, '2019-07-01', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

CREATE TABLE `contrato` (
  `codigo` int(11) NOT NULL,
  `codigoEgresado` int(11) NOT NULL,
  `codigoCentroLaboral` int(11) NOT NULL,
  `cargo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `detalleFunciones` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `contrato`
--

INSERT INTO `contrato` (`codigo`, `codigoEgresado`, `codigoCentroLaboral`, `cargo`, `fechaInicio`, `fechaTermino`, `detalleFunciones`, `vigencia`) VALUES
(1, 1, 1, 'Jefe de GestiÃ³n', '2018-04-02', '2019-01-31', 'Gestiona que todos los departamentos realicen sus actividades de manera correcta y eficiente.', 1),
(2, 7, 4, 'Jefe de DiseÃ±o ', '2018-01-01', '2019-06-30', 'Responsable de definir el enfoque estratÃ©gico, de precisar el planteamiento tÃ¡ctico y operativo del diseÃ±o del producto, servicio o sistema.', 1),
(4, 3, 6, 'Programador Web', '2018-12-03', '2019-12-31', 'Desarrollador de software, crea y realiza mantenimiento a pÃ¡ginas y aplicaciones web.', 1),
(5, 1, 5, 'Network Marketing', '2019-01-01', '2020-01-01', 'Distribuidor de productos y servicios a traves de una Red de comercializaciÃ³n.', 1),
(6, 1, 3, 'Creador de videojuegos', '2018-10-15', '2020-02-14', 'Desarrollador de software que crea exclusivamente videojuegos, como los RPG, FPS, etc.', 1),
(11, 2, 3, 'sdadf', '0000-00-00', '0000-00-00', 'sdfsdf', 1),
(12, 9, 3, '', '2019-07-09', '2019-07-10', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`codigo`, `nombre`, `vigencia`) VALUES
(1, 'Lambayeque', 0),
(2, 'Piura', 0),
(3, 'La Libertad', 0),
(4, 'Lima', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE `distrito` (
  `codigo` int(11) NOT NULL,
  `codigoProvincia` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `distrito`
--

INSERT INTO `distrito` (`codigo`, `codigoProvincia`, `nombre`, `vigencia`) VALUES
(1, 1, 'Chiclayo', 1),
(2, 1, 'Pimentel', 1),
(3, 2, 'FerreÃ±afe', 1),
(4, 3, 'MÃ³rrope', 1),
(5, 3, 'Lambayeque', 1),
(6, 6, 'Rioja', 1),
(7, 6, 'Miraflores', 1),
(8, 6, 'Surco', 1),
(9, 6, 'La Victoria', 1),
(10, 4, 'Talara', 1),
(11, 4, 'Sullana', 1),
(12, 5, 'ChepÃ©n', 1),
(13, 5, 'Pacasmayo', 1),
(14, 2, 'Incahuasi', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresado`
--

CREATE TABLE `egresado` (
  `codigo` int(11) NOT NULL,
  `codigoEscuela` int(11) NOT NULL,
  `codigoPersona` int(11) NOT NULL,
  `codigoAdmision` int(11) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `egresado`
--

INSERT INTO `egresado` (`codigo`, `codigoEscuela`, `codigoPersona`, `codigoAdmision`, `fechaInicio`, `fechaTermino`, `vigencia`) VALUES
(1, 1, 169027, 4, '2016-04-25', '2020-12-20', 1),
(2, 1, 169025, 4, '2016-04-25', '2020-12-20', 1),
(3, 1, 165058, 3, '2016-04-25', '2020-12-20', 1),
(4, 2, 169027, 2, '2016-04-25', '2020-12-20', 1),
(5, 1, 160012, 3, '2016-04-25', '2020-12-20', 1),
(6, 3, 169027, 1, '2019-07-01', '2019-07-04', 1),
(7, 4, 169025, 5, '2019-07-01', '2019-07-08', 1),
(8, 6, 169025, 6, '2019-07-04', '2019-07-20', 1),
(9, 7, 169025, 7, '2019-02-05', '2019-07-08', 1),
(10, 8, 169025, 8, '2019-07-22', '2019-07-22', 1),
(11, 2, 169025, 9, '2019-07-22', '2019-07-22', 1),
(12, 9, 169025, 10, '2019-07-22', '2019-07-22', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuelaprofesional`
--

CREATE TABLE `escuelaprofesional` (
  `codigo` int(11) NOT NULL,
  `codigoFacultad` int(11) DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `siglas` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `codigoUniversidad` int(11) DEFAULT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `escuelaprofesional`
--

INSERT INTO `escuelaprofesional` (`codigo`, `codigoFacultad`, `nombre`, `siglas`, `estado`, `codigoUniversidad`, `vigencia`) VALUES
(1, NULL, 'Escuela Profesional de IngenierÃ­a en ComputaciÃ³n e InformÃ¡tica', 'EPICI', 1, 1, 1),
(2, NULL, 'Escuela Profesional de Estadistica', 'EPE', 1, 4, 1),
(3, 2, 'Escuela Profesional de MecÃ¡nica ElÃ©ctrica', 'FIME', 1, 5, 1),
(4, NULL, 'Escuela Profesional de Enfermeria', 'EPEN', 1, 1, 1),
(5, 1, 'Escuela Profesional de Ingenieria Agricola', 'EPIA', 1, 5, 1),
(6, NULL, 'Escuela de la Mogrovejo', '', 1, 3, 1),
(7, NULL, 'Escuela de Sistemas de Chota', '', 1, 6, 1),
(8, NULL, 'Escuela de Computacion', '', 1, 6, 1),
(9, NULL, 'Escuela de artes plasticas', '', 1, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiospostgrado`
--

CREATE TABLE `estudiospostgrado` (
  `codigo` int(11) NOT NULL,
  `codigoEgresado` int(11) NOT NULL,
  `codigoTipo` int(11) NOT NULL,
  `codigoUniversidad` int(11) DEFAULT NULL,
  `codigoCentroEstudios` int(11) DEFAULT NULL,
  `nombre` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `anioCertificacion` year(4) DEFAULT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `estudiospostgrado`
--

INSERT INTO `estudiospostgrado` (`codigo`, `codigoEgresado`, `codigoTipo`, `codigoUniversidad`, `codigoCentroEstudios`, `nombre`, `fechaInicio`, `fechaTermino`, `anioCertificacion`, `vigencia`) VALUES
(1, 1, 3, 1, NULL, 'ImplementaciÃ³n de drones', '2015-04-06', '2018-12-21', NULL, 1),
(2, 4, 4, NULL, 2, 'Seguridad InformÃ¡tica', '2018-04-02', '2018-12-14', NULL, 1),
(3, 5, 1, NULL, 5, 'Cloud Computing ', '2017-08-07', '2018-08-31', NULL, 1),
(4, 7, 2, NULL, 1, 'DiseÃ±o y Desarrollo de Videojuegos', '2017-12-22', '2019-04-26', NULL, 1),
(6, 7, 4, NULL, 4, 'Inyectables 1', '2019-07-01', '2019-07-09', 2019, 1),
(7, 1, 1, NULL, 2, 'Postgrado de prueba 1', '2019-07-10', '2019-07-17', 2018, 1),
(8, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(9, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(10, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(11, 4, 6, NULL, 3, 'Inglish Avanzao p', '2019-07-16', '2019-07-17', 2019, 1),
(12, 4, 6, NULL, 3, 'Inglish Avanzao p', '2019-07-16', '2019-07-17', 2019, 1),
(13, 1, 2, 6, NULL, '', '2019-07-17', '2019-07-17', 0000, 1),
(14, 4, 2, 10, NULL, '', '2019-07-18', '2019-07-18', 2019, 1),
(15, 8, 4, NULL, 4, 'Curso ambiental', '2019-07-01', '2019-07-17', 2015, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facultad`
--

CREATE TABLE `facultad` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `siglas` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`codigo`, `nombre`, `siglas`, `estado`, `vigencia`) VALUES
(1, 'Facultad de Ciencias Fisicas y MatemÃ¡ticas', 'FACFYM', 1, 1),
(2, 'Facultad de MecÃ¡nica ElÃ©ctrica', 'FIME', 1, 1),
(3, 'Facultad de Enfermeria', 'FE', 1, 1),
(4, 'Facultad de Agronomia', 'FAG', 1, 1),
(5, 'Facultad de Ingenieria Agricola', 'FIA', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modalidadadmision`
--

CREATE TABLE `modalidadadmision` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(22) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modalidadadmision`
--

INSERT INTO `modalidadadmision` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Ordinario', 'Examen de admisiÃ³n para cualquier postulante que haya culminado el colegio.', 1),
(2, 'Extraordinario', 'Examen de admisiÃ³n para alumnos de quinto aÃ±o del colegio.', 1),
(3, 'Centro PRE', 'Examen de admisiÃ³n para chicos que ya han culminado el colegio y estan en academia.', 1),
(4, 'Exonerados', 'Examen de admisiÃ³n para chicos que ocuparon los primeros puestos en su etapa acadÃ©mica.', 1),
(5, 'Casos Especiales', 'Examen de admisiÃ³n para chicos con alguna discapacidad.', 1),
(6, 'Deportista Calificado', 'Examen de admisiÃ³n para chicos que destacan en algun deporte.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modalidadtitulacion`
--

CREATE TABLE `modalidadtitulacion` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modalidadtitulacion`
--

INSERT INTO `modalidadtitulacion` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Experiencia Profesional', 'Esta modalidad es vÃ¡lida para aquellos egresados que estan o hayan desarrollado actividad profesional. ', 1),
(2, 'Tesis', 'Esta modalidad es vÃ¡lida para los estudiantes y egresados sin restricciÃ³n del tiempo de egreso. ', 1),
(3, 'Clase Modelo', 'Es una plantilla para la creaciÃ³n de objetos de datos segÃºn un modelo predefinido.', 1),
(4, 'Curso', 'Proceso o serie de estados por los que pasa una acciÃ³n, un asunto, etc.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `codigo` int(11) NOT NULL,
  `nombres` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `apellidoMaterno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `apellidoPaterno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `genero` tinyint(1) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `celular` char(9) COLLATE utf8_unicode_ci NOT NULL,
  `correo` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `dni` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `estadoCivil` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `urlFoto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`codigo`, `nombres`, `apellidoMaterno`, `apellidoPaterno`, `genero`, `fechaNacimiento`, `celular`, `correo`, `dni`, `estadoCivil`, `vigencia`, `urlFoto`) VALUES
(160012, 'Christian Robert', 'Flores', 'Torres', 0, '1998-12-10', '98534656', 'cflores@unprg.edu.pe', '65734654', 'V', 1, 0),
(165032, 'David', 'Paz', 'Rioja', 1, '1999-07-13', '93523622', 'drioja@unprg.edu.pe', '74575683', '1', 0, 0),
(165058, 'Marcelo', 'Villar', 'VelÃ¡squez', 1, '1999-02-18', '974657567', 'mvelasquez@unprg.edu.pe', '74813707', 'S', 1, 0),
(169025, 'Javier Arturo', 'Sialer', 'ChÃ¡vez', 1, '1999-06-12', '949912973', 'achavez@unprg.edu.pe', '70505538', 'C', 1, 0),
(169027, 'Fabian Andres', 'Bautista', 'Pacherres', 0, '1998-12-13', '953172725', 'fpacherres@gmail.com', '73860228', 'S', 1, 0),
(169028, 'Joan Bruno JesÃºs', 'Sandoval', 'SipiÃ³n', 0, '1997-09-17', '743291840', 'nglife@unprg.edu.pe', '16462834', 'S', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `codigo` int(11) NOT NULL,
  `apellidoPaterno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `apellidoMaterno` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `dni` char(8) COLLATE utf8_unicode_ci NOT NULL,
  `genero` tinyint(1) NOT NULL,
  `correo` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `celular` char(9) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `nombres` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `urlFoto` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`codigo`, `apellidoPaterno`, `apellidoMaterno`, `dni`, `genero`, `correo`, `celular`, `vigencia`, `nombres`, `urlFoto`) VALUES
(1, 'Portocarrero', 'Rojas', '76867943', 1, 'portocarrero_rojas@unprg.edu.pe', '983297423', 1, 'Jose Eduardo', ''),
(2, 'Espejo', 'Cornejo', '78453245', 1, 'espejo_cornejo@unprg.edu.pe', '989345346', 1, 'Alejandro Miguel', ''),
(3, 'Montes', 'Eslava', '97942442', 1, 'montes_eslava@unprg.edu.pe', '973435645', 1, 'Oscar', ''),
(4, 'Alamo', 'Rioja', '56235222', 1, 'alamo_rioja@unprg.edu.pe', '934151121', 1, 'Jordi Erick', ''),
(5, 'Supo', 'Chumpen', '84523132', 1, 'supo_chumpen@unprg.edu.pe', '983423512', 1, 'Marco Antonio', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE `provincia` (
  `codigo` int(11) NOT NULL,
  `codigoDepartamento` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`codigo`, `codigoDepartamento`, `nombre`, `vigencia`) VALUES
(1, 1, 'Chiclayo', 0),
(2, 1, 'FerreÃ±afe', 0),
(3, 1, 'Lambayeque', 0),
(4, 2, 'Piura', 0),
(5, 3, 'Trujillo', 0),
(6, 4, 'Lima', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoestudiopostgrado`
--

CREATE TABLE `tipoestudiopostgrado` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipoestudiopostgrado`
--

INSERT INTO `tipoestudiopostgrado` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Curso', 'Cursos de corta duraciÃ³n para conocer mejor un nuevo Ã¡mbito espec&iacute;fico.', 1),
(2, 'Diplomado', 'Curso de corta o mediana duraciÃ³n.', 1),
(3, 'Doctorado', 'Es la mÃ¡xima formaciÃ³n acadÃ©mica a la que se puede optar.', 1),
(4, 'Segunda Especialidad', 'FormaciÃ³n de investigadores, docentes universitarios y especialistas.', 1),
(5, 'Maestria', 'Grado acadÃ©mico de postgrado que se consigue al completar un programa de uno a dos aÃ±os.', 1),
(6, 'Idioma', 'Dominio de un idioma extranjero. ', 1),
(7, 'Certificacion', 'Procedimiento destinado a que un organismo dictamine la calidad del sistema aplicado.', 1),
(8, 'Taller', 'Espacio en el que se realiza un trabajo.​', 1),
(9, 'Ponencia', 'ExposiciÃ³n por parte de alguien que da algunas ideas.', 1),
(10, 'Congreso', 'Reunion o conferencia, generalmente periÃ³dica en donde se comparte conocimiento.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulacion`
--

CREATE TABLE `titulacion` (
  `codigoEgresado` int(11) NOT NULL,
  `codigoModalidad` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `titulacion`
--

INSERT INTO `titulacion` (`codigoEgresado`, `codigoModalidad`, `fecha`, `vigencia`) VALUES
(1, 2, '2021-04-21', 1),
(2, 2, '2021-04-21', 1),
(3, 1, '2021-04-21', 1),
(4, 1, '2021-04-21', 1),
(5, 2, '2021-04-21', 1),
(7, 2, '2019-07-03', 1),
(8, 4, '2010-02-18', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `universidad`
--

CREATE TABLE `universidad` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `siglas` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `universidad`
--

INSERT INTO `universidad` (`codigo`, `nombre`, `siglas`, `estado`, `vigencia`) VALUES
(1, 'Universidad Nacional de Trujillo', 'UNAT', 0, 1),
(2, 'Universidad de Piura', 'UDEP', 1, 0),
(3, 'Universidad Santo Toribio de Mogrovejo', 'USATAA', 0, 1),
(4, 'Universidad San MartÃ­n de Porres', 'USMAA', 0, 1),
(5, 'Universidad Nacional Pedro Ruiz Gallo', 'UNPRG', 1, 1),
(6, 'Universidad de Chota', 'UNDCH', 1, 1),
(7, 'Universidad Nacional de IngenierÃ­a', 'UNAI', 1, 1),
(8, 'Universidad Agraria', 'UAGR', 1, 1),
(9, 'Universidad de la vida', 'UDLV', 1, 1),
(10, 'Universidad de Prueba', 'UDP', 1, 1),
(11, 'Otra U de prueba', 'PRUEBITA', 1, 1),
(12, 'Universidad CatÃ³lica del Norte', 'UCDN', 1, 0),
(13, 'Universidad CatÃ³lica del Sur', 'UCDS', 1, 1),
(14, 'Universidad Vacia', 'UNVCA', 1, 0),
(15, 'Universidad CMTREEEEEEEEE', 'ASD', 1, 0),
(16, '', '', 1, 0),
(17, '', '', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `codigo` int(11) NOT NULL,
  `codigoPersonal` int(11) DEFAULT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(90) COLLATE utf8_unicode_ci NOT NULL,
  `tipo` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `codigoPersona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`codigo`, `codigoPersonal`, `nombre`, `clave`, `tipo`, `vigencia`, `codigoPersona`) VALUES
(4, 1, 'Pocarr', '123', 'P', 1, NULL),
(5, NULL, 'Javcho', '$2y$10$xlweEJXuWsyhyZyTW8Ow4.pemBIA9xmXH741XuDv9T531uSgYt6re', 'E', 1, 169025),
(6, 2, 'EspCor1', '987', 'P', 1, NULL),
(7, 4, 'AlaRioja', '741', 'P', 1, NULL),
(8, NULL, 'DavidR', '258', 'E', 0, 165032),
(9, NULL, 'MarckTone', '369', 'E', 1, 165058),
(10, 2, 'FXLR16', '$2y$10$aaZ2KJ3qZLLZFY4Qe2tq/.u9ZPhCB5iZlQC/SrEoqQ3EZIXdoo.Y.', 'A', 1, NULL),
(11, NULL, 'nglife', '$2y$10$XvlYUqtMh8/8q6QG00he0uh/eM0I4ZFRcADu5rl.E7YOmT7MJob.G', 'E', 0, 169028);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividadeconomica`
--
ALTER TABLE `actividadeconomica`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `admision`
--
ALTER TABLE `admision`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoEscuela` (`codigoEscuela`),
  ADD KEY `codigoModalidad` (`codigoModalidad`);

--
-- Indices de la tabla `centroestudios`
--
ALTER TABLE `centroestudios`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `centrolaboral`
--
ALTER TABLE `centrolaboral`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoDistrito` (`codigoDistrito`),
  ADD KEY `codigoActividad` (`codigoActividad`);

--
-- Indices de la tabla `colegiatura`
--
ALTER TABLE `colegiatura`
  ADD PRIMARY KEY (`codigoEgresado`);

--
-- Indices de la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoEgresado` (`codigoEgresado`),
  ADD KEY `codigoCentroLaboral` (`codigoCentroLaboral`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoProvincia` (`codigoProvincia`);

--
-- Indices de la tabla `egresado`
--
ALTER TABLE `egresado`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoEscuela` (`codigoEscuela`),
  ADD KEY `codigoPersona` (`codigoPersona`),
  ADD KEY `codigoAdmision` (`codigoAdmision`);

--
-- Indices de la tabla `escuelaprofesional`
--
ALTER TABLE `escuelaprofesional`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoFacultad` (`codigoFacultad`),
  ADD KEY `codigoUniversidad` (`codigoUniversidad`);

--
-- Indices de la tabla `estudiospostgrado`
--
ALTER TABLE `estudiospostgrado`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoEgresado` (`codigoEgresado`),
  ADD KEY `codigoTipo` (`codigoTipo`),
  ADD KEY `codigoUniversidad` (`codigoUniversidad`),
  ADD KEY `codigoCentroEstudios` (`codigoCentroEstudios`);

--
-- Indices de la tabla `facultad`
--
ALTER TABLE `facultad`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `modalidadadmision`
--
ALTER TABLE `modalidadadmision`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `modalidadtitulacion`
--
ALTER TABLE `modalidadtitulacion`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoDepartamento` (`codigoDepartamento`);

--
-- Indices de la tabla `tipoestudiopostgrado`
--
ALTER TABLE `tipoestudiopostgrado`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  ADD PRIMARY KEY (`codigoEgresado`),
  ADD KEY `codigoModalidad` (`codigoModalidad`);

--
-- Indices de la tabla `universidad`
--
ALTER TABLE `universidad`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `codigoPersonal` (`codigoPersonal`),
  ADD KEY `codigoPersona` (`codigoPersona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividadeconomica`
--
ALTER TABLE `actividadeconomica`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `admision`
--
ALTER TABLE `admision`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `centroestudios`
--
ALTER TABLE `centroestudios`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `centrolaboral`
--
ALTER TABLE `centrolaboral`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `colegiatura`
--
ALTER TABLE `colegiatura`
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `contrato`
--
ALTER TABLE `contrato`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `distrito`
--
ALTER TABLE `distrito`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `egresado`
--
ALTER TABLE `egresado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `escuelaprofesional`
--
ALTER TABLE `escuelaprofesional`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `estudiospostgrado`
--
ALTER TABLE `estudiospostgrado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `facultad`
--
ALTER TABLE `facultad`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `modalidadadmision`
--
ALTER TABLE `modalidadadmision`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `modalidadtitulacion`
--
ALTER TABLE `modalidadtitulacion`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169029;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `provincia`
--
ALTER TABLE `provincia`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipoestudiopostgrado`
--
ALTER TABLE `tipoestudiopostgrado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admision`
--
ALTER TABLE `admision`
  ADD CONSTRAINT `admision_ibfk_1` FOREIGN KEY (`codigoEscuela`) REFERENCES `escuelaprofesional` (`codigo`),
  ADD CONSTRAINT `admision_ibfk_2` FOREIGN KEY (`codigoModalidad`) REFERENCES `modalidadadmision` (`codigo`);

--
-- Filtros para la tabla `centrolaboral`
--
ALTER TABLE `centrolaboral`
  ADD CONSTRAINT `centrolaboral_ibfk_1` FOREIGN KEY (`codigoDistrito`) REFERENCES `distrito` (`codigo`),
  ADD CONSTRAINT `centrolaboral_ibfk_2` FOREIGN KEY (`codigoActividad`) REFERENCES `actividadeconomica` (`codigo`);

--
-- Filtros para la tabla `colegiatura`
--
ALTER TABLE `colegiatura`
  ADD CONSTRAINT `colegiatura_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `titulacion` (`codigoEgresado`);

--
-- Filtros para la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `contrato_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`),
  ADD CONSTRAINT `contrato_ibfk_2` FOREIGN KEY (`codigoCentroLaboral`) REFERENCES `centrolaboral` (`codigo`);

--
-- Filtros para la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD CONSTRAINT `distrito_ibfk_1` FOREIGN KEY (`codigoProvincia`) REFERENCES `provincia` (`codigo`);

--
-- Filtros para la tabla `egresado`
--
ALTER TABLE `egresado`
  ADD CONSTRAINT `egresado_ibfk_1` FOREIGN KEY (`codigoEscuela`) REFERENCES `escuelaprofesional` (`codigo`),
  ADD CONSTRAINT `egresado_ibfk_2` FOREIGN KEY (`codigoPersona`) REFERENCES `persona` (`codigo`),
  ADD CONSTRAINT `egresado_ibfk_3` FOREIGN KEY (`codigoAdmision`) REFERENCES `admision` (`codigo`);

--
-- Filtros para la tabla `escuelaprofesional`
--
ALTER TABLE `escuelaprofesional`
  ADD CONSTRAINT `escuelaprofesional_ibfk_1` FOREIGN KEY (`codigoFacultad`) REFERENCES `facultad` (`codigo`),
  ADD CONSTRAINT `escuelaprofesional_ibfk_2` FOREIGN KEY (`codigoUniversidad`) REFERENCES `universidad` (`codigo`);

--
-- Filtros para la tabla `estudiospostgrado`
--
ALTER TABLE `estudiospostgrado`
  ADD CONSTRAINT `estudiospostgrado_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`),
  ADD CONSTRAINT `estudiospostgrado_ibfk_2` FOREIGN KEY (`codigoTipo`) REFERENCES `tipoestudiopostgrado` (`codigo`),
  ADD CONSTRAINT `estudiospostgrado_ibfk_3` FOREIGN KEY (`codigoUniversidad`) REFERENCES `universidad` (`codigo`),
  ADD CONSTRAINT `estudiospostgrado_ibfk_4` FOREIGN KEY (`codigoCentroEstudios`) REFERENCES `centroestudios` (`codigo`);

--
-- Filtros para la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD CONSTRAINT `provincia_ibfk_1` FOREIGN KEY (`codigoDepartamento`) REFERENCES `departamento` (`codigo`);

--
-- Filtros para la tabla `titulacion`
--
ALTER TABLE `titulacion`
  ADD CONSTRAINT `titulacion_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`),
  ADD CONSTRAINT `titulacion_ibfk_2` FOREIGN KEY (`codigoModalidad`) REFERENCES `modalidadtitulacion` (`codigo`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`codigoPersonal`) REFERENCES `personal` (`codigo`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`codigoPersona`) REFERENCES `persona` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
