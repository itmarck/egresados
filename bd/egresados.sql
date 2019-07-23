-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-07-2019 a las 21:53:16
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
  `descripcion` text COLLATE utf8_unicode_ci,
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
(6, 'Turismo', 'Actividad que realizan las personas durante sus viajes y estancias en lugares distintos a su entorno habitual durante un periodo de tiempo inferior a un ano, con fines de ocio, negocios u otros', 1),
(7, '', '', 1);

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
(10, 9, '2019-07-22', '2019-II', 4, 1),
(11, 10, '2019-07-22', '2019-II', 6, 1),
(12, 11, '2019-07-22', '2019-II', 6, 1),
(13, 12, '2019-07-22', '2019-II', 6, 1),
(14, 10, '2019-07-22', '2019-II', 3, 1),
(15, 13, '2019-07-22', '2019-I', 2, 1),
(16, 13, '2011-03-01', '2011-I', 2, 1),
(17, 14, '2019-07-22', '2019-I', 1, 1),
(18, 5, '2019-07-22', '2019-I', 2, 1);

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
(5, 'EDUSOL', 1),
(6, 'XUPAR', 1),
(7, 'XUPARE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centrolaboral`
--

CREATE TABLE `centrolaboral` (
  `codigo` int(11) NOT NULL,
  `codigoActividad` int(11) NOT NULL,
  `codigoDistrito` int(11) DEFAULT NULL,
  `RUC` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `razonSocial` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `centrolaboral`
--

INSERT INTO `centrolaboral` (`codigo`, `codigoActividad`, `codigoDistrito`, `RUC`, `razonSocial`, `vigencia`) VALUES
(1, 1, 1, '78293462364283423523', 'Catamarca', 1),
(2, 3, 2, '24343657654756867867', 'Gloria', 1),
(3, 2, 4, '97239423524654456743', 'El Muelle', 1),
(4, 6, 5, '28974982365237469342', 'AirTour', 1),
(5, 4, 6, '3534645745671235346', 'Coolbox', 1),
(6, 5, 7, '24365869543534564572', 'Natura', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colegiatura`
--

CREATE TABLE `colegiatura` (
  `codigoEgresado` int(11) NOT NULL,
  `codigo` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `colegiatura`
--

INSERT INTO `colegiatura` (`codigoEgresado`, `codigo`, `fecha`, `vigencia`) VALUES
(1, '2021010001', '2021-04-21', 1),
(2, '20210', '2021-04-21', 1),
(3, '2021010003', '2021-04-21', 1),
(4, '2021010004', '2021-04-21', 1),
(5, '2021010005', '2021-04-21', 1),
(8, '0', '2019-07-01', 1),
(13, '1110', '2024-09-19', 1);

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
(6, 1, 3, 'Creador de videojuegos', '2018-10-15', '2020-02-14', 'Desarrollador de software que crea exclusivamente videojuegos, como los RPG, FPS, etc.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`codigo`, `nombre`, `vigencia`) VALUES
(1, 'AMAZONAS', 1),
(2, 'ANCASH', 1),
(3, 'APURIMAC', 1),
(4, 'AREQUIPA', 1),
(5, 'AYACUCHO', 1),
(6, 'CAJAMARCA', 1),
(7, 'CALLAO', 1),
(8, 'CUSCO', 1),
(9, 'HUANCAVELICA', 1),
(10, 'HUANUCO', 1),
(11, 'ICA', 1),
(12, 'JUNIN', 1),
(13, 'LA LIBERTAD', 1),
(14, 'LAMBAYEQUE', 1),
(15, 'LIMA', 1),
(16, 'LORETO', 1),
(17, 'MADRE DE DIOS', 1),
(18, 'MOQUEGUA', 1),
(19, 'PASCO', 1),
(20, 'PIURA', 1),
(21, 'PUNO', 1),
(22, 'SAN MARTIN', 1),
(23, 'TACNA', 1),
(24, 'TUMBES', 1),
(25, 'UCAYALI', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE `distrito` (
  `codigo` int(11) NOT NULL,
  `codigoProvincia` int(11) NOT NULL,
  `nombre` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `distrito`
--

INSERT INTO `distrito` (`codigo`, `codigoProvincia`, `nombre`, `vigencia`) VALUES
(1, 1, 'CHACHAPOYAS', 1),
(2, 1, 'ASUNCION', 1),
(3, 1, 'BALSAS', 1),
(4, 1, 'CHETO', 1),
(5, 1, 'CHILIQUIN', 1),
(6, 1, 'CHUQUIBAMBA', 1),
(7, 1, 'GRANADA', 1),
(8, 1, 'HUANCAS', 1),
(9, 1, 'LA JALCA', 1),
(10, 1, 'LEIMEBAMBA', 1),
(11, 1, 'LEVANTO', 1),
(12, 1, 'MAGDALENA', 1),
(13, 1, 'MARISCAL CASTILLA', 1),
(14, 1, 'MOLINOPAMPA', 1),
(15, 1, 'MONTEVIDEO', 1),
(16, 1, 'OLLEROS', 1),
(17, 1, 'QUINJALCA', 1),
(18, 1, 'SAN FRANCISCO DE DAGUAS', 1),
(19, 1, 'SAN ISIDRO DE MAINO', 1),
(20, 1, 'SOLOCO', 1),
(21, 1, 'SONCHE', 1),
(22, 2, 'LA PECA', 1),
(23, 2, 'ARAMANGO', 1),
(24, 2, 'COPALLIN', 1),
(25, 2, 'EL PARCO', 1),
(26, 2, 'IMAZA', 1),
(27, 3, 'JUMBILLA', 1),
(28, 3, 'CHISQUILLA', 1),
(29, 3, 'CHURUJA', 1),
(30, 3, 'COROSHA', 1),
(31, 3, 'CUISPES', 1),
(32, 3, 'FLORIDA', 1),
(33, 3, 'JAZAN', 1),
(34, 3, 'RECTA', 1),
(35, 3, 'SAN CARLOS', 1),
(36, 3, 'SHIPASBAMBA', 1),
(37, 3, 'VALERA', 1),
(38, 3, 'YAMBRASBAMBA', 1),
(39, 4, 'NIEVA', 1),
(40, 4, 'EL CENEPA', 1),
(41, 4, 'RIO SANTIAGO', 1),
(42, 5, 'LAMUD', 1),
(43, 5, 'CAMPORREDONDO', 1),
(44, 5, 'COCABAMBA', 1),
(45, 5, 'COLCAMAR', 1),
(46, 5, 'CONILA', 1),
(47, 5, 'INGUILPATA', 1),
(48, 5, 'LONGUITA', 1),
(49, 5, 'LONYA CHICO', 1),
(50, 5, 'LUYA', 1),
(51, 5, 'LUYA VIEJO', 1),
(52, 5, 'MARIA', 1),
(53, 5, 'OCALLI', 1),
(54, 5, 'OCUMAL', 1),
(55, 5, 'PISUQUIA', 1),
(56, 5, 'PROVIDENCIA', 1),
(57, 5, 'SAN CRISTOBAL', 1),
(58, 5, 'SAN FRANCISCO DEL YESO', 1),
(59, 5, 'SAN JERONIMO', 1),
(60, 5, 'SAN JUAN DE LOPECANCHA', 1),
(61, 5, 'SANTA CATALINA', 1),
(62, 5, 'SANTO TOMAS', 1),
(63, 5, 'TINGO', 1),
(64, 5, 'TRITA', 1),
(65, 6, 'SAN NICOLAS', 1),
(66, 6, 'CHIRIMOTO', 1),
(67, 6, 'COCHAMAL', 1),
(68, 6, 'HUAMBO', 1),
(69, 6, 'LIMABAMBA', 1),
(70, 6, 'LONGAR', 1),
(71, 6, 'MARISCAL BENAVIDES', 1),
(72, 6, 'MILPUC', 1),
(73, 6, 'OMIA', 1),
(74, 6, 'SANTA ROSA', 1),
(75, 6, 'TOTORA', 1),
(76, 6, 'VISTA ALEGRE', 1),
(77, 7, 'BAGUA GRANDE', 1),
(78, 7, 'CAJARURO', 1),
(79, 7, 'CUMBA', 1),
(80, 7, 'EL MILAGRO', 1),
(81, 7, 'JAMALCA', 1),
(82, 7, 'LONYA GRANDE', 1),
(83, 7, 'YAMON', 1),
(84, 8, 'HUARAZ', 1),
(85, 8, 'COCHABAMBA', 1),
(86, 8, 'COLCABAMBA', 1),
(87, 8, 'HUANCHAY', 1),
(88, 8, 'INDEPENDENCIA', 1),
(89, 8, 'JANGAS', 1),
(90, 8, 'LA LIBERTAD', 1),
(91, 8, 'OLLEROS', 1),
(92, 8, 'PAMPAS', 1),
(93, 8, 'PARIACOTO', 1),
(94, 8, 'PIRA', 1),
(95, 8, 'TARICA', 1),
(96, 9, 'AIJA', 1),
(97, 9, 'CORIS', 1),
(98, 9, 'HUACLLAN', 1),
(99, 9, 'LA MERCED', 1),
(100, 9, 'SUCCHA', 1),
(101, 10, 'LLAMELLIN', 1),
(102, 10, 'ACZO', 1),
(103, 10, 'CHACCHO', 1),
(104, 10, 'CHINGAS', 1),
(105, 10, 'MIRGAS', 1),
(106, 10, 'SAN JUAN DE RONTOY', 1),
(107, 11, 'CHACAS', 1),
(108, 11, 'ACOCHACA', 1),
(109, 12, 'CHIQUIAN', 1),
(110, 12, 'ABELARDO PARDO LEZAMETA', 1),
(111, 12, 'ANTONIO RAYMONDI', 1),
(112, 12, 'AQUIA', 1),
(113, 12, 'CAJACAY', 1),
(114, 12, 'CANIS', 1),
(115, 12, 'COLQUIOC', 1),
(116, 12, 'HUALLANCA', 1),
(117, 12, 'HUASTA', 1),
(118, 12, 'HUAYLLACAYAN', 1),
(119, 12, 'LA PRIMAVERA', 1),
(120, 12, 'MANGAS', 1),
(121, 12, 'PACLLON', 1),
(122, 12, 'SAN MIGUEL DE CORPANQUI', 1),
(123, 12, 'TICLLOS', 1),
(124, 13, 'CARHUAZ', 1),
(125, 13, 'ACOPAMPA', 1),
(126, 13, 'AMASHCA', 1),
(127, 13, 'ANTA', 1),
(128, 13, 'ATAQUERO', 1),
(129, 13, 'MARCARA', 1),
(130, 13, 'PARIAHUANCA', 1),
(131, 13, 'SAN MIGUEL DE ACO', 1),
(132, 13, 'SHILLA', 1),
(133, 13, 'TINCO', 1),
(134, 13, 'YUNGAR', 1),
(135, 14, 'SAN LUIS', 1),
(136, 14, 'SAN NICOLAS', 1),
(137, 14, 'YAUYA', 1),
(138, 15, 'CASMA', 1),
(139, 15, 'BUENA VISTA ALTA', 1),
(140, 15, 'COMANDANTE NOEL', 1),
(141, 15, 'YAUTAN', 1),
(142, 16, 'CORONGO', 1),
(143, 16, 'ACO', 1),
(144, 16, 'BAMBAS', 1),
(145, 16, 'CUSCA', 1),
(146, 16, 'LA PAMPA', 1),
(147, 16, 'YANAC', 1),
(148, 16, 'YUPAN', 1),
(149, 17, 'HUARI', 1),
(150, 17, 'ANRA', 1),
(151, 17, 'CAJAY', 1),
(152, 17, 'CHAVIN DE HUANTAR', 1),
(153, 17, 'HUACACHI', 1),
(154, 17, 'HUACCHIS', 1),
(155, 17, 'HUACHIS', 1),
(156, 17, 'HUANTAR', 1),
(157, 17, 'MASIN', 1),
(158, 17, 'PAUCAS', 1),
(159, 17, 'PONTO', 1),
(160, 17, 'RAHUAPAMPA', 1),
(161, 17, 'RAPAYAN', 1),
(162, 17, 'SAN MARCOS', 1),
(163, 17, 'SAN PEDRO DE CHANA', 1),
(164, 17, 'UCO', 1),
(165, 18, 'HUARMEY', 1),
(166, 18, 'COCHAPETI', 1),
(167, 18, 'CULEBRAS', 1),
(168, 18, 'HUAYAN', 1),
(169, 18, 'MALVAS', 1),
(170, 26, 'CARAZ', 1),
(171, 26, 'HUALLANCA', 1),
(172, 26, 'HUATA', 1),
(173, 26, 'HUAYLAS', 1),
(174, 26, 'MATO', 1),
(175, 26, 'PAMPAROMAS', 1),
(176, 26, 'PUEBLO LIBRE', 1),
(177, 26, 'SANTA CRUZ', 1),
(178, 26, 'SANTO TORIBIO', 1),
(179, 26, 'YURACMARCA', 1),
(180, 27, 'PISCOBAMBA', 1),
(181, 27, 'CASCA', 1),
(182, 27, 'ELEAZAR GUZMAN BARRON', 1),
(183, 27, 'FIDEL OLIVAS ESCUDERO', 1),
(184, 27, 'LLAMA', 1),
(185, 27, 'LLUMPA', 1),
(186, 27, 'LUCMA', 1),
(187, 27, 'MUSGA', 1),
(188, 21, 'OCROS', 1),
(189, 21, 'ACAS', 1),
(190, 21, 'CAJAMARQUILLA', 1),
(191, 21, 'CARHUAPAMPA', 1),
(192, 21, 'COCHAS', 1),
(193, 21, 'CONGAS', 1),
(194, 21, 'LLIPA', 1),
(195, 21, 'SAN CRISTOBAL DE RAJAN', 1),
(196, 21, 'SAN PEDRO', 1),
(197, 21, 'SANTIAGO DE CHILCAS', 1),
(198, 22, 'CABANA', 1),
(199, 22, 'BOLOGNESI', 1),
(200, 22, 'CONCHUCOS', 1),
(201, 22, 'HUACASCHUQUE', 1),
(202, 22, 'HUANDOVAL', 1),
(203, 22, 'LACABAMBA', 1),
(204, 22, 'LLAPO', 1),
(205, 22, 'PALLASCA', 1),
(206, 22, 'PAMPAS', 1),
(207, 22, 'SANTA ROSA', 1),
(208, 22, 'TAUCA', 1),
(209, 23, 'POMABAMBA', 1),
(210, 23, 'HUAYLLAN', 1),
(211, 23, 'PAROBAMBA', 1),
(212, 23, 'QUINUABAMBA', 1),
(213, 24, 'RECUAY', 1),
(214, 24, 'CATAC', 1),
(215, 24, 'COTAPARACO', 1),
(216, 24, 'HUAYLLAPAMPA', 1),
(217, 24, 'LLACLLIN', 1),
(218, 24, 'MARCA', 1),
(219, 24, 'PAMPAS CHICO', 1),
(220, 24, 'PARARIN', 1),
(221, 24, 'TAPACOCHA', 1),
(222, 24, 'TICAPAMPA', 1),
(223, 25, 'CHIMBOTE', 1),
(224, 25, 'CACERES DEL PERU', 1),
(225, 25, 'COISHCO', 1),
(226, 25, 'MACATE', 1),
(227, 25, 'MORO', 1),
(228, 25, 'NEPE&Ntilde;A', 1),
(229, 25, 'SAMANCO', 1),
(230, 25, 'SANTA', 1),
(231, 25, 'NUEVO CHIMBOTE', 1),
(232, 26, 'SIHUAS', 1),
(233, 26, 'ACOBAMBA', 1),
(234, 26, 'ALFONSO UGARTE', 1),
(235, 26, 'CASHAPAMPA', 1),
(236, 26, 'CHINGALPO', 1),
(237, 26, 'HUAYLLABAMBA', 1),
(238, 26, 'QUICHES', 1),
(239, 26, 'RAGASH', 1),
(240, 26, 'SAN JUAN', 1),
(241, 26, 'SICSIBAMBA', 1),
(242, 27, 'YUNGAY', 1),
(243, 27, 'CASCAPARA', 1),
(244, 27, 'MANCOS', 1),
(245, 27, 'MATACOTO', 1),
(246, 27, 'QUILLO', 1),
(247, 27, 'RANRAHIRCA', 1),
(248, 27, 'SHUPLUY', 1),
(249, 27, 'YANAMA', 1),
(250, 28, 'ABANCAY', 1),
(251, 28, 'CHACOCHE', 1),
(252, 28, 'CIRCA', 1),
(253, 28, 'CURAHUASI', 1),
(254, 28, 'HUANIPACA', 1),
(255, 28, 'LAMBRAMA', 1),
(256, 28, 'PICHIRHUA', 1),
(257, 28, 'SAN PEDRO DE CACHORA', 1),
(258, 28, 'TAMBURCO', 1),
(259, 29, 'ANDAHUAYLAS', 1),
(260, 29, 'ANDARAPA', 1),
(261, 29, 'CHIARA', 1),
(262, 29, 'HUANCARAMA', 1),
(263, 29, 'HUANCARAY', 1),
(264, 29, 'HUAYANA', 1),
(265, 29, 'KISHUARA', 1),
(266, 29, 'PACOBAMBA', 1),
(267, 29, 'PACUCHA', 1),
(268, 29, 'PAMPACHIRI', 1),
(269, 29, 'POMACOCHA', 1),
(270, 29, 'SAN ANTONIO DE CACHI', 1),
(271, 29, 'SAN JERONIMO', 1),
(272, 29, 'SAN MIGUEL DE CHACCRAMPA', 1),
(273, 29, 'SANTA MARIA DE CHICMO', 1),
(274, 29, 'TALAVERA', 1),
(275, 29, 'TUMAY HUARACA', 1),
(276, 29, 'TURPO', 1),
(277, 29, 'KAQUIABAMBA', 1),
(278, 30, 'ANTABAMBA', 1),
(279, 30, 'EL ORO', 1),
(280, 30, 'HUAQUIRCA', 1),
(281, 30, 'JUAN ESPINOZA MEDRANO', 1),
(282, 30, 'OROPESA', 1),
(283, 30, 'PACHACONAS', 1),
(284, 30, 'SABAINO', 1),
(285, 31, 'CHALHUANCA', 1),
(286, 31, 'CAPAYA', 1),
(287, 31, 'CARAYBAMBA', 1),
(288, 31, 'CHAPIMARCA', 1),
(289, 31, 'COLCABAMBA', 1),
(290, 31, 'COTARUSE', 1),
(291, 31, 'HUAYLLO', 1),
(292, 31, 'JUSTO APU SAHUARAURA', 1),
(293, 31, 'LUCRE', 1),
(294, 31, 'POCOHUANCA', 1),
(295, 31, 'SAN JUAN DE CHACÃ‘A', 1),
(296, 31, 'SA&Ntilde;AYCA', 1),
(297, 31, 'SORAYA', 1),
(298, 31, 'TAPAIRIHUA', 1),
(299, 31, 'TINTAY', 1),
(300, 31, 'TORAYA', 1),
(301, 31, 'YANACA', 1),
(302, 32, 'TAMBOBAMBA', 1),
(303, 32, 'COTABAMBAS', 1),
(304, 32, 'COYLLURQUI', 1),
(305, 32, 'HAQUIRA', 1),
(306, 32, 'MARA', 1),
(307, 32, 'CHALLHUAHUACHO', 1),
(308, 33, 'CHINCHEROS', 1),
(309, 33, 'ANCO-HUALLO', 1),
(310, 33, 'COCHARCAS', 1),
(311, 33, 'HUACCANA', 1),
(312, 33, 'OCOBAMBA', 1),
(313, 33, 'ONGOY', 1),
(314, 33, 'URANMARCA', 1),
(315, 33, 'RANRACANCHA', 1),
(316, 34, 'CHUQUIBAMBILLA', 1),
(317, 34, 'CURPAHUASI', 1),
(318, 34, 'GAMARRA', 1),
(319, 34, 'HUAYLLATI', 1),
(320, 34, 'MAMARA', 1),
(321, 34, 'MICAELA BASTIDAS', 1),
(322, 34, 'PATAYPAMPA', 1),
(323, 34, 'PROGRESO', 1),
(324, 34, 'SAN ANTONIO', 1),
(325, 34, 'SANTA ROSA', 1),
(326, 34, 'TURPAY', 1),
(327, 34, 'VILCABAMBA', 1),
(328, 34, 'VIRUNDO', 1),
(329, 34, 'CURASCO', 1),
(330, 35, 'AREQUIPA', 1),
(331, 35, 'ALTO SELVA ALEGRE', 1),
(332, 35, 'CAYMA', 1),
(333, 35, 'CERRO COLORADO', 1),
(334, 35, 'CHARACATO', 1),
(335, 35, 'CHIGUATA', 1),
(336, 35, 'JACOBO HUNTER', 1),
(337, 35, 'LA JOYA', 1),
(338, 35, 'MARIANO MELGAR', 1),
(339, 35, 'MIRAFLORES', 1),
(340, 35, 'MOLLEBAYA', 1),
(341, 35, 'PAUCARPATA', 1),
(342, 35, 'POCSI', 1),
(343, 35, 'POLOBAYA', 1),
(344, 35, 'QUEQUE&Ntilde;A', 1),
(345, 35, 'SABANDIA', 1),
(346, 35, 'SACHACA', 1),
(347, 35, 'SAN JUAN DE SIGUAS', 1),
(348, 35, 'SAN JUAN DE TARUCANI', 1),
(349, 35, 'SANTA ISABEL DE SIGUAS', 1),
(350, 35, 'SANTA RITA DE SIGUAS', 1),
(351, 35, 'SOCABAYA', 1),
(352, 35, 'TIABAYA', 1),
(353, 35, 'UCHUMAYO', 1),
(354, 35, 'VITOR', 1),
(355, 35, 'YANAHUARA', 1),
(356, 35, 'YARABAMBA', 1),
(357, 35, 'YURA', 1),
(358, 35, 'JOSE LUIS BUSTAMANTE Y RIVERO', 1),
(359, 36, 'CAMANA', 1),
(360, 36, 'JOSE MARIA QUIMPER', 1),
(361, 36, 'MARIANO NICOLAS VALCARCEL', 1),
(362, 36, 'MARISCAL CACERES', 1),
(363, 36, 'NICOLAS DE PIEROLA', 1),
(364, 36, 'OCOÃ‘A', 1),
(365, 36, 'QUILCA', 1),
(366, 36, 'SAMUEL PASTOR', 1),
(367, 37, 'CARAVELI', 1),
(368, 37, 'ACARI', 1),
(369, 37, 'ATICO', 1),
(370, 37, 'ATIQUIPA', 1),
(371, 37, 'BELLA UNION', 1),
(372, 37, 'CAHUACHO', 1),
(373, 37, 'CHALA', 1),
(374, 37, 'CHAPARRA', 1),
(375, 37, 'HUANUHUANU', 1),
(376, 37, 'JAQUI', 1),
(377, 37, 'LOMAS', 1),
(378, 37, 'QUICACHA', 1),
(379, 37, 'YAUCA', 1),
(380, 38, 'APLAO', 1),
(381, 38, 'ANDAGUA', 1),
(382, 38, 'AYO', 1),
(383, 38, 'CHACHAS', 1),
(384, 38, 'CHILCAYMARCA', 1),
(385, 38, 'CHOCO', 1),
(386, 38, 'HUANCARQUI', 1),
(387, 38, 'MACHAGUAY', 1),
(388, 38, 'ORCOPAMPA', 1),
(389, 38, 'PAMPACOLCA', 1),
(390, 38, 'TIPAN', 1),
(391, 38, 'UÃ‘ON', 1),
(392, 38, 'URACA', 1),
(393, 38, 'VIRACO', 1),
(394, 39, 'CHIVAY', 1),
(395, 39, 'ACHOMA', 1),
(396, 39, 'CABANACONDE', 1),
(397, 39, 'CALLALLI', 1),
(398, 39, 'CAYLLOMA', 1),
(399, 39, 'COPORAQUE', 1),
(400, 39, 'HUAMBO', 1),
(401, 39, 'HUANCA', 1),
(402, 39, 'ICHUPAMPA', 1),
(403, 39, 'LARI', 1),
(404, 39, 'LLUTA', 1),
(405, 39, 'MACA', 1),
(406, 39, 'MADRIGAL', 1),
(407, 39, 'SAN ANTONIO DE CHUCA', 1),
(408, 39, 'SIBAYO', 1),
(409, 39, 'TAPAY', 1),
(410, 39, 'TISCO', 1),
(411, 39, 'TUTI', 1),
(412, 39, 'YANQUE', 1),
(413, 39, 'MAJES', 1),
(414, 40, 'CHUQUIBAMBA', 1),
(415, 40, 'ANDARAY', 1),
(416, 40, 'CAYARANI', 1),
(417, 40, 'CHICHAS', 1),
(418, 40, 'IRAY', 1),
(419, 40, 'RIO GRANDE', 1),
(420, 40, 'SALAMANCA', 1),
(421, 40, 'YANAQUIHUA', 1),
(422, 41, 'MOLLENDO', 1),
(423, 41, 'COCACHACRA', 1),
(424, 41, 'DEAN VALDIVIA', 1),
(425, 41, 'ISLAY', 1),
(426, 41, 'MEJIA', 1),
(427, 41, 'PUNTA DE BOMBON', 1),
(428, 42, 'COTAHUASI', 1),
(429, 42, 'ALCA', 1),
(430, 42, 'CHARCANA', 1),
(431, 42, 'HUAYNACOTAS', 1),
(432, 42, 'PAMPAMARCA', 1),
(433, 42, 'PUYCA', 1),
(434, 42, 'QUECHUALLA', 1),
(435, 42, 'SAYLA', 1),
(436, 42, 'TAURIA', 1),
(437, 42, 'TOMEPAMPA', 1),
(438, 42, 'TORO', 1),
(439, 43, 'AYACUCHO', 1),
(440, 43, 'ACOCRO', 1),
(441, 43, 'ACOS VINCHOS', 1),
(442, 43, 'CARMEN ALTO', 1),
(443, 43, 'CHIARA', 1),
(444, 43, 'OCROS', 1),
(445, 43, 'PACAYCASA', 1),
(446, 43, 'QUINUA', 1),
(447, 43, 'SAN JOSE DE TICLLAS', 1),
(448, 43, 'SAN JUAN BAUTISTA', 1),
(449, 43, 'SANTIAGO DE PISCHA', 1),
(450, 43, 'SOCOS', 1),
(451, 43, 'TAMBILLO', 1),
(452, 43, 'VINCHOS', 1),
(453, 43, 'JESUS NAZARENO', 1),
(454, 44, 'CANGALLO', 1),
(455, 44, 'CHUSCHI', 1),
(456, 44, 'LOS MOROCHUCOS', 1),
(457, 44, 'MARIA PARADO DE BELLIDO', 1),
(458, 44, 'PARAS', 1),
(459, 44, 'TOTOS', 1),
(460, 45, 'SANCOS', 1),
(461, 45, 'CARAPO', 1),
(462, 45, 'SACSAMARCA', 1),
(463, 45, 'SANTIAGO DE LUCANAMARCA', 1),
(464, 46, 'HUANTA', 1),
(465, 46, 'AYAHUANCO', 1),
(466, 46, 'HUAMANGUILLA', 1),
(467, 46, 'IGUAIN', 1),
(468, 46, 'LURICOCHA', 1),
(469, 46, 'SANTILLANA', 1),
(470, 46, 'SIVIA', 1),
(471, 46, 'LLOCHEGUA', 1),
(472, 47, 'SAN MIGUEL', 1),
(473, 47, 'ANCO', 1),
(474, 47, 'AYNA', 1),
(475, 47, 'CHILCAS', 1),
(476, 47, 'CHUNGUI', 1),
(477, 47, 'LUIS CARRANZA', 1),
(478, 47, 'SANTA ROSA', 1),
(479, 47, 'TAMBO', 1),
(480, 48, 'PUQUIO', 1),
(481, 48, 'AUCARA', 1),
(482, 48, 'CABANA', 1),
(483, 48, 'CARMEN SALCEDO', 1),
(484, 48, 'CHAVIÃ‘A', 1),
(485, 48, 'CHIPAO', 1),
(486, 48, 'HUAC-HUAS', 1),
(487, 48, 'LARAMATE', 1),
(488, 48, 'LEONCIO PRADO', 1),
(489, 48, 'LLAUTA', 1),
(490, 48, 'LUCANAS', 1),
(491, 48, 'OCAÃ‘A', 1),
(492, 48, 'OTOCA', 1),
(493, 48, 'SAISA', 1),
(494, 48, 'SAN CRISTOBAL', 1),
(495, 48, 'SAN JUAN', 1),
(496, 48, 'SAN PEDRO', 1),
(497, 48, 'SAN PEDRO DE PALCO', 1),
(498, 48, 'SANCOS', 1),
(499, 48, 'SANTA ANA DE HUAYCAHUACHO', 1),
(500, 48, 'SANTA LUCIA', 1),
(501, 49, 'CORACORA', 1),
(502, 49, 'CHUMPI', 1),
(503, 49, 'CORONEL CASTA&Ntilde;EDA', 1),
(504, 49, 'PACAPAUSA', 1),
(505, 49, 'PULLO', 1),
(506, 49, 'PUYUSCA', 1),
(507, 49, 'SAN FRANCISCO DE RAVACAYCO', 1),
(508, 49, 'UPAHUACHO', 1),
(509, 50, 'PAUSA', 1),
(510, 50, 'COLTA', 1),
(511, 50, 'CORCULLA', 1),
(512, 50, 'LAMPA', 1),
(513, 50, 'MARCABAMBA', 1),
(514, 50, 'OYOLO', 1),
(515, 50, 'PARARCA', 1),
(516, 50, 'SAN JAVIER DE ALPABAMBA', 1),
(517, 50, 'SAN JOSE DE USHUA', 1),
(518, 50, 'SARA SARA', 1),
(519, 51, 'QUEROBAMBA', 1),
(520, 51, 'BELEN', 1),
(521, 51, 'CHALCOS', 1),
(522, 51, 'CHILCAYOC', 1),
(523, 51, 'HUACA&Ntilde;A', 1),
(524, 51, 'MORCOLLA', 1),
(525, 51, 'PAICO', 1),
(526, 51, 'SAN PEDRO DE LARCAY', 1),
(527, 51, 'SAN SALVADOR DE QUIJE', 1),
(528, 51, 'SANTIAGO DE PAUCARAY', 1),
(529, 51, 'SORAS', 1),
(530, 52, 'HUANCAPI', 1),
(531, 52, 'ALCAMENCA', 1),
(532, 52, 'APONGO', 1),
(533, 52, 'ASQUIPATA', 1),
(534, 52, 'CANARIA', 1),
(535, 52, 'CAYARA', 1),
(536, 52, 'COLCA', 1),
(537, 52, 'HUAMANQUIQUIA', 1),
(538, 52, 'HUANCARAYLLA', 1),
(539, 52, 'HUAYA', 1),
(540, 52, 'SARHUA', 1),
(541, 52, 'VILCANCHOS', 1),
(542, 53, 'VILCAS HUAMAN', 1),
(543, 53, 'ACCOMARCA', 1),
(544, 53, 'CARHUANCA', 1),
(545, 53, 'CONCEPCION', 1),
(546, 53, 'HUAMBALPA', 1),
(547, 53, 'INDEPENDENCIA', 1),
(548, 53, 'SAURAMA', 1),
(549, 53, 'VISCHONGO', 1),
(550, 54, 'CAJAMARCA', 1),
(551, 54, 'CAJAMARCA', 1),
(552, 54, 'ASUNCION', 1),
(553, 54, 'CHETILLA', 1),
(554, 54, 'COSPAN', 1),
(555, 54, 'ENCAÃ‘ADA', 1),
(556, 54, 'JESUS', 1),
(557, 54, 'LLACANORA', 1),
(558, 54, 'LOS BAÃ‘OS DEL INCA', 1),
(559, 54, 'MAGDALENA', 1),
(560, 54, 'MATARA', 1),
(561, 54, 'NAMORA', 1),
(562, 54, 'SAN JUAN', 1),
(563, 55, 'CAJABAMBA', 1),
(564, 55, 'CACHACHI', 1),
(565, 55, 'CONDEBAMBA', 1),
(566, 55, 'SITACOCHA', 1),
(567, 56, 'CELENDIN', 1),
(568, 56, 'CHUMUCH', 1),
(569, 56, 'CORTEGANA', 1),
(570, 56, 'HUASMIN', 1),
(571, 56, 'JORGE CHAVEZ', 1),
(572, 56, 'JOSE GALVEZ', 1),
(573, 56, 'MIGUEL IGLESIAS', 1),
(574, 56, 'OXAMARCA', 1),
(575, 56, 'SOROCHUCO', 1),
(576, 56, 'SUCRE', 1),
(577, 56, 'UTCO', 1),
(578, 56, 'LA LIBERTAD DE PALLAN', 1),
(579, 57, 'CHOTA', 1),
(580, 57, 'ANGUIA', 1),
(581, 57, 'CHADIN', 1),
(582, 57, 'CHIGUIRIP', 1),
(583, 57, 'CHIMBAN', 1),
(584, 57, 'CHOROPAMPA', 1),
(585, 57, 'COCHABAMBA', 1),
(586, 57, 'CONCHAN', 1),
(587, 57, 'HUAMBOS', 1),
(588, 57, 'LAJAS', 1),
(589, 57, 'LLAMA', 1),
(590, 57, 'MIRACOSTA', 1),
(591, 57, 'PACCHA', 1),
(592, 57, 'PION', 1),
(593, 57, 'QUEROCOTO', 1),
(594, 57, 'SAN JUAN DE LICUPIS', 1),
(595, 57, 'TACABAMBA', 1),
(596, 57, 'TOCMOCHE', 1),
(597, 57, 'CHALAMARCA', 1),
(598, 58, 'CONTUMAZA', 1),
(599, 58, 'CHILETE', 1),
(600, 58, 'CUPISNIQUE', 1),
(601, 58, 'GUZMANGO', 1),
(602, 58, 'SAN BENITO', 1),
(603, 58, 'SANTA CRUZ DE TOLED', 1),
(604, 58, 'TANTARICA', 1),
(605, 58, 'YONAN', 1),
(606, 59, 'CUTERVO', 1),
(607, 59, 'CALLAYUC', 1),
(608, 59, 'CHOROS', 1),
(609, 59, 'CUJILLO', 1),
(610, 59, 'LA RAMADA', 1),
(611, 59, 'PIMPINGOS', 1),
(612, 59, 'QUEROCOTILLO', 1),
(613, 59, 'SAN ANDRES DE CUTERVO', 1),
(614, 59, 'SAN JUAN DE CUTERVO', 1),
(615, 59, 'SAN LUIS DE LUCMA', 1),
(616, 59, 'SANTA CRUZ', 1),
(617, 59, 'SANTO DOMINGO DE LA CAPILLA', 1),
(618, 59, 'SANTO TOMAS', 1),
(619, 59, 'SOCOTA', 1),
(620, 59, 'TORIBIO CASANOVA', 1),
(621, 60, 'BAMBAMARCA', 1),
(622, 60, 'CHUGUR', 1),
(623, 60, 'HUALGAYOC', 1),
(624, 61, 'JAEN', 1),
(625, 61, 'BELLAVISTA', 1),
(626, 61, 'CHONTALI', 1),
(627, 61, 'COLASAY', 1),
(628, 61, 'HUABAL', 1),
(629, 61, 'LAS PIRIAS', 1),
(630, 61, 'POMAHUACA', 1),
(631, 61, 'PUCARA', 1),
(632, 61, 'SALLIQUE', 1),
(633, 61, 'SAN FELIPE', 1),
(634, 61, 'SAN JOSE DEL ALTO', 1),
(635, 61, 'SANTA ROSA', 1),
(636, 62, 'SAN IGNACIO', 1),
(637, 62, 'CHIRINOS', 1),
(638, 62, 'HUARANGO', 1),
(639, 62, 'LA COIPA', 1),
(640, 62, 'NAMBALLE', 1),
(641, 62, 'SAN JOSE DE LOURDES', 1),
(642, 62, 'TABACONAS', 1),
(643, 63, 'PEDRO GALVEZ', 1),
(644, 63, 'CHANCAY', 1),
(645, 63, 'EDUARDO VILLANUEVA', 1),
(646, 63, 'GREGORIO PITA', 1),
(647, 63, 'ICHOCAN', 1),
(648, 63, 'JOSE MANUEL QUIROZ', 1),
(649, 63, 'JOSE SABOGAL', 1),
(650, 64, 'SAN MIGUEL', 1),
(651, 64, 'SAN MIGUEL', 1),
(652, 64, 'BOLIVAR', 1),
(653, 64, 'CALQUIS', 1),
(654, 64, 'CATILLUC', 1),
(655, 64, 'EL PRADO', 1),
(656, 64, 'LA FLORIDA', 1),
(657, 64, 'LLAPA', 1),
(658, 64, 'NANCHOC', 1),
(659, 64, 'NIEPOS', 1),
(660, 64, 'SAN GREGORIO', 1),
(661, 64, 'SAN SILVESTRE DE COCHAN', 1),
(662, 64, 'TONGOD', 1),
(663, 64, 'UNION AGUA BLANCA', 1),
(664, 65, 'SAN PABLO', 1),
(665, 65, 'SAN BERNARDINO', 1),
(666, 65, 'SAN LUIS', 1),
(667, 65, 'TUMBADEN', 1),
(668, 66, 'SANTA CRUZ', 1),
(669, 66, 'ANDABAMBA', 1),
(670, 66, 'CATACHE', 1),
(671, 66, 'CHANCAYBAÃ‘OS', 1),
(672, 66, 'LA ESPERANZA', 1),
(673, 66, 'NINABAMBA', 1),
(674, 66, 'PULAN', 1),
(675, 66, 'SAUCEPAMPA', 1),
(676, 66, 'SEXI', 1),
(677, 66, 'UTICYACU', 1),
(678, 66, 'YAUYUCAN', 1),
(679, 67, 'CALLAO', 1),
(680, 67, 'BELLAVISTA', 1),
(681, 67, 'CARMEN DE LA LEGUA REYNOSO', 1),
(682, 67, 'LA PERLA', 1),
(683, 67, 'LA PUNTA', 1),
(684, 67, 'VENTANILLA', 1),
(685, 67, 'CUSCO', 1),
(686, 67, 'CCORCA', 1),
(687, 67, 'POROY', 1),
(688, 67, 'SAN JERONIMO', 1),
(689, 67, 'SAN SEBASTIAN', 1),
(690, 67, 'SANTIAGO', 1),
(691, 67, 'SAYLLA', 1),
(692, 67, 'WANCHAQ', 1),
(693, 68, 'ACOMAYO', 1),
(694, 68, 'ACOPIA', 1),
(695, 68, 'ACOS', 1),
(696, 68, 'MOSOC LLACTA', 1),
(697, 68, 'POMACANCHI', 1),
(698, 68, 'RONDOCAN', 1),
(699, 68, 'SANGARARA', 1),
(700, 69, 'ANTA', 1),
(701, 69, 'ANCAHUASI', 1),
(702, 69, 'CACHIMAYO', 1),
(703, 69, 'CHINCHAYPUJIO', 1),
(704, 69, 'HUAROCONDO', 1),
(705, 69, 'LIMATAMBO', 1),
(706, 69, 'MOLLEPATA', 1),
(707, 69, 'PUCYURA', 1),
(708, 69, 'ZURITE', 1),
(709, 70, 'CALCA', 1),
(710, 70, 'COYA', 1),
(711, 70, 'LAMAY', 1),
(712, 70, 'LARES', 1),
(713, 70, 'PISAC', 1),
(714, 70, 'SAN SALVADOR', 1),
(715, 70, 'TARAY', 1),
(716, 70, 'YANATILE', 1),
(717, 71, 'YANAOCA', 1),
(718, 71, 'CHECCA', 1),
(719, 71, 'KUNTURKANKI', 1),
(720, 71, 'LANGUI', 1),
(721, 71, 'LAYO', 1),
(722, 71, 'PAMPAMARCA', 1),
(723, 71, 'QUEHUE', 1),
(724, 71, 'TUPAC AMARU', 1),
(725, 72, 'SICUANI', 1),
(726, 72, 'CHECACUPE', 1),
(727, 72, 'COMBAPATA', 1),
(728, 72, 'MARANGANI', 1),
(729, 72, 'PITUMARCA', 1),
(730, 72, 'SAN PABLO', 1),
(731, 72, 'SAN PEDRO', 1),
(732, 72, 'TINTA', 1),
(733, 73, 'SANTO TOMAS', 1),
(734, 73, 'CAPACMARCA', 1),
(735, 73, 'CHAMACA', 1),
(736, 73, 'COLQUEMARCA', 1),
(737, 73, 'LIVITACA', 1),
(738, 73, 'LLUSCO', 1),
(739, 73, 'QUI&Ntilde;OTA', 1),
(740, 73, 'VELILLE', 1),
(741, 74, 'ESPINAR', 1),
(742, 74, 'CONDOROMA', 1),
(743, 74, 'COPORAQUE', 1),
(744, 74, 'OCORURO', 1),
(745, 74, 'PALLPATA', 1),
(746, 74, 'PICHIGUA', 1),
(747, 74, 'SUYCKUTAMBO', 1),
(748, 74, 'ALTO PICHIGUA', 1),
(749, 75, 'SANTA ANA', 1),
(750, 75, 'ECHARATE', 1),
(751, 75, 'HUAYOPATA', 1),
(752, 75, 'MARANURA', 1),
(753, 75, 'OCOBAMBA', 1),
(754, 75, 'QUELLOUNO', 1),
(755, 75, 'KIMBIRI', 1),
(756, 75, 'SANTA TERESA', 1),
(757, 75, 'VILCABAMBA', 1),
(758, 75, 'PICHARI', 1),
(759, 76, 'PARURO', 1),
(760, 76, 'ACCHA', 1),
(761, 76, 'CCAPI', 1),
(762, 76, 'COLCHA', 1),
(763, 76, 'HUANOQUITE', 1),
(764, 76, 'OMACHA', 1),
(765, 76, 'PACCARITAMBO', 1),
(766, 76, 'PILLPINTO', 1),
(767, 76, 'YAURISQUE', 1),
(768, 77, 'PAUCARTAMBO', 1),
(769, 77, 'CAICAY', 1),
(770, 77, 'CHALLABAMBA', 1),
(771, 77, 'COLQUEPATA', 1),
(772, 77, 'HUANCARANI', 1),
(773, 77, 'KOS&Ntilde;IPATA', 1),
(774, 78, 'URCOS', 1),
(775, 78, 'ANDAHUAYLILLAS', 1),
(776, 78, 'CAMANTI', 1),
(777, 78, 'CCARHUAYO', 1),
(778, 78, 'CCATCA', 1),
(779, 78, 'CUSIPATA', 1),
(780, 78, 'HUARO', 1),
(781, 78, 'LUCRE', 1),
(782, 78, 'MARCAPATA', 1),
(783, 78, 'OCONGATE', 1),
(784, 78, 'OROPESA', 1),
(785, 78, 'QUIQUIJANA', 1),
(786, 79, 'URUBAMBA', 1),
(787, 79, 'CHINCHERO', 1),
(788, 79, 'HUAYLLABAMBA', 1),
(789, 79, 'MACHUPICCHU', 1),
(790, 79, 'MARAS', 1),
(791, 79, 'OLLANTAYTAMBO', 1),
(792, 79, 'YUCAY', 1),
(793, 80, 'HUANCAVELICA', 1),
(794, 80, 'ACOBAMBILLA', 1),
(795, 80, 'ACORIA', 1),
(796, 80, 'CONAYCA', 1),
(797, 80, 'CUENCA', 1),
(798, 80, 'HUACHOCOLPA', 1),
(799, 80, 'HUAYLLAHUARA', 1),
(800, 80, 'IZCUCHACA', 1),
(801, 80, 'LARIA', 1),
(802, 80, 'MANTA', 1),
(803, 80, 'MARISCAL CACERES', 1),
(804, 80, 'MOYA', 1),
(805, 80, 'NUEVO OCCORO', 1),
(806, 80, 'PALCA', 1),
(807, 80, 'PILCHACA', 1),
(808, 80, 'VILCA', 1),
(809, 80, 'YAULI', 1),
(810, 80, 'ASCENSION', 1),
(811, 80, 'HUANDO', 1),
(812, 81, 'ACOBAMBA', 1),
(813, 81, 'ANDABAMBA', 1),
(814, 81, 'ANTA', 1),
(815, 81, 'CAJA', 1),
(816, 81, 'MARCAS', 1),
(817, 81, 'PAUCARA', 1),
(818, 81, 'POMACOCHA', 1),
(819, 81, 'ROSARIO', 1),
(820, 82, 'LIRCAY', 1),
(821, 82, 'ANCHONGA', 1),
(822, 82, 'CALLANMARCA', 1),
(823, 82, 'CCOCHACCASA', 1),
(824, 82, 'CHINCHO', 1),
(825, 82, 'CONGALLA', 1),
(826, 82, 'HUANCA-HUANCA', 1),
(827, 82, 'HUAYLLAY GRANDE', 1),
(828, 82, 'JULCAMARCA', 1),
(829, 82, 'SAN ANTONIO DE ANTAPARCO', 1),
(830, 82, 'SANTO TOMAS DE PATA', 1),
(831, 82, 'SECCLLA', 1),
(832, 83, 'CASTROVIRREYNA', 1),
(833, 83, 'ARMA', 1),
(834, 83, 'AURAHUA', 1),
(835, 83, 'CAPILLAS', 1),
(836, 83, 'CHUPAMARCA', 1),
(837, 83, 'COCAS', 1),
(838, 83, 'HUACHOS', 1),
(839, 83, 'HUAMATAMBO', 1),
(840, 83, 'MOLLEPAMPA', 1),
(841, 83, 'SAN JUAN', 1),
(842, 83, 'SANTA ANA', 1),
(843, 83, 'TANTARA', 1),
(844, 83, 'TICRAPO', 1),
(845, 84, 'CHURCAMPA', 1),
(846, 84, 'ANCO', 1),
(847, 84, 'CHINCHIHUASI', 1),
(848, 84, 'EL CARMEN', 1),
(849, 84, 'LA MERCED', 1),
(850, 84, 'LOCROJA', 1),
(851, 84, 'PAUCARBAMBA', 1),
(852, 84, 'SAN MIGUEL DE MAYOCC', 1),
(853, 84, 'SAN PEDRO DE CORIS', 1),
(854, 84, 'PACHAMARCA', 1),
(855, 85, 'HUAYTARA', 1),
(856, 85, 'AYAVI', 1),
(857, 85, 'CORDOVA', 1),
(858, 85, 'HUAYACUNDO ARMA', 1),
(859, 85, 'LARAMARCA', 1),
(860, 85, 'OCOYO', 1),
(861, 85, 'PILPICHACA', 1),
(862, 85, 'QUERCO', 1),
(863, 85, 'QUITO-ARMA', 1),
(864, 85, 'SAN ANTONIO DE CUSICANCHA', 1),
(865, 85, 'SAN FRANCISCO DE SANGAYAICO', 1),
(866, 85, 'SAN ISIDRO', 1),
(867, 85, 'SANTIAGO DE CHOCORVOS', 1),
(868, 85, 'SANTIAGO DE QUIRAHUARA', 1),
(869, 85, 'SANTO DOMINGO DE CAPILLAS', 1),
(870, 85, 'TAMBO', 1),
(871, 86, 'PAMPAS', 1),
(872, 86, 'ACOSTAMBO', 1),
(873, 86, 'ACRAQUIA', 1),
(874, 86, 'AHUAYCHA', 1),
(875, 86, 'COLCABAMBA', 1),
(876, 86, 'DANIEL HERNANDEZ', 1),
(877, 86, 'HUACHOCOLPA', 1),
(878, 86, 'HUARIBAMBA', 1),
(879, 86, '&Ntilde;AHUIMPUQUIO', 1),
(880, 86, 'PAZOS', 1),
(881, 86, 'QUISHUAR', 1),
(882, 86, 'SALCABAMBA', 1),
(883, 86, 'SALCAHUASI', 1),
(884, 86, 'SAN MARCOS DE ROCCHAC', 1),
(885, 86, 'SURCUBAMBA', 1),
(886, 86, 'TINTAY PUNCU', 1),
(887, 87, 'HUANUCO', 1),
(888, 87, 'AMARILIS', 1),
(889, 87, 'CHINCHAO', 1),
(890, 87, 'CHURUBAMBA', 1),
(891, 87, 'MARGOS', 1),
(892, 87, 'QUISQUI', 1),
(893, 87, 'SAN FRANCISCO DE CAYRAN', 1),
(894, 87, 'SAN PEDRO DE CHAULAN', 1),
(895, 87, 'SANTA MARIA DEL VALLE', 1),
(896, 87, 'YARUMAYO', 1),
(897, 87, 'PILLCO MARCA', 1),
(898, 88, 'AMBO', 1),
(899, 88, 'CAYNA', 1),
(900, 88, 'COLPAS', 1),
(901, 88, 'CONCHAMARCA', 1),
(902, 88, 'HUACAR', 1),
(903, 88, 'SAN FRANCISCO', 1),
(904, 88, 'SAN RAFAEL', 1),
(905, 88, 'TOMAY KICHWA', 1),
(906, 89, 'LA UNION', 1),
(907, 89, 'CHUQUIS', 1),
(908, 89, 'MARIAS', 1),
(909, 89, 'PACHAS', 1),
(910, 89, 'QUIVILLA', 1),
(911, 89, 'RIPAN', 1),
(912, 89, 'SHUNQUI', 1),
(913, 89, 'SILLAPATA', 1),
(914, 89, 'YANAS', 1),
(915, 90, 'HUACAYBAMBA', 1),
(916, 90, 'CANCHABAMBA', 1),
(917, 90, 'COCHABAMBA', 1),
(918, 90, 'PINRA', 1),
(919, 91, 'LLATA', 1),
(920, 91, 'ARANCAY', 1),
(921, 91, 'CHAVIN DE PARIARCA', 1),
(922, 91, 'JACAS GRANDE', 1),
(923, 91, 'JIRCAN', 1),
(924, 91, 'MIRAFLORES', 1),
(925, 91, 'MONZON', 1),
(926, 91, 'PUNCHAO', 1),
(927, 91, 'PUÃ‘OS', 1),
(928, 91, 'SINGA', 1),
(929, 91, 'TANTAMAYO', 1),
(930, 92, 'RUPA-RUPA', 1),
(931, 92, 'DANIEL ALOMIA ROBLES', 1),
(932, 92, 'HERMILIO VALDIZAN', 1),
(933, 92, 'JOSE CRESPO Y CASTILLO', 1),
(934, 92, 'LUYANDO', 1),
(935, 92, 'MARIANO DAMASO BERAUN', 1),
(936, 93, 'HUACRACHUCO', 1),
(937, 93, 'CHOLON', 1),
(938, 93, 'SAN BUENAVENTURA', 1),
(939, 94, 'PANAO', 1),
(940, 94, 'CHAGLLA', 1),
(941, 94, 'MOLINO', 1),
(942, 94, 'UMARI', 1),
(943, 95, 'PUERTO INCA', 1),
(944, 95, 'CODO DEL POZUZO', 1),
(945, 95, 'HONORIA', 1),
(946, 95, 'TOURNAVISTA', 1),
(947, 95, 'YUYAPICHIS', 1),
(948, 96, 'JESUS', 1),
(949, 96, 'BAÃ‘OS', 1),
(950, 96, 'JIVIA', 1),
(951, 96, 'QUEROPALCA', 1),
(952, 96, 'RONDOS', 1),
(953, 96, 'SAN FRANCISCO DE ASIS', 1),
(954, 96, 'SAN MIGUEL DE CAURI', 1),
(955, 97, 'CHAVINILLO', 1),
(956, 97, 'CAHUAC', 1),
(957, 97, 'CHACABAMBA', 1),
(958, 97, 'APARICIO POMARES', 1),
(959, 97, 'JACAS CHICO', 1),
(960, 97, 'OBAS', 1),
(961, 97, 'PAMPAMARCA', 1),
(962, 97, 'CHORAS', 1),
(963, 98, 'ICA', 1),
(964, 98, 'LA TINGUI&Ntilde;A', 1),
(965, 98, 'LOS AQUIJES', 1),
(966, 98, 'OCUCAJE', 1),
(967, 98, 'PACHACUTEC', 1),
(968, 98, 'PARCONA', 1),
(969, 98, 'PUEBLO NUEVO', 1),
(970, 98, 'SALAS', 1),
(971, 98, 'SAN JOSE DE LOS MOLINOS', 1),
(972, 98, 'SAN JUAN BAUTISTA', 1),
(973, 98, 'SANTIAGO', 1),
(974, 98, 'SUBTANJALLA', 1),
(975, 98, 'TATE', 1),
(976, 98, 'YAUCA DEL ROSARIO', 1),
(977, 99, 'CHINCHA ALTA', 1),
(978, 99, 'ALTO LARAN', 1),
(979, 99, 'CHAVIN', 1),
(980, 99, 'CHINCHA BAJA', 1),
(981, 99, 'EL CARMEN', 1),
(982, 99, 'GROCIO PRADO', 1),
(983, 99, 'PUEBLO NUEVO', 1),
(984, 99, 'SAN JUAN DE YANAC', 1),
(985, 99, 'SAN PEDRO DE HUACARPANA', 1),
(986, 99, 'SUNAMPE', 1),
(987, 99, 'TAMBO DE MORA', 1),
(988, 100, 'NAZCA', 1),
(989, 100, 'CHANGUILLO', 1),
(990, 100, 'EL INGENIO', 1),
(991, 100, 'MARCONA', 1),
(992, 100, 'VISTA ALEGRE', 1),
(993, 101, 'PALPA', 1),
(994, 101, 'LLIPATA', 1),
(995, 101, 'RIO GRANDE', 1),
(996, 101, 'SANTA CRUZ', 1),
(997, 101, 'TIBILLO', 1),
(998, 102, 'PISCO', 1),
(999, 102, 'HUANCANO', 1),
(1000, 102, 'HUMAY', 1),
(1001, 102, 'INDEPENDENCIA', 1),
(1002, 102, 'PARACAS', 1),
(1003, 102, 'SAN ANDRES', 1),
(1004, 102, 'SAN CLEMENTE', 1),
(1005, 102, 'TUPAC AMARU INCA', 1),
(1006, 103, 'HUANCAYO', 1),
(1007, 103, 'CARHUACALLANGA', 1),
(1008, 103, 'CHACAPAMPA', 1),
(1009, 103, 'CHICCHE', 1),
(1010, 103, 'CHILCA', 1),
(1011, 103, 'CHONGOS ALTO', 1),
(1012, 103, 'CHUPURO', 1),
(1013, 103, 'COLCA', 1),
(1014, 103, 'CULLHUAS', 1),
(1015, 103, 'EL TAMBO', 1),
(1016, 103, 'HUACRAPUQUIO', 1),
(1017, 103, 'HUALHUAS', 1),
(1018, 103, 'HUANCAN', 1),
(1019, 103, 'HUASICANCHA', 1),
(1020, 103, 'HUAYUCACHI', 1),
(1021, 103, 'INGENIO', 1),
(1022, 103, 'PARIAHUANCA', 1),
(1023, 103, 'PILCOMAYO', 1),
(1024, 103, 'PUCARA', 1),
(1025, 103, 'QUICHUAY', 1),
(1026, 103, 'QUILCAS', 1),
(1027, 103, 'SAN AGUSTIN', 1),
(1028, 103, 'SAN JERONIMO DE TUNAN', 1),
(1029, 103, 'SAÃ‘O', 1),
(1030, 103, 'SAPALLANGA', 1),
(1031, 103, 'SICAYA', 1),
(1032, 103, 'SANTO DOMINGO DE ACOBAMBA', 1),
(1033, 103, 'VIQUES', 1),
(1034, 104, 'CONCEPCION', 1),
(1035, 104, 'ACO', 1),
(1036, 104, 'ANDAMARCA', 1),
(1037, 104, 'CHAMBARA', 1),
(1038, 104, 'COCHAS', 1),
(1039, 104, 'COMAS', 1),
(1040, 104, 'HEROINAS TOLEDO', 1),
(1041, 104, 'MANZANARES', 1),
(1042, 104, 'MARISCAL CASTILLA', 1),
(1043, 104, 'MATAHUASI', 1),
(1044, 104, 'MITO', 1),
(1045, 104, 'NUEVE DE JULIO', 1),
(1046, 104, 'ORCOTUNA', 1),
(1047, 104, 'SAN JOSE DE QUERO', 1),
(1048, 104, 'SANTA ROSA DE OCOPA', 1),
(1049, 105, 'CHANCHAMAYO', 1),
(1050, 105, 'PERENE', 1),
(1051, 105, 'PICHANAQUI', 1),
(1052, 105, 'SAN LUIS DE SHUARO', 1),
(1053, 105, 'SAN RAMON', 1),
(1054, 105, 'VITOC', 1),
(1055, 106, 'JAUJA', 1),
(1056, 106, 'ACOLLA', 1),
(1057, 106, 'APATA', 1),
(1058, 106, 'ATAURA', 1),
(1059, 106, 'CANCHAYLLO', 1),
(1060, 106, 'CURICACA', 1),
(1061, 106, 'EL MANTARO', 1),
(1062, 106, 'HUAMALI', 1),
(1063, 106, 'HUARIPAMPA', 1),
(1064, 106, 'HUERTAS', 1),
(1065, 106, 'JANJAILLO', 1),
(1066, 106, 'JULCAN', 1),
(1067, 106, 'LEONOR ORDOÃ‘EZ', 1),
(1068, 106, 'LLOCLLAPAMPA', 1),
(1069, 106, 'MARCO', 1),
(1070, 106, 'MASMA', 1),
(1071, 106, 'MASMA CHICCHE', 1),
(1072, 106, 'MOLINOS', 1),
(1073, 106, 'MONOBAMBA', 1),
(1074, 106, 'MUQUI', 1),
(1075, 106, 'MUQUIYAUYO', 1),
(1076, 106, 'PACA', 1),
(1077, 106, 'PACCHA', 1),
(1078, 106, 'PANCAN', 1),
(1079, 106, 'PARCO', 1),
(1080, 106, 'POMACANCHA', 1),
(1081, 106, 'RICRAN', 1),
(1082, 106, 'SAN LORENZO', 1),
(1083, 106, 'SAN PEDRO DE CHUNAN', 1),
(1084, 106, 'SAUSA', 1),
(1085, 106, 'SINCOS', 1),
(1086, 106, 'TUNAN MARCA', 1),
(1087, 106, 'YAULI', 1),
(1088, 106, 'YAUYOS', 1),
(1089, 107, 'JUNIN', 1),
(1090, 107, 'CARHUAMAYO', 1),
(1091, 107, 'ONDORES', 1),
(1092, 107, 'ULCUMAYO', 1),
(1093, 108, 'SATIPO', 1),
(1094, 108, 'COVIRIALI', 1),
(1095, 108, 'LLAYLLA', 1),
(1096, 108, 'MAZAMARI', 1),
(1097, 108, 'PAMPA HERMOSA', 1),
(1098, 108, 'PANGOA', 1),
(1099, 108, 'RIO NEGRO', 1),
(1100, 108, 'RIO TAMBO', 1),
(1101, 109, 'TARMA', 1),
(1102, 109, 'ACOBAMBA', 1),
(1103, 109, 'HUARICOLCA', 1),
(1104, 109, 'HUASAHUASI', 1),
(1105, 109, 'LA UNION', 1),
(1106, 109, 'PALCA', 1),
(1107, 109, 'PALCAMAYO', 1),
(1108, 109, 'SAN PEDRO DE CAJAS', 1),
(1109, 109, 'TAPO', 1),
(1110, 110, 'LA OROYA', 1),
(1111, 110, 'CHACAPALPA', 1),
(1112, 110, 'HUAY-HUAY', 1),
(1113, 110, 'MARCAPOMACOCHA', 1),
(1114, 110, 'MOROCOCHA', 1),
(1115, 110, 'PACCHA', 1),
(1116, 110, 'SANTA BARBARA DE CARHUACAYAN', 1),
(1117, 110, 'SANTA ROSA DE SACCO', 1),
(1118, 110, 'SUITUCANCHA', 1),
(1119, 110, 'YAULI', 1),
(1120, 111, 'CHUPACA', 1),
(1121, 111, 'AHUAC', 1),
(1122, 111, 'CHONGOS BAJO', 1),
(1123, 111, 'HUACHAC', 1),
(1124, 111, 'HUAMANCACA CHICO', 1),
(1125, 111, 'SAN JUAN DE ISCOS', 1),
(1126, 111, 'SAN JUAN DE JARPA', 1),
(1127, 111, 'TRES DE DICIEMBRE', 1),
(1128, 111, 'YANACANCHA', 1),
(1129, 112, 'TRUJILLO', 1),
(1130, 112, 'EL PORVENIR', 1),
(1131, 112, 'FLORENCIA DE MORA', 1),
(1132, 112, 'HUANCHACO', 1),
(1133, 112, 'LA ESPERANZA', 1),
(1134, 112, 'LAREDO', 1),
(1135, 112, 'MOCHE', 1),
(1136, 112, 'POROTO', 1),
(1137, 112, 'SALAVERRY', 1),
(1138, 112, 'SIMBAL', 1),
(1139, 112, 'VICTOR LARCO HERRERA', 1),
(1140, 113, 'ASCOPE', 1),
(1141, 113, 'CHICAMA', 1),
(1142, 113, 'CHOCOPE', 1),
(1143, 113, 'MAGDALENA DE CAO', 1),
(1144, 113, 'PAIJAN', 1),
(1145, 113, 'RAZURI', 1),
(1146, 113, 'SANTIAGO DE CAO', 1),
(1147, 113, 'CASA GRANDE', 1),
(1148, 114, 'BOLIVAR', 1),
(1149, 114, 'BAMBAMARCA', 1),
(1150, 114, 'CONDORMARCA', 1),
(1151, 114, 'LONGOTEA', 1),
(1152, 114, 'UCHUMARCA', 1),
(1153, 114, 'UCUNCHA', 1),
(1154, 115, 'CHEPEN', 1),
(1155, 115, 'PACANGA', 1),
(1156, 115, 'PUEBLO NUEVO', 1),
(1157, 116, 'JULCAN', 1),
(1158, 116, 'CALAMARCA', 1),
(1159, 116, 'CARABAMBA', 1),
(1160, 116, 'HUASO', 1),
(1161, 117, 'OTUZCO', 1),
(1162, 117, 'AGALLPAMPA', 1),
(1163, 117, 'CHARAT', 1),
(1164, 117, 'HUARANCHAL', 1),
(1165, 117, 'LA CUESTA', 1),
(1166, 117, 'MACHE', 1),
(1167, 117, 'PARANDAY', 1),
(1168, 117, 'SALPO', 1),
(1169, 117, 'SINSICAP', 1),
(1170, 117, 'USQUIL', 1),
(1171, 118, 'SAN PEDRO DE LLOC', 1),
(1172, 118, 'GUADALUPE', 1),
(1173, 118, 'JEQUETEPEQUE', 1),
(1174, 118, 'PACASMAYO', 1),
(1175, 118, 'SAN JOSE', 1),
(1176, 119, 'TAYABAMBA', 1),
(1177, 119, 'BULDIBUYO', 1),
(1178, 119, 'CHILLIA', 1),
(1179, 119, 'HUANCASPATA', 1),
(1180, 119, 'HUAYLILLAS', 1),
(1181, 119, 'HUAYO', 1),
(1182, 119, 'ONGON', 1),
(1183, 119, 'PARCOY', 1),
(1184, 119, 'PATAZ', 1),
(1185, 119, 'PIAS', 1),
(1186, 119, 'SANTIAGO DE CHALLAS', 1),
(1187, 119, 'TAURIJA', 1),
(1188, 119, 'URPAY', 1),
(1189, 120, 'HUAMACHUCO', 1),
(1190, 120, 'CHUGAY', 1),
(1191, 120, 'COCHORCO', 1),
(1192, 120, 'CURGOS', 1),
(1193, 120, 'MARCABAL', 1),
(1194, 120, 'SANAGORAN', 1),
(1195, 120, 'SARIN', 1),
(1196, 120, 'SARTIMBAMBA', 1),
(1197, 121, 'SANTIAGO DE CHUCO', 1),
(1198, 121, 'ANGASMARCA', 1),
(1199, 121, 'CACHICADAN', 1),
(1200, 121, 'MOLLEBAMBA', 1),
(1201, 121, 'MOLLEPATA', 1),
(1202, 121, 'QUIRUVILCA', 1),
(1203, 121, 'SANTA CRUZ DE CHUCA', 1),
(1204, 121, 'SITABAMBA', 1),
(1205, 122, 'GRAN CHIMU', 1),
(1206, 122, 'CASCAS', 1),
(1207, 122, 'LUCMA', 1),
(1208, 122, 'MARMOT', 1),
(1209, 122, 'SAYAPULLO', 1),
(1210, 123, 'VIRU', 1),
(1211, 123, 'CHAO', 1),
(1212, 123, 'GUADALUPITO', 1),
(1213, 124, 'CHICLAYO', 1),
(1214, 124, 'CHONGOYAPE', 1),
(1215, 124, 'ETEN', 1),
(1216, 124, 'ETEN PUERTO', 1),
(1217, 124, 'JOSE LEONARDO ORTIZ', 1),
(1218, 124, 'LA VICTORIA', 1),
(1219, 124, 'LAGUNAS', 1),
(1220, 124, 'MONSEFU', 1),
(1221, 124, 'NUEVA ARICA', 1),
(1222, 124, 'OYOTUN', 1),
(1223, 124, 'PICSI', 1),
(1224, 124, 'PIMENTEL', 1),
(1225, 124, 'REQUE', 1),
(1226, 124, 'SANTA ROSA', 1),
(1227, 124, 'SAÃ‘A', 1),
(1228, 124, 'CAYALTI', 1),
(1229, 124, 'PATAPO', 1),
(1230, 124, 'POMALCA', 1),
(1231, 124, 'PUCALA', 1),
(1232, 124, 'TUMAN', 1),
(1233, 125, 'FERREÃ‘AFE', 1),
(1234, 125, 'CAÃ‘ARIS', 1),
(1235, 125, 'INCAHUASI', 1),
(1236, 125, 'MANUEL ANTONIO MESONES MURO', 1),
(1237, 125, 'PITIPO', 1),
(1238, 125, 'PUEBLO NUEVO', 1),
(1239, 126, 'LAMBAYEQUE', 1),
(1240, 126, 'CHOCHOPE', 1),
(1241, 126, 'ILLIMO', 1),
(1242, 126, 'JAYANCA', 1),
(1243, 126, 'MOCHUMI', 1),
(1244, 126, 'MORROPE', 1),
(1245, 126, 'MOTUPE', 1),
(1246, 126, 'OLMOS', 1),
(1247, 126, 'PACORA', 1),
(1248, 126, 'SALAS', 1),
(1249, 126, 'SAN JOSE', 1),
(1250, 126, 'TUCUME', 1),
(1251, 127, 'LIMA', 1),
(1252, 127, 'ANCON', 1),
(1253, 127, 'ATE', 1),
(1254, 127, 'BARRANCO', 1),
(1255, 127, 'BRE&Ntilde;A', 1),
(1256, 127, 'CARABAYLLO', 1),
(1257, 127, 'CHACLACAYO', 1),
(1258, 127, 'CHORRILLOS', 1),
(1259, 127, 'CIENEGUILLA', 1),
(1260, 127, 'COMAS', 1),
(1261, 127, 'EL AGUSTINO', 1),
(1262, 127, 'INDEPENDENCIA', 1),
(1263, 127, 'JESUS MARIA', 1),
(1264, 127, 'LA MOLINA', 1),
(1265, 127, 'LA VICTORIA', 1),
(1266, 127, 'LINCE', 1),
(1267, 127, 'LOS OLIVOS', 1),
(1268, 127, 'LURIGANCHO', 1),
(1269, 127, 'LURIN', 1),
(1270, 127, 'MAGDALENA DEL MAR', 1),
(1271, 127, 'MAGDALENA VIEJA', 1),
(1272, 127, 'MIRAFLORES', 1),
(1273, 127, 'PACHACAMAC', 1),
(1274, 127, 'PUCUSANA', 1),
(1275, 127, 'PUENTE PIEDRA', 1),
(1276, 127, 'PUNTA HERMOSA', 1),
(1277, 127, 'PUNTA NEGRA', 1),
(1278, 127, 'RIMAC', 1),
(1279, 127, 'SAN BARTOLO', 1),
(1280, 127, 'SAN BORJA', 1),
(1281, 127, 'SAN ISIDRO', 1),
(1282, 127, 'SAN JUAN DE LURIGANCHO', 1),
(1283, 127, 'SAN JUAN DE MIRAFLORES', 1),
(1284, 127, 'SAN LUIS', 1),
(1285, 127, 'SAN MARTIN DE PORRES', 1),
(1286, 127, 'SAN MIGUEL', 1),
(1287, 127, 'SANTA ANITA', 1),
(1288, 127, 'SANTA MARIA DEL MAR', 1),
(1289, 127, 'SANTA ROSA', 1),
(1290, 127, 'SANTIAGO DE SURCO', 1),
(1291, 127, 'SURQUILLO', 1),
(1292, 127, 'VILLA EL SALVADOR', 1),
(1293, 127, 'VILLA MARIA DEL TRIUNFO', 1),
(1294, 128, 'BARRANCA', 1),
(1295, 128, 'PARAMONGA', 1),
(1296, 128, 'PATIVILCA', 1),
(1297, 128, 'SUPE', 1),
(1298, 128, 'SUPE PUERTO', 1),
(1299, 129, 'CAJATAMBO', 1),
(1300, 129, 'COPA', 1),
(1301, 129, 'GORGOR', 1),
(1302, 129, 'HUANCAPON', 1),
(1303, 129, 'MANAS', 1),
(1304, 130, 'CANTA', 1),
(1305, 130, 'ARAHUAY', 1),
(1306, 130, 'HUAMANTANGA', 1),
(1307, 130, 'HUAROS', 1),
(1308, 130, 'LACHAQUI', 1),
(1309, 130, 'SAN BUENAVENTURA', 1),
(1310, 130, 'SANTA ROSA DE QUIVES', 1),
(1311, 131, 'SAN VICENTE DE CAÃ‘ETE', 1),
(1312, 131, 'ASIA', 1),
(1313, 131, 'CALANGO', 1),
(1314, 131, 'CERRO AZUL', 1),
(1315, 131, 'CHILCA', 1),
(1316, 131, 'COAYLLO', 1),
(1317, 131, 'IMPERIAL', 1),
(1318, 131, 'LUNAHUANA', 1),
(1319, 131, 'MALA', 1),
(1320, 131, 'NUEVO IMPERIAL', 1),
(1321, 131, 'PACARAN', 1),
(1322, 131, 'QUILMANA', 1),
(1323, 131, 'SAN ANTONIO', 1),
(1324, 131, 'SAN LUIS', 1),
(1325, 131, 'SANTA CRUZ DE FLORES', 1),
(1326, 131, 'ZU&Ntilde;IGA', 1),
(1327, 132, 'HUARAL', 1),
(1328, 132, 'ATAVILLOS ALTO', 1),
(1329, 132, 'ATAVILLOS BAJO', 1),
(1330, 132, 'AUCALLAMA', 1),
(1331, 132, 'CHANCAY', 1),
(1332, 132, 'IHUARI', 1),
(1333, 132, 'LAMPIAN', 1),
(1334, 132, 'PACARAOS', 1),
(1335, 132, 'SAN MIGUEL DE ACOS', 1),
(1336, 132, 'SANTA CRUZ DE ANDAMARCA', 1),
(1337, 132, 'SUMBILCA', 1),
(1338, 132, 'VEINTISIETE DE NOVIEMBRE', 1),
(1339, 133, 'MATUCANA', 1),
(1340, 133, 'ANTIOQUIA', 1),
(1341, 133, 'CALLAHUANCA', 1),
(1342, 133, 'CARAMPOMA', 1),
(1343, 133, 'CHICLA', 1),
(1344, 133, 'CUENCA', 1),
(1345, 133, 'HUACHUPAMPA', 1),
(1346, 133, 'HUANZA', 1),
(1347, 133, 'HUAROCHIRI', 1),
(1348, 133, 'LAHUAYTAMBO', 1),
(1349, 133, 'LANGA', 1),
(1350, 133, 'LARAOS', 1),
(1351, 133, 'MARIATANA', 1),
(1352, 133, 'RICARDO PALMA', 1),
(1353, 133, 'SAN ANDRES DE TUPICOCHA', 1),
(1354, 133, 'SAN ANTONIO', 1),
(1355, 133, 'SAN BARTOLOME', 1),
(1356, 133, 'SAN DAMIAN', 1),
(1357, 133, 'SAN JUAN DE IRIS', 1),
(1358, 133, 'SAN JUAN DE TANTARANCHE', 1),
(1359, 133, 'SAN LORENZO DE QUINTI', 1),
(1360, 133, 'SAN MATEO', 1),
(1361, 133, 'SAN MATEO DE OTAO', 1),
(1362, 133, 'SAN PEDRO DE CASTA', 1),
(1363, 133, 'SAN PEDRO DE HUANCAYRE', 1),
(1364, 133, 'SANGALLAYA', 1),
(1365, 133, 'SANTA CRUZ DE COCACHACRA', 1),
(1366, 133, 'SANTA EULALIA', 1),
(1367, 133, 'SANTIAGO DE ANCHUCAYA', 1),
(1368, 133, 'SANTIAGO DE TUNA', 1),
(1369, 133, 'SANTO DOMINGO DE LOS OLLEROS', 1),
(1370, 133, 'SURCO', 1),
(1371, 134, 'HUACHO', 1),
(1372, 134, 'AMBAR', 1),
(1373, 134, 'CALETA DE CARQUIN', 1),
(1374, 134, 'CHECRAS', 1),
(1375, 134, 'HUALMAY', 1),
(1376, 134, 'HUAURA', 1),
(1377, 134, 'LEONCIO PRADO', 1),
(1378, 134, 'PACCHO', 1),
(1379, 134, 'SANTA LEONOR', 1),
(1380, 134, 'SANTA MARIA', 1),
(1381, 134, 'SAYAN', 1),
(1382, 134, 'VEGUETA', 1),
(1383, 135, 'OYON', 1),
(1384, 135, 'ANDAJES', 1),
(1385, 135, 'CAUJUL', 1),
(1386, 135, 'COCHAMARCA', 1),
(1387, 135, 'NAVAN', 1),
(1388, 135, 'PACHANGARA', 1),
(1389, 136, 'YAUYOS', 1),
(1390, 136, 'ALIS', 1),
(1391, 136, 'AYAUCA', 1),
(1392, 136, 'AYAVIRI', 1),
(1393, 136, 'AZANGARO', 1),
(1394, 136, 'CACRA', 1),
(1395, 136, 'CARANIA', 1),
(1396, 136, 'CATAHUASI', 1),
(1397, 136, 'CHOCOS', 1),
(1398, 136, 'COCHAS', 1),
(1399, 136, 'COLONIA', 1),
(1400, 136, 'HONGOS', 1),
(1401, 136, 'HUAMPARA', 1),
(1402, 136, 'HUANCAYA', 1),
(1403, 136, 'HUANGASCAR', 1),
(1404, 136, 'HUANTAN', 1),
(1405, 136, 'HUAÃ‘EC', 1),
(1406, 136, 'LARAOS', 1),
(1407, 136, 'LINCHA', 1),
(1408, 136, 'MADEAN', 1),
(1409, 136, 'MIRAFLORES', 1),
(1410, 136, 'OMAS', 1),
(1411, 136, 'PUTINZA', 1),
(1412, 136, 'QUINCHES', 1),
(1413, 136, 'QUINOCAY', 1),
(1414, 136, 'SAN JOAQUIN', 1),
(1415, 136, 'SAN PEDRO DE PILAS', 1),
(1416, 136, 'TANTA', 1),
(1417, 136, 'TAURIPAMPA', 1),
(1418, 136, 'TOMAS', 1),
(1419, 136, 'TUPE', 1),
(1420, 136, 'VIÃ‘AC', 1),
(1421, 136, 'VITIS', 1),
(1422, 137, 'IQUITOS', 1),
(1423, 137, 'ALTO NANAY', 1),
(1424, 137, 'FERNANDO LORES', 1),
(1425, 137, 'INDIANA', 1),
(1426, 137, 'LAS AMAZONAS', 1),
(1427, 137, 'MAZAN', 1),
(1428, 137, 'NAPO', 1),
(1429, 137, 'PUNCHANA', 1),
(1430, 137, 'PUTUMAYO', 1),
(1431, 137, 'TORRES CAUSANA', 1),
(1432, 137, 'BELEN', 1),
(1433, 137, 'SAN JUAN BAUTISTA', 1),
(1434, 138, 'YURIMAGUAS', 1),
(1435, 138, 'BALSAPUERTO', 1),
(1436, 138, 'BARRANCA', 1),
(1437, 138, 'CAHUAPANAS', 1),
(1438, 138, 'JEBEROS', 1),
(1439, 138, 'LAGUNAS', 1),
(1440, 138, 'MANSERICHE', 1),
(1441, 138, 'MORONA', 1),
(1442, 138, 'PASTAZA', 1),
(1443, 138, 'SANTA CRUZ', 1),
(1444, 138, 'TENIENTE CESAR LOPEZ ROJAS', 1),
(1445, 139, 'NAUTA', 1),
(1446, 139, 'PARINARI', 1),
(1447, 139, 'TIGRE', 1),
(1448, 139, 'TROMPETEROS', 1),
(1449, 139, 'URARINAS', 1),
(1450, 140, 'RAMON CASTILLA', 1),
(1451, 140, 'PEBAS', 1),
(1452, 140, 'YAVARI', 1),
(1453, 140, 'SAN PABLO', 1),
(1454, 141, 'REQUENA', 1),
(1455, 141, 'ALTO TAPICHE', 1),
(1456, 141, 'CAPELO', 1),
(1457, 141, 'EMILIO SAN MARTIN', 1),
(1458, 141, 'MAQUIA', 1),
(1459, 141, 'PUINAHUA', 1),
(1460, 141, 'SAQUENA', 1),
(1461, 141, 'SOPLIN', 1),
(1462, 141, 'TAPICHE', 1),
(1463, 141, 'JENARO HERRERA', 1),
(1464, 141, 'YAQUERANA', 1),
(1465, 142, 'CONTAMANA', 1),
(1466, 142, 'INAHUAYA', 1),
(1467, 142, 'PADRE MARQUEZ', 1),
(1468, 142, 'PAMPA HERMOSA', 1),
(1469, 142, 'SARAYACU', 1),
(1470, 142, 'VARGAS GUERRA', 1),
(1471, 143, 'TAMBOPATA', 1),
(1472, 143, 'INAMBARI', 1),
(1473, 143, 'LAS PIEDRAS', 1),
(1474, 143, 'LABERINTO', 1),
(1475, 144, 'MANU', 1),
(1476, 144, 'FITZCARRALD', 1),
(1477, 144, 'MADRE DE DIOS', 1),
(1478, 144, 'HUEPETUHE', 1),
(1479, 145, 'IÃ‘APARI', 1),
(1480, 145, 'IBERIA', 1),
(1481, 145, 'TAHUAMANU', 1),
(1482, 146, 'MOQUEGUA', 1),
(1483, 146, 'CARUMAS', 1),
(1484, 146, 'CUCHUMBAYA', 1),
(1485, 146, 'SAMEGUA', 1),
(1486, 146, 'SAN CRISTOBAL', 1),
(1487, 146, 'TORATA', 1),
(1488, 147, 'OMATE', 1),
(1489, 147, 'CHOJATA', 1),
(1490, 147, 'COALAQUE', 1),
(1491, 147, 'ICHU&Ntilde;A', 1),
(1492, 147, 'LA CAPILLA', 1),
(1493, 147, 'LLOQUE', 1),
(1494, 147, 'MATALAQUE', 1),
(1495, 147, 'PUQUINA', 1),
(1496, 147, 'QUINISTAQUILLAS', 1),
(1497, 147, 'UBINAS', 1),
(1498, 147, 'YUNGA', 1),
(1499, 148, 'ILO', 1),
(1500, 148, 'EL ALGARROBAL', 1),
(1501, 148, 'PACOCHA', 1),
(1502, 149, 'CHAUPIMARCA', 1),
(1503, 149, 'HUACHON', 1),
(1504, 149, 'HUARIACA', 1),
(1505, 149, 'HUAYLLAY', 1),
(1506, 149, 'NINACACA', 1),
(1507, 149, 'PALLANCHACRA', 1),
(1508, 149, 'PAUCARTAMBO', 1),
(1509, 149, 'SAN FCO.DE ASIS DE YARUSYACAN', 1),
(1510, 149, 'SIMON BOLIVAR', 1),
(1511, 149, 'TICLACAYAN', 1),
(1512, 149, 'TINYAHUARCO', 1),
(1513, 149, 'VICCO', 1),
(1514, 149, 'YANACANCHA', 1),
(1515, 150, 'YANAHUANCA', 1),
(1516, 150, 'CHACAYAN', 1),
(1517, 150, 'GOYLLARISQUIZGA', 1),
(1518, 150, 'PAUCAR', 1),
(1519, 150, 'SAN PEDRO DE PILLAO', 1),
(1520, 150, 'SANTA ANA DE TUSI', 1),
(1521, 150, 'TAPUC', 1),
(1522, 150, 'VILCABAMBA', 1),
(1523, 151, 'OXAPAMPA', 1),
(1524, 151, 'CHONTABAMBA', 1),
(1525, 151, 'HUANCABAMBA', 1),
(1526, 151, 'PALCAZU', 1),
(1527, 151, 'POZUZO', 1),
(1528, 151, 'PUERTO BERMUDEZ', 1),
(1529, 151, 'VILLA RICA', 1),
(1530, 152, 'PIURA', 1),
(1531, 152, 'CASTILLA', 1),
(1532, 152, 'CATACAOS', 1),
(1533, 152, 'CURA MORI', 1),
(1534, 152, 'EL TALLAN', 1),
(1535, 152, 'LA ARENA', 1),
(1536, 152, 'LA UNION', 1),
(1537, 152, 'LAS LOMAS', 1),
(1538, 152, 'TAMBO GRANDE', 1),
(1539, 153, 'AYABACA', 1),
(1540, 153, 'FRIAS', 1),
(1541, 153, 'JILILI', 1),
(1542, 153, 'LAGUNAS', 1),
(1543, 153, 'MONTERO', 1),
(1544, 153, 'PACAIPAMPA', 1),
(1545, 153, 'PAIMAS', 1),
(1546, 153, 'SAPILLICA', 1),
(1547, 153, 'SICCHEZ', 1),
(1548, 153, 'SUYO', 1),
(1549, 154, 'HUANCABAMBA', 1),
(1550, 154, 'CANCHAQUE', 1),
(1551, 154, 'EL CARMEN DE LA FRONTERA', 1),
(1552, 154, 'HUARMACA', 1),
(1553, 154, 'LALAQUIZ', 1),
(1554, 154, 'SAN MIGUEL DE EL FAIQUE', 1),
(1555, 154, 'SONDOR', 1),
(1556, 154, 'SONDORILLO', 1),
(1557, 155, 'CHULUCANAS', 1),
(1558, 155, 'BUENOS AIRES', 1),
(1559, 155, 'CHALACO', 1),
(1560, 155, 'LA MATANZA', 1),
(1561, 155, 'MORROPON', 1),
(1562, 155, 'SALITRAL', 1),
(1563, 155, 'SAN JUAN DE BIGOTE', 1),
(1564, 155, 'SANTA CATALINA DE MOSSA', 1),
(1565, 155, 'SANTO DOMINGO', 1),
(1566, 155, 'YAMANGO', 1),
(1567, 156, 'PAITA', 1),
(1568, 156, 'AMOTAPE', 1),
(1569, 156, 'ARENAL', 1),
(1570, 156, 'COLAN', 1),
(1571, 156, 'LA HUACA', 1),
(1572, 156, 'TAMARINDO', 1),
(1573, 156, 'VICHAYAL', 1),
(1574, 157, 'SULLANA', 1),
(1575, 157, 'BELLAVISTA', 1),
(1576, 157, 'IGNACIO ESCUDERO', 1),
(1577, 157, 'LANCONES', 1),
(1578, 157, 'MARCAVELICA', 1),
(1579, 157, 'MIGUEL CHECA', 1),
(1580, 157, 'QUERECOTILLO', 1),
(1581, 157, 'SALITRAL', 1),
(1582, 158, 'PARIÃ‘AS', 1),
(1583, 158, 'EL ALTO', 1),
(1584, 158, 'LA BREA', 1),
(1585, 158, 'LOBITOS', 1),
(1586, 158, 'LOS ORGANOS', 1),
(1587, 158, 'MANCORA', 1),
(1588, 159, 'SECHURA', 1),
(1589, 159, 'BELLAVISTA DE LA UNION', 1),
(1590, 159, 'BERNAL', 1),
(1591, 159, 'CRISTO NOS VALGA', 1),
(1592, 159, 'VICE', 1),
(1593, 159, 'RINCONADA LLICUAR', 1),
(1594, 160, 'PUNO', 1),
(1595, 160, 'ACORA', 1),
(1596, 160, 'AMANTANI', 1),
(1597, 160, 'ATUNCOLLA', 1),
(1598, 160, 'CAPACHICA', 1),
(1599, 160, 'CHUCUITO', 1),
(1600, 160, 'COATA', 1),
(1601, 160, 'HUATA', 1),
(1602, 160, 'MA&Ntilde;AZO', 1),
(1603, 160, 'PAUCARCOLLA', 1),
(1604, 160, 'PICHACANI', 1),
(1605, 160, 'PLATERIA', 1),
(1606, 160, 'SAN ANTONIO', 1),
(1607, 160, 'TIQUILLACA', 1),
(1608, 160, 'VILQUE', 1),
(1609, 161, 'AZANGARO', 1),
(1610, 161, 'ACHAYA', 1),
(1611, 161, 'ARAPA', 1),
(1612, 161, 'ASILLO', 1),
(1613, 161, 'CAMINACA', 1),
(1614, 161, 'CHUPA', 1),
(1615, 161, 'JOSE DOMINGO CHOQUEHUANCA', 1),
(1616, 161, 'MUÃ‘ANI', 1),
(1617, 161, 'POTONI', 1),
(1618, 161, 'SAMAN', 1),
(1619, 161, 'SAN ANTON', 1),
(1620, 161, 'SAN JOSE', 1),
(1621, 161, 'SAN JUAN DE SALINAS', 1),
(1622, 161, 'SANTIAGO DE PUPUJA', 1),
(1623, 161, 'TIRAPATA', 1),
(1624, 162, 'MACUSANI', 1),
(1625, 162, 'AJOYANI', 1),
(1626, 162, 'AYAPATA', 1),
(1627, 162, 'COASA', 1),
(1628, 162, 'CORANI', 1),
(1629, 162, 'CRUCERO', 1),
(1630, 162, 'ITUATA', 1),
(1631, 162, 'OLLACHEA', 1),
(1632, 162, 'SAN GABAN', 1),
(1633, 162, 'USICAYOS', 1),
(1634, 163, 'JULI', 1),
(1635, 163, 'DESAGUADERO', 1),
(1636, 163, 'HUACULLANI', 1),
(1637, 163, 'KELLUYO', 1),
(1638, 163, 'PISACOMA', 1),
(1639, 163, 'POMATA', 1),
(1640, 163, 'ZEPITA', 1),
(1641, 164, 'ILAVE', 1),
(1642, 164, 'CAPAZO', 1),
(1643, 164, 'PILCUYO', 1),
(1644, 164, 'SANTA ROSA', 1),
(1645, 164, 'CONDURIRI', 1),
(1646, 165, 'HUANCANE', 1),
(1647, 165, 'COJATA', 1),
(1648, 165, 'HUATASANI', 1),
(1649, 165, 'INCHUPALLA', 1),
(1650, 165, 'PUSI', 1),
(1651, 165, 'ROSASPATA', 1),
(1652, 165, 'TARACO', 1),
(1653, 165, 'VILQUE CHICO', 1),
(1654, 166, 'LAMPA', 1),
(1655, 166, 'CABANILLA', 1),
(1656, 166, 'CALAPUJA', 1),
(1657, 166, 'NICASIO', 1),
(1658, 166, 'OCUVIRI', 1),
(1659, 166, 'PALCA', 1),
(1660, 166, 'PARATIA', 1),
(1661, 166, 'PUCARA', 1),
(1662, 166, 'SANTA LUCIA', 1),
(1663, 166, 'VILAVILA', 1),
(1664, 167, 'AYAVIRI', 1),
(1665, 167, 'ANTAUTA', 1),
(1666, 167, 'CUPI', 1),
(1667, 167, 'LLALLI', 1),
(1668, 167, 'MACARI', 1),
(1669, 167, 'NU&Ntilde;OA', 1),
(1670, 167, 'ORURILLO', 1),
(1671, 167, 'SANTA ROSA', 1),
(1672, 167, 'UMACHIRI', 1),
(1673, 168, 'MOHO', 1),
(1674, 168, 'CONIMA', 1),
(1675, 168, 'HUAYRAPATA', 1),
(1676, 168, 'TILALI', 1),
(1677, 169, 'PUTINA', 1),
(1678, 169, 'ANANEA', 1),
(1679, 169, 'PEDRO VILCA APAZA', 1),
(1680, 169, 'QUILCAPUNCU', 1),
(1681, 169, 'SINA', 1),
(1682, 170, 'JULIACA', 1),
(1683, 170, 'CABANA', 1),
(1684, 170, 'CABANILLAS', 1),
(1685, 170, 'CARACOTO', 1),
(1686, 171, 'SANDIA', 1),
(1687, 171, 'CUYOCUYO', 1),
(1688, 171, 'LIMBANI', 1),
(1689, 171, 'PATAMBUCO', 1),
(1690, 171, 'PHARA', 1),
(1691, 171, 'QUIACA', 1),
(1692, 171, 'SAN JUAN DEL ORO', 1),
(1693, 171, 'YANAHUAYA', 1),
(1694, 171, 'ALTO INAMBARI', 1),
(1695, 172, 'YUNGUYO', 1),
(1696, 172, 'ANAPIA', 1),
(1697, 172, 'COPANI', 1),
(1698, 172, 'CUTURAPI', 1),
(1699, 172, 'OLLARAYA', 1),
(1700, 172, 'TINICACHI', 1),
(1701, 172, 'UNICACHI', 1),
(1702, 173, 'MOYOBAMBA', 1),
(1703, 173, 'CALZADA', 1),
(1704, 173, 'HABANA', 1),
(1705, 173, 'JEPELACIO', 1),
(1706, 173, 'SORITOR', 1),
(1707, 173, 'YANTALO', 1),
(1708, 174, 'BELLAVISTA', 1),
(1709, 174, 'ALTO BIAVO', 1),
(1710, 174, 'BAJO BIAVO', 1),
(1711, 174, 'HUALLAGA', 1),
(1712, 174, 'SAN PABLO', 1),
(1713, 174, 'SAN RAFAEL', 1),
(1714, 175, 'SAN JOSE DE SISA', 1),
(1715, 175, 'AGUA BLANCA', 1),
(1716, 175, 'SAN MARTIN', 1),
(1717, 175, 'SANTA ROSA', 1),
(1718, 175, 'SHATOJA', 1),
(1719, 176, 'SAPOSOA', 1),
(1720, 176, 'ALTO SAPOSOA', 1),
(1721, 176, 'EL ESLABON', 1),
(1722, 176, 'PISCOYACU', 1),
(1723, 176, 'SACANCHE', 1),
(1724, 176, 'TINGO DE SAPOSOA', 1),
(1725, 177, 'LAMAS', 1),
(1726, 177, 'ALONSO DE ALVARADO', 1),
(1727, 177, 'BARRANQUITA', 1),
(1728, 177, 'CAYNARACHI', 1),
(1729, 177, 'CUÃ‘UNBUQUI', 1),
(1730, 177, 'PINTO RECODO', 1),
(1731, 177, 'RUMISAPA', 1),
(1732, 177, 'SAN ROQUE DE CUMBAZA', 1),
(1733, 177, 'SHANAO', 1),
(1734, 177, 'TABALOSOS', 1),
(1735, 177, 'ZAPATERO', 1),
(1736, 178, 'JUANJUI', 1),
(1737, 178, 'CAMPANILLA', 1),
(1738, 178, 'HUICUNGO', 1),
(1739, 178, 'PACHIZA', 1),
(1740, 178, 'PAJARILLO', 1),
(1741, 179, 'PICOTA', 1),
(1742, 179, 'BUENOS AIRES', 1),
(1743, 179, 'CASPISAPA', 1),
(1744, 179, 'PILLUANA', 1),
(1745, 179, 'PUCACACA', 1),
(1746, 179, 'SAN CRISTOBAL', 1),
(1747, 179, 'SAN HILARION', 1),
(1748, 179, 'SHAMBOYACU', 1),
(1749, 179, 'TINGO DE PONASA', 1),
(1750, 179, 'TRES UNIDOS', 1),
(1751, 180, 'RIOJA', 1),
(1752, 180, 'AWAJUN', 1),
(1753, 180, 'ELIAS SOPLIN VARGAS', 1),
(1754, 180, 'NUEVA CAJAMARCA', 1),
(1755, 180, 'PARDO MIGUEL', 1),
(1756, 180, 'POSIC', 1),
(1757, 180, 'SAN FERNANDO', 1),
(1758, 180, 'YORONGOS', 1),
(1759, 180, 'YURACYACU', 1),
(1760, 181, 'TARAPOTO', 1),
(1761, 181, 'ALBERTO LEVEAU', 1),
(1762, 181, 'CACATACHI', 1),
(1763, 181, 'CHAZUTA', 1),
(1764, 181, 'CHIPURANA', 1),
(1765, 181, 'EL PORVENIR', 1),
(1766, 181, 'HUIMBAYOC', 1),
(1767, 181, 'JUAN GUERRA', 1),
(1768, 181, 'LA BANDA DE SHILCAYO', 1),
(1769, 181, 'MORALES', 1),
(1770, 181, 'PAPAPLAYA', 1),
(1771, 181, 'SAN ANTONIO', 1),
(1772, 181, 'SAUCE', 1),
(1773, 181, 'SHAPAJA', 1),
(1774, 182, 'TOCACHE', 1),
(1775, 182, 'NUEVO PROGRESO', 1),
(1776, 182, 'POLVORA', 1),
(1777, 182, 'SHUNTE', 1),
(1778, 182, 'UCHIZA', 1),
(1779, 183, 'TACNA', 1),
(1780, 183, 'ALTO DE LA ALIANZA', 1),
(1781, 183, 'CALANA', 1),
(1782, 183, 'CIUDAD NUEVA', 1),
(1783, 183, 'INCLAN', 1),
(1784, 183, 'PACHIA', 1),
(1785, 183, 'PALCA', 1),
(1786, 183, 'POCOLLAY', 1),
(1787, 183, 'SAMA', 1),
(1788, 183, 'CORONEL GREGORIO ALBARRACIN LANCHIPA', 1),
(1789, 184, 'CANDARAVE', 1),
(1790, 184, 'CAIRANI', 1),
(1791, 184, 'CAMILACA', 1),
(1792, 184, 'CURIBAYA', 1),
(1793, 184, 'HUANUARA', 1),
(1794, 184, 'QUILAHUANI', 1),
(1795, 185, 'LOCUMBA', 1),
(1796, 185, 'ILABAYA', 1),
(1797, 185, 'ITE', 1),
(1798, 186, 'TARATA', 1),
(1799, 186, 'CHUCATAMANI', 1),
(1800, 186, 'ESTIQUE', 1),
(1801, 186, 'ESTIQUE-PAMPA', 1),
(1802, 186, 'SITAJARA', 1),
(1803, 186, 'SUSAPAYA', 1),
(1804, 186, 'TARUCACHI', 1),
(1805, 186, 'TICACO', 1),
(1806, 187, 'TUMBES', 1),
(1807, 187, 'CORRALES', 1),
(1808, 187, 'LA CRUZ', 1),
(1809, 187, 'PAMPAS DE HOSPITAL', 1),
(1810, 187, 'SAN JACINTO', 1),
(1811, 187, 'SAN JUAN DE LA VIRGEN', 1),
(1812, 188, 'ZORRITOS', 1),
(1813, 188, 'CASITAS', 1),
(1814, 189, 'ZARUMILLA', 1),
(1815, 189, 'AGUAS VERDES', 1),
(1816, 189, 'MATAPALO', 1),
(1817, 189, 'PAPAYAL', 1),
(1818, 190, 'CALLERIA', 1),
(1819, 190, 'CAMPOVERDE', 1),
(1820, 190, 'IPARIA', 1),
(1821, 190, 'MASISEA', 1),
(1822, 190, 'YARINACOCHA', 1),
(1823, 190, 'NUEVA REQUENA', 1),
(1824, 191, 'RAYMONDI', 1),
(1825, 191, 'SEPAHUA', 1),
(1826, 191, 'TAHUANIA', 1),
(1827, 191, 'YURUA', 1),
(1828, 192, 'PADRE ABAD', 1),
(1829, 192, 'IRAZOLA', 1),
(1830, 192, 'CURIMANA', 1),
(1831, 193, 'PURUS', 1);

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
(12, 9, 169025, 10, '2019-07-22', '2019-07-22', 1),
(13, 5, 169028, 18, '2018-07-18', '2023-09-09', 1),
(14, 13, 169028, 15, '2011-04-12', '2016-11-24', 1),
(15, 14, 169028, 17, '2017-09-21', '2019-07-15', 1),
(16, 2, 169028, 9, '2019-07-22', '2019-07-22', 1);

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
(9, NULL, 'Escuela de artes plasticas', '', 1, 3, 1),
(10, NULL, 'Jugador Free Fire', '', 1, 5, 1),
(11, NULL, 'Jughfhgfhgfhg', '', 1, 5, 1),
(12, NULL, '231321', '', 1, 5, 1),
(13, NULL, 'Vampiro', '', 1, 1, 1),
(14, NULL, 'Manejar Moto', '', 1, 4, 1);

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
(1, 1, 3, NULL, 1, 'ImplementaciÃ³n de drones', '2015-04-06', '2018-12-21', 1999, 1),
(2, 4, 4, NULL, 2, 'Seguridad InformÃ¡tica', '2018-04-02', '2018-12-14', NULL, 1),
(3, 5, 1, NULL, 5, 'Cloud Computing ', '2017-08-07', '2018-08-31', NULL, 1),
(4, 7, 2, NULL, 1, 'DiseÃ±o y Desarrollo de Videojuegos', '2017-12-22', '2019-04-26', NULL, 1),
(6, 7, 4, NULL, 4, 'Inyectables 1', '2019-07-01', '2019-07-09', 2019, 1),
(7, 1, 1, NULL, 2, 'Postgrado de prueba 1', '2019-07-10', '2019-07-17', 2018, 1),
(8, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(9, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(10, 1, 1, NULL, 2, 'Postgrado de prueba 2', '2019-07-17', '2019-07-17', NULL, 1),
(11, 4, 6, NULL, 3, 'Inglish Avanzao p', '2019-07-16', '2019-07-17', 2019, 1),
(12, 4, 6, NULL, 3, 'Inglish Avanzao p', '2019-07-16', '2019-07-17', 2019, 1);

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
  `urlFoto` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `privacidad` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`codigo`, `nombres`, `apellidoMaterno`, `apellidoPaterno`, `genero`, `fechaNacimiento`, `celular`, `correo`, `dni`, `estadoCivil`, `vigencia`, `urlFoto`, `privacidad`) VALUES
(160012, 'Christian Robert', 'Flores', 'Torres', 0, '1998-12-10', '98534656', 'cflores@unprg.edu.pe', '65734654', 'V', 1, '0', 0),
(165032, 'David', 'Paz', 'Rioja', 1, '1999-07-13', '93523622', 'drioja@unprg.edu.pe', '74575683', '1', 0, '0', 0),
(165058, 'Marcelo', 'Villar', 'VelÃ¡squez', 1, '1999-02-18', '974657567', 'mvelasquez@unprg.edu.pe', '74813707', 'S', 1, '0', 0),
(169025, 'Javier Arturo', 'Sialer', 'ChÃ¡vez', 1, '1999-06-12', '949912973', 'achavez@unprg.edu.pe', '70505538', 'C', 1, 'images/eabaf3777e0170fd1784.jpeg', 0),
(169027, 'Fabian Andres', 'Bautista', 'Pacherres', 0, '1998-12-13', '953172725', 'fpacherres@gmail.com', '73860228', 'S', 1, '0', 0),
(169028, 'Joan Bruno JesÃºs', 'Sandoval', 'SipiÃ³n', 1, '1997-09-17', '918417432', 'nglife@unprg.edu.pe', '16462834', 'C', 1, '0', 0);

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
  `nombre` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`codigo`, `codigoDepartamento`, `nombre`, `vigencia`) VALUES
(1, 1, 'CHACHAPOYAS ', 1),
(2, 1, 'BAGUA', 1),
(3, 1, 'BONGARA', 1),
(4, 1, 'CONDORCANQUI', 1),
(5, 1, 'LUYA', 1),
(6, 1, 'RODRIGUEZ DE MENDOZA', 1),
(7, 1, 'UTCUBAMBA', 1),
(8, 2, 'HUARAZ', 1),
(9, 2, 'AIJA', 1),
(10, 2, 'ANTONIO RAYMONDI', 1),
(11, 2, 'ASUNCION', 1),
(12, 2, 'BOLOGNESI', 1),
(13, 2, 'CARHUAZ', 1),
(14, 2, 'CARLOS FERMIN FITZCA', 1),
(15, 2, 'CASMA', 1),
(16, 2, 'CORONGO', 1),
(17, 2, 'HUARI', 1),
(18, 2, 'HUARMEY', 1),
(19, 2, 'HUAYLAS', 1),
(20, 2, 'MARISCAL LUZURIAGA', 1),
(21, 2, 'OCROS', 1),
(22, 2, 'PALLASCA', 1),
(23, 2, 'POMABAMBA', 1),
(24, 2, 'RECUAY', 1),
(25, 2, 'SANTA', 1),
(26, 2, 'SIHUAS', 1),
(27, 2, 'YUNGAY', 1),
(28, 3, 'ABANCAY', 1),
(29, 3, 'ANDAHUAYLAS', 1),
(30, 3, 'ANTABAMBA', 1),
(31, 3, 'AYMARAES', 1),
(32, 3, 'COTABAMBAS', 1),
(33, 3, 'CHINCHEROS', 1),
(34, 3, 'GRAU', 1),
(35, 4, 'AREQUIPA', 1),
(36, 4, 'CAMANA', 1),
(37, 4, 'CARAVELI', 1),
(38, 4, 'CASTILLA', 1),
(39, 4, 'CAYLLOMA', 1),
(40, 4, 'CONDESUYOS', 1),
(41, 4, 'ISLAY', 1),
(42, 4, 'LA UNION', 1),
(43, 5, 'HUAMANGA', 1),
(44, 5, 'CANGALLO', 1),
(45, 5, 'HUANCA SANCOS', 1),
(46, 5, 'HUANTA', 1),
(47, 5, 'LA MAR', 1),
(48, 5, 'LUCANAS', 1),
(49, 5, 'PARINACOCHAS', 1),
(50, 5, 'PAUCAR DEL SARA SARA', 1),
(51, 5, 'SUCRE', 1),
(52, 5, 'VICTOR FAJARDO', 1),
(53, 5, 'VILCAS HUAMAN', 1),
(54, 6, 'CAJAMARCA', 1),
(55, 6, 'CAJABAMBA', 1),
(56, 6, 'CELENDIN', 1),
(57, 6, 'CHOTA ', 1),
(58, 6, 'CONTUMAZA', 1),
(59, 6, 'CUTERVO', 1),
(60, 6, 'HUALGAYOC', 1),
(61, 6, 'JAEN', 1),
(62, 6, 'SAN IGNACIO', 1),
(63, 6, 'SAN MARCOS', 1),
(64, 6, 'SAN PABLO', 1),
(65, 6, 'SANTA CRUZ', 1),
(66, 7, 'CALLAO', 1),
(67, 8, 'CUSCO', 1),
(68, 8, 'ACOMAYO', 1),
(69, 8, 'ANTA', 1),
(70, 8, 'CALCA', 1),
(71, 8, 'CANAS', 1),
(72, 8, 'CANCHIS', 1),
(73, 8, 'CHUMBIVILCAS', 1),
(74, 8, 'ESPINAR', 1),
(75, 8, 'LA CONVENCION', 1),
(76, 8, 'PARURO', 1),
(77, 8, 'PAUCARTAMBO', 1),
(78, 8, 'QUISPICANCHI', 1),
(79, 8, 'URUBAMBA', 1),
(80, 9, 'HUANCAVELICA', 1),
(81, 9, 'ACOBAMBA', 1),
(82, 9, 'ANGARAES', 1),
(83, 9, 'CASTROVIRREYNA', 1),
(84, 9, 'CHURCAMPA', 1),
(85, 9, 'HUAYTARA', 1),
(86, 9, 'TAYACAJA', 1),
(87, 10, 'HUANUCO', 1),
(88, 10, 'AMBO', 1),
(89, 10, 'DOS DE MAYO', 1),
(90, 10, 'HUACAYBAMBA', 1),
(91, 10, 'HUAMALIES', 1),
(92, 10, 'LEONCIO PRADO', 1),
(93, 10, 'MARAÃ‘ON', 1),
(94, 10, 'PACHITEA', 1),
(95, 10, 'PUERTO INCA', 1),
(96, 10, 'LAURICOCHA', 1),
(97, 10, 'YAROWILCA', 1),
(98, 11, 'ICA', 1),
(99, 11, 'CHINCHA', 1),
(100, 11, 'NAZCA', 1),
(101, 11, 'PALPA', 1),
(102, 11, 'PISCO', 1),
(103, 12, 'HUANCAYO', 1),
(104, 12, 'CONCEPCION', 1),
(105, 12, 'CHANCHAMAYO', 1),
(106, 12, 'JAUJA', 1),
(107, 12, 'JUNIN', 1),
(108, 12, 'SATIPO', 1),
(109, 12, 'TARMA', 1),
(110, 12, 'YAULI', 1),
(111, 12, 'CHUPACA', 1),
(112, 13, 'TRUJILLO', 1),
(113, 13, 'ASCOPE', 1),
(114, 13, 'BOLIVAR', 1),
(115, 13, 'CHEPEN', 1),
(116, 13, 'JULCAN', 1),
(117, 13, 'OTUZCO', 1),
(118, 13, 'PACASMAYO', 1),
(119, 13, 'PATAZ', 1),
(120, 13, 'SANCHEZ CARRION', 1),
(121, 13, 'SANTIAGO DE CHUCO', 1),
(122, 13, 'GRAN CHIMU', 1),
(123, 13, 'VIRU', 1),
(124, 14, 'CHICLAYO', 1),
(125, 14, 'FERREÃ‘AFE', 1),
(126, 14, 'LAMBAYEQUE', 1),
(127, 15, 'LIMA', 1),
(128, 15, 'BARRANCA', 1),
(129, 15, 'CAJATAMBO', 1),
(130, 15, 'CANTA', 1),
(131, 15, 'CAÃ‘ETE', 1),
(132, 15, 'HUARAL', 1),
(133, 15, 'HUAROCHIRI', 1),
(134, 15, 'HUAURA', 1),
(135, 15, 'OYON', 1),
(136, 15, 'YAUYOS', 1),
(137, 16, 'MAYNAS', 1),
(138, 16, 'ALTO AMAZONAS', 1),
(139, 16, 'LORETO', 1),
(140, 16, 'MARISCAL RAMON CASTILLA', 1),
(141, 16, 'REQUENA', 1),
(142, 16, 'UCAYALI', 1),
(143, 17, 'TAMBOPATA', 1),
(144, 17, 'MANU', 1),
(145, 17, 'TAHUAMANU', 1),
(146, 18, 'MARISCAL NIETO', 1),
(147, 18, 'GENERAL SANCHEZ CERRO', 1),
(148, 18, 'ILO', 1),
(149, 19, 'PASCO', 1),
(150, 19, 'DANIEL ALCIDES CARRION', 1),
(151, 19, 'OXAPAMPA', 1),
(152, 20, 'PIURA', 1),
(153, 20, 'AYABACA', 1),
(154, 20, 'HUANCABAMBA', 1),
(155, 20, 'MORROPON', 1),
(156, 20, 'PAITA', 1),
(157, 20, 'SULLANA', 1),
(158, 20, 'TALARA', 1),
(159, 20, 'SECHURA', 1),
(160, 21, 'PUNO', 1),
(161, 21, 'AZANGARO', 1),
(162, 21, 'CARABAYA', 1),
(163, 21, 'CHUCUITO', 1),
(164, 21, 'EL COLLAO', 1),
(165, 21, 'HUANCANE', 1),
(166, 21, 'LAMPA', 1),
(167, 21, 'MELGAR', 1),
(168, 21, 'MOHO', 1),
(169, 21, 'SAN ANTONIO DE PUTINA', 1),
(170, 21, 'SAN ROMAN', 1),
(171, 21, 'SANDIA', 1),
(172, 21, 'YUNGUYO', 1),
(173, 22, 'MOYOBAMBA', 1),
(174, 22, 'BELLAVISTA', 1),
(175, 22, 'EL DORADO', 1),
(176, 22, 'HUALLAGA', 1),
(177, 22, 'LAMAS', 1),
(178, 22, 'MARISCAL CACERES', 1),
(179, 22, 'PICOTA', 1),
(180, 22, 'RIOJA', 1),
(181, 22, 'SAN MARTIN', 1),
(182, 22, 'TOCACHE', 1),
(183, 23, 'TACNA', 1),
(184, 23, 'CANDARAVE', 1),
(185, 23, 'JORGE BASADRE', 1),
(186, 23, 'TARATA', 1),
(187, 24, 'TUMBES', 1),
(188, 24, 'CONTRALMIRANTE VILLA', 1),
(189, 24, 'ZARUMILLA', 1),
(190, 25, 'CORONEL PORTILLO', 1),
(191, 25, 'ATALAYA', 1),
(192, 25, 'PADRE ABAD', 1),
(193, 25, 'PURUS', 1);

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
(1, 'Curso', 'Cursos de corta duraciÃ³n para conocer mejor un nuevo Ã¡mbito especÃ­fico.', 1),
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
(8, 4, '2010-02-18', 1),
(13, 2, '2024-03-20', 1),
(14, 2, '2016-12-12', 1);

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
(2, 'Universidad de Piura', 'UDEP', 0, 1),
(3, 'Universidad Santo Toribio de Mogrovejo', 'USAT', 0, 1),
(4, 'Universidad San MartÃ­n de Porres', 'USMAA', 0, 1),
(5, 'Universidad Nacional Pedro Ruiz Gallo', 'UNPRG', 1, 1),
(6, 'Universidad de Chota', 'UNDCH', 1, 1),
(7, 'Universidad Nacional de IngenierÃ­a', 'UNAI', 1, 1),
(8, 'Universidad Agraria', 'UAGR', 1, 1),
(12, 'Universidad CatÃ³lica del Norte', 'UCDN', 1, 0),
(13, 'Universidad CatÃ³lica del Sur', 'UCDS', 1, 1);

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
(5, NULL, 'Javcho', '$2y$10$oEewjhF9aaJ1WXhJSMXHhugJ.ynoElOBEx.KkDeSw4IyIGb9SgwCm', 'P', 1, 169025),
(6, 2, 'EspCor1', '987', 'P', 1, NULL),
(7, 4, 'AlaRioja', '741', 'P', 1, NULL),
(8, NULL, 'DavidR', '258', 'E', 0, 165032),
(9, NULL, 'MarckTone', '369', 'E', 1, 165058),
(10, 2, 'FXLR16', '$2y$10$aaZ2KJ3qZLLZFY4Qe2tq/.u9ZPhCB5iZlQC/SrEoqQ3EZIXdoo.Y.', 'A', 1, NULL),
(11, NULL, 'nglife', '$2y$10$xlweEJXuWsyhyZyTW8Ow4.pemBIA9xmXH741XuDv9T531uSgYt6re', 'E', 1, 169028);

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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `admision`
--
ALTER TABLE `admision`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `centroestudios`
--
ALTER TABLE `centroestudios`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `centrolaboral`
--
ALTER TABLE `centrolaboral`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `colegiatura`
--
ALTER TABLE `colegiatura`
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `contrato`
--
ALTER TABLE `contrato`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `distrito`
--
ALTER TABLE `distrito`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1832;

--
-- AUTO_INCREMENT de la tabla `egresado`
--
ALTER TABLE `egresado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `escuelaprofesional`
--
ALTER TABLE `escuelaprofesional`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `estudiospostgrado`
--
ALTER TABLE `estudiospostgrado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT de la tabla `tipoestudiopostgrado`
--
ALTER TABLE `tipoestudiopostgrado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `titulacion`
--
ALTER TABLE `titulacion`
  MODIFY `codigoEgresado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `universidad`
--
ALTER TABLE `universidad`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
