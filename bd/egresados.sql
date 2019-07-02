-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-07-2019 a las 07:20:51
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
-- Base de datos: `proyectofinal`
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
(1, 'Mineria', 'Actividad económica del sector primario representada por la explotación o extracción de los minerales que se han acumulado en el suelo y subsuelo en forma de yacimientos.', 0),
(2, 'Pesca', 'Actividad que se realiza para extraer peces. Puede realizarse en aguas continentales o marítimas.', 0),
(3, 'Ganaderia', 'Actividad económica de origen muy antiguo que consiste en el manejo y explotación de animales domesticables con fines de producción, para su aprovechamiento.', 0),
(4, 'Industria', 'Actividad que tiene como finalidad de transformar las materias primas en productos elaborados o semielaborados utilizando una fuente de energía.', 0),
(5, 'Agricultura', 'Conjunto de técnicas, conocimientos y saberes para cultivar la tierra y la parte del sector primario que se dedica a ello. En ella se engloban los diferentes trabajos de tratamiento del suelo y los cultivos de vegetales.', 0),
(6, 'Turismo', 'Actividad que realizan las personas durante sus viajes y estancias en lugares distintos a su entorno habitual durante un período de tiempo inferior a un año, con fines de ocio, negocios u otros', 0);

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
(5, 4, '2016-07-08', '2016-II', 1, 1);

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
(1, 'Universidad Nacional Pedro Ruiz Gallo', 1),
(2, 'Universidad San Martin de Porres', 1),
(3, 'Universidad Santo Toribio de Mogrovejo', 1),
(4, 'Universidad de Piura', 1),
(5, 'Universidad Nacional de Trujillo', 1);

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
(5, 4, 1, '3534645745671235346', 'Coobox', 1),
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
(2, 2021010002, '2021-04-21', 1),
(3, 2021010003, '2021-04-21', 1),
(4, 2021010004, '2021-04-21', 1),
(5, 2021010005, '2021-04-21', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

CREATE TABLE `contrato` (
  `codigo` int(11) NOT NULL,
  `codigoEgresado` int(11) NOT NULL,
  `codigoCentroLaboral` int(11) NOT NULL,
  `cargo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `detalleFunciones` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(1, 1, 'Chiclayo', 0),
(2, 1, 'Pimentel', 0),
(3, 2, 'Ferreñafe', 0),
(4, 3, 'Morrope', 0),
(5, 3, 'Lambayeque', 0),
(6, 6, 'Miraflores', 0),
(7, 6, 'Miraflores', 0),
(8, 6, 'Surco', 0),
(9, 6, 'La Victoria', 0),
(10, 4, 'Talara', 0),
(11, 4, 'Suyana', 0),
(12, 5, 'Chepen', 0),
(13, 5, 'Pacasmayo', 0),
(14, 2, 'Incahuasi', 0);

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
(4, 1, 165032, 2, '2016-04-25', '2020-12-20', 1),
(5, 1, 160012, 3, '2016-04-25', '2020-12-20', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escuelaprofesional`
--

CREATE TABLE `escuelaprofesional` (
  `codigo` int(11) NOT NULL,
  `codigoFacultad` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `siglas` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `codigoUniversidad` int(11) NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `escuelaprofesional`
--

INSERT INTO `escuelaprofesional` (`codigo`, `codigoFacultad`, `nombre`, `siglas`, `estado`, `codigoUniversidad`, `vigencia`) VALUES
(1, 1, 'Escuela de Ingeniería en Computación e Informática', 'EPICI', 1, 5, 1),
(2, 1, 'Escuela Profesional de Estadística', 'EPE', 1, 5, 1),
(3, 2, 'Escuela Profesional de Mecánica Eléctrica', 'FIME', 1, 5, 1),
(4, 3, 'Escuela Profesional de Enfermería', 'EPEN', 1, 4, 1),
(5, 5, 'Escuela Profesional de Ingeniería Agrícola', 'EPIA', 1, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiospostgrados`
--

CREATE TABLE `estudiospostgrados` (
  `codigo` int(11) NOT NULL,
  `codigoEgresado` int(11) NOT NULL,
  `codigoTipo` int(11) NOT NULL,
  `codigoUniversidad` int(11) NOT NULL,
  `codigoCentroEstudios` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(1, 'Facultad de Ciencias Físicas y Matemáticas', 'FACFYM', 1, 1),
(2, 'Facultad de Mecánica Eléctrica', 'FIME', 1, 1),
(3, 'Facultad de Enfermería', 'FE', 1, 1),
(4, 'Facultad de Agronomia', 'FAG', 1, 1),
(5, 'Facultad de Ingeniería Agrícola', 'FIA', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modalidadadmision`
--

CREATE TABLE `modalidadadmision` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modalidadadmision`
--

INSERT INTO `modalidadadmision` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Ordinario', 'Examen de Admisión para cualquier postulante con un solo requisito, haber terminado el colegio.', 1),
(2, 'Extraordinario', 'Examen de Admisión para alumnos de quinto que aun no terminan el colegio.', 1),
(3, 'Centro PRE', 'Examen de Admisión para chicos que ya han culminado el colegio y están en la academia de la universidad.', 1),
(4, 'Exonerados', 'Examen de Admisión para chicos que ocuparon los primeros puestos en su etapa académica.', 1),
(5, 'Casos Especiales', 'Examen de Admisión para chicos con alguna discapacidad.', 1),
(6, 'Deportista Calificad', 'Examen de Admisión para chicos que destacan en algún deporte. ', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modalidadtitulacion`
--

CREATE TABLE `modalidadtitulacion` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `modalidadtitulacion`
--

INSERT INTO `modalidadtitulacion` (`codigo`, `nombre`, `descripcion`, `vigencia`) VALUES
(1, 'Sistematización EXP', 'Esta modalidad es válida para aquellos egresados que están o hayan desarrollado\r\nactividad profesional en el campo educativo preferentemente en un periodo no\r\nmenor de cinco años. ', 0),
(2, 'Tesis', 'Esta modalidad es valida para los estudiantes y egresados sin restricción del\r\ntiempo de egreso. ', 0);

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
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`codigo`, `nombres`, `apellidoMaterno`, `apellidoPaterno`, `genero`, `fechaNacimiento`, `celular`, `correo`, `dni`, `estadoCivil`, `vigencia`) VALUES
(160012, 'Christian Robert', 'Flores', 'Torres', 1, '1998-12-10', '98534656', 'cflores@unprg.edu.pe', '65734654', '1', 1),
(165032, 'David', 'Paz', 'Rioja', 1, '1999-07-13', '93523622', 'drioja@unprg.edu.pe', '74575683', '1', 1),
(165058, 'Marcelo', 'Villar', 'Velásquez', 1, '1999-02-18', '974657567', 'mvelasquez@unprg.edu.pe', '56845346', '1', 1),
(169025, 'Javier Arturo', 'Sialer', 'Chávez', 1, '1999-06-12', '90348543', 'achavez@unprg.edu.pe', '67723032', '1', 1),
(169027, 'Fabián Andrés', 'Bautista', 'Pacherres', 1, '1998-12-13', '953172725', 'fpacherres@gmail.com', '73860228', '1', 1);

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
  `nombres` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`codigo`, `apellidoPaterno`, `apellidoMaterno`, `dni`, `genero`, `correo`, `celular`, `vigencia`, `nombres`) VALUES
(1, 'Portocarrero', 'Rojas', '76867943', 1, 'portocarrero_rojas@unprg.edu.pe', '983297423', 1, 'José Eduardo'),
(2, 'Espejo', 'Cornejo', '78453245', 1, 'espejo_cornejo@unprg.edu.pe', '989345346', 1, 'Alejandro Miguel'),
(3, 'Montes', 'Eslava', '97942442', 1, 'montes_eslava@unprg.edu.pe', '973435645', 1, 'Óscar'),
(4, 'Álamo', 'Rioja', '56235222', 1, 'alamo_rioja@unprg.edu.pe', '934151121', 1, 'Jordi Erick'),
(5, 'Supo', 'Chumpen', '84523132', 1, 'supo_chumpen@unprg.edu.pe', '983423512', 1, 'Marco Antonio');

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
(2, 1, 'Ferreñafe', 0),
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
(1, 'Máster Oficial', 'Son los másteres con los que se obtiene una titulación oficial y reconocida, que permite acceder al doctorado y para la que es necesario poseer una titulación universitaria.', 1),
(2, 'Máster Título Propio', 'Son unos másteres no oficiales ni homologados, ofertados y diseñados por las propias universidades, donde también fijan los requisitos de acceso y el plan de estudios.', 1),
(3, 'Doctorado', 'Es la máxima formación académica a la que se puede optar, tras realizar un máster y realizar una tesis de investigación, ya sea si tu objetivo es la docencia o ser un referente en tu ámbito profesional.', 1),
(4, 'Curso de Esp', 'Se tratan de cursos de corta duración ofertados para aquellos que quieren conocer mejor un nuevo ámbito de su trabajo, dominar una nueva competencia o reciclar su perfil.', 1),
(5, 'MBA', 'Master of Business Administration (o Maestría en Administración de Empresas), es un tipo de posgrado muy específico dirigido a los profesionales del mundo de los negocios con cargos de responsabilidad o que quieren optar a un ascenso laboral. Se trata de una formación muy orientada a su aplicación práctica en sus puestos de trabajo.', 1);

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
(5, 2, '2021-04-21', 1);

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
(1, 'Universidad Nacional de Trujillo', 'UNT', 1, 1),
(2, 'Universidad de Piura', 'UDEP', 1, 1),
(3, 'Universidad Santo Toribio de Mogrovejo', 'USAT', 1, 1),
(4, 'Universidad San Martín de Porres', 'USMP', 1, 1),
(5, 'Universidad Nacional Pedro Ruíz Gallo', 'UNPRG', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `codigo` int(11) NOT NULL,
  `codigoPersonal` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `tipo` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `codigoPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
-- Indices de la tabla `estudiospostgrados`
--
ALTER TABLE `estudiospostgrados`
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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contrato`
--
ALTER TABLE `contrato`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `escuelaprofesional`
--
ALTER TABLE `escuelaprofesional`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estudiospostgrados`
--
ALTER TABLE `estudiospostgrados`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169028;

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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `estudiospostgrados`
--
ALTER TABLE `estudiospostgrados`
  ADD CONSTRAINT `estudiospostgrados_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`),
  ADD CONSTRAINT `estudiospostgrados_ibfk_2` FOREIGN KEY (`codigoTipo`) REFERENCES `tipoestudiopostgrado` (`codigo`),
  ADD CONSTRAINT `estudiospostgrados_ibfk_3` FOREIGN KEY (`codigoUniversidad`) REFERENCES `universidad` (`codigo`),
  ADD CONSTRAINT `estudiospostgrados_ibfk_4` FOREIGN KEY (`codigoCentroEstudios`) REFERENCES `centroestudios` (`codigo`);

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
