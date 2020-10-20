/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 100140
 Source Host           : localhost:3306
 Source Schema         : egresados

 Target Server Type    : MySQL
 Target Server Version : 100140
 File Encoding         : 65001

 Date: 20/10/2020 18:41:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for actividadeconomica
-- ----------------------------
DROP TABLE IF EXISTS `actividadeconomica`;
CREATE TABLE `actividadeconomica`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of actividadeconomica
-- ----------------------------
INSERT INTO `actividadeconomica` VALUES (1, 'Minería', 'Actividad económica del sector primario representada por la explotación o extracción de los minerales.', 1);
INSERT INTO `actividadeconomica` VALUES (2, 'Pesca', 'Actividad que se realiza para extraer peces. Puede realizarse en aguas continentales o mar&iacute;timas.', 1);
INSERT INTO `actividadeconomica` VALUES (3, 'Ganadería', 'Actividad económica que consiste en el manejo y explotación de animales domesticables.', 1);
INSERT INTO `actividadeconomica` VALUES (4, 'Industria', 'Actividad que tiene como finalidad transformar las materias primas en productos elaborados o semielaborados.', 1);
INSERT INTO `actividadeconomica` VALUES (5, 'Agricultura', 'Conjunto de técnicas, conocimientos y saberes para cultivar la tierra y la parte del sector primario que se dedica a ello.', 1);
INSERT INTO `actividadeconomica` VALUES (6, 'Turismo', 'Actividad que realizan las personas durante sus viajes y estancias en lugares distintos a su entorno habitual.', 1);
INSERT INTO `actividadeconomica` VALUES (7, 'Tecnología', NULL, 1);

-- ----------------------------
-- Table structure for admision
-- ----------------------------
DROP TABLE IF EXISTS `admision`;
CREATE TABLE `admision`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoEscuela` int NOT NULL,
  `fechaAdmision` date NOT NULL,
  `nombre` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `codigoModalidad` int NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoEscuela`(`codigoEscuela`) USING BTREE,
  INDEX `codigoModalidad`(`codigoModalidad`) USING BTREE,
  CONSTRAINT `admision_ibfk_1` FOREIGN KEY (`codigoEscuela`) REFERENCES `escuelaprofesional` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `admision_ibfk_2` FOREIGN KEY (`codigoModalidad`) REFERENCES `modalidadadmision` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admision
-- ----------------------------
INSERT INTO `admision` VALUES (1, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (2, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (3, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (4, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (5, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (6, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (7, 2, '2015-12-20', '2015-I', 2, 1);
INSERT INTO `admision` VALUES (8, 1, '2015-12-20', '2015-I', 2, 1);

-- ----------------------------
-- Table structure for centroestudios
-- ----------------------------
DROP TABLE IF EXISTS `centroestudios`;
CREATE TABLE `centroestudios`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `razonSocial` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of centroestudios
-- ----------------------------
INSERT INTO `centroestudios` VALUES (1, 'CETI', 1);
INSERT INTO `centroestudios` VALUES (2, 'SENATI', 1);
INSERT INTO `centroestudios` VALUES (3, 'EIGER', 1);
INSERT INTO `centroestudios` VALUES (4, 'CERTUS', 1);

-- ----------------------------
-- Table structure for centrolaboral
-- ----------------------------
DROP TABLE IF EXISTS `centrolaboral`;
CREATE TABLE `centrolaboral`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoActividad` int NOT NULL,
  `codigoDistrito` int NULL DEFAULT NULL,
  `RUC` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `razonSocial` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoDistrito`(`codigoDistrito`) USING BTREE,
  INDEX `codigoActividad`(`codigoActividad`) USING BTREE,
  CONSTRAINT `centrolaboral_ibfk_1` FOREIGN KEY (`codigoDistrito`) REFERENCES `distrito` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `centrolaboral_ibfk_2` FOREIGN KEY (`codigoActividad`) REFERENCES `actividadeconomica` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of centrolaboral
-- ----------------------------
INSERT INTO `centrolaboral` VALUES (1, 1, 2, '', 'Soporte', 1);
INSERT INTO `centrolaboral` VALUES (2, 7, 1225, '', 'Red Milan', 1);

-- ----------------------------
-- Table structure for colegiatura
-- ----------------------------
DROP TABLE IF EXISTS `colegiatura`;
CREATE TABLE `colegiatura`  (
  `codigoEgresado` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigoEgresado`) USING BTREE,
  CONSTRAINT `colegiatura_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `titulacion` (`codigoEgresado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of colegiatura
-- ----------------------------

-- ----------------------------
-- Table structure for contrato
-- ----------------------------
DROP TABLE IF EXISTS `contrato`;
CREATE TABLE `contrato`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoEgresado` int NOT NULL,
  `codigoCentroLaboral` int NOT NULL,
  `cargo` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NULL DEFAULT NULL,
  `detalleFunciones` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoEgresado`(`codigoEgresado`) USING BTREE,
  INDEX `codigoCentroLaboral`(`codigoCentroLaboral`) USING BTREE,
  CONSTRAINT `contrato_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `contrato_ibfk_2` FOREIGN KEY (`codigoCentroLaboral`) REFERENCES `centrolaboral` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of contrato
-- ----------------------------
INSERT INTO `contrato` VALUES (1, 8, 1, 'Desarrollador', '2020-08-03', '2020-09-20', 'Desarrollaba webs', 1);
INSERT INTO `contrato` VALUES (2, 8, 2, 'Encargado de DevOps', '2019-01-08', NULL, 'Hacia muchas cosas', 1);

-- ----------------------------
-- Table structure for departamento
-- ----------------------------
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE `departamento`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of departamento
-- ----------------------------
INSERT INTO `departamento` VALUES (1, 'AMAZONAS', 1);
INSERT INTO `departamento` VALUES (2, 'ANCASH', 1);
INSERT INTO `departamento` VALUES (3, 'APURIMAC', 1);
INSERT INTO `departamento` VALUES (4, 'AREQUIPA', 1);
INSERT INTO `departamento` VALUES (5, 'AYACUCHO', 1);
INSERT INTO `departamento` VALUES (6, 'CAJAMARCA', 1);
INSERT INTO `departamento` VALUES (7, 'CALLAO', 1);
INSERT INTO `departamento` VALUES (8, 'CUSCO', 1);
INSERT INTO `departamento` VALUES (9, 'HUANCAVELICA', 1);
INSERT INTO `departamento` VALUES (10, 'HUANUCO', 1);
INSERT INTO `departamento` VALUES (11, 'ICA', 1);
INSERT INTO `departamento` VALUES (12, 'JUNIN', 1);
INSERT INTO `departamento` VALUES (13, 'LA LIBERTAD', 1);
INSERT INTO `departamento` VALUES (14, 'LAMBAYEQUE', 1);
INSERT INTO `departamento` VALUES (15, 'LIMA', 1);
INSERT INTO `departamento` VALUES (16, 'LORETO', 1);
INSERT INTO `departamento` VALUES (17, 'MADRE DE DIOS', 1);
INSERT INTO `departamento` VALUES (18, 'MOQUEGUA', 1);
INSERT INTO `departamento` VALUES (19, 'PASCO', 1);
INSERT INTO `departamento` VALUES (20, 'PIURA', 1);
INSERT INTO `departamento` VALUES (21, 'PUNO', 1);
INSERT INTO `departamento` VALUES (22, 'SAN MARTIN', 1);
INSERT INTO `departamento` VALUES (23, 'TACNA', 1);
INSERT INTO `departamento` VALUES (24, 'TUMBES', 1);
INSERT INTO `departamento` VALUES (25, 'UCAYALI', 1);

-- ----------------------------
-- Table structure for distrito
-- ----------------------------
DROP TABLE IF EXISTS `distrito`;
CREATE TABLE `distrito`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoProvincia` int NOT NULL,
  `nombre` varchar(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoProvincia`(`codigoProvincia`) USING BTREE,
  CONSTRAINT `distrito_ibfk_1` FOREIGN KEY (`codigoProvincia`) REFERENCES `provincia` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1832 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of distrito
-- ----------------------------
INSERT INTO `distrito` VALUES (1, 1, 'CHACHAPOYAS', 1);
INSERT INTO `distrito` VALUES (2, 1, 'ASUNCION', 1);
INSERT INTO `distrito` VALUES (3, 1, 'BALSAS', 1);
INSERT INTO `distrito` VALUES (4, 1, 'CHETO', 1);
INSERT INTO `distrito` VALUES (5, 1, 'CHILIQUIN', 1);
INSERT INTO `distrito` VALUES (6, 1, 'CHUQUIBAMBA', 1);
INSERT INTO `distrito` VALUES (7, 1, 'GRANADA', 1);
INSERT INTO `distrito` VALUES (8, 1, 'HUANCAS', 1);
INSERT INTO `distrito` VALUES (9, 1, 'LA JALCA', 1);
INSERT INTO `distrito` VALUES (10, 1, 'LEIMEBAMBA', 1);
INSERT INTO `distrito` VALUES (11, 1, 'LEVANTO', 1);
INSERT INTO `distrito` VALUES (12, 1, 'MAGDALENA', 1);
INSERT INTO `distrito` VALUES (13, 1, 'MARISCAL CASTILLA', 1);
INSERT INTO `distrito` VALUES (14, 1, 'MOLINOPAMPA', 1);
INSERT INTO `distrito` VALUES (15, 1, 'MONTEVIDEO', 1);
INSERT INTO `distrito` VALUES (16, 1, 'OLLEROS', 1);
INSERT INTO `distrito` VALUES (17, 1, 'QUINJALCA', 1);
INSERT INTO `distrito` VALUES (18, 1, 'SAN FRANCISCO DE DAGUAS', 1);
INSERT INTO `distrito` VALUES (19, 1, 'SAN ISIDRO DE MAINO', 1);
INSERT INTO `distrito` VALUES (20, 1, 'SOLOCO', 1);
INSERT INTO `distrito` VALUES (21, 1, 'SONCHE', 1);
INSERT INTO `distrito` VALUES (22, 2, 'LA PECA', 1);
INSERT INTO `distrito` VALUES (23, 2, 'ARAMANGO', 1);
INSERT INTO `distrito` VALUES (24, 2, 'COPALLIN', 1);
INSERT INTO `distrito` VALUES (25, 2, 'EL PARCO', 1);
INSERT INTO `distrito` VALUES (26, 2, 'IMAZA', 1);
INSERT INTO `distrito` VALUES (27, 3, 'JUMBILLA', 1);
INSERT INTO `distrito` VALUES (28, 3, 'CHISQUILLA', 1);
INSERT INTO `distrito` VALUES (29, 3, 'CHURUJA', 1);
INSERT INTO `distrito` VALUES (30, 3, 'COROSHA', 1);
INSERT INTO `distrito` VALUES (31, 3, 'CUISPES', 1);
INSERT INTO `distrito` VALUES (32, 3, 'FLORIDA', 1);
INSERT INTO `distrito` VALUES (33, 3, 'JAZAN', 1);
INSERT INTO `distrito` VALUES (34, 3, 'RECTA', 1);
INSERT INTO `distrito` VALUES (35, 3, 'SAN CARLOS', 1);
INSERT INTO `distrito` VALUES (36, 3, 'SHIPASBAMBA', 1);
INSERT INTO `distrito` VALUES (37, 3, 'VALERA', 1);
INSERT INTO `distrito` VALUES (38, 3, 'YAMBRASBAMBA', 1);
INSERT INTO `distrito` VALUES (39, 4, 'NIEVA', 1);
INSERT INTO `distrito` VALUES (40, 4, 'EL CENEPA', 1);
INSERT INTO `distrito` VALUES (41, 4, 'RIO SANTIAGO', 1);
INSERT INTO `distrito` VALUES (42, 5, 'LAMUD', 1);
INSERT INTO `distrito` VALUES (43, 5, 'CAMPORREDONDO', 1);
INSERT INTO `distrito` VALUES (44, 5, 'COCABAMBA', 1);
INSERT INTO `distrito` VALUES (45, 5, 'COLCAMAR', 1);
INSERT INTO `distrito` VALUES (46, 5, 'CONILA', 1);
INSERT INTO `distrito` VALUES (47, 5, 'INGUILPATA', 1);
INSERT INTO `distrito` VALUES (48, 5, 'LONGUITA', 1);
INSERT INTO `distrito` VALUES (49, 5, 'LONYA CHICO', 1);
INSERT INTO `distrito` VALUES (50, 5, 'LUYA', 1);
INSERT INTO `distrito` VALUES (51, 5, 'LUYA VIEJO', 1);
INSERT INTO `distrito` VALUES (52, 5, 'MARIA', 1);
INSERT INTO `distrito` VALUES (53, 5, 'OCALLI', 1);
INSERT INTO `distrito` VALUES (54, 5, 'OCUMAL', 1);
INSERT INTO `distrito` VALUES (55, 5, 'PISUQUIA', 1);
INSERT INTO `distrito` VALUES (56, 5, 'PROVIDENCIA', 1);
INSERT INTO `distrito` VALUES (57, 5, 'SAN CRISTOBAL', 1);
INSERT INTO `distrito` VALUES (58, 5, 'SAN FRANCISCO DEL YESO', 1);
INSERT INTO `distrito` VALUES (59, 5, 'SAN JERONIMO', 1);
INSERT INTO `distrito` VALUES (60, 5, 'SAN JUAN DE LOPECANCHA', 1);
INSERT INTO `distrito` VALUES (61, 5, 'SANTA CATALINA', 1);
INSERT INTO `distrito` VALUES (62, 5, 'SANTO TOMAS', 1);
INSERT INTO `distrito` VALUES (63, 5, 'TINGO', 1);
INSERT INTO `distrito` VALUES (64, 5, 'TRITA', 1);
INSERT INTO `distrito` VALUES (65, 6, 'SAN NICOLAS', 1);
INSERT INTO `distrito` VALUES (66, 6, 'CHIRIMOTO', 1);
INSERT INTO `distrito` VALUES (67, 6, 'COCHAMAL', 1);
INSERT INTO `distrito` VALUES (68, 6, 'HUAMBO', 1);
INSERT INTO `distrito` VALUES (69, 6, 'LIMABAMBA', 1);
INSERT INTO `distrito` VALUES (70, 6, 'LONGAR', 1);
INSERT INTO `distrito` VALUES (71, 6, 'MARISCAL BENAVIDES', 1);
INSERT INTO `distrito` VALUES (72, 6, 'MILPUC', 1);
INSERT INTO `distrito` VALUES (73, 6, 'OMIA', 1);
INSERT INTO `distrito` VALUES (74, 6, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (75, 6, 'TOTORA', 1);
INSERT INTO `distrito` VALUES (76, 6, 'VISTA ALEGRE', 1);
INSERT INTO `distrito` VALUES (77, 7, 'BAGUA GRANDE', 1);
INSERT INTO `distrito` VALUES (78, 7, 'CAJARURO', 1);
INSERT INTO `distrito` VALUES (79, 7, 'CUMBA', 1);
INSERT INTO `distrito` VALUES (80, 7, 'EL MILAGRO', 1);
INSERT INTO `distrito` VALUES (81, 7, 'JAMALCA', 1);
INSERT INTO `distrito` VALUES (82, 7, 'LONYA GRANDE', 1);
INSERT INTO `distrito` VALUES (83, 7, 'YAMON', 1);
INSERT INTO `distrito` VALUES (84, 8, 'HUARAZ', 1);
INSERT INTO `distrito` VALUES (85, 8, 'COCHABAMBA', 1);
INSERT INTO `distrito` VALUES (86, 8, 'COLCABAMBA', 1);
INSERT INTO `distrito` VALUES (87, 8, 'HUANCHAY', 1);
INSERT INTO `distrito` VALUES (88, 8, 'INDEPENDENCIA', 1);
INSERT INTO `distrito` VALUES (89, 8, 'JANGAS', 1);
INSERT INTO `distrito` VALUES (90, 8, 'LA LIBERTAD', 1);
INSERT INTO `distrito` VALUES (91, 8, 'OLLEROS', 1);
INSERT INTO `distrito` VALUES (92, 8, 'PAMPAS', 1);
INSERT INTO `distrito` VALUES (93, 8, 'PARIACOTO', 1);
INSERT INTO `distrito` VALUES (94, 8, 'PIRA', 1);
INSERT INTO `distrito` VALUES (95, 8, 'TARICA', 1);
INSERT INTO `distrito` VALUES (96, 9, 'AIJA', 1);
INSERT INTO `distrito` VALUES (97, 9, 'CORIS', 1);
INSERT INTO `distrito` VALUES (98, 9, 'HUACLLAN', 1);
INSERT INTO `distrito` VALUES (99, 9, 'LA MERCED', 1);
INSERT INTO `distrito` VALUES (100, 9, 'SUCCHA', 1);
INSERT INTO `distrito` VALUES (101, 10, 'LLAMELLIN', 1);
INSERT INTO `distrito` VALUES (102, 10, 'ACZO', 1);
INSERT INTO `distrito` VALUES (103, 10, 'CHACCHO', 1);
INSERT INTO `distrito` VALUES (104, 10, 'CHINGAS', 1);
INSERT INTO `distrito` VALUES (105, 10, 'MIRGAS', 1);
INSERT INTO `distrito` VALUES (106, 10, 'SAN JUAN DE RONTOY', 1);
INSERT INTO `distrito` VALUES (107, 11, 'CHACAS', 1);
INSERT INTO `distrito` VALUES (108, 11, 'ACOCHACA', 1);
INSERT INTO `distrito` VALUES (109, 12, 'CHIQUIAN', 1);
INSERT INTO `distrito` VALUES (110, 12, 'ABELARDO PARDO LEZAMETA', 1);
INSERT INTO `distrito` VALUES (111, 12, 'ANTONIO RAYMONDI', 1);
INSERT INTO `distrito` VALUES (112, 12, 'AQUIA', 1);
INSERT INTO `distrito` VALUES (113, 12, 'CAJACAY', 1);
INSERT INTO `distrito` VALUES (114, 12, 'CANIS', 1);
INSERT INTO `distrito` VALUES (115, 12, 'COLQUIOC', 1);
INSERT INTO `distrito` VALUES (116, 12, 'HUALLANCA', 1);
INSERT INTO `distrito` VALUES (117, 12, 'HUASTA', 1);
INSERT INTO `distrito` VALUES (118, 12, 'HUAYLLACAYAN', 1);
INSERT INTO `distrito` VALUES (119, 12, 'LA PRIMAVERA', 1);
INSERT INTO `distrito` VALUES (120, 12, 'MANGAS', 1);
INSERT INTO `distrito` VALUES (121, 12, 'PACLLON', 1);
INSERT INTO `distrito` VALUES (122, 12, 'SAN MIGUEL DE CORPANQUI', 1);
INSERT INTO `distrito` VALUES (123, 12, 'TICLLOS', 1);
INSERT INTO `distrito` VALUES (124, 13, 'CARHUAZ', 1);
INSERT INTO `distrito` VALUES (125, 13, 'ACOPAMPA', 1);
INSERT INTO `distrito` VALUES (126, 13, 'AMASHCA', 1);
INSERT INTO `distrito` VALUES (127, 13, 'ANTA', 1);
INSERT INTO `distrito` VALUES (128, 13, 'ATAQUERO', 1);
INSERT INTO `distrito` VALUES (129, 13, 'MARCARA', 1);
INSERT INTO `distrito` VALUES (130, 13, 'PARIAHUANCA', 1);
INSERT INTO `distrito` VALUES (131, 13, 'SAN MIGUEL DE ACO', 1);
INSERT INTO `distrito` VALUES (132, 13, 'SHILLA', 1);
INSERT INTO `distrito` VALUES (133, 13, 'TINCO', 1);
INSERT INTO `distrito` VALUES (134, 13, 'YUNGAR', 1);
INSERT INTO `distrito` VALUES (135, 14, 'SAN LUIS', 1);
INSERT INTO `distrito` VALUES (136, 14, 'SAN NICOLAS', 1);
INSERT INTO `distrito` VALUES (137, 14, 'YAUYA', 1);
INSERT INTO `distrito` VALUES (138, 15, 'CASMA', 1);
INSERT INTO `distrito` VALUES (139, 15, 'BUENA VISTA ALTA', 1);
INSERT INTO `distrito` VALUES (140, 15, 'COMANDANTE NOEL', 1);
INSERT INTO `distrito` VALUES (141, 15, 'YAUTAN', 1);
INSERT INTO `distrito` VALUES (142, 16, 'CORONGO', 1);
INSERT INTO `distrito` VALUES (143, 16, 'ACO', 1);
INSERT INTO `distrito` VALUES (144, 16, 'BAMBAS', 1);
INSERT INTO `distrito` VALUES (145, 16, 'CUSCA', 1);
INSERT INTO `distrito` VALUES (146, 16, 'LA PAMPA', 1);
INSERT INTO `distrito` VALUES (147, 16, 'YANAC', 1);
INSERT INTO `distrito` VALUES (148, 16, 'YUPAN', 1);
INSERT INTO `distrito` VALUES (149, 17, 'HUARI', 1);
INSERT INTO `distrito` VALUES (150, 17, 'ANRA', 1);
INSERT INTO `distrito` VALUES (151, 17, 'CAJAY', 1);
INSERT INTO `distrito` VALUES (152, 17, 'CHAVIN DE HUANTAR', 1);
INSERT INTO `distrito` VALUES (153, 17, 'HUACACHI', 1);
INSERT INTO `distrito` VALUES (154, 17, 'HUACCHIS', 1);
INSERT INTO `distrito` VALUES (155, 17, 'HUACHIS', 1);
INSERT INTO `distrito` VALUES (156, 17, 'HUANTAR', 1);
INSERT INTO `distrito` VALUES (157, 17, 'MASIN', 1);
INSERT INTO `distrito` VALUES (158, 17, 'PAUCAS', 1);
INSERT INTO `distrito` VALUES (159, 17, 'PONTO', 1);
INSERT INTO `distrito` VALUES (160, 17, 'RAHUAPAMPA', 1);
INSERT INTO `distrito` VALUES (161, 17, 'RAPAYAN', 1);
INSERT INTO `distrito` VALUES (162, 17, 'SAN MARCOS', 1);
INSERT INTO `distrito` VALUES (163, 17, 'SAN PEDRO DE CHANA', 1);
INSERT INTO `distrito` VALUES (164, 17, 'UCO', 1);
INSERT INTO `distrito` VALUES (165, 18, 'HUARMEY', 1);
INSERT INTO `distrito` VALUES (166, 18, 'COCHAPETI', 1);
INSERT INTO `distrito` VALUES (167, 18, 'CULEBRAS', 1);
INSERT INTO `distrito` VALUES (168, 18, 'HUAYAN', 1);
INSERT INTO `distrito` VALUES (169, 18, 'MALVAS', 1);
INSERT INTO `distrito` VALUES (170, 26, 'CARAZ', 1);
INSERT INTO `distrito` VALUES (171, 26, 'HUALLANCA', 1);
INSERT INTO `distrito` VALUES (172, 26, 'HUATA', 1);
INSERT INTO `distrito` VALUES (173, 26, 'HUAYLAS', 1);
INSERT INTO `distrito` VALUES (174, 26, 'MATO', 1);
INSERT INTO `distrito` VALUES (175, 26, 'PAMPAROMAS', 1);
INSERT INTO `distrito` VALUES (176, 26, 'PUEBLO LIBRE', 1);
INSERT INTO `distrito` VALUES (177, 26, 'SANTA CRUZ', 1);
INSERT INTO `distrito` VALUES (178, 26, 'SANTO TORIBIO', 1);
INSERT INTO `distrito` VALUES (179, 26, 'YURACMARCA', 1);
INSERT INTO `distrito` VALUES (180, 27, 'PISCOBAMBA', 1);
INSERT INTO `distrito` VALUES (181, 27, 'CASCA', 1);
INSERT INTO `distrito` VALUES (182, 27, 'ELEAZAR GUZMAN BARRON', 1);
INSERT INTO `distrito` VALUES (183, 27, 'FIDEL OLIVAS ESCUDERO', 1);
INSERT INTO `distrito` VALUES (184, 27, 'LLAMA', 1);
INSERT INTO `distrito` VALUES (185, 27, 'LLUMPA', 1);
INSERT INTO `distrito` VALUES (186, 27, 'LUCMA', 1);
INSERT INTO `distrito` VALUES (187, 27, 'MUSGA', 1);
INSERT INTO `distrito` VALUES (188, 21, 'OCROS', 1);
INSERT INTO `distrito` VALUES (189, 21, 'ACAS', 1);
INSERT INTO `distrito` VALUES (190, 21, 'CAJAMARQUILLA', 1);
INSERT INTO `distrito` VALUES (191, 21, 'CARHUAPAMPA', 1);
INSERT INTO `distrito` VALUES (192, 21, 'COCHAS', 1);
INSERT INTO `distrito` VALUES (193, 21, 'CONGAS', 1);
INSERT INTO `distrito` VALUES (194, 21, 'LLIPA', 1);
INSERT INTO `distrito` VALUES (195, 21, 'SAN CRISTOBAL DE RAJAN', 1);
INSERT INTO `distrito` VALUES (196, 21, 'SAN PEDRO', 1);
INSERT INTO `distrito` VALUES (197, 21, 'SANTIAGO DE CHILCAS', 1);
INSERT INTO `distrito` VALUES (198, 22, 'CABANA', 1);
INSERT INTO `distrito` VALUES (199, 22, 'BOLOGNESI', 1);
INSERT INTO `distrito` VALUES (200, 22, 'CONCHUCOS', 1);
INSERT INTO `distrito` VALUES (201, 22, 'HUACASCHUQUE', 1);
INSERT INTO `distrito` VALUES (202, 22, 'HUANDOVAL', 1);
INSERT INTO `distrito` VALUES (203, 22, 'LACABAMBA', 1);
INSERT INTO `distrito` VALUES (204, 22, 'LLAPO', 1);
INSERT INTO `distrito` VALUES (205, 22, 'PALLASCA', 1);
INSERT INTO `distrito` VALUES (206, 22, 'PAMPAS', 1);
INSERT INTO `distrito` VALUES (207, 22, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (208, 22, 'TAUCA', 1);
INSERT INTO `distrito` VALUES (209, 23, 'POMABAMBA', 1);
INSERT INTO `distrito` VALUES (210, 23, 'HUAYLLAN', 1);
INSERT INTO `distrito` VALUES (211, 23, 'PAROBAMBA', 1);
INSERT INTO `distrito` VALUES (212, 23, 'QUINUABAMBA', 1);
INSERT INTO `distrito` VALUES (213, 24, 'RECUAY', 1);
INSERT INTO `distrito` VALUES (214, 24, 'CATAC', 1);
INSERT INTO `distrito` VALUES (215, 24, 'COTAPARACO', 1);
INSERT INTO `distrito` VALUES (216, 24, 'HUAYLLAPAMPA', 1);
INSERT INTO `distrito` VALUES (217, 24, 'LLACLLIN', 1);
INSERT INTO `distrito` VALUES (218, 24, 'MARCA', 1);
INSERT INTO `distrito` VALUES (219, 24, 'PAMPAS CHICO', 1);
INSERT INTO `distrito` VALUES (220, 24, 'PARARIN', 1);
INSERT INTO `distrito` VALUES (221, 24, 'TAPACOCHA', 1);
INSERT INTO `distrito` VALUES (222, 24, 'TICAPAMPA', 1);
INSERT INTO `distrito` VALUES (223, 25, 'CHIMBOTE', 1);
INSERT INTO `distrito` VALUES (224, 25, 'CACERES DEL PERU', 1);
INSERT INTO `distrito` VALUES (225, 25, 'COISHCO', 1);
INSERT INTO `distrito` VALUES (226, 25, 'MACATE', 1);
INSERT INTO `distrito` VALUES (227, 25, 'MORO', 1);
INSERT INTO `distrito` VALUES (228, 25, 'NEPEÑA', 1);
INSERT INTO `distrito` VALUES (229, 25, 'SAMANCO', 1);
INSERT INTO `distrito` VALUES (230, 25, 'SANTA', 1);
INSERT INTO `distrito` VALUES (231, 25, 'NUEVO CHIMBOTE', 1);
INSERT INTO `distrito` VALUES (232, 26, 'SIHUAS', 1);
INSERT INTO `distrito` VALUES (233, 26, 'ACOBAMBA', 1);
INSERT INTO `distrito` VALUES (234, 26, 'ALFONSO UGARTE', 1);
INSERT INTO `distrito` VALUES (235, 26, 'CASHAPAMPA', 1);
INSERT INTO `distrito` VALUES (236, 26, 'CHINGALPO', 1);
INSERT INTO `distrito` VALUES (237, 26, 'HUAYLLABAMBA', 1);
INSERT INTO `distrito` VALUES (238, 26, 'QUICHES', 1);
INSERT INTO `distrito` VALUES (239, 26, 'RAGASH', 1);
INSERT INTO `distrito` VALUES (240, 26, 'SAN JUAN', 1);
INSERT INTO `distrito` VALUES (241, 26, 'SICSIBAMBA', 1);
INSERT INTO `distrito` VALUES (242, 27, 'YUNGAY', 1);
INSERT INTO `distrito` VALUES (243, 27, 'CASCAPARA', 1);
INSERT INTO `distrito` VALUES (244, 27, 'MANCOS', 1);
INSERT INTO `distrito` VALUES (245, 27, 'MATACOTO', 1);
INSERT INTO `distrito` VALUES (246, 27, 'QUILLO', 1);
INSERT INTO `distrito` VALUES (247, 27, 'RANRAHIRCA', 1);
INSERT INTO `distrito` VALUES (248, 27, 'SHUPLUY', 1);
INSERT INTO `distrito` VALUES (249, 27, 'YANAMA', 1);
INSERT INTO `distrito` VALUES (250, 28, 'ABANCAY', 1);
INSERT INTO `distrito` VALUES (251, 28, 'CHACOCHE', 1);
INSERT INTO `distrito` VALUES (252, 28, 'CIRCA', 1);
INSERT INTO `distrito` VALUES (253, 28, 'CURAHUASI', 1);
INSERT INTO `distrito` VALUES (254, 28, 'HUANIPACA', 1);
INSERT INTO `distrito` VALUES (255, 28, 'LAMBRAMA', 1);
INSERT INTO `distrito` VALUES (256, 28, 'PICHIRHUA', 1);
INSERT INTO `distrito` VALUES (257, 28, 'SAN PEDRO DE CACHORA', 1);
INSERT INTO `distrito` VALUES (258, 28, 'TAMBURCO', 1);
INSERT INTO `distrito` VALUES (259, 29, 'ANDAHUAYLAS', 1);
INSERT INTO `distrito` VALUES (260, 29, 'ANDARAPA', 1);
INSERT INTO `distrito` VALUES (261, 29, 'CHIARA', 1);
INSERT INTO `distrito` VALUES (262, 29, 'HUANCARAMA', 1);
INSERT INTO `distrito` VALUES (263, 29, 'HUANCARAY', 1);
INSERT INTO `distrito` VALUES (264, 29, 'HUAYANA', 1);
INSERT INTO `distrito` VALUES (265, 29, 'KISHUARA', 1);
INSERT INTO `distrito` VALUES (266, 29, 'PACOBAMBA', 1);
INSERT INTO `distrito` VALUES (267, 29, 'PACUCHA', 1);
INSERT INTO `distrito` VALUES (268, 29, 'PAMPACHIRI', 1);
INSERT INTO `distrito` VALUES (269, 29, 'POMACOCHA', 1);
INSERT INTO `distrito` VALUES (270, 29, 'SAN ANTONIO DE CACHI', 1);
INSERT INTO `distrito` VALUES (271, 29, 'SAN JERONIMO', 1);
INSERT INTO `distrito` VALUES (272, 29, 'SAN MIGUEL DE CHACCRAMPA', 1);
INSERT INTO `distrito` VALUES (273, 29, 'SANTA MARIA DE CHICMO', 1);
INSERT INTO `distrito` VALUES (274, 29, 'TALAVERA', 1);
INSERT INTO `distrito` VALUES (275, 29, 'TUMAY HUARACA', 1);
INSERT INTO `distrito` VALUES (276, 29, 'TURPO', 1);
INSERT INTO `distrito` VALUES (277, 29, 'KAQUIABAMBA', 1);
INSERT INTO `distrito` VALUES (278, 30, 'ANTABAMBA', 1);
INSERT INTO `distrito` VALUES (279, 30, 'EL ORO', 1);
INSERT INTO `distrito` VALUES (280, 30, 'HUAQUIRCA', 1);
INSERT INTO `distrito` VALUES (281, 30, 'JUAN ESPINOZA MEDRANO', 1);
INSERT INTO `distrito` VALUES (282, 30, 'OROPESA', 1);
INSERT INTO `distrito` VALUES (283, 30, 'PACHACONAS', 1);
INSERT INTO `distrito` VALUES (284, 30, 'SABAINO', 1);
INSERT INTO `distrito` VALUES (285, 31, 'CHALHUANCA', 1);
INSERT INTO `distrito` VALUES (286, 31, 'CAPAYA', 1);
INSERT INTO `distrito` VALUES (287, 31, 'CARAYBAMBA', 1);
INSERT INTO `distrito` VALUES (288, 31, 'CHAPIMARCA', 1);
INSERT INTO `distrito` VALUES (289, 31, 'COLCABAMBA', 1);
INSERT INTO `distrito` VALUES (290, 31, 'COTARUSE', 1);
INSERT INTO `distrito` VALUES (291, 31, 'HUAYLLO', 1);
INSERT INTO `distrito` VALUES (292, 31, 'JUSTO APU SAHUARAURA', 1);
INSERT INTO `distrito` VALUES (293, 31, 'LUCRE', 1);
INSERT INTO `distrito` VALUES (294, 31, 'POCOHUANCA', 1);
INSERT INTO `distrito` VALUES (295, 31, 'SAN JUAN DE CHACÑA', 1);
INSERT INTO `distrito` VALUES (296, 31, 'SAÑAYCA', 1);
INSERT INTO `distrito` VALUES (297, 31, 'SORAYA', 1);
INSERT INTO `distrito` VALUES (298, 31, 'TAPAIRIHUA', 1);
INSERT INTO `distrito` VALUES (299, 31, 'TINTAY', 1);
INSERT INTO `distrito` VALUES (300, 31, 'TORAYA', 1);
INSERT INTO `distrito` VALUES (301, 31, 'YANACA', 1);
INSERT INTO `distrito` VALUES (302, 32, 'TAMBOBAMBA', 1);
INSERT INTO `distrito` VALUES (303, 32, 'COTABAMBAS', 1);
INSERT INTO `distrito` VALUES (304, 32, 'COYLLURQUI', 1);
INSERT INTO `distrito` VALUES (305, 32, 'HAQUIRA', 1);
INSERT INTO `distrito` VALUES (306, 32, 'MARA', 1);
INSERT INTO `distrito` VALUES (307, 32, 'CHALLHUAHUACHO', 1);
INSERT INTO `distrito` VALUES (308, 33, 'CHINCHEROS', 1);
INSERT INTO `distrito` VALUES (309, 33, 'ANCO-HUALLO', 1);
INSERT INTO `distrito` VALUES (310, 33, 'COCHARCAS', 1);
INSERT INTO `distrito` VALUES (311, 33, 'HUACCANA', 1);
INSERT INTO `distrito` VALUES (312, 33, 'OCOBAMBA', 1);
INSERT INTO `distrito` VALUES (313, 33, 'ONGOY', 1);
INSERT INTO `distrito` VALUES (314, 33, 'URANMARCA', 1);
INSERT INTO `distrito` VALUES (315, 33, 'RANRACANCHA', 1);
INSERT INTO `distrito` VALUES (316, 34, 'CHUQUIBAMBILLA', 1);
INSERT INTO `distrito` VALUES (317, 34, 'CURPAHUASI', 1);
INSERT INTO `distrito` VALUES (318, 34, 'GAMARRA', 1);
INSERT INTO `distrito` VALUES (319, 34, 'HUAYLLATI', 1);
INSERT INTO `distrito` VALUES (320, 34, 'MAMARA', 1);
INSERT INTO `distrito` VALUES (321, 34, 'MICAELA BASTIDAS', 1);
INSERT INTO `distrito` VALUES (322, 34, 'PATAYPAMPA', 1);
INSERT INTO `distrito` VALUES (323, 34, 'PROGRESO', 1);
INSERT INTO `distrito` VALUES (324, 34, 'SAN ANTONIO', 1);
INSERT INTO `distrito` VALUES (325, 34, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (326, 34, 'TURPAY', 1);
INSERT INTO `distrito` VALUES (327, 34, 'VILCABAMBA', 1);
INSERT INTO `distrito` VALUES (328, 34, 'VIRUNDO', 1);
INSERT INTO `distrito` VALUES (329, 34, 'CURASCO', 1);
INSERT INTO `distrito` VALUES (330, 35, 'AREQUIPA', 1);
INSERT INTO `distrito` VALUES (331, 35, 'ALTO SELVA ALEGRE', 1);
INSERT INTO `distrito` VALUES (332, 35, 'CAYMA', 1);
INSERT INTO `distrito` VALUES (333, 35, 'CERRO COLORADO', 1);
INSERT INTO `distrito` VALUES (334, 35, 'CHARACATO', 1);
INSERT INTO `distrito` VALUES (335, 35, 'CHIGUATA', 1);
INSERT INTO `distrito` VALUES (336, 35, 'JACOBO HUNTER', 1);
INSERT INTO `distrito` VALUES (337, 35, 'LA JOYA', 1);
INSERT INTO `distrito` VALUES (338, 35, 'MARIANO MELGAR', 1);
INSERT INTO `distrito` VALUES (339, 35, 'MIRAFLORES', 1);
INSERT INTO `distrito` VALUES (340, 35, 'MOLLEBAYA', 1);
INSERT INTO `distrito` VALUES (341, 35, 'PAUCARPATA', 1);
INSERT INTO `distrito` VALUES (342, 35, 'POCSI', 1);
INSERT INTO `distrito` VALUES (343, 35, 'POLOBAYA', 1);
INSERT INTO `distrito` VALUES (344, 35, 'QUEQUEÑA', 1);
INSERT INTO `distrito` VALUES (345, 35, 'SABANDIA', 1);
INSERT INTO `distrito` VALUES (346, 35, 'SACHACA', 1);
INSERT INTO `distrito` VALUES (347, 35, 'SAN JUAN DE SIGUAS', 1);
INSERT INTO `distrito` VALUES (348, 35, 'SAN JUAN DE TARUCANI', 1);
INSERT INTO `distrito` VALUES (349, 35, 'SANTA ISABEL DE SIGUAS', 1);
INSERT INTO `distrito` VALUES (350, 35, 'SANTA RITA DE SIGUAS', 1);
INSERT INTO `distrito` VALUES (351, 35, 'SOCABAYA', 1);
INSERT INTO `distrito` VALUES (352, 35, 'TIABAYA', 1);
INSERT INTO `distrito` VALUES (353, 35, 'UCHUMAYO', 1);
INSERT INTO `distrito` VALUES (354, 35, 'VITOR', 1);
INSERT INTO `distrito` VALUES (355, 35, 'YANAHUARA', 1);
INSERT INTO `distrito` VALUES (356, 35, 'YARABAMBA', 1);
INSERT INTO `distrito` VALUES (357, 35, 'YURA', 1);
INSERT INTO `distrito` VALUES (358, 35, 'JOSE LUIS BUSTAMANTE Y RIVERO', 1);
INSERT INTO `distrito` VALUES (359, 36, 'CAMANA', 1);
INSERT INTO `distrito` VALUES (360, 36, 'JOSE MARIA QUIMPER', 1);
INSERT INTO `distrito` VALUES (361, 36, 'MARIANO NICOLAS VALCARCEL', 1);
INSERT INTO `distrito` VALUES (362, 36, 'MARISCAL CACERES', 1);
INSERT INTO `distrito` VALUES (363, 36, 'NICOLAS DE PIEROLA', 1);
INSERT INTO `distrito` VALUES (364, 36, 'OCOÑA', 1);
INSERT INTO `distrito` VALUES (365, 36, 'QUILCA', 1);
INSERT INTO `distrito` VALUES (366, 36, 'SAMUEL PASTOR', 1);
INSERT INTO `distrito` VALUES (367, 37, 'CARAVELI', 1);
INSERT INTO `distrito` VALUES (368, 37, 'ACARI', 1);
INSERT INTO `distrito` VALUES (369, 37, 'ATICO', 1);
INSERT INTO `distrito` VALUES (370, 37, 'ATIQUIPA', 1);
INSERT INTO `distrito` VALUES (371, 37, 'BELLA UNION', 1);
INSERT INTO `distrito` VALUES (372, 37, 'CAHUACHO', 1);
INSERT INTO `distrito` VALUES (373, 37, 'CHALA', 1);
INSERT INTO `distrito` VALUES (374, 37, 'CHAPARRA', 1);
INSERT INTO `distrito` VALUES (375, 37, 'HUANUHUANU', 1);
INSERT INTO `distrito` VALUES (376, 37, 'JAQUI', 1);
INSERT INTO `distrito` VALUES (377, 37, 'LOMAS', 1);
INSERT INTO `distrito` VALUES (378, 37, 'QUICACHA', 1);
INSERT INTO `distrito` VALUES (379, 37, 'YAUCA', 1);
INSERT INTO `distrito` VALUES (380, 38, 'APLAO', 1);
INSERT INTO `distrito` VALUES (381, 38, 'ANDAGUA', 1);
INSERT INTO `distrito` VALUES (382, 38, 'AYO', 1);
INSERT INTO `distrito` VALUES (383, 38, 'CHACHAS', 1);
INSERT INTO `distrito` VALUES (384, 38, 'CHILCAYMARCA', 1);
INSERT INTO `distrito` VALUES (385, 38, 'CHOCO', 1);
INSERT INTO `distrito` VALUES (386, 38, 'HUANCARQUI', 1);
INSERT INTO `distrito` VALUES (387, 38, 'MACHAGUAY', 1);
INSERT INTO `distrito` VALUES (388, 38, 'ORCOPAMPA', 1);
INSERT INTO `distrito` VALUES (389, 38, 'PAMPACOLCA', 1);
INSERT INTO `distrito` VALUES (390, 38, 'TIPAN', 1);
INSERT INTO `distrito` VALUES (391, 38, 'UÑON', 1);
INSERT INTO `distrito` VALUES (392, 38, 'URACA', 1);
INSERT INTO `distrito` VALUES (393, 38, 'VIRACO', 1);
INSERT INTO `distrito` VALUES (394, 39, 'CHIVAY', 1);
INSERT INTO `distrito` VALUES (395, 39, 'ACHOMA', 1);
INSERT INTO `distrito` VALUES (396, 39, 'CABANACONDE', 1);
INSERT INTO `distrito` VALUES (397, 39, 'CALLALLI', 1);
INSERT INTO `distrito` VALUES (398, 39, 'CAYLLOMA', 1);
INSERT INTO `distrito` VALUES (399, 39, 'COPORAQUE', 1);
INSERT INTO `distrito` VALUES (400, 39, 'HUAMBO', 1);
INSERT INTO `distrito` VALUES (401, 39, 'HUANCA', 1);
INSERT INTO `distrito` VALUES (402, 39, 'ICHUPAMPA', 1);
INSERT INTO `distrito` VALUES (403, 39, 'LARI', 1);
INSERT INTO `distrito` VALUES (404, 39, 'LLUTA', 1);
INSERT INTO `distrito` VALUES (405, 39, 'MACA', 1);
INSERT INTO `distrito` VALUES (406, 39, 'MADRIGAL', 1);
INSERT INTO `distrito` VALUES (407, 39, 'SAN ANTONIO DE CHUCA', 1);
INSERT INTO `distrito` VALUES (408, 39, 'SIBAYO', 1);
INSERT INTO `distrito` VALUES (409, 39, 'TAPAY', 1);
INSERT INTO `distrito` VALUES (410, 39, 'TISCO', 1);
INSERT INTO `distrito` VALUES (411, 39, 'TUTI', 1);
INSERT INTO `distrito` VALUES (412, 39, 'YANQUE', 1);
INSERT INTO `distrito` VALUES (413, 39, 'MAJES', 1);
INSERT INTO `distrito` VALUES (414, 40, 'CHUQUIBAMBA', 1);
INSERT INTO `distrito` VALUES (415, 40, 'ANDARAY', 1);
INSERT INTO `distrito` VALUES (416, 40, 'CAYARANI', 1);
INSERT INTO `distrito` VALUES (417, 40, 'CHICHAS', 1);
INSERT INTO `distrito` VALUES (418, 40, 'IRAY', 1);
INSERT INTO `distrito` VALUES (419, 40, 'RIO GRANDE', 1);
INSERT INTO `distrito` VALUES (420, 40, 'SALAMANCA', 1);
INSERT INTO `distrito` VALUES (421, 40, 'YANAQUIHUA', 1);
INSERT INTO `distrito` VALUES (422, 41, 'MOLLENDO', 1);
INSERT INTO `distrito` VALUES (423, 41, 'COCACHACRA', 1);
INSERT INTO `distrito` VALUES (424, 41, 'DEAN VALDIVIA', 1);
INSERT INTO `distrito` VALUES (425, 41, 'ISLAY', 1);
INSERT INTO `distrito` VALUES (426, 41, 'MEJIA', 1);
INSERT INTO `distrito` VALUES (427, 41, 'PUNTA DE BOMBON', 1);
INSERT INTO `distrito` VALUES (428, 42, 'COTAHUASI', 1);
INSERT INTO `distrito` VALUES (429, 42, 'ALCA', 1);
INSERT INTO `distrito` VALUES (430, 42, 'CHARCANA', 1);
INSERT INTO `distrito` VALUES (431, 42, 'HUAYNACOTAS', 1);
INSERT INTO `distrito` VALUES (432, 42, 'PAMPAMARCA', 1);
INSERT INTO `distrito` VALUES (433, 42, 'PUYCA', 1);
INSERT INTO `distrito` VALUES (434, 42, 'QUECHUALLA', 1);
INSERT INTO `distrito` VALUES (435, 42, 'SAYLA', 1);
INSERT INTO `distrito` VALUES (436, 42, 'TAURIA', 1);
INSERT INTO `distrito` VALUES (437, 42, 'TOMEPAMPA', 1);
INSERT INTO `distrito` VALUES (438, 42, 'TORO', 1);
INSERT INTO `distrito` VALUES (439, 43, 'AYACUCHO', 1);
INSERT INTO `distrito` VALUES (440, 43, 'ACOCRO', 1);
INSERT INTO `distrito` VALUES (441, 43, 'ACOS VINCHOS', 1);
INSERT INTO `distrito` VALUES (442, 43, 'CARMEN ALTO', 1);
INSERT INTO `distrito` VALUES (443, 43, 'CHIARA', 1);
INSERT INTO `distrito` VALUES (444, 43, 'OCROS', 1);
INSERT INTO `distrito` VALUES (445, 43, 'PACAYCASA', 1);
INSERT INTO `distrito` VALUES (446, 43, 'QUINUA', 1);
INSERT INTO `distrito` VALUES (447, 43, 'SAN JOSE DE TICLLAS', 1);
INSERT INTO `distrito` VALUES (448, 43, 'SAN JUAN BAUTISTA', 1);
INSERT INTO `distrito` VALUES (449, 43, 'SANTIAGO DE PISCHA', 1);
INSERT INTO `distrito` VALUES (450, 43, 'SOCOS', 1);
INSERT INTO `distrito` VALUES (451, 43, 'TAMBILLO', 1);
INSERT INTO `distrito` VALUES (452, 43, 'VINCHOS', 1);
INSERT INTO `distrito` VALUES (453, 43, 'JESUS NAZARENO', 1);
INSERT INTO `distrito` VALUES (454, 44, 'CANGALLO', 1);
INSERT INTO `distrito` VALUES (455, 44, 'CHUSCHI', 1);
INSERT INTO `distrito` VALUES (456, 44, 'LOS MOROCHUCOS', 1);
INSERT INTO `distrito` VALUES (457, 44, 'MARIA PARADO DE BELLIDO', 1);
INSERT INTO `distrito` VALUES (458, 44, 'PARAS', 1);
INSERT INTO `distrito` VALUES (459, 44, 'TOTOS', 1);
INSERT INTO `distrito` VALUES (460, 45, 'SANCOS', 1);
INSERT INTO `distrito` VALUES (461, 45, 'CARAPO', 1);
INSERT INTO `distrito` VALUES (462, 45, 'SACSAMARCA', 1);
INSERT INTO `distrito` VALUES (463, 45, 'SANTIAGO DE LUCANAMARCA', 1);
INSERT INTO `distrito` VALUES (464, 46, 'HUANTA', 1);
INSERT INTO `distrito` VALUES (465, 46, 'AYAHUANCO', 1);
INSERT INTO `distrito` VALUES (466, 46, 'HUAMANGUILLA', 1);
INSERT INTO `distrito` VALUES (467, 46, 'IGUAIN', 1);
INSERT INTO `distrito` VALUES (468, 46, 'LURICOCHA', 1);
INSERT INTO `distrito` VALUES (469, 46, 'SANTILLANA', 1);
INSERT INTO `distrito` VALUES (470, 46, 'SIVIA', 1);
INSERT INTO `distrito` VALUES (471, 46, 'LLOCHEGUA', 1);
INSERT INTO `distrito` VALUES (472, 47, 'SAN MIGUEL', 1);
INSERT INTO `distrito` VALUES (473, 47, 'ANCO', 1);
INSERT INTO `distrito` VALUES (474, 47, 'AYNA', 1);
INSERT INTO `distrito` VALUES (475, 47, 'CHILCAS', 1);
INSERT INTO `distrito` VALUES (476, 47, 'CHUNGUI', 1);
INSERT INTO `distrito` VALUES (477, 47, 'LUIS CARRANZA', 1);
INSERT INTO `distrito` VALUES (478, 47, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (479, 47, 'TAMBO', 1);
INSERT INTO `distrito` VALUES (480, 48, 'PUQUIO', 1);
INSERT INTO `distrito` VALUES (481, 48, 'AUCARA', 1);
INSERT INTO `distrito` VALUES (482, 48, 'CABANA', 1);
INSERT INTO `distrito` VALUES (483, 48, 'CARMEN SALCEDO', 1);
INSERT INTO `distrito` VALUES (484, 48, 'CHAVIÑA', 1);
INSERT INTO `distrito` VALUES (485, 48, 'CHIPAO', 1);
INSERT INTO `distrito` VALUES (486, 48, 'HUAC-HUAS', 1);
INSERT INTO `distrito` VALUES (487, 48, 'LARAMATE', 1);
INSERT INTO `distrito` VALUES (488, 48, 'LEONCIO PRADO', 1);
INSERT INTO `distrito` VALUES (489, 48, 'LLAUTA', 1);
INSERT INTO `distrito` VALUES (490, 48, 'LUCANAS', 1);
INSERT INTO `distrito` VALUES (491, 48, 'OCAÑA', 1);
INSERT INTO `distrito` VALUES (492, 48, 'OTOCA', 1);
INSERT INTO `distrito` VALUES (493, 48, 'SAISA', 1);
INSERT INTO `distrito` VALUES (494, 48, 'SAN CRISTOBAL', 1);
INSERT INTO `distrito` VALUES (495, 48, 'SAN JUAN', 1);
INSERT INTO `distrito` VALUES (496, 48, 'SAN PEDRO', 1);
INSERT INTO `distrito` VALUES (497, 48, 'SAN PEDRO DE PALCO', 1);
INSERT INTO `distrito` VALUES (498, 48, 'SANCOS', 1);
INSERT INTO `distrito` VALUES (499, 48, 'SANTA ANA DE HUAYCAHUACHO', 1);
INSERT INTO `distrito` VALUES (500, 48, 'SANTA LUCIA', 1);
INSERT INTO `distrito` VALUES (501, 49, 'CORACORA', 1);
INSERT INTO `distrito` VALUES (502, 49, 'CHUMPI', 1);
INSERT INTO `distrito` VALUES (503, 49, 'CORONEL CASTAÑEDA', 1);
INSERT INTO `distrito` VALUES (504, 49, 'PACAPAUSA', 1);
INSERT INTO `distrito` VALUES (505, 49, 'PULLO', 1);
INSERT INTO `distrito` VALUES (506, 49, 'PUYUSCA', 1);
INSERT INTO `distrito` VALUES (507, 49, 'SAN FRANCISCO DE RAVACAYCO', 1);
INSERT INTO `distrito` VALUES (508, 49, 'UPAHUACHO', 1);
INSERT INTO `distrito` VALUES (509, 50, 'PAUSA', 1);
INSERT INTO `distrito` VALUES (510, 50, 'COLTA', 1);
INSERT INTO `distrito` VALUES (511, 50, 'CORCULLA', 1);
INSERT INTO `distrito` VALUES (512, 50, 'LAMPA', 1);
INSERT INTO `distrito` VALUES (513, 50, 'MARCABAMBA', 1);
INSERT INTO `distrito` VALUES (514, 50, 'OYOLO', 1);
INSERT INTO `distrito` VALUES (515, 50, 'PARARCA', 1);
INSERT INTO `distrito` VALUES (516, 50, 'SAN JAVIER DE ALPABAMBA', 1);
INSERT INTO `distrito` VALUES (517, 50, 'SAN JOSE DE USHUA', 1);
INSERT INTO `distrito` VALUES (518, 50, 'SARA SARA', 1);
INSERT INTO `distrito` VALUES (519, 51, 'QUEROBAMBA', 1);
INSERT INTO `distrito` VALUES (520, 51, 'BELEN', 1);
INSERT INTO `distrito` VALUES (521, 51, 'CHALCOS', 1);
INSERT INTO `distrito` VALUES (522, 51, 'CHILCAYOC', 1);
INSERT INTO `distrito` VALUES (523, 51, 'HUACAÑA', 1);
INSERT INTO `distrito` VALUES (524, 51, 'MORCOLLA', 1);
INSERT INTO `distrito` VALUES (525, 51, 'PAICO', 1);
INSERT INTO `distrito` VALUES (526, 51, 'SAN PEDRO DE LARCAY', 1);
INSERT INTO `distrito` VALUES (527, 51, 'SAN SALVADOR DE QUIJE', 1);
INSERT INTO `distrito` VALUES (528, 51, 'SANTIAGO DE PAUCARAY', 1);
INSERT INTO `distrito` VALUES (529, 51, 'SORAS', 1);
INSERT INTO `distrito` VALUES (530, 52, 'HUANCAPI', 1);
INSERT INTO `distrito` VALUES (531, 52, 'ALCAMENCA', 1);
INSERT INTO `distrito` VALUES (532, 52, 'APONGO', 1);
INSERT INTO `distrito` VALUES (533, 52, 'ASQUIPATA', 1);
INSERT INTO `distrito` VALUES (534, 52, 'CANARIA', 1);
INSERT INTO `distrito` VALUES (535, 52, 'CAYARA', 1);
INSERT INTO `distrito` VALUES (536, 52, 'COLCA', 1);
INSERT INTO `distrito` VALUES (537, 52, 'HUAMANQUIQUIA', 1);
INSERT INTO `distrito` VALUES (538, 52, 'HUANCARAYLLA', 1);
INSERT INTO `distrito` VALUES (539, 52, 'HUAYA', 1);
INSERT INTO `distrito` VALUES (540, 52, 'SARHUA', 1);
INSERT INTO `distrito` VALUES (541, 52, 'VILCANCHOS', 1);
INSERT INTO `distrito` VALUES (542, 53, 'VILCAS HUAMAN', 1);
INSERT INTO `distrito` VALUES (543, 53, 'ACCOMARCA', 1);
INSERT INTO `distrito` VALUES (544, 53, 'CARHUANCA', 1);
INSERT INTO `distrito` VALUES (545, 53, 'CONCEPCION', 1);
INSERT INTO `distrito` VALUES (546, 53, 'HUAMBALPA', 1);
INSERT INTO `distrito` VALUES (547, 53, 'INDEPENDENCIA', 1);
INSERT INTO `distrito` VALUES (548, 53, 'SAURAMA', 1);
INSERT INTO `distrito` VALUES (549, 53, 'VISCHONGO', 1);
INSERT INTO `distrito` VALUES (550, 54, 'CAJAMARCA', 1);
INSERT INTO `distrito` VALUES (551, 54, 'CAJAMARCA', 1);
INSERT INTO `distrito` VALUES (552, 54, 'ASUNCION', 1);
INSERT INTO `distrito` VALUES (553, 54, 'CHETILLA', 1);
INSERT INTO `distrito` VALUES (554, 54, 'COSPAN', 1);
INSERT INTO `distrito` VALUES (555, 54, 'ENCAÑADA', 1);
INSERT INTO `distrito` VALUES (556, 54, 'JESUS', 1);
INSERT INTO `distrito` VALUES (557, 54, 'LLACANORA', 1);
INSERT INTO `distrito` VALUES (558, 54, 'LOS BAÑOS DEL INCA', 1);
INSERT INTO `distrito` VALUES (559, 54, 'MAGDALENA', 1);
INSERT INTO `distrito` VALUES (560, 54, 'MATARA', 1);
INSERT INTO `distrito` VALUES (561, 54, 'NAMORA', 1);
INSERT INTO `distrito` VALUES (562, 54, 'SAN JUAN', 1);
INSERT INTO `distrito` VALUES (563, 55, 'CAJABAMBA', 1);
INSERT INTO `distrito` VALUES (564, 55, 'CACHACHI', 1);
INSERT INTO `distrito` VALUES (565, 55, 'CONDEBAMBA', 1);
INSERT INTO `distrito` VALUES (566, 55, 'SITACOCHA', 1);
INSERT INTO `distrito` VALUES (567, 56, 'CELENDIN', 1);
INSERT INTO `distrito` VALUES (568, 56, 'CHUMUCH', 1);
INSERT INTO `distrito` VALUES (569, 56, 'CORTEGANA', 1);
INSERT INTO `distrito` VALUES (570, 56, 'HUASMIN', 1);
INSERT INTO `distrito` VALUES (571, 56, 'JORGE CHAVEZ', 1);
INSERT INTO `distrito` VALUES (572, 56, 'JOSE GALVEZ', 1);
INSERT INTO `distrito` VALUES (573, 56, 'MIGUEL IGLESIAS', 1);
INSERT INTO `distrito` VALUES (574, 56, 'OXAMARCA', 1);
INSERT INTO `distrito` VALUES (575, 56, 'SOROCHUCO', 1);
INSERT INTO `distrito` VALUES (576, 56, 'SUCRE', 1);
INSERT INTO `distrito` VALUES (577, 56, 'UTCO', 1);
INSERT INTO `distrito` VALUES (578, 56, 'LA LIBERTAD DE PALLAN', 1);
INSERT INTO `distrito` VALUES (579, 57, 'CHOTA', 1);
INSERT INTO `distrito` VALUES (580, 57, 'ANGUIA', 1);
INSERT INTO `distrito` VALUES (581, 57, 'CHADIN', 1);
INSERT INTO `distrito` VALUES (582, 57, 'CHIGUIRIP', 1);
INSERT INTO `distrito` VALUES (583, 57, 'CHIMBAN', 1);
INSERT INTO `distrito` VALUES (584, 57, 'CHOROPAMPA', 1);
INSERT INTO `distrito` VALUES (585, 57, 'COCHABAMBA', 1);
INSERT INTO `distrito` VALUES (586, 57, 'CONCHAN', 1);
INSERT INTO `distrito` VALUES (587, 57, 'HUAMBOS', 1);
INSERT INTO `distrito` VALUES (588, 57, 'LAJAS', 1);
INSERT INTO `distrito` VALUES (589, 57, 'LLAMA', 1);
INSERT INTO `distrito` VALUES (590, 57, 'MIRACOSTA', 1);
INSERT INTO `distrito` VALUES (591, 57, 'PACCHA', 1);
INSERT INTO `distrito` VALUES (592, 57, 'PION', 1);
INSERT INTO `distrito` VALUES (593, 57, 'QUEROCOTO', 1);
INSERT INTO `distrito` VALUES (594, 57, 'SAN JUAN DE LICUPIS', 1);
INSERT INTO `distrito` VALUES (595, 57, 'TACABAMBA', 1);
INSERT INTO `distrito` VALUES (596, 57, 'TOCMOCHE', 1);
INSERT INTO `distrito` VALUES (597, 57, 'CHALAMARCA', 1);
INSERT INTO `distrito` VALUES (598, 58, 'CONTUMAZA', 1);
INSERT INTO `distrito` VALUES (599, 58, 'CHILETE', 1);
INSERT INTO `distrito` VALUES (600, 58, 'CUPISNIQUE', 1);
INSERT INTO `distrito` VALUES (601, 58, 'GUZMANGO', 1);
INSERT INTO `distrito` VALUES (602, 58, 'SAN BENITO', 1);
INSERT INTO `distrito` VALUES (603, 58, 'SANTA CRUZ DE TOLED', 1);
INSERT INTO `distrito` VALUES (604, 58, 'TANTARICA', 1);
INSERT INTO `distrito` VALUES (605, 58, 'YONAN', 1);
INSERT INTO `distrito` VALUES (606, 59, 'CUTERVO', 1);
INSERT INTO `distrito` VALUES (607, 59, 'CALLAYUC', 1);
INSERT INTO `distrito` VALUES (608, 59, 'CHOROS', 1);
INSERT INTO `distrito` VALUES (609, 59, 'CUJILLO', 1);
INSERT INTO `distrito` VALUES (610, 59, 'LA RAMADA', 1);
INSERT INTO `distrito` VALUES (611, 59, 'PIMPINGOS', 1);
INSERT INTO `distrito` VALUES (612, 59, 'QUEROCOTILLO', 1);
INSERT INTO `distrito` VALUES (613, 59, 'SAN ANDRES DE CUTERVO', 1);
INSERT INTO `distrito` VALUES (614, 59, 'SAN JUAN DE CUTERVO', 1);
INSERT INTO `distrito` VALUES (615, 59, 'SAN LUIS DE LUCMA', 1);
INSERT INTO `distrito` VALUES (616, 59, 'SANTA CRUZ', 1);
INSERT INTO `distrito` VALUES (617, 59, 'SANTO DOMINGO DE LA CAPILLA', 1);
INSERT INTO `distrito` VALUES (618, 59, 'SANTO TOMAS', 1);
INSERT INTO `distrito` VALUES (619, 59, 'SOCOTA', 1);
INSERT INTO `distrito` VALUES (620, 59, 'TORIBIO CASANOVA', 1);
INSERT INTO `distrito` VALUES (621, 60, 'BAMBAMARCA', 1);
INSERT INTO `distrito` VALUES (622, 60, 'CHUGUR', 1);
INSERT INTO `distrito` VALUES (623, 60, 'HUALGAYOC', 1);
INSERT INTO `distrito` VALUES (624, 61, 'JAEN', 1);
INSERT INTO `distrito` VALUES (625, 61, 'BELLAVISTA', 1);
INSERT INTO `distrito` VALUES (626, 61, 'CHONTALI', 1);
INSERT INTO `distrito` VALUES (627, 61, 'COLASAY', 1);
INSERT INTO `distrito` VALUES (628, 61, 'HUABAL', 1);
INSERT INTO `distrito` VALUES (629, 61, 'LAS PIRIAS', 1);
INSERT INTO `distrito` VALUES (630, 61, 'POMAHUACA', 1);
INSERT INTO `distrito` VALUES (631, 61, 'PUCARA', 1);
INSERT INTO `distrito` VALUES (632, 61, 'SALLIQUE', 1);
INSERT INTO `distrito` VALUES (633, 61, 'SAN FELIPE', 1);
INSERT INTO `distrito` VALUES (634, 61, 'SAN JOSE DEL ALTO', 1);
INSERT INTO `distrito` VALUES (635, 61, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (636, 62, 'SAN IGNACIO', 1);
INSERT INTO `distrito` VALUES (637, 62, 'CHIRINOS', 1);
INSERT INTO `distrito` VALUES (638, 62, 'HUARANGO', 1);
INSERT INTO `distrito` VALUES (639, 62, 'LA COIPA', 1);
INSERT INTO `distrito` VALUES (640, 62, 'NAMBALLE', 1);
INSERT INTO `distrito` VALUES (641, 62, 'SAN JOSE DE LOURDES', 1);
INSERT INTO `distrito` VALUES (642, 62, 'TABACONAS', 1);
INSERT INTO `distrito` VALUES (643, 63, 'PEDRO GALVEZ', 1);
INSERT INTO `distrito` VALUES (644, 63, 'CHANCAY', 1);
INSERT INTO `distrito` VALUES (645, 63, 'EDUARDO VILLANUEVA', 1);
INSERT INTO `distrito` VALUES (646, 63, 'GREGORIO PITA', 1);
INSERT INTO `distrito` VALUES (647, 63, 'ICHOCAN', 1);
INSERT INTO `distrito` VALUES (648, 63, 'JOSE MANUEL QUIROZ', 1);
INSERT INTO `distrito` VALUES (649, 63, 'JOSE SABOGAL', 1);
INSERT INTO `distrito` VALUES (650, 64, 'SAN MIGUEL', 1);
INSERT INTO `distrito` VALUES (651, 64, 'SAN MIGUEL', 1);
INSERT INTO `distrito` VALUES (652, 64, 'BOLIVAR', 1);
INSERT INTO `distrito` VALUES (653, 64, 'CALQUIS', 1);
INSERT INTO `distrito` VALUES (654, 64, 'CATILLUC', 1);
INSERT INTO `distrito` VALUES (655, 64, 'EL PRADO', 1);
INSERT INTO `distrito` VALUES (656, 64, 'LA FLORIDA', 1);
INSERT INTO `distrito` VALUES (657, 64, 'LLAPA', 1);
INSERT INTO `distrito` VALUES (658, 64, 'NANCHOC', 1);
INSERT INTO `distrito` VALUES (659, 64, 'NIEPOS', 1);
INSERT INTO `distrito` VALUES (660, 64, 'SAN GREGORIO', 1);
INSERT INTO `distrito` VALUES (661, 64, 'SAN SILVESTRE DE COCHAN', 1);
INSERT INTO `distrito` VALUES (662, 64, 'TONGOD', 1);
INSERT INTO `distrito` VALUES (663, 64, 'UNION AGUA BLANCA', 1);
INSERT INTO `distrito` VALUES (664, 65, 'SAN PABLO', 1);
INSERT INTO `distrito` VALUES (665, 65, 'SAN BERNARDINO', 1);
INSERT INTO `distrito` VALUES (666, 65, 'SAN LUIS', 1);
INSERT INTO `distrito` VALUES (667, 65, 'TUMBADEN', 1);
INSERT INTO `distrito` VALUES (668, 66, 'SANTA CRUZ', 1);
INSERT INTO `distrito` VALUES (669, 66, 'ANDABAMBA', 1);
INSERT INTO `distrito` VALUES (670, 66, 'CATACHE', 1);
INSERT INTO `distrito` VALUES (671, 66, 'CHANCAYBAÑOS', 1);
INSERT INTO `distrito` VALUES (672, 66, 'LA ESPERANZA', 1);
INSERT INTO `distrito` VALUES (673, 66, 'NINABAMBA', 1);
INSERT INTO `distrito` VALUES (674, 66, 'PULAN', 1);
INSERT INTO `distrito` VALUES (675, 66, 'SAUCEPAMPA', 1);
INSERT INTO `distrito` VALUES (676, 66, 'SEXI', 1);
INSERT INTO `distrito` VALUES (677, 66, 'UTICYACU', 1);
INSERT INTO `distrito` VALUES (678, 66, 'YAUYUCAN', 1);
INSERT INTO `distrito` VALUES (679, 67, 'CALLAO', 1);
INSERT INTO `distrito` VALUES (680, 67, 'BELLAVISTA', 1);
INSERT INTO `distrito` VALUES (681, 67, 'CARMEN DE LA LEGUA REYNOSO', 1);
INSERT INTO `distrito` VALUES (682, 67, 'LA PERLA', 1);
INSERT INTO `distrito` VALUES (683, 67, 'LA PUNTA', 1);
INSERT INTO `distrito` VALUES (684, 67, 'VENTANILLA', 1);
INSERT INTO `distrito` VALUES (685, 67, 'CUSCO', 1);
INSERT INTO `distrito` VALUES (686, 67, 'CCORCA', 1);
INSERT INTO `distrito` VALUES (687, 67, 'POROY', 1);
INSERT INTO `distrito` VALUES (688, 67, 'SAN JERONIMO', 1);
INSERT INTO `distrito` VALUES (689, 67, 'SAN SEBASTIAN', 1);
INSERT INTO `distrito` VALUES (690, 67, 'SANTIAGO', 1);
INSERT INTO `distrito` VALUES (691, 67, 'SAYLLA', 1);
INSERT INTO `distrito` VALUES (692, 67, 'WANCHAQ', 1);
INSERT INTO `distrito` VALUES (693, 68, 'ACOMAYO', 1);
INSERT INTO `distrito` VALUES (694, 68, 'ACOPIA', 1);
INSERT INTO `distrito` VALUES (695, 68, 'ACOS', 1);
INSERT INTO `distrito` VALUES (696, 68, 'MOSOC LLACTA', 1);
INSERT INTO `distrito` VALUES (697, 68, 'POMACANCHI', 1);
INSERT INTO `distrito` VALUES (698, 68, 'RONDOCAN', 1);
INSERT INTO `distrito` VALUES (699, 68, 'SANGARARA', 1);
INSERT INTO `distrito` VALUES (700, 69, 'ANTA', 1);
INSERT INTO `distrito` VALUES (701, 69, 'ANCAHUASI', 1);
INSERT INTO `distrito` VALUES (702, 69, 'CACHIMAYO', 1);
INSERT INTO `distrito` VALUES (703, 69, 'CHINCHAYPUJIO', 1);
INSERT INTO `distrito` VALUES (704, 69, 'HUAROCONDO', 1);
INSERT INTO `distrito` VALUES (705, 69, 'LIMATAMBO', 1);
INSERT INTO `distrito` VALUES (706, 69, 'MOLLEPATA', 1);
INSERT INTO `distrito` VALUES (707, 69, 'PUCYURA', 1);
INSERT INTO `distrito` VALUES (708, 69, 'ZURITE', 1);
INSERT INTO `distrito` VALUES (709, 70, 'CALCA', 1);
INSERT INTO `distrito` VALUES (710, 70, 'COYA', 1);
INSERT INTO `distrito` VALUES (711, 70, 'LAMAY', 1);
INSERT INTO `distrito` VALUES (712, 70, 'LARES', 1);
INSERT INTO `distrito` VALUES (713, 70, 'PISAC', 1);
INSERT INTO `distrito` VALUES (714, 70, 'SAN SALVADOR', 1);
INSERT INTO `distrito` VALUES (715, 70, 'TARAY', 1);
INSERT INTO `distrito` VALUES (716, 70, 'YANATILE', 1);
INSERT INTO `distrito` VALUES (717, 71, 'YANAOCA', 1);
INSERT INTO `distrito` VALUES (718, 71, 'CHECCA', 1);
INSERT INTO `distrito` VALUES (719, 71, 'KUNTURKANKI', 1);
INSERT INTO `distrito` VALUES (720, 71, 'LANGUI', 1);
INSERT INTO `distrito` VALUES (721, 71, 'LAYO', 1);
INSERT INTO `distrito` VALUES (722, 71, 'PAMPAMARCA', 1);
INSERT INTO `distrito` VALUES (723, 71, 'QUEHUE', 1);
INSERT INTO `distrito` VALUES (724, 71, 'TUPAC AMARU', 1);
INSERT INTO `distrito` VALUES (725, 72, 'SICUANI', 1);
INSERT INTO `distrito` VALUES (726, 72, 'CHECACUPE', 1);
INSERT INTO `distrito` VALUES (727, 72, 'COMBAPATA', 1);
INSERT INTO `distrito` VALUES (728, 72, 'MARANGANI', 1);
INSERT INTO `distrito` VALUES (729, 72, 'PITUMARCA', 1);
INSERT INTO `distrito` VALUES (730, 72, 'SAN PABLO', 1);
INSERT INTO `distrito` VALUES (731, 72, 'SAN PEDRO', 1);
INSERT INTO `distrito` VALUES (732, 72, 'TINTA', 1);
INSERT INTO `distrito` VALUES (733, 73, 'SANTO TOMAS', 1);
INSERT INTO `distrito` VALUES (734, 73, 'CAPACMARCA', 1);
INSERT INTO `distrito` VALUES (735, 73, 'CHAMACA', 1);
INSERT INTO `distrito` VALUES (736, 73, 'COLQUEMARCA', 1);
INSERT INTO `distrito` VALUES (737, 73, 'LIVITACA', 1);
INSERT INTO `distrito` VALUES (738, 73, 'LLUSCO', 1);
INSERT INTO `distrito` VALUES (739, 73, 'QUIÑOTA', 1);
INSERT INTO `distrito` VALUES (740, 73, 'VELILLE', 1);
INSERT INTO `distrito` VALUES (741, 74, 'ESPINAR', 1);
INSERT INTO `distrito` VALUES (742, 74, 'CONDOROMA', 1);
INSERT INTO `distrito` VALUES (743, 74, 'COPORAQUE', 1);
INSERT INTO `distrito` VALUES (744, 74, 'OCORURO', 1);
INSERT INTO `distrito` VALUES (745, 74, 'PALLPATA', 1);
INSERT INTO `distrito` VALUES (746, 74, 'PICHIGUA', 1);
INSERT INTO `distrito` VALUES (747, 74, 'SUYCKUTAMBO', 1);
INSERT INTO `distrito` VALUES (748, 74, 'ALTO PICHIGUA', 1);
INSERT INTO `distrito` VALUES (749, 75, 'SANTA ANA', 1);
INSERT INTO `distrito` VALUES (750, 75, 'ECHARATE', 1);
INSERT INTO `distrito` VALUES (751, 75, 'HUAYOPATA', 1);
INSERT INTO `distrito` VALUES (752, 75, 'MARANURA', 1);
INSERT INTO `distrito` VALUES (753, 75, 'OCOBAMBA', 1);
INSERT INTO `distrito` VALUES (754, 75, 'QUELLOUNO', 1);
INSERT INTO `distrito` VALUES (755, 75, 'KIMBIRI', 1);
INSERT INTO `distrito` VALUES (756, 75, 'SANTA TERESA', 1);
INSERT INTO `distrito` VALUES (757, 75, 'VILCABAMBA', 1);
INSERT INTO `distrito` VALUES (758, 75, 'PICHARI', 1);
INSERT INTO `distrito` VALUES (759, 76, 'PARURO', 1);
INSERT INTO `distrito` VALUES (760, 76, 'ACCHA', 1);
INSERT INTO `distrito` VALUES (761, 76, 'CCAPI', 1);
INSERT INTO `distrito` VALUES (762, 76, 'COLCHA', 1);
INSERT INTO `distrito` VALUES (763, 76, 'HUANOQUITE', 1);
INSERT INTO `distrito` VALUES (764, 76, 'OMACHA', 1);
INSERT INTO `distrito` VALUES (765, 76, 'PACCARITAMBO', 1);
INSERT INTO `distrito` VALUES (766, 76, 'PILLPINTO', 1);
INSERT INTO `distrito` VALUES (767, 76, 'YAURISQUE', 1);
INSERT INTO `distrito` VALUES (768, 77, 'PAUCARTAMBO', 1);
INSERT INTO `distrito` VALUES (769, 77, 'CAICAY', 1);
INSERT INTO `distrito` VALUES (770, 77, 'CHALLABAMBA', 1);
INSERT INTO `distrito` VALUES (771, 77, 'COLQUEPATA', 1);
INSERT INTO `distrito` VALUES (772, 77, 'HUANCARANI', 1);
INSERT INTO `distrito` VALUES (773, 77, 'KOSÑIPATA', 1);
INSERT INTO `distrito` VALUES (774, 78, 'URCOS', 1);
INSERT INTO `distrito` VALUES (775, 78, 'ANDAHUAYLILLAS', 1);
INSERT INTO `distrito` VALUES (776, 78, 'CAMANTI', 1);
INSERT INTO `distrito` VALUES (777, 78, 'CCARHUAYO', 1);
INSERT INTO `distrito` VALUES (778, 78, 'CCATCA', 1);
INSERT INTO `distrito` VALUES (779, 78, 'CUSIPATA', 1);
INSERT INTO `distrito` VALUES (780, 78, 'HUARO', 1);
INSERT INTO `distrito` VALUES (781, 78, 'LUCRE', 1);
INSERT INTO `distrito` VALUES (782, 78, 'MARCAPATA', 1);
INSERT INTO `distrito` VALUES (783, 78, 'OCONGATE', 1);
INSERT INTO `distrito` VALUES (784, 78, 'OROPESA', 1);
INSERT INTO `distrito` VALUES (785, 78, 'QUIQUIJANA', 1);
INSERT INTO `distrito` VALUES (786, 79, 'URUBAMBA', 1);
INSERT INTO `distrito` VALUES (787, 79, 'CHINCHERO', 1);
INSERT INTO `distrito` VALUES (788, 79, 'HUAYLLABAMBA', 1);
INSERT INTO `distrito` VALUES (789, 79, 'MACHUPICCHU', 1);
INSERT INTO `distrito` VALUES (790, 79, 'MARAS', 1);
INSERT INTO `distrito` VALUES (791, 79, 'OLLANTAYTAMBO', 1);
INSERT INTO `distrito` VALUES (792, 79, 'YUCAY', 1);
INSERT INTO `distrito` VALUES (793, 80, 'HUANCAVELICA', 1);
INSERT INTO `distrito` VALUES (794, 80, 'ACOBAMBILLA', 1);
INSERT INTO `distrito` VALUES (795, 80, 'ACORIA', 1);
INSERT INTO `distrito` VALUES (796, 80, 'CONAYCA', 1);
INSERT INTO `distrito` VALUES (797, 80, 'CUENCA', 1);
INSERT INTO `distrito` VALUES (798, 80, 'HUACHOCOLPA', 1);
INSERT INTO `distrito` VALUES (799, 80, 'HUAYLLAHUARA', 1);
INSERT INTO `distrito` VALUES (800, 80, 'IZCUCHACA', 1);
INSERT INTO `distrito` VALUES (801, 80, 'LARIA', 1);
INSERT INTO `distrito` VALUES (802, 80, 'MANTA', 1);
INSERT INTO `distrito` VALUES (803, 80, 'MARISCAL CACERES', 1);
INSERT INTO `distrito` VALUES (804, 80, 'MOYA', 1);
INSERT INTO `distrito` VALUES (805, 80, 'NUEVO OCCORO', 1);
INSERT INTO `distrito` VALUES (806, 80, 'PALCA', 1);
INSERT INTO `distrito` VALUES (807, 80, 'PILCHACA', 1);
INSERT INTO `distrito` VALUES (808, 80, 'VILCA', 1);
INSERT INTO `distrito` VALUES (809, 80, 'YAULI', 1);
INSERT INTO `distrito` VALUES (810, 80, 'ASCENSION', 1);
INSERT INTO `distrito` VALUES (811, 80, 'HUANDO', 1);
INSERT INTO `distrito` VALUES (812, 81, 'ACOBAMBA', 1);
INSERT INTO `distrito` VALUES (813, 81, 'ANDABAMBA', 1);
INSERT INTO `distrito` VALUES (814, 81, 'ANTA', 1);
INSERT INTO `distrito` VALUES (815, 81, 'CAJA', 1);
INSERT INTO `distrito` VALUES (816, 81, 'MARCAS', 1);
INSERT INTO `distrito` VALUES (817, 81, 'PAUCARA', 1);
INSERT INTO `distrito` VALUES (818, 81, 'POMACOCHA', 1);
INSERT INTO `distrito` VALUES (819, 81, 'ROSARIO', 1);
INSERT INTO `distrito` VALUES (820, 82, 'LIRCAY', 1);
INSERT INTO `distrito` VALUES (821, 82, 'ANCHONGA', 1);
INSERT INTO `distrito` VALUES (822, 82, 'CALLANMARCA', 1);
INSERT INTO `distrito` VALUES (823, 82, 'CCOCHACCASA', 1);
INSERT INTO `distrito` VALUES (824, 82, 'CHINCHO', 1);
INSERT INTO `distrito` VALUES (825, 82, 'CONGALLA', 1);
INSERT INTO `distrito` VALUES (826, 82, 'HUANCA-HUANCA', 1);
INSERT INTO `distrito` VALUES (827, 82, 'HUAYLLAY GRANDE', 1);
INSERT INTO `distrito` VALUES (828, 82, 'JULCAMARCA', 1);
INSERT INTO `distrito` VALUES (829, 82, 'SAN ANTONIO DE ANTAPARCO', 1);
INSERT INTO `distrito` VALUES (830, 82, 'SANTO TOMAS DE PATA', 1);
INSERT INTO `distrito` VALUES (831, 82, 'SECCLLA', 1);
INSERT INTO `distrito` VALUES (832, 83, 'CASTROVIRREYNA', 1);
INSERT INTO `distrito` VALUES (833, 83, 'ARMA', 1);
INSERT INTO `distrito` VALUES (834, 83, 'AURAHUA', 1);
INSERT INTO `distrito` VALUES (835, 83, 'CAPILLAS', 1);
INSERT INTO `distrito` VALUES (836, 83, 'CHUPAMARCA', 1);
INSERT INTO `distrito` VALUES (837, 83, 'COCAS', 1);
INSERT INTO `distrito` VALUES (838, 83, 'HUACHOS', 1);
INSERT INTO `distrito` VALUES (839, 83, 'HUAMATAMBO', 1);
INSERT INTO `distrito` VALUES (840, 83, 'MOLLEPAMPA', 1);
INSERT INTO `distrito` VALUES (841, 83, 'SAN JUAN', 1);
INSERT INTO `distrito` VALUES (842, 83, 'SANTA ANA', 1);
INSERT INTO `distrito` VALUES (843, 83, 'TANTARA', 1);
INSERT INTO `distrito` VALUES (844, 83, 'TICRAPO', 1);
INSERT INTO `distrito` VALUES (845, 84, 'CHURCAMPA', 1);
INSERT INTO `distrito` VALUES (846, 84, 'ANCO', 1);
INSERT INTO `distrito` VALUES (847, 84, 'CHINCHIHUASI', 1);
INSERT INTO `distrito` VALUES (848, 84, 'EL CARMEN', 1);
INSERT INTO `distrito` VALUES (849, 84, 'LA MERCED', 1);
INSERT INTO `distrito` VALUES (850, 84, 'LOCROJA', 1);
INSERT INTO `distrito` VALUES (851, 84, 'PAUCARBAMBA', 1);
INSERT INTO `distrito` VALUES (852, 84, 'SAN MIGUEL DE MAYOCC', 1);
INSERT INTO `distrito` VALUES (853, 84, 'SAN PEDRO DE CORIS', 1);
INSERT INTO `distrito` VALUES (854, 84, 'PACHAMARCA', 1);
INSERT INTO `distrito` VALUES (855, 85, 'HUAYTARA', 1);
INSERT INTO `distrito` VALUES (856, 85, 'AYAVI', 1);
INSERT INTO `distrito` VALUES (857, 85, 'CORDOVA', 1);
INSERT INTO `distrito` VALUES (858, 85, 'HUAYACUNDO ARMA', 1);
INSERT INTO `distrito` VALUES (859, 85, 'LARAMARCA', 1);
INSERT INTO `distrito` VALUES (860, 85, 'OCOYO', 1);
INSERT INTO `distrito` VALUES (861, 85, 'PILPICHACA', 1);
INSERT INTO `distrito` VALUES (862, 85, 'QUERCO', 1);
INSERT INTO `distrito` VALUES (863, 85, 'QUITO-ARMA', 1);
INSERT INTO `distrito` VALUES (864, 85, 'SAN ANTONIO DE CUSICANCHA', 1);
INSERT INTO `distrito` VALUES (865, 85, 'SAN FRANCISCO DE SANGAYAICO', 1);
INSERT INTO `distrito` VALUES (866, 85, 'SAN ISIDRO', 1);
INSERT INTO `distrito` VALUES (867, 85, 'SANTIAGO DE CHOCORVOS', 1);
INSERT INTO `distrito` VALUES (868, 85, 'SANTIAGO DE QUIRAHUARA', 1);
INSERT INTO `distrito` VALUES (869, 85, 'SANTO DOMINGO DE CAPILLAS', 1);
INSERT INTO `distrito` VALUES (870, 85, 'TAMBO', 1);
INSERT INTO `distrito` VALUES (871, 86, 'PAMPAS', 1);
INSERT INTO `distrito` VALUES (872, 86, 'ACOSTAMBO', 1);
INSERT INTO `distrito` VALUES (873, 86, 'ACRAQUIA', 1);
INSERT INTO `distrito` VALUES (874, 86, 'AHUAYCHA', 1);
INSERT INTO `distrito` VALUES (875, 86, 'COLCABAMBA', 1);
INSERT INTO `distrito` VALUES (876, 86, 'DANIEL HERNANDEZ', 1);
INSERT INTO `distrito` VALUES (877, 86, 'HUACHOCOLPA', 1);
INSERT INTO `distrito` VALUES (878, 86, 'HUARIBAMBA', 1);
INSERT INTO `distrito` VALUES (879, 86, 'ÑAHUIMPUQUIO', 1);
INSERT INTO `distrito` VALUES (880, 86, 'PAZOS', 1);
INSERT INTO `distrito` VALUES (881, 86, 'QUISHUAR', 1);
INSERT INTO `distrito` VALUES (882, 86, 'SALCABAMBA', 1);
INSERT INTO `distrito` VALUES (883, 86, 'SALCAHUASI', 1);
INSERT INTO `distrito` VALUES (884, 86, 'SAN MARCOS DE ROCCHAC', 1);
INSERT INTO `distrito` VALUES (885, 86, 'SURCUBAMBA', 1);
INSERT INTO `distrito` VALUES (886, 86, 'TINTAY PUNCU', 1);
INSERT INTO `distrito` VALUES (887, 87, 'HUANUCO', 1);
INSERT INTO `distrito` VALUES (888, 87, 'AMARILIS', 1);
INSERT INTO `distrito` VALUES (889, 87, 'CHINCHAO', 1);
INSERT INTO `distrito` VALUES (890, 87, 'CHURUBAMBA', 1);
INSERT INTO `distrito` VALUES (891, 87, 'MARGOS', 1);
INSERT INTO `distrito` VALUES (892, 87, 'QUISQUI', 1);
INSERT INTO `distrito` VALUES (893, 87, 'SAN FRANCISCO DE CAYRAN', 1);
INSERT INTO `distrito` VALUES (894, 87, 'SAN PEDRO DE CHAULAN', 1);
INSERT INTO `distrito` VALUES (895, 87, 'SANTA MARIA DEL VALLE', 1);
INSERT INTO `distrito` VALUES (896, 87, 'YARUMAYO', 1);
INSERT INTO `distrito` VALUES (897, 87, 'PILLCO MARCA', 1);
INSERT INTO `distrito` VALUES (898, 88, 'AMBO', 1);
INSERT INTO `distrito` VALUES (899, 88, 'CAYNA', 1);
INSERT INTO `distrito` VALUES (900, 88, 'COLPAS', 1);
INSERT INTO `distrito` VALUES (901, 88, 'CONCHAMARCA', 1);
INSERT INTO `distrito` VALUES (902, 88, 'HUACAR', 1);
INSERT INTO `distrito` VALUES (903, 88, 'SAN FRANCISCO', 1);
INSERT INTO `distrito` VALUES (904, 88, 'SAN RAFAEL', 1);
INSERT INTO `distrito` VALUES (905, 88, 'TOMAY KICHWA', 1);
INSERT INTO `distrito` VALUES (906, 89, 'LA UNION', 1);
INSERT INTO `distrito` VALUES (907, 89, 'CHUQUIS', 1);
INSERT INTO `distrito` VALUES (908, 89, 'MARIAS', 1);
INSERT INTO `distrito` VALUES (909, 89, 'PACHAS', 1);
INSERT INTO `distrito` VALUES (910, 89, 'QUIVILLA', 1);
INSERT INTO `distrito` VALUES (911, 89, 'RIPAN', 1);
INSERT INTO `distrito` VALUES (912, 89, 'SHUNQUI', 1);
INSERT INTO `distrito` VALUES (913, 89, 'SILLAPATA', 1);
INSERT INTO `distrito` VALUES (914, 89, 'YANAS', 1);
INSERT INTO `distrito` VALUES (915, 90, 'HUACAYBAMBA', 1);
INSERT INTO `distrito` VALUES (916, 90, 'CANCHABAMBA', 1);
INSERT INTO `distrito` VALUES (917, 90, 'COCHABAMBA', 1);
INSERT INTO `distrito` VALUES (918, 90, 'PINRA', 1);
INSERT INTO `distrito` VALUES (919, 91, 'LLATA', 1);
INSERT INTO `distrito` VALUES (920, 91, 'ARANCAY', 1);
INSERT INTO `distrito` VALUES (921, 91, 'CHAVIN DE PARIARCA', 1);
INSERT INTO `distrito` VALUES (922, 91, 'JACAS GRANDE', 1);
INSERT INTO `distrito` VALUES (923, 91, 'JIRCAN', 1);
INSERT INTO `distrito` VALUES (924, 91, 'MIRAFLORES', 1);
INSERT INTO `distrito` VALUES (925, 91, 'MONZON', 1);
INSERT INTO `distrito` VALUES (926, 91, 'PUNCHAO', 1);
INSERT INTO `distrito` VALUES (927, 91, 'PUÑOS', 1);
INSERT INTO `distrito` VALUES (928, 91, 'SINGA', 1);
INSERT INTO `distrito` VALUES (929, 91, 'TANTAMAYO', 1);
INSERT INTO `distrito` VALUES (930, 92, 'RUPA-RUPA', 1);
INSERT INTO `distrito` VALUES (931, 92, 'DANIEL ALOMIA ROBLES', 1);
INSERT INTO `distrito` VALUES (932, 92, 'HERMILIO VALDIZAN', 1);
INSERT INTO `distrito` VALUES (933, 92, 'JOSE CRESPO Y CASTILLO', 1);
INSERT INTO `distrito` VALUES (934, 92, 'LUYANDO', 1);
INSERT INTO `distrito` VALUES (935, 92, 'MARIANO DAMASO BERAUN', 1);
INSERT INTO `distrito` VALUES (936, 93, 'HUACRACHUCO', 1);
INSERT INTO `distrito` VALUES (937, 93, 'CHOLON', 1);
INSERT INTO `distrito` VALUES (938, 93, 'SAN BUENAVENTURA', 1);
INSERT INTO `distrito` VALUES (939, 94, 'PANAO', 1);
INSERT INTO `distrito` VALUES (940, 94, 'CHAGLLA', 1);
INSERT INTO `distrito` VALUES (941, 94, 'MOLINO', 1);
INSERT INTO `distrito` VALUES (942, 94, 'UMARI', 1);
INSERT INTO `distrito` VALUES (943, 95, 'PUERTO INCA', 1);
INSERT INTO `distrito` VALUES (944, 95, 'CODO DEL POZUZO', 1);
INSERT INTO `distrito` VALUES (945, 95, 'HONORIA', 1);
INSERT INTO `distrito` VALUES (946, 95, 'TOURNAVISTA', 1);
INSERT INTO `distrito` VALUES (947, 95, 'YUYAPICHIS', 1);
INSERT INTO `distrito` VALUES (948, 96, 'JESUS', 1);
INSERT INTO `distrito` VALUES (949, 96, 'BAÑOS', 1);
INSERT INTO `distrito` VALUES (950, 96, 'JIVIA', 1);
INSERT INTO `distrito` VALUES (951, 96, 'QUEROPALCA', 1);
INSERT INTO `distrito` VALUES (952, 96, 'RONDOS', 1);
INSERT INTO `distrito` VALUES (953, 96, 'SAN FRANCISCO DE ASIS', 1);
INSERT INTO `distrito` VALUES (954, 96, 'SAN MIGUEL DE CAURI', 1);
INSERT INTO `distrito` VALUES (955, 97, 'CHAVINILLO', 1);
INSERT INTO `distrito` VALUES (956, 97, 'CAHUAC', 1);
INSERT INTO `distrito` VALUES (957, 97, 'CHACABAMBA', 1);
INSERT INTO `distrito` VALUES (958, 97, 'APARICIO POMARES', 1);
INSERT INTO `distrito` VALUES (959, 97, 'JACAS CHICO', 1);
INSERT INTO `distrito` VALUES (960, 97, 'OBAS', 1);
INSERT INTO `distrito` VALUES (961, 97, 'PAMPAMARCA', 1);
INSERT INTO `distrito` VALUES (962, 97, 'CHORAS', 1);
INSERT INTO `distrito` VALUES (963, 98, 'ICA', 1);
INSERT INTO `distrito` VALUES (964, 98, 'LA TINGUIÑA', 1);
INSERT INTO `distrito` VALUES (965, 98, 'LOS AQUIJES', 1);
INSERT INTO `distrito` VALUES (966, 98, 'OCUCAJE', 1);
INSERT INTO `distrito` VALUES (967, 98, 'PACHACUTEC', 1);
INSERT INTO `distrito` VALUES (968, 98, 'PARCONA', 1);
INSERT INTO `distrito` VALUES (969, 98, 'PUEBLO NUEVO', 1);
INSERT INTO `distrito` VALUES (970, 98, 'SALAS', 1);
INSERT INTO `distrito` VALUES (971, 98, 'SAN JOSE DE LOS MOLINOS', 1);
INSERT INTO `distrito` VALUES (972, 98, 'SAN JUAN BAUTISTA', 1);
INSERT INTO `distrito` VALUES (973, 98, 'SANTIAGO', 1);
INSERT INTO `distrito` VALUES (974, 98, 'SUBTANJALLA', 1);
INSERT INTO `distrito` VALUES (975, 98, 'TATE', 1);
INSERT INTO `distrito` VALUES (976, 98, 'YAUCA DEL ROSARIO', 1);
INSERT INTO `distrito` VALUES (977, 99, 'CHINCHA ALTA', 1);
INSERT INTO `distrito` VALUES (978, 99, 'ALTO LARAN', 1);
INSERT INTO `distrito` VALUES (979, 99, 'CHAVIN', 1);
INSERT INTO `distrito` VALUES (980, 99, 'CHINCHA BAJA', 1);
INSERT INTO `distrito` VALUES (981, 99, 'EL CARMEN', 1);
INSERT INTO `distrito` VALUES (982, 99, 'GROCIO PRADO', 1);
INSERT INTO `distrito` VALUES (983, 99, 'PUEBLO NUEVO', 1);
INSERT INTO `distrito` VALUES (984, 99, 'SAN JUAN DE YANAC', 1);
INSERT INTO `distrito` VALUES (985, 99, 'SAN PEDRO DE HUACARPANA', 1);
INSERT INTO `distrito` VALUES (986, 99, 'SUNAMPE', 1);
INSERT INTO `distrito` VALUES (987, 99, 'TAMBO DE MORA', 1);
INSERT INTO `distrito` VALUES (988, 100, 'NAZCA', 1);
INSERT INTO `distrito` VALUES (989, 100, 'CHANGUILLO', 1);
INSERT INTO `distrito` VALUES (990, 100, 'EL INGENIO', 1);
INSERT INTO `distrito` VALUES (991, 100, 'MARCONA', 1);
INSERT INTO `distrito` VALUES (992, 100, 'VISTA ALEGRE', 1);
INSERT INTO `distrito` VALUES (993, 101, 'PALPA', 1);
INSERT INTO `distrito` VALUES (994, 101, 'LLIPATA', 1);
INSERT INTO `distrito` VALUES (995, 101, 'RIO GRANDE', 1);
INSERT INTO `distrito` VALUES (996, 101, 'SANTA CRUZ', 1);
INSERT INTO `distrito` VALUES (997, 101, 'TIBILLO', 1);
INSERT INTO `distrito` VALUES (998, 102, 'PISCO', 1);
INSERT INTO `distrito` VALUES (999, 102, 'HUANCANO', 1);
INSERT INTO `distrito` VALUES (1000, 102, 'HUMAY', 1);
INSERT INTO `distrito` VALUES (1001, 102, 'INDEPENDENCIA', 1);
INSERT INTO `distrito` VALUES (1002, 102, 'PARACAS', 1);
INSERT INTO `distrito` VALUES (1003, 102, 'SAN ANDRES', 1);
INSERT INTO `distrito` VALUES (1004, 102, 'SAN CLEMENTE', 1);
INSERT INTO `distrito` VALUES (1005, 102, 'TUPAC AMARU INCA', 1);
INSERT INTO `distrito` VALUES (1006, 103, 'HUANCAYO', 1);
INSERT INTO `distrito` VALUES (1007, 103, 'CARHUACALLANGA', 1);
INSERT INTO `distrito` VALUES (1008, 103, 'CHACAPAMPA', 1);
INSERT INTO `distrito` VALUES (1009, 103, 'CHICCHE', 1);
INSERT INTO `distrito` VALUES (1010, 103, 'CHILCA', 1);
INSERT INTO `distrito` VALUES (1011, 103, 'CHONGOS ALTO', 1);
INSERT INTO `distrito` VALUES (1012, 103, 'CHUPURO', 1);
INSERT INTO `distrito` VALUES (1013, 103, 'COLCA', 1);
INSERT INTO `distrito` VALUES (1014, 103, 'CULLHUAS', 1);
INSERT INTO `distrito` VALUES (1015, 103, 'EL TAMBO', 1);
INSERT INTO `distrito` VALUES (1016, 103, 'HUACRAPUQUIO', 1);
INSERT INTO `distrito` VALUES (1017, 103, 'HUALHUAS', 1);
INSERT INTO `distrito` VALUES (1018, 103, 'HUANCAN', 1);
INSERT INTO `distrito` VALUES (1019, 103, 'HUASICANCHA', 1);
INSERT INTO `distrito` VALUES (1020, 103, 'HUAYUCACHI', 1);
INSERT INTO `distrito` VALUES (1021, 103, 'INGENIO', 1);
INSERT INTO `distrito` VALUES (1022, 103, 'PARIAHUANCA', 1);
INSERT INTO `distrito` VALUES (1023, 103, 'PILCOMAYO', 1);
INSERT INTO `distrito` VALUES (1024, 103, 'PUCARA', 1);
INSERT INTO `distrito` VALUES (1025, 103, 'QUICHUAY', 1);
INSERT INTO `distrito` VALUES (1026, 103, 'QUILCAS', 1);
INSERT INTO `distrito` VALUES (1027, 103, 'SAN AGUSTIN', 1);
INSERT INTO `distrito` VALUES (1028, 103, 'SAN JERONIMO DE TUNAN', 1);
INSERT INTO `distrito` VALUES (1029, 103, 'SAÑO', 1);
INSERT INTO `distrito` VALUES (1030, 103, 'SAPALLANGA', 1);
INSERT INTO `distrito` VALUES (1031, 103, 'SICAYA', 1);
INSERT INTO `distrito` VALUES (1032, 103, 'SANTO DOMINGO DE ACOBAMBA', 1);
INSERT INTO `distrito` VALUES (1033, 103, 'VIQUES', 1);
INSERT INTO `distrito` VALUES (1034, 104, 'CONCEPCION', 1);
INSERT INTO `distrito` VALUES (1035, 104, 'ACO', 1);
INSERT INTO `distrito` VALUES (1036, 104, 'ANDAMARCA', 1);
INSERT INTO `distrito` VALUES (1037, 104, 'CHAMBARA', 1);
INSERT INTO `distrito` VALUES (1038, 104, 'COCHAS', 1);
INSERT INTO `distrito` VALUES (1039, 104, 'COMAS', 1);
INSERT INTO `distrito` VALUES (1040, 104, 'HEROINAS TOLEDO', 1);
INSERT INTO `distrito` VALUES (1041, 104, 'MANZANARES', 1);
INSERT INTO `distrito` VALUES (1042, 104, 'MARISCAL CASTILLA', 1);
INSERT INTO `distrito` VALUES (1043, 104, 'MATAHUASI', 1);
INSERT INTO `distrito` VALUES (1044, 104, 'MITO', 1);
INSERT INTO `distrito` VALUES (1045, 104, 'NUEVE DE JULIO', 1);
INSERT INTO `distrito` VALUES (1046, 104, 'ORCOTUNA', 1);
INSERT INTO `distrito` VALUES (1047, 104, 'SAN JOSE DE QUERO', 1);
INSERT INTO `distrito` VALUES (1048, 104, 'SANTA ROSA DE OCOPA', 1);
INSERT INTO `distrito` VALUES (1049, 105, 'CHANCHAMAYO', 1);
INSERT INTO `distrito` VALUES (1050, 105, 'PERENE', 1);
INSERT INTO `distrito` VALUES (1051, 105, 'PICHANAQUI', 1);
INSERT INTO `distrito` VALUES (1052, 105, 'SAN LUIS DE SHUARO', 1);
INSERT INTO `distrito` VALUES (1053, 105, 'SAN RAMON', 1);
INSERT INTO `distrito` VALUES (1054, 105, 'VITOC', 1);
INSERT INTO `distrito` VALUES (1055, 106, 'JAUJA', 1);
INSERT INTO `distrito` VALUES (1056, 106, 'ACOLLA', 1);
INSERT INTO `distrito` VALUES (1057, 106, 'APATA', 1);
INSERT INTO `distrito` VALUES (1058, 106, 'ATAURA', 1);
INSERT INTO `distrito` VALUES (1059, 106, 'CANCHAYLLO', 1);
INSERT INTO `distrito` VALUES (1060, 106, 'CURICACA', 1);
INSERT INTO `distrito` VALUES (1061, 106, 'EL MANTARO', 1);
INSERT INTO `distrito` VALUES (1062, 106, 'HUAMALI', 1);
INSERT INTO `distrito` VALUES (1063, 106, 'HUARIPAMPA', 1);
INSERT INTO `distrito` VALUES (1064, 106, 'HUERTAS', 1);
INSERT INTO `distrito` VALUES (1065, 106, 'JANJAILLO', 1);
INSERT INTO `distrito` VALUES (1066, 106, 'JULCAN', 1);
INSERT INTO `distrito` VALUES (1067, 106, 'LEONOR ORDOÑEZ', 1);
INSERT INTO `distrito` VALUES (1068, 106, 'LLOCLLAPAMPA', 1);
INSERT INTO `distrito` VALUES (1069, 106, 'MARCO', 1);
INSERT INTO `distrito` VALUES (1070, 106, 'MASMA', 1);
INSERT INTO `distrito` VALUES (1071, 106, 'MASMA CHICCHE', 1);
INSERT INTO `distrito` VALUES (1072, 106, 'MOLINOS', 1);
INSERT INTO `distrito` VALUES (1073, 106, 'MONOBAMBA', 1);
INSERT INTO `distrito` VALUES (1074, 106, 'MUQUI', 1);
INSERT INTO `distrito` VALUES (1075, 106, 'MUQUIYAUYO', 1);
INSERT INTO `distrito` VALUES (1076, 106, 'PACA', 1);
INSERT INTO `distrito` VALUES (1077, 106, 'PACCHA', 1);
INSERT INTO `distrito` VALUES (1078, 106, 'PANCAN', 1);
INSERT INTO `distrito` VALUES (1079, 106, 'PARCO', 1);
INSERT INTO `distrito` VALUES (1080, 106, 'POMACANCHA', 1);
INSERT INTO `distrito` VALUES (1081, 106, 'RICRAN', 1);
INSERT INTO `distrito` VALUES (1082, 106, 'SAN LORENZO', 1);
INSERT INTO `distrito` VALUES (1083, 106, 'SAN PEDRO DE CHUNAN', 1);
INSERT INTO `distrito` VALUES (1084, 106, 'SAUSA', 1);
INSERT INTO `distrito` VALUES (1085, 106, 'SINCOS', 1);
INSERT INTO `distrito` VALUES (1086, 106, 'TUNAN MARCA', 1);
INSERT INTO `distrito` VALUES (1087, 106, 'YAULI', 1);
INSERT INTO `distrito` VALUES (1088, 106, 'YAUYOS', 1);
INSERT INTO `distrito` VALUES (1089, 107, 'JUNIN', 1);
INSERT INTO `distrito` VALUES (1090, 107, 'CARHUAMAYO', 1);
INSERT INTO `distrito` VALUES (1091, 107, 'ONDORES', 1);
INSERT INTO `distrito` VALUES (1092, 107, 'ULCUMAYO', 1);
INSERT INTO `distrito` VALUES (1093, 108, 'SATIPO', 1);
INSERT INTO `distrito` VALUES (1094, 108, 'COVIRIALI', 1);
INSERT INTO `distrito` VALUES (1095, 108, 'LLAYLLA', 1);
INSERT INTO `distrito` VALUES (1096, 108, 'MAZAMARI', 1);
INSERT INTO `distrito` VALUES (1097, 108, 'PAMPA HERMOSA', 1);
INSERT INTO `distrito` VALUES (1098, 108, 'PANGOA', 1);
INSERT INTO `distrito` VALUES (1099, 108, 'RIO NEGRO', 1);
INSERT INTO `distrito` VALUES (1100, 108, 'RIO TAMBO', 1);
INSERT INTO `distrito` VALUES (1101, 109, 'TARMA', 1);
INSERT INTO `distrito` VALUES (1102, 109, 'ACOBAMBA', 1);
INSERT INTO `distrito` VALUES (1103, 109, 'HUARICOLCA', 1);
INSERT INTO `distrito` VALUES (1104, 109, 'HUASAHUASI', 1);
INSERT INTO `distrito` VALUES (1105, 109, 'LA UNION', 1);
INSERT INTO `distrito` VALUES (1106, 109, 'PALCA', 1);
INSERT INTO `distrito` VALUES (1107, 109, 'PALCAMAYO', 1);
INSERT INTO `distrito` VALUES (1108, 109, 'SAN PEDRO DE CAJAS', 1);
INSERT INTO `distrito` VALUES (1109, 109, 'TAPO', 1);
INSERT INTO `distrito` VALUES (1110, 110, 'LA OROYA', 1);
INSERT INTO `distrito` VALUES (1111, 110, 'CHACAPALPA', 1);
INSERT INTO `distrito` VALUES (1112, 110, 'HUAY-HUAY', 1);
INSERT INTO `distrito` VALUES (1113, 110, 'MARCAPOMACOCHA', 1);
INSERT INTO `distrito` VALUES (1114, 110, 'MOROCOCHA', 1);
INSERT INTO `distrito` VALUES (1115, 110, 'PACCHA', 1);
INSERT INTO `distrito` VALUES (1116, 110, 'SANTA BARBARA DE CARHUACAYAN', 1);
INSERT INTO `distrito` VALUES (1117, 110, 'SANTA ROSA DE SACCO', 1);
INSERT INTO `distrito` VALUES (1118, 110, 'SUITUCANCHA', 1);
INSERT INTO `distrito` VALUES (1119, 110, 'YAULI', 1);
INSERT INTO `distrito` VALUES (1120, 111, 'CHUPACA', 1);
INSERT INTO `distrito` VALUES (1121, 111, 'AHUAC', 1);
INSERT INTO `distrito` VALUES (1122, 111, 'CHONGOS BAJO', 1);
INSERT INTO `distrito` VALUES (1123, 111, 'HUACHAC', 1);
INSERT INTO `distrito` VALUES (1124, 111, 'HUAMANCACA CHICO', 1);
INSERT INTO `distrito` VALUES (1125, 111, 'SAN JUAN DE ISCOS', 1);
INSERT INTO `distrito` VALUES (1126, 111, 'SAN JUAN DE JARPA', 1);
INSERT INTO `distrito` VALUES (1127, 111, 'TRES DE DICIEMBRE', 1);
INSERT INTO `distrito` VALUES (1128, 111, 'YANACANCHA', 1);
INSERT INTO `distrito` VALUES (1129, 112, 'TRUJILLO', 1);
INSERT INTO `distrito` VALUES (1130, 112, 'EL PORVENIR', 1);
INSERT INTO `distrito` VALUES (1131, 112, 'FLORENCIA DE MORA', 1);
INSERT INTO `distrito` VALUES (1132, 112, 'HUANCHACO', 1);
INSERT INTO `distrito` VALUES (1133, 112, 'LA ESPERANZA', 1);
INSERT INTO `distrito` VALUES (1134, 112, 'LAREDO', 1);
INSERT INTO `distrito` VALUES (1135, 112, 'MOCHE', 1);
INSERT INTO `distrito` VALUES (1136, 112, 'POROTO', 1);
INSERT INTO `distrito` VALUES (1137, 112, 'SALAVERRY', 1);
INSERT INTO `distrito` VALUES (1138, 112, 'SIMBAL', 1);
INSERT INTO `distrito` VALUES (1139, 112, 'VICTOR LARCO HERRERA', 1);
INSERT INTO `distrito` VALUES (1140, 113, 'ASCOPE', 1);
INSERT INTO `distrito` VALUES (1141, 113, 'CHICAMA', 1);
INSERT INTO `distrito` VALUES (1142, 113, 'CHOCOPE', 1);
INSERT INTO `distrito` VALUES (1143, 113, 'MAGDALENA DE CAO', 1);
INSERT INTO `distrito` VALUES (1144, 113, 'PAIJAN', 1);
INSERT INTO `distrito` VALUES (1145, 113, 'RAZURI', 1);
INSERT INTO `distrito` VALUES (1146, 113, 'SANTIAGO DE CAO', 1);
INSERT INTO `distrito` VALUES (1147, 113, 'CASA GRANDE', 1);
INSERT INTO `distrito` VALUES (1148, 114, 'BOLIVAR', 1);
INSERT INTO `distrito` VALUES (1149, 114, 'BAMBAMARCA', 1);
INSERT INTO `distrito` VALUES (1150, 114, 'CONDORMARCA', 1);
INSERT INTO `distrito` VALUES (1151, 114, 'LONGOTEA', 1);
INSERT INTO `distrito` VALUES (1152, 114, 'UCHUMARCA', 1);
INSERT INTO `distrito` VALUES (1153, 114, 'UCUNCHA', 1);
INSERT INTO `distrito` VALUES (1154, 115, 'CHEPEN', 1);
INSERT INTO `distrito` VALUES (1155, 115, 'PACANGA', 1);
INSERT INTO `distrito` VALUES (1156, 115, 'PUEBLO NUEVO', 1);
INSERT INTO `distrito` VALUES (1157, 116, 'JULCAN', 1);
INSERT INTO `distrito` VALUES (1158, 116, 'CALAMARCA', 1);
INSERT INTO `distrito` VALUES (1159, 116, 'CARABAMBA', 1);
INSERT INTO `distrito` VALUES (1160, 116, 'HUASO', 1);
INSERT INTO `distrito` VALUES (1161, 117, 'OTUZCO', 1);
INSERT INTO `distrito` VALUES (1162, 117, 'AGALLPAMPA', 1);
INSERT INTO `distrito` VALUES (1163, 117, 'CHARAT', 1);
INSERT INTO `distrito` VALUES (1164, 117, 'HUARANCHAL', 1);
INSERT INTO `distrito` VALUES (1165, 117, 'LA CUESTA', 1);
INSERT INTO `distrito` VALUES (1166, 117, 'MACHE', 1);
INSERT INTO `distrito` VALUES (1167, 117, 'PARANDAY', 1);
INSERT INTO `distrito` VALUES (1168, 117, 'SALPO', 1);
INSERT INTO `distrito` VALUES (1169, 117, 'SINSICAP', 1);
INSERT INTO `distrito` VALUES (1170, 117, 'USQUIL', 1);
INSERT INTO `distrito` VALUES (1171, 118, 'SAN PEDRO DE LLOC', 1);
INSERT INTO `distrito` VALUES (1172, 118, 'GUADALUPE', 1);
INSERT INTO `distrito` VALUES (1173, 118, 'JEQUETEPEQUE', 1);
INSERT INTO `distrito` VALUES (1174, 118, 'PACASMAYO', 1);
INSERT INTO `distrito` VALUES (1175, 118, 'SAN JOSE', 1);
INSERT INTO `distrito` VALUES (1176, 119, 'TAYABAMBA', 1);
INSERT INTO `distrito` VALUES (1177, 119, 'BULDIBUYO', 1);
INSERT INTO `distrito` VALUES (1178, 119, 'CHILLIA', 1);
INSERT INTO `distrito` VALUES (1179, 119, 'HUANCASPATA', 1);
INSERT INTO `distrito` VALUES (1180, 119, 'HUAYLILLAS', 1);
INSERT INTO `distrito` VALUES (1181, 119, 'HUAYO', 1);
INSERT INTO `distrito` VALUES (1182, 119, 'ONGON', 1);
INSERT INTO `distrito` VALUES (1183, 119, 'PARCOY', 1);
INSERT INTO `distrito` VALUES (1184, 119, 'PATAZ', 1);
INSERT INTO `distrito` VALUES (1185, 119, 'PIAS', 1);
INSERT INTO `distrito` VALUES (1186, 119, 'SANTIAGO DE CHALLAS', 1);
INSERT INTO `distrito` VALUES (1187, 119, 'TAURIJA', 1);
INSERT INTO `distrito` VALUES (1188, 119, 'URPAY', 1);
INSERT INTO `distrito` VALUES (1189, 120, 'HUAMACHUCO', 1);
INSERT INTO `distrito` VALUES (1190, 120, 'CHUGAY', 1);
INSERT INTO `distrito` VALUES (1191, 120, 'COCHORCO', 1);
INSERT INTO `distrito` VALUES (1192, 120, 'CURGOS', 1);
INSERT INTO `distrito` VALUES (1193, 120, 'MARCABAL', 1);
INSERT INTO `distrito` VALUES (1194, 120, 'SANAGORAN', 1);
INSERT INTO `distrito` VALUES (1195, 120, 'SARIN', 1);
INSERT INTO `distrito` VALUES (1196, 120, 'SARTIMBAMBA', 1);
INSERT INTO `distrito` VALUES (1197, 121, 'SANTIAGO DE CHUCO', 1);
INSERT INTO `distrito` VALUES (1198, 121, 'ANGASMARCA', 1);
INSERT INTO `distrito` VALUES (1199, 121, 'CACHICADAN', 1);
INSERT INTO `distrito` VALUES (1200, 121, 'MOLLEBAMBA', 1);
INSERT INTO `distrito` VALUES (1201, 121, 'MOLLEPATA', 1);
INSERT INTO `distrito` VALUES (1202, 121, 'QUIRUVILCA', 1);
INSERT INTO `distrito` VALUES (1203, 121, 'SANTA CRUZ DE CHUCA', 1);
INSERT INTO `distrito` VALUES (1204, 121, 'SITABAMBA', 1);
INSERT INTO `distrito` VALUES (1205, 122, 'GRAN CHIMU', 1);
INSERT INTO `distrito` VALUES (1206, 122, 'CASCAS', 1);
INSERT INTO `distrito` VALUES (1207, 122, 'LUCMA', 1);
INSERT INTO `distrito` VALUES (1208, 122, 'MARMOT', 1);
INSERT INTO `distrito` VALUES (1209, 122, 'SAYAPULLO', 1);
INSERT INTO `distrito` VALUES (1210, 123, 'VIRU', 1);
INSERT INTO `distrito` VALUES (1211, 123, 'CHAO', 1);
INSERT INTO `distrito` VALUES (1212, 123, 'GUADALUPITO', 1);
INSERT INTO `distrito` VALUES (1213, 124, 'CHICLAYO', 1);
INSERT INTO `distrito` VALUES (1214, 124, 'CHONGOYAPE', 1);
INSERT INTO `distrito` VALUES (1215, 124, 'ETEN', 1);
INSERT INTO `distrito` VALUES (1216, 124, 'ETEN PUERTO', 1);
INSERT INTO `distrito` VALUES (1217, 124, 'JOSE LEONARDO ORTIZ', 1);
INSERT INTO `distrito` VALUES (1218, 124, 'LA VICTORIA', 1);
INSERT INTO `distrito` VALUES (1219, 124, 'LAGUNAS', 1);
INSERT INTO `distrito` VALUES (1220, 124, 'MONSEFU', 1);
INSERT INTO `distrito` VALUES (1221, 124, 'NUEVA ARICA', 1);
INSERT INTO `distrito` VALUES (1222, 124, 'OYOTUN', 1);
INSERT INTO `distrito` VALUES (1223, 124, 'PICSI', 1);
INSERT INTO `distrito` VALUES (1224, 124, 'PIMENTEL', 1);
INSERT INTO `distrito` VALUES (1225, 124, 'REQUE', 1);
INSERT INTO `distrito` VALUES (1226, 124, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (1227, 124, 'SAÑA', 1);
INSERT INTO `distrito` VALUES (1228, 124, 'CAYALTI', 1);
INSERT INTO `distrito` VALUES (1229, 124, 'PATAPO', 1);
INSERT INTO `distrito` VALUES (1230, 124, 'POMALCA', 1);
INSERT INTO `distrito` VALUES (1231, 124, 'PUCALA', 1);
INSERT INTO `distrito` VALUES (1232, 124, 'TUMAN', 1);
INSERT INTO `distrito` VALUES (1233, 125, 'FERREÑAFE', 1);
INSERT INTO `distrito` VALUES (1234, 125, 'CAÑARIS', 1);
INSERT INTO `distrito` VALUES (1235, 125, 'INCAHUASI', 1);
INSERT INTO `distrito` VALUES (1236, 125, 'MANUEL ANTONIO MESONES MURO', 1);
INSERT INTO `distrito` VALUES (1237, 125, 'PITIPO', 1);
INSERT INTO `distrito` VALUES (1238, 125, 'PUEBLO NUEVO', 1);
INSERT INTO `distrito` VALUES (1239, 126, 'LAMBAYEQUE', 1);
INSERT INTO `distrito` VALUES (1240, 126, 'CHOCHOPE', 1);
INSERT INTO `distrito` VALUES (1241, 126, 'ILLIMO', 1);
INSERT INTO `distrito` VALUES (1242, 126, 'JAYANCA', 1);
INSERT INTO `distrito` VALUES (1243, 126, 'MOCHUMI', 1);
INSERT INTO `distrito` VALUES (1244, 126, 'MORROPE', 1);
INSERT INTO `distrito` VALUES (1245, 126, 'MOTUPE', 1);
INSERT INTO `distrito` VALUES (1246, 126, 'OLMOS', 1);
INSERT INTO `distrito` VALUES (1247, 126, 'PACORA', 1);
INSERT INTO `distrito` VALUES (1248, 126, 'SALAS', 1);
INSERT INTO `distrito` VALUES (1249, 126, 'SAN JOSE', 1);
INSERT INTO `distrito` VALUES (1250, 126, 'TUCUME', 1);
INSERT INTO `distrito` VALUES (1251, 127, 'LIMA', 1);
INSERT INTO `distrito` VALUES (1252, 127, 'ANCON', 1);
INSERT INTO `distrito` VALUES (1253, 127, 'ATE', 1);
INSERT INTO `distrito` VALUES (1254, 127, 'BARRANCO', 1);
INSERT INTO `distrito` VALUES (1255, 127, 'BREÑA', 1);
INSERT INTO `distrito` VALUES (1256, 127, 'CARABAYLLO', 1);
INSERT INTO `distrito` VALUES (1257, 127, 'CHACLACAYO', 1);
INSERT INTO `distrito` VALUES (1258, 127, 'CHORRILLOS', 1);
INSERT INTO `distrito` VALUES (1259, 127, 'CIENEGUILLA', 1);
INSERT INTO `distrito` VALUES (1260, 127, 'COMAS', 1);
INSERT INTO `distrito` VALUES (1261, 127, 'EL AGUSTINO', 1);
INSERT INTO `distrito` VALUES (1262, 127, 'INDEPENDENCIA', 1);
INSERT INTO `distrito` VALUES (1263, 127, 'JESUS MARIA', 1);
INSERT INTO `distrito` VALUES (1264, 127, 'LA MOLINA', 1);
INSERT INTO `distrito` VALUES (1265, 127, 'LA VICTORIA', 1);
INSERT INTO `distrito` VALUES (1266, 127, 'LINCE', 1);
INSERT INTO `distrito` VALUES (1267, 127, 'LOS OLIVOS', 1);
INSERT INTO `distrito` VALUES (1268, 127, 'LURIGANCHO', 1);
INSERT INTO `distrito` VALUES (1269, 127, 'LURIN', 1);
INSERT INTO `distrito` VALUES (1270, 127, 'MAGDALENA DEL MAR', 1);
INSERT INTO `distrito` VALUES (1271, 127, 'MAGDALENA VIEJA', 1);
INSERT INTO `distrito` VALUES (1272, 127, 'MIRAFLORES', 1);
INSERT INTO `distrito` VALUES (1273, 127, 'PACHACAMAC', 1);
INSERT INTO `distrito` VALUES (1274, 127, 'PUCUSANA', 1);
INSERT INTO `distrito` VALUES (1275, 127, 'PUENTE PIEDRA', 1);
INSERT INTO `distrito` VALUES (1276, 127, 'PUNTA HERMOSA', 1);
INSERT INTO `distrito` VALUES (1277, 127, 'PUNTA NEGRA', 1);
INSERT INTO `distrito` VALUES (1278, 127, 'RIMAC', 1);
INSERT INTO `distrito` VALUES (1279, 127, 'SAN BARTOLO', 1);
INSERT INTO `distrito` VALUES (1280, 127, 'SAN BORJA', 1);
INSERT INTO `distrito` VALUES (1281, 127, 'SAN ISIDRO', 1);
INSERT INTO `distrito` VALUES (1282, 127, 'SAN JUAN DE LURIGANCHO', 1);
INSERT INTO `distrito` VALUES (1283, 127, 'SAN JUAN DE MIRAFLORES', 1);
INSERT INTO `distrito` VALUES (1284, 127, 'SAN LUIS', 1);
INSERT INTO `distrito` VALUES (1285, 127, 'SAN MARTIN DE PORRES', 1);
INSERT INTO `distrito` VALUES (1286, 127, 'SAN MIGUEL', 1);
INSERT INTO `distrito` VALUES (1287, 127, 'SANTA ANITA', 1);
INSERT INTO `distrito` VALUES (1288, 127, 'SANTA MARIA DEL MAR', 1);
INSERT INTO `distrito` VALUES (1289, 127, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (1290, 127, 'SANTIAGO DE SURCO', 1);
INSERT INTO `distrito` VALUES (1291, 127, 'SURQUILLO', 1);
INSERT INTO `distrito` VALUES (1292, 127, 'VILLA EL SALVADOR', 1);
INSERT INTO `distrito` VALUES (1293, 127, 'VILLA MARIA DEL TRIUNFO', 1);
INSERT INTO `distrito` VALUES (1294, 128, 'BARRANCA', 1);
INSERT INTO `distrito` VALUES (1295, 128, 'PARAMONGA', 1);
INSERT INTO `distrito` VALUES (1296, 128, 'PATIVILCA', 1);
INSERT INTO `distrito` VALUES (1297, 128, 'SUPE', 1);
INSERT INTO `distrito` VALUES (1298, 128, 'SUPE PUERTO', 1);
INSERT INTO `distrito` VALUES (1299, 129, 'CAJATAMBO', 1);
INSERT INTO `distrito` VALUES (1300, 129, 'COPA', 1);
INSERT INTO `distrito` VALUES (1301, 129, 'GORGOR', 1);
INSERT INTO `distrito` VALUES (1302, 129, 'HUANCAPON', 1);
INSERT INTO `distrito` VALUES (1303, 129, 'MANAS', 1);
INSERT INTO `distrito` VALUES (1304, 130, 'CANTA', 1);
INSERT INTO `distrito` VALUES (1305, 130, 'ARAHUAY', 1);
INSERT INTO `distrito` VALUES (1306, 130, 'HUAMANTANGA', 1);
INSERT INTO `distrito` VALUES (1307, 130, 'HUAROS', 1);
INSERT INTO `distrito` VALUES (1308, 130, 'LACHAQUI', 1);
INSERT INTO `distrito` VALUES (1309, 130, 'SAN BUENAVENTURA', 1);
INSERT INTO `distrito` VALUES (1310, 130, 'SANTA ROSA DE QUIVES', 1);
INSERT INTO `distrito` VALUES (1311, 131, 'SAN VICENTE DE CAÑETE', 1);
INSERT INTO `distrito` VALUES (1312, 131, 'ASIA', 1);
INSERT INTO `distrito` VALUES (1313, 131, 'CALANGO', 1);
INSERT INTO `distrito` VALUES (1314, 131, 'CERRO AZUL', 1);
INSERT INTO `distrito` VALUES (1315, 131, 'CHILCA', 1);
INSERT INTO `distrito` VALUES (1316, 131, 'COAYLLO', 1);
INSERT INTO `distrito` VALUES (1317, 131, 'IMPERIAL', 1);
INSERT INTO `distrito` VALUES (1318, 131, 'LUNAHUANA', 1);
INSERT INTO `distrito` VALUES (1319, 131, 'MALA', 1);
INSERT INTO `distrito` VALUES (1320, 131, 'NUEVO IMPERIAL', 1);
INSERT INTO `distrito` VALUES (1321, 131, 'PACARAN', 1);
INSERT INTO `distrito` VALUES (1322, 131, 'QUILMANA', 1);
INSERT INTO `distrito` VALUES (1323, 131, 'SAN ANTONIO', 1);
INSERT INTO `distrito` VALUES (1324, 131, 'SAN LUIS', 1);
INSERT INTO `distrito` VALUES (1325, 131, 'SANTA CRUZ DE FLORES', 1);
INSERT INTO `distrito` VALUES (1326, 131, 'ZUÑIGA', 1);
INSERT INTO `distrito` VALUES (1327, 132, 'HUARAL', 1);
INSERT INTO `distrito` VALUES (1328, 132, 'ATAVILLOS ALTO', 1);
INSERT INTO `distrito` VALUES (1329, 132, 'ATAVILLOS BAJO', 1);
INSERT INTO `distrito` VALUES (1330, 132, 'AUCALLAMA', 1);
INSERT INTO `distrito` VALUES (1331, 132, 'CHANCAY', 1);
INSERT INTO `distrito` VALUES (1332, 132, 'IHUARI', 1);
INSERT INTO `distrito` VALUES (1333, 132, 'LAMPIAN', 1);
INSERT INTO `distrito` VALUES (1334, 132, 'PACARAOS', 1);
INSERT INTO `distrito` VALUES (1335, 132, 'SAN MIGUEL DE ACOS', 1);
INSERT INTO `distrito` VALUES (1336, 132, 'SANTA CRUZ DE ANDAMARCA', 1);
INSERT INTO `distrito` VALUES (1337, 132, 'SUMBILCA', 1);
INSERT INTO `distrito` VALUES (1338, 132, 'VEINTISIETE DE NOVIEMBRE', 1);
INSERT INTO `distrito` VALUES (1339, 133, 'MATUCANA', 1);
INSERT INTO `distrito` VALUES (1340, 133, 'ANTIOQUIA', 1);
INSERT INTO `distrito` VALUES (1341, 133, 'CALLAHUANCA', 1);
INSERT INTO `distrito` VALUES (1342, 133, 'CARAMPOMA', 1);
INSERT INTO `distrito` VALUES (1343, 133, 'CHICLA', 1);
INSERT INTO `distrito` VALUES (1344, 133, 'CUENCA', 1);
INSERT INTO `distrito` VALUES (1345, 133, 'HUACHUPAMPA', 1);
INSERT INTO `distrito` VALUES (1346, 133, 'HUANZA', 1);
INSERT INTO `distrito` VALUES (1347, 133, 'HUAROCHIRI', 1);
INSERT INTO `distrito` VALUES (1348, 133, 'LAHUAYTAMBO', 1);
INSERT INTO `distrito` VALUES (1349, 133, 'LANGA', 1);
INSERT INTO `distrito` VALUES (1350, 133, 'LARAOS', 1);
INSERT INTO `distrito` VALUES (1351, 133, 'MARIATANA', 1);
INSERT INTO `distrito` VALUES (1352, 133, 'RICARDO PALMA', 1);
INSERT INTO `distrito` VALUES (1353, 133, 'SAN ANDRES DE TUPICOCHA', 1);
INSERT INTO `distrito` VALUES (1354, 133, 'SAN ANTONIO', 1);
INSERT INTO `distrito` VALUES (1355, 133, 'SAN BARTOLOME', 1);
INSERT INTO `distrito` VALUES (1356, 133, 'SAN DAMIAN', 1);
INSERT INTO `distrito` VALUES (1357, 133, 'SAN JUAN DE IRIS', 1);
INSERT INTO `distrito` VALUES (1358, 133, 'SAN JUAN DE TANTARANCHE', 1);
INSERT INTO `distrito` VALUES (1359, 133, 'SAN LORENZO DE QUINTI', 1);
INSERT INTO `distrito` VALUES (1360, 133, 'SAN MATEO', 1);
INSERT INTO `distrito` VALUES (1361, 133, 'SAN MATEO DE OTAO', 1);
INSERT INTO `distrito` VALUES (1362, 133, 'SAN PEDRO DE CASTA', 1);
INSERT INTO `distrito` VALUES (1363, 133, 'SAN PEDRO DE HUANCAYRE', 1);
INSERT INTO `distrito` VALUES (1364, 133, 'SANGALLAYA', 1);
INSERT INTO `distrito` VALUES (1365, 133, 'SANTA CRUZ DE COCACHACRA', 1);
INSERT INTO `distrito` VALUES (1366, 133, 'SANTA EULALIA', 1);
INSERT INTO `distrito` VALUES (1367, 133, 'SANTIAGO DE ANCHUCAYA', 1);
INSERT INTO `distrito` VALUES (1368, 133, 'SANTIAGO DE TUNA', 1);
INSERT INTO `distrito` VALUES (1369, 133, 'SANTO DOMINGO DE LOS OLLEROS', 1);
INSERT INTO `distrito` VALUES (1370, 133, 'SURCO', 1);
INSERT INTO `distrito` VALUES (1371, 134, 'HUACHO', 1);
INSERT INTO `distrito` VALUES (1372, 134, 'AMBAR', 1);
INSERT INTO `distrito` VALUES (1373, 134, 'CALETA DE CARQUIN', 1);
INSERT INTO `distrito` VALUES (1374, 134, 'CHECRAS', 1);
INSERT INTO `distrito` VALUES (1375, 134, 'HUALMAY', 1);
INSERT INTO `distrito` VALUES (1376, 134, 'HUAURA', 1);
INSERT INTO `distrito` VALUES (1377, 134, 'LEONCIO PRADO', 1);
INSERT INTO `distrito` VALUES (1378, 134, 'PACCHO', 1);
INSERT INTO `distrito` VALUES (1379, 134, 'SANTA LEONOR', 1);
INSERT INTO `distrito` VALUES (1380, 134, 'SANTA MARIA', 1);
INSERT INTO `distrito` VALUES (1381, 134, 'SAYAN', 1);
INSERT INTO `distrito` VALUES (1382, 134, 'VEGUETA', 1);
INSERT INTO `distrito` VALUES (1383, 135, 'OYON', 1);
INSERT INTO `distrito` VALUES (1384, 135, 'ANDAJES', 1);
INSERT INTO `distrito` VALUES (1385, 135, 'CAUJUL', 1);
INSERT INTO `distrito` VALUES (1386, 135, 'COCHAMARCA', 1);
INSERT INTO `distrito` VALUES (1387, 135, 'NAVAN', 1);
INSERT INTO `distrito` VALUES (1388, 135, 'PACHANGARA', 1);
INSERT INTO `distrito` VALUES (1389, 136, 'YAUYOS', 1);
INSERT INTO `distrito` VALUES (1390, 136, 'ALIS', 1);
INSERT INTO `distrito` VALUES (1391, 136, 'AYAUCA', 1);
INSERT INTO `distrito` VALUES (1392, 136, 'AYAVIRI', 1);
INSERT INTO `distrito` VALUES (1393, 136, 'AZANGARO', 1);
INSERT INTO `distrito` VALUES (1394, 136, 'CACRA', 1);
INSERT INTO `distrito` VALUES (1395, 136, 'CARANIA', 1);
INSERT INTO `distrito` VALUES (1396, 136, 'CATAHUASI', 1);
INSERT INTO `distrito` VALUES (1397, 136, 'CHOCOS', 1);
INSERT INTO `distrito` VALUES (1398, 136, 'COCHAS', 1);
INSERT INTO `distrito` VALUES (1399, 136, 'COLONIA', 1);
INSERT INTO `distrito` VALUES (1400, 136, 'HONGOS', 1);
INSERT INTO `distrito` VALUES (1401, 136, 'HUAMPARA', 1);
INSERT INTO `distrito` VALUES (1402, 136, 'HUANCAYA', 1);
INSERT INTO `distrito` VALUES (1403, 136, 'HUANGASCAR', 1);
INSERT INTO `distrito` VALUES (1404, 136, 'HUANTAN', 1);
INSERT INTO `distrito` VALUES (1405, 136, 'HUAÑEC', 1);
INSERT INTO `distrito` VALUES (1406, 136, 'LARAOS', 1);
INSERT INTO `distrito` VALUES (1407, 136, 'LINCHA', 1);
INSERT INTO `distrito` VALUES (1408, 136, 'MADEAN', 1);
INSERT INTO `distrito` VALUES (1409, 136, 'MIRAFLORES', 1);
INSERT INTO `distrito` VALUES (1410, 136, 'OMAS', 1);
INSERT INTO `distrito` VALUES (1411, 136, 'PUTINZA', 1);
INSERT INTO `distrito` VALUES (1412, 136, 'QUINCHES', 1);
INSERT INTO `distrito` VALUES (1413, 136, 'QUINOCAY', 1);
INSERT INTO `distrito` VALUES (1414, 136, 'SAN JOAQUIN', 1);
INSERT INTO `distrito` VALUES (1415, 136, 'SAN PEDRO DE PILAS', 1);
INSERT INTO `distrito` VALUES (1416, 136, 'TANTA', 1);
INSERT INTO `distrito` VALUES (1417, 136, 'TAURIPAMPA', 1);
INSERT INTO `distrito` VALUES (1418, 136, 'TOMAS', 1);
INSERT INTO `distrito` VALUES (1419, 136, 'TUPE', 1);
INSERT INTO `distrito` VALUES (1420, 136, 'VIÑAC', 1);
INSERT INTO `distrito` VALUES (1421, 136, 'VITIS', 1);
INSERT INTO `distrito` VALUES (1422, 137, 'IQUITOS', 1);
INSERT INTO `distrito` VALUES (1423, 137, 'ALTO NANAY', 1);
INSERT INTO `distrito` VALUES (1424, 137, 'FERNANDO LORES', 1);
INSERT INTO `distrito` VALUES (1425, 137, 'INDIANA', 1);
INSERT INTO `distrito` VALUES (1426, 137, 'LAS AMAZONAS', 1);
INSERT INTO `distrito` VALUES (1427, 137, 'MAZAN', 1);
INSERT INTO `distrito` VALUES (1428, 137, 'NAPO', 1);
INSERT INTO `distrito` VALUES (1429, 137, 'PUNCHANA', 1);
INSERT INTO `distrito` VALUES (1430, 137, 'PUTUMAYO', 1);
INSERT INTO `distrito` VALUES (1431, 137, 'TORRES CAUSANA', 1);
INSERT INTO `distrito` VALUES (1432, 137, 'BELEN', 1);
INSERT INTO `distrito` VALUES (1433, 137, 'SAN JUAN BAUTISTA', 1);
INSERT INTO `distrito` VALUES (1434, 138, 'YURIMAGUAS', 1);
INSERT INTO `distrito` VALUES (1435, 138, 'BALSAPUERTO', 1);
INSERT INTO `distrito` VALUES (1436, 138, 'BARRANCA', 1);
INSERT INTO `distrito` VALUES (1437, 138, 'CAHUAPANAS', 1);
INSERT INTO `distrito` VALUES (1438, 138, 'JEBEROS', 1);
INSERT INTO `distrito` VALUES (1439, 138, 'LAGUNAS', 1);
INSERT INTO `distrito` VALUES (1440, 138, 'MANSERICHE', 1);
INSERT INTO `distrito` VALUES (1441, 138, 'MORONA', 1);
INSERT INTO `distrito` VALUES (1442, 138, 'PASTAZA', 1);
INSERT INTO `distrito` VALUES (1443, 138, 'SANTA CRUZ', 1);
INSERT INTO `distrito` VALUES (1444, 138, 'TENIENTE CESAR LOPEZ ROJAS', 1);
INSERT INTO `distrito` VALUES (1445, 139, 'NAUTA', 1);
INSERT INTO `distrito` VALUES (1446, 139, 'PARINARI', 1);
INSERT INTO `distrito` VALUES (1447, 139, 'TIGRE', 1);
INSERT INTO `distrito` VALUES (1448, 139, 'TROMPETEROS', 1);
INSERT INTO `distrito` VALUES (1449, 139, 'URARINAS', 1);
INSERT INTO `distrito` VALUES (1450, 140, 'RAMON CASTILLA', 1);
INSERT INTO `distrito` VALUES (1451, 140, 'PEBAS', 1);
INSERT INTO `distrito` VALUES (1452, 140, 'YAVARI', 1);
INSERT INTO `distrito` VALUES (1453, 140, 'SAN PABLO', 1);
INSERT INTO `distrito` VALUES (1454, 141, 'REQUENA', 1);
INSERT INTO `distrito` VALUES (1455, 141, 'ALTO TAPICHE', 1);
INSERT INTO `distrito` VALUES (1456, 141, 'CAPELO', 1);
INSERT INTO `distrito` VALUES (1457, 141, 'EMILIO SAN MARTIN', 1);
INSERT INTO `distrito` VALUES (1458, 141, 'MAQUIA', 1);
INSERT INTO `distrito` VALUES (1459, 141, 'PUINAHUA', 1);
INSERT INTO `distrito` VALUES (1460, 141, 'SAQUENA', 1);
INSERT INTO `distrito` VALUES (1461, 141, 'SOPLIN', 1);
INSERT INTO `distrito` VALUES (1462, 141, 'TAPICHE', 1);
INSERT INTO `distrito` VALUES (1463, 141, 'JENARO HERRERA', 1);
INSERT INTO `distrito` VALUES (1464, 141, 'YAQUERANA', 1);
INSERT INTO `distrito` VALUES (1465, 142, 'CONTAMANA', 1);
INSERT INTO `distrito` VALUES (1466, 142, 'INAHUAYA', 1);
INSERT INTO `distrito` VALUES (1467, 142, 'PADRE MARQUEZ', 1);
INSERT INTO `distrito` VALUES (1468, 142, 'PAMPA HERMOSA', 1);
INSERT INTO `distrito` VALUES (1469, 142, 'SARAYACU', 1);
INSERT INTO `distrito` VALUES (1470, 142, 'VARGAS GUERRA', 1);
INSERT INTO `distrito` VALUES (1471, 143, 'TAMBOPATA', 1);
INSERT INTO `distrito` VALUES (1472, 143, 'INAMBARI', 1);
INSERT INTO `distrito` VALUES (1473, 143, 'LAS PIEDRAS', 1);
INSERT INTO `distrito` VALUES (1474, 143, 'LABERINTO', 1);
INSERT INTO `distrito` VALUES (1475, 144, 'MANU', 1);
INSERT INTO `distrito` VALUES (1476, 144, 'FITZCARRALD', 1);
INSERT INTO `distrito` VALUES (1477, 144, 'MADRE DE DIOS', 1);
INSERT INTO `distrito` VALUES (1478, 144, 'HUEPETUHE', 1);
INSERT INTO `distrito` VALUES (1479, 145, 'IÑAPARI', 1);
INSERT INTO `distrito` VALUES (1480, 145, 'IBERIA', 1);
INSERT INTO `distrito` VALUES (1481, 145, 'TAHUAMANU', 1);
INSERT INTO `distrito` VALUES (1482, 146, 'MOQUEGUA', 1);
INSERT INTO `distrito` VALUES (1483, 146, 'CARUMAS', 1);
INSERT INTO `distrito` VALUES (1484, 146, 'CUCHUMBAYA', 1);
INSERT INTO `distrito` VALUES (1485, 146, 'SAMEGUA', 1);
INSERT INTO `distrito` VALUES (1486, 146, 'SAN CRISTOBAL', 1);
INSERT INTO `distrito` VALUES (1487, 146, 'TORATA', 1);
INSERT INTO `distrito` VALUES (1488, 147, 'OMATE', 1);
INSERT INTO `distrito` VALUES (1489, 147, 'CHOJATA', 1);
INSERT INTO `distrito` VALUES (1490, 147, 'COALAQUE', 1);
INSERT INTO `distrito` VALUES (1491, 147, 'ICHUÑA', 1);
INSERT INTO `distrito` VALUES (1492, 147, 'LA CAPILLA', 1);
INSERT INTO `distrito` VALUES (1493, 147, 'LLOQUE', 1);
INSERT INTO `distrito` VALUES (1494, 147, 'MATALAQUE', 1);
INSERT INTO `distrito` VALUES (1495, 147, 'PUQUINA', 1);
INSERT INTO `distrito` VALUES (1496, 147, 'QUINISTAQUILLAS', 1);
INSERT INTO `distrito` VALUES (1497, 147, 'UBINAS', 1);
INSERT INTO `distrito` VALUES (1498, 147, 'YUNGA', 1);
INSERT INTO `distrito` VALUES (1499, 148, 'ILO', 1);
INSERT INTO `distrito` VALUES (1500, 148, 'EL ALGARROBAL', 1);
INSERT INTO `distrito` VALUES (1501, 148, 'PACOCHA', 1);
INSERT INTO `distrito` VALUES (1502, 149, 'CHAUPIMARCA', 1);
INSERT INTO `distrito` VALUES (1503, 149, 'HUACHON', 1);
INSERT INTO `distrito` VALUES (1504, 149, 'HUARIACA', 1);
INSERT INTO `distrito` VALUES (1505, 149, 'HUAYLLAY', 1);
INSERT INTO `distrito` VALUES (1506, 149, 'NINACACA', 1);
INSERT INTO `distrito` VALUES (1507, 149, 'PALLANCHACRA', 1);
INSERT INTO `distrito` VALUES (1508, 149, 'PAUCARTAMBO', 1);
INSERT INTO `distrito` VALUES (1509, 149, 'SAN FCO.DE ASIS DE YARUSYACAN', 1);
INSERT INTO `distrito` VALUES (1510, 149, 'SIMON BOLIVAR', 1);
INSERT INTO `distrito` VALUES (1511, 149, 'TICLACAYAN', 1);
INSERT INTO `distrito` VALUES (1512, 149, 'TINYAHUARCO', 1);
INSERT INTO `distrito` VALUES (1513, 149, 'VICCO', 1);
INSERT INTO `distrito` VALUES (1514, 149, 'YANACANCHA', 1);
INSERT INTO `distrito` VALUES (1515, 150, 'YANAHUANCA', 1);
INSERT INTO `distrito` VALUES (1516, 150, 'CHACAYAN', 1);
INSERT INTO `distrito` VALUES (1517, 150, 'GOYLLARISQUIZGA', 1);
INSERT INTO `distrito` VALUES (1518, 150, 'PAUCAR', 1);
INSERT INTO `distrito` VALUES (1519, 150, 'SAN PEDRO DE PILLAO', 1);
INSERT INTO `distrito` VALUES (1520, 150, 'SANTA ANA DE TUSI', 1);
INSERT INTO `distrito` VALUES (1521, 150, 'TAPUC', 1);
INSERT INTO `distrito` VALUES (1522, 150, 'VILCABAMBA', 1);
INSERT INTO `distrito` VALUES (1523, 151, 'OXAPAMPA', 1);
INSERT INTO `distrito` VALUES (1524, 151, 'CHONTABAMBA', 1);
INSERT INTO `distrito` VALUES (1525, 151, 'HUANCABAMBA', 1);
INSERT INTO `distrito` VALUES (1526, 151, 'PALCAZU', 1);
INSERT INTO `distrito` VALUES (1527, 151, 'POZUZO', 1);
INSERT INTO `distrito` VALUES (1528, 151, 'PUERTO BERMUDEZ', 1);
INSERT INTO `distrito` VALUES (1529, 151, 'VILLA RICA', 1);
INSERT INTO `distrito` VALUES (1530, 152, 'PIURA', 1);
INSERT INTO `distrito` VALUES (1531, 152, 'CASTILLA', 1);
INSERT INTO `distrito` VALUES (1532, 152, 'CATACAOS', 1);
INSERT INTO `distrito` VALUES (1533, 152, 'CURA MORI', 1);
INSERT INTO `distrito` VALUES (1534, 152, 'EL TALLAN', 1);
INSERT INTO `distrito` VALUES (1535, 152, 'LA ARENA', 1);
INSERT INTO `distrito` VALUES (1536, 152, 'LA UNION', 1);
INSERT INTO `distrito` VALUES (1537, 152, 'LAS LOMAS', 1);
INSERT INTO `distrito` VALUES (1538, 152, 'TAMBO GRANDE', 1);
INSERT INTO `distrito` VALUES (1539, 153, 'AYABACA', 1);
INSERT INTO `distrito` VALUES (1540, 153, 'FRIAS', 1);
INSERT INTO `distrito` VALUES (1541, 153, 'JILILI', 1);
INSERT INTO `distrito` VALUES (1542, 153, 'LAGUNAS', 1);
INSERT INTO `distrito` VALUES (1543, 153, 'MONTERO', 1);
INSERT INTO `distrito` VALUES (1544, 153, 'PACAIPAMPA', 1);
INSERT INTO `distrito` VALUES (1545, 153, 'PAIMAS', 1);
INSERT INTO `distrito` VALUES (1546, 153, 'SAPILLICA', 1);
INSERT INTO `distrito` VALUES (1547, 153, 'SICCHEZ', 1);
INSERT INTO `distrito` VALUES (1548, 153, 'SUYO', 1);
INSERT INTO `distrito` VALUES (1549, 154, 'HUANCABAMBA', 1);
INSERT INTO `distrito` VALUES (1550, 154, 'CANCHAQUE', 1);
INSERT INTO `distrito` VALUES (1551, 154, 'EL CARMEN DE LA FRONTERA', 1);
INSERT INTO `distrito` VALUES (1552, 154, 'HUARMACA', 1);
INSERT INTO `distrito` VALUES (1553, 154, 'LALAQUIZ', 1);
INSERT INTO `distrito` VALUES (1554, 154, 'SAN MIGUEL DE EL FAIQUE', 1);
INSERT INTO `distrito` VALUES (1555, 154, 'SONDOR', 1);
INSERT INTO `distrito` VALUES (1556, 154, 'SONDORILLO', 1);
INSERT INTO `distrito` VALUES (1557, 155, 'CHULUCANAS', 1);
INSERT INTO `distrito` VALUES (1558, 155, 'BUENOS AIRES', 1);
INSERT INTO `distrito` VALUES (1559, 155, 'CHALACO', 1);
INSERT INTO `distrito` VALUES (1560, 155, 'LA MATANZA', 1);
INSERT INTO `distrito` VALUES (1561, 155, 'MORROPON', 1);
INSERT INTO `distrito` VALUES (1562, 155, 'SALITRAL', 1);
INSERT INTO `distrito` VALUES (1563, 155, 'SAN JUAN DE BIGOTE', 1);
INSERT INTO `distrito` VALUES (1564, 155, 'SANTA CATALINA DE MOSSA', 1);
INSERT INTO `distrito` VALUES (1565, 155, 'SANTO DOMINGO', 1);
INSERT INTO `distrito` VALUES (1566, 155, 'YAMANGO', 1);
INSERT INTO `distrito` VALUES (1567, 156, 'PAITA', 1);
INSERT INTO `distrito` VALUES (1568, 156, 'AMOTAPE', 1);
INSERT INTO `distrito` VALUES (1569, 156, 'ARENAL', 1);
INSERT INTO `distrito` VALUES (1570, 156, 'COLAN', 1);
INSERT INTO `distrito` VALUES (1571, 156, 'LA HUACA', 1);
INSERT INTO `distrito` VALUES (1572, 156, 'TAMARINDO', 1);
INSERT INTO `distrito` VALUES (1573, 156, 'VICHAYAL', 1);
INSERT INTO `distrito` VALUES (1574, 157, 'SULLANA', 1);
INSERT INTO `distrito` VALUES (1575, 157, 'BELLAVISTA', 1);
INSERT INTO `distrito` VALUES (1576, 157, 'IGNACIO ESCUDERO', 1);
INSERT INTO `distrito` VALUES (1577, 157, 'LANCONES', 1);
INSERT INTO `distrito` VALUES (1578, 157, 'MARCAVELICA', 1);
INSERT INTO `distrito` VALUES (1579, 157, 'MIGUEL CHECA', 1);
INSERT INTO `distrito` VALUES (1580, 157, 'QUERECOTILLO', 1);
INSERT INTO `distrito` VALUES (1581, 157, 'SALITRAL', 1);
INSERT INTO `distrito` VALUES (1582, 158, 'PARIÑAS', 1);
INSERT INTO `distrito` VALUES (1583, 158, 'EL ALTO', 1);
INSERT INTO `distrito` VALUES (1584, 158, 'LA BREA', 1);
INSERT INTO `distrito` VALUES (1585, 158, 'LOBITOS', 1);
INSERT INTO `distrito` VALUES (1586, 158, 'LOS ORGANOS', 1);
INSERT INTO `distrito` VALUES (1587, 158, 'MANCORA', 1);
INSERT INTO `distrito` VALUES (1588, 159, 'SECHURA', 1);
INSERT INTO `distrito` VALUES (1589, 159, 'BELLAVISTA DE LA UNION', 1);
INSERT INTO `distrito` VALUES (1590, 159, 'BERNAL', 1);
INSERT INTO `distrito` VALUES (1591, 159, 'CRISTO NOS VALGA', 1);
INSERT INTO `distrito` VALUES (1592, 159, 'VICE', 1);
INSERT INTO `distrito` VALUES (1593, 159, 'RINCONADA LLICUAR', 1);
INSERT INTO `distrito` VALUES (1594, 160, 'PUNO', 1);
INSERT INTO `distrito` VALUES (1595, 160, 'ACORA', 1);
INSERT INTO `distrito` VALUES (1596, 160, 'AMANTANI', 1);
INSERT INTO `distrito` VALUES (1597, 160, 'ATUNCOLLA', 1);
INSERT INTO `distrito` VALUES (1598, 160, 'CAPACHICA', 1);
INSERT INTO `distrito` VALUES (1599, 160, 'CHUCUITO', 1);
INSERT INTO `distrito` VALUES (1600, 160, 'COATA', 1);
INSERT INTO `distrito` VALUES (1601, 160, 'HUATA', 1);
INSERT INTO `distrito` VALUES (1602, 160, 'MAÑAZO', 1);
INSERT INTO `distrito` VALUES (1603, 160, 'PAUCARCOLLA', 1);
INSERT INTO `distrito` VALUES (1604, 160, 'PICHACANI', 1);
INSERT INTO `distrito` VALUES (1605, 160, 'PLATERIA', 1);
INSERT INTO `distrito` VALUES (1606, 160, 'SAN ANTONIO', 1);
INSERT INTO `distrito` VALUES (1607, 160, 'TIQUILLACA', 1);
INSERT INTO `distrito` VALUES (1608, 160, 'VILQUE', 1);
INSERT INTO `distrito` VALUES (1609, 161, 'AZANGARO', 1);
INSERT INTO `distrito` VALUES (1610, 161, 'ACHAYA', 1);
INSERT INTO `distrito` VALUES (1611, 161, 'ARAPA', 1);
INSERT INTO `distrito` VALUES (1612, 161, 'ASILLO', 1);
INSERT INTO `distrito` VALUES (1613, 161, 'CAMINACA', 1);
INSERT INTO `distrito` VALUES (1614, 161, 'CHUPA', 1);
INSERT INTO `distrito` VALUES (1615, 161, 'JOSE DOMINGO CHOQUEHUANCA', 1);
INSERT INTO `distrito` VALUES (1616, 161, 'MUÑANI', 1);
INSERT INTO `distrito` VALUES (1617, 161, 'POTONI', 1);
INSERT INTO `distrito` VALUES (1618, 161, 'SAMAN', 1);
INSERT INTO `distrito` VALUES (1619, 161, 'SAN ANTON', 1);
INSERT INTO `distrito` VALUES (1620, 161, 'SAN JOSE', 1);
INSERT INTO `distrito` VALUES (1621, 161, 'SAN JUAN DE SALINAS', 1);
INSERT INTO `distrito` VALUES (1622, 161, 'SANTIAGO DE PUPUJA', 1);
INSERT INTO `distrito` VALUES (1623, 161, 'TIRAPATA', 1);
INSERT INTO `distrito` VALUES (1624, 162, 'MACUSANI', 1);
INSERT INTO `distrito` VALUES (1625, 162, 'AJOYANI', 1);
INSERT INTO `distrito` VALUES (1626, 162, 'AYAPATA', 1);
INSERT INTO `distrito` VALUES (1627, 162, 'COASA', 1);
INSERT INTO `distrito` VALUES (1628, 162, 'CORANI', 1);
INSERT INTO `distrito` VALUES (1629, 162, 'CRUCERO', 1);
INSERT INTO `distrito` VALUES (1630, 162, 'ITUATA', 1);
INSERT INTO `distrito` VALUES (1631, 162, 'OLLACHEA', 1);
INSERT INTO `distrito` VALUES (1632, 162, 'SAN GABAN', 1);
INSERT INTO `distrito` VALUES (1633, 162, 'USICAYOS', 1);
INSERT INTO `distrito` VALUES (1634, 163, 'JULI', 1);
INSERT INTO `distrito` VALUES (1635, 163, 'DESAGUADERO', 1);
INSERT INTO `distrito` VALUES (1636, 163, 'HUACULLANI', 1);
INSERT INTO `distrito` VALUES (1637, 163, 'KELLUYO', 1);
INSERT INTO `distrito` VALUES (1638, 163, 'PISACOMA', 1);
INSERT INTO `distrito` VALUES (1639, 163, 'POMATA', 1);
INSERT INTO `distrito` VALUES (1640, 163, 'ZEPITA', 1);
INSERT INTO `distrito` VALUES (1641, 164, 'ILAVE', 1);
INSERT INTO `distrito` VALUES (1642, 164, 'CAPAZO', 1);
INSERT INTO `distrito` VALUES (1643, 164, 'PILCUYO', 1);
INSERT INTO `distrito` VALUES (1644, 164, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (1645, 164, 'CONDURIRI', 1);
INSERT INTO `distrito` VALUES (1646, 165, 'HUANCANE', 1);
INSERT INTO `distrito` VALUES (1647, 165, 'COJATA', 1);
INSERT INTO `distrito` VALUES (1648, 165, 'HUATASANI', 1);
INSERT INTO `distrito` VALUES (1649, 165, 'INCHUPALLA', 1);
INSERT INTO `distrito` VALUES (1650, 165, 'PUSI', 1);
INSERT INTO `distrito` VALUES (1651, 165, 'ROSASPATA', 1);
INSERT INTO `distrito` VALUES (1652, 165, 'TARACO', 1);
INSERT INTO `distrito` VALUES (1653, 165, 'VILQUE CHICO', 1);
INSERT INTO `distrito` VALUES (1654, 166, 'LAMPA', 1);
INSERT INTO `distrito` VALUES (1655, 166, 'CABANILLA', 1);
INSERT INTO `distrito` VALUES (1656, 166, 'CALAPUJA', 1);
INSERT INTO `distrito` VALUES (1657, 166, 'NICASIO', 1);
INSERT INTO `distrito` VALUES (1658, 166, 'OCUVIRI', 1);
INSERT INTO `distrito` VALUES (1659, 166, 'PALCA', 1);
INSERT INTO `distrito` VALUES (1660, 166, 'PARATIA', 1);
INSERT INTO `distrito` VALUES (1661, 166, 'PUCARA', 1);
INSERT INTO `distrito` VALUES (1662, 166, 'SANTA LUCIA', 1);
INSERT INTO `distrito` VALUES (1663, 166, 'VILAVILA', 1);
INSERT INTO `distrito` VALUES (1664, 167, 'AYAVIRI', 1);
INSERT INTO `distrito` VALUES (1665, 167, 'ANTAUTA', 1);
INSERT INTO `distrito` VALUES (1666, 167, 'CUPI', 1);
INSERT INTO `distrito` VALUES (1667, 167, 'LLALLI', 1);
INSERT INTO `distrito` VALUES (1668, 167, 'MACARI', 1);
INSERT INTO `distrito` VALUES (1669, 167, 'NUÑOA', 1);
INSERT INTO `distrito` VALUES (1670, 167, 'ORURILLO', 1);
INSERT INTO `distrito` VALUES (1671, 167, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (1672, 167, 'UMACHIRI', 1);
INSERT INTO `distrito` VALUES (1673, 168, 'MOHO', 1);
INSERT INTO `distrito` VALUES (1674, 168, 'CONIMA', 1);
INSERT INTO `distrito` VALUES (1675, 168, 'HUAYRAPATA', 1);
INSERT INTO `distrito` VALUES (1676, 168, 'TILALI', 1);
INSERT INTO `distrito` VALUES (1677, 169, 'PUTINA', 1);
INSERT INTO `distrito` VALUES (1678, 169, 'ANANEA', 1);
INSERT INTO `distrito` VALUES (1679, 169, 'PEDRO VILCA APAZA', 1);
INSERT INTO `distrito` VALUES (1680, 169, 'QUILCAPUNCU', 1);
INSERT INTO `distrito` VALUES (1681, 169, 'SINA', 1);
INSERT INTO `distrito` VALUES (1682, 170, 'JULIACA', 1);
INSERT INTO `distrito` VALUES (1683, 170, 'CABANA', 1);
INSERT INTO `distrito` VALUES (1684, 170, 'CABANILLAS', 1);
INSERT INTO `distrito` VALUES (1685, 170, 'CARACOTO', 1);
INSERT INTO `distrito` VALUES (1686, 171, 'SANDIA', 1);
INSERT INTO `distrito` VALUES (1687, 171, 'CUYOCUYO', 1);
INSERT INTO `distrito` VALUES (1688, 171, 'LIMBANI', 1);
INSERT INTO `distrito` VALUES (1689, 171, 'PATAMBUCO', 1);
INSERT INTO `distrito` VALUES (1690, 171, 'PHARA', 1);
INSERT INTO `distrito` VALUES (1691, 171, 'QUIACA', 1);
INSERT INTO `distrito` VALUES (1692, 171, 'SAN JUAN DEL ORO', 1);
INSERT INTO `distrito` VALUES (1693, 171, 'YANAHUAYA', 1);
INSERT INTO `distrito` VALUES (1694, 171, 'ALTO INAMBARI', 1);
INSERT INTO `distrito` VALUES (1695, 172, 'YUNGUYO', 1);
INSERT INTO `distrito` VALUES (1696, 172, 'ANAPIA', 1);
INSERT INTO `distrito` VALUES (1697, 172, 'COPANI', 1);
INSERT INTO `distrito` VALUES (1698, 172, 'CUTURAPI', 1);
INSERT INTO `distrito` VALUES (1699, 172, 'OLLARAYA', 1);
INSERT INTO `distrito` VALUES (1700, 172, 'TINICACHI', 1);
INSERT INTO `distrito` VALUES (1701, 172, 'UNICACHI', 1);
INSERT INTO `distrito` VALUES (1702, 173, 'MOYOBAMBA', 1);
INSERT INTO `distrito` VALUES (1703, 173, 'CALZADA', 1);
INSERT INTO `distrito` VALUES (1704, 173, 'HABANA', 1);
INSERT INTO `distrito` VALUES (1705, 173, 'JEPELACIO', 1);
INSERT INTO `distrito` VALUES (1706, 173, 'SORITOR', 1);
INSERT INTO `distrito` VALUES (1707, 173, 'YANTALO', 1);
INSERT INTO `distrito` VALUES (1708, 174, 'BELLAVISTA', 1);
INSERT INTO `distrito` VALUES (1709, 174, 'ALTO BIAVO', 1);
INSERT INTO `distrito` VALUES (1710, 174, 'BAJO BIAVO', 1);
INSERT INTO `distrito` VALUES (1711, 174, 'HUALLAGA', 1);
INSERT INTO `distrito` VALUES (1712, 174, 'SAN PABLO', 1);
INSERT INTO `distrito` VALUES (1713, 174, 'SAN RAFAEL', 1);
INSERT INTO `distrito` VALUES (1714, 175, 'SAN JOSE DE SISA', 1);
INSERT INTO `distrito` VALUES (1715, 175, 'AGUA BLANCA', 1);
INSERT INTO `distrito` VALUES (1716, 175, 'SAN MARTIN', 1);
INSERT INTO `distrito` VALUES (1717, 175, 'SANTA ROSA', 1);
INSERT INTO `distrito` VALUES (1718, 175, 'SHATOJA', 1);
INSERT INTO `distrito` VALUES (1719, 176, 'SAPOSOA', 1);
INSERT INTO `distrito` VALUES (1720, 176, 'ALTO SAPOSOA', 1);
INSERT INTO `distrito` VALUES (1721, 176, 'EL ESLABON', 1);
INSERT INTO `distrito` VALUES (1722, 176, 'PISCOYACU', 1);
INSERT INTO `distrito` VALUES (1723, 176, 'SACANCHE', 1);
INSERT INTO `distrito` VALUES (1724, 176, 'TINGO DE SAPOSOA', 1);
INSERT INTO `distrito` VALUES (1725, 177, 'LAMAS', 1);
INSERT INTO `distrito` VALUES (1726, 177, 'ALONSO DE ALVARADO', 1);
INSERT INTO `distrito` VALUES (1727, 177, 'BARRANQUITA', 1);
INSERT INTO `distrito` VALUES (1728, 177, 'CAYNARACHI', 1);
INSERT INTO `distrito` VALUES (1729, 177, 'CUÑUNBUQUI', 1);
INSERT INTO `distrito` VALUES (1730, 177, 'PINTO RECODO', 1);
INSERT INTO `distrito` VALUES (1731, 177, 'RUMISAPA', 1);
INSERT INTO `distrito` VALUES (1732, 177, 'SAN ROQUE DE CUMBAZA', 1);
INSERT INTO `distrito` VALUES (1733, 177, 'SHANAO', 1);
INSERT INTO `distrito` VALUES (1734, 177, 'TABALOSOS', 1);
INSERT INTO `distrito` VALUES (1735, 177, 'ZAPATERO', 1);
INSERT INTO `distrito` VALUES (1736, 178, 'JUANJUI', 1);
INSERT INTO `distrito` VALUES (1737, 178, 'CAMPANILLA', 1);
INSERT INTO `distrito` VALUES (1738, 178, 'HUICUNGO', 1);
INSERT INTO `distrito` VALUES (1739, 178, 'PACHIZA', 1);
INSERT INTO `distrito` VALUES (1740, 178, 'PAJARILLO', 1);
INSERT INTO `distrito` VALUES (1741, 179, 'PICOTA', 1);
INSERT INTO `distrito` VALUES (1742, 179, 'BUENOS AIRES', 1);
INSERT INTO `distrito` VALUES (1743, 179, 'CASPISAPA', 1);
INSERT INTO `distrito` VALUES (1744, 179, 'PILLUANA', 1);
INSERT INTO `distrito` VALUES (1745, 179, 'PUCACACA', 1);
INSERT INTO `distrito` VALUES (1746, 179, 'SAN CRISTOBAL', 1);
INSERT INTO `distrito` VALUES (1747, 179, 'SAN HILARION', 1);
INSERT INTO `distrito` VALUES (1748, 179, 'SHAMBOYACU', 1);
INSERT INTO `distrito` VALUES (1749, 179, 'TINGO DE PONASA', 1);
INSERT INTO `distrito` VALUES (1750, 179, 'TRES UNIDOS', 1);
INSERT INTO `distrito` VALUES (1751, 180, 'RIOJA', 1);
INSERT INTO `distrito` VALUES (1752, 180, 'AWAJUN', 1);
INSERT INTO `distrito` VALUES (1753, 180, 'ELIAS SOPLIN VARGAS', 1);
INSERT INTO `distrito` VALUES (1754, 180, 'NUEVA CAJAMARCA', 1);
INSERT INTO `distrito` VALUES (1755, 180, 'PARDO MIGUEL', 1);
INSERT INTO `distrito` VALUES (1756, 180, 'POSIC', 1);
INSERT INTO `distrito` VALUES (1757, 180, 'SAN FERNANDO', 1);
INSERT INTO `distrito` VALUES (1758, 180, 'YORONGOS', 1);
INSERT INTO `distrito` VALUES (1759, 180, 'YURACYACU', 1);
INSERT INTO `distrito` VALUES (1760, 181, 'TARAPOTO', 1);
INSERT INTO `distrito` VALUES (1761, 181, 'ALBERTO LEVEAU', 1);
INSERT INTO `distrito` VALUES (1762, 181, 'CACATACHI', 1);
INSERT INTO `distrito` VALUES (1763, 181, 'CHAZUTA', 1);
INSERT INTO `distrito` VALUES (1764, 181, 'CHIPURANA', 1);
INSERT INTO `distrito` VALUES (1765, 181, 'EL PORVENIR', 1);
INSERT INTO `distrito` VALUES (1766, 181, 'HUIMBAYOC', 1);
INSERT INTO `distrito` VALUES (1767, 181, 'JUAN GUERRA', 1);
INSERT INTO `distrito` VALUES (1768, 181, 'LA BANDA DE SHILCAYO', 1);
INSERT INTO `distrito` VALUES (1769, 181, 'MORALES', 1);
INSERT INTO `distrito` VALUES (1770, 181, 'PAPAPLAYA', 1);
INSERT INTO `distrito` VALUES (1771, 181, 'SAN ANTONIO', 1);
INSERT INTO `distrito` VALUES (1772, 181, 'SAUCE', 1);
INSERT INTO `distrito` VALUES (1773, 181, 'SHAPAJA', 1);
INSERT INTO `distrito` VALUES (1774, 182, 'TOCACHE', 1);
INSERT INTO `distrito` VALUES (1775, 182, 'NUEVO PROGRESO', 1);
INSERT INTO `distrito` VALUES (1776, 182, 'POLVORA', 1);
INSERT INTO `distrito` VALUES (1777, 182, 'SHUNTE', 1);
INSERT INTO `distrito` VALUES (1778, 182, 'UCHIZA', 1);
INSERT INTO `distrito` VALUES (1779, 183, 'TACNA', 1);
INSERT INTO `distrito` VALUES (1780, 183, 'ALTO DE LA ALIANZA', 1);
INSERT INTO `distrito` VALUES (1781, 183, 'CALANA', 1);
INSERT INTO `distrito` VALUES (1782, 183, 'CIUDAD NUEVA', 1);
INSERT INTO `distrito` VALUES (1783, 183, 'INCLAN', 1);
INSERT INTO `distrito` VALUES (1784, 183, 'PACHIA', 1);
INSERT INTO `distrito` VALUES (1785, 183, 'PALCA', 1);
INSERT INTO `distrito` VALUES (1786, 183, 'POCOLLAY', 1);
INSERT INTO `distrito` VALUES (1787, 183, 'SAMA', 1);
INSERT INTO `distrito` VALUES (1788, 183, 'CORONEL GREGORIO ALBARRACIN LANCHIPA', 1);
INSERT INTO `distrito` VALUES (1789, 184, 'CANDARAVE', 1);
INSERT INTO `distrito` VALUES (1790, 184, 'CAIRANI', 1);
INSERT INTO `distrito` VALUES (1791, 184, 'CAMILACA', 1);
INSERT INTO `distrito` VALUES (1792, 184, 'CURIBAYA', 1);
INSERT INTO `distrito` VALUES (1793, 184, 'HUANUARA', 1);
INSERT INTO `distrito` VALUES (1794, 184, 'QUILAHUANI', 1);
INSERT INTO `distrito` VALUES (1795, 185, 'LOCUMBA', 1);
INSERT INTO `distrito` VALUES (1796, 185, 'ILABAYA', 1);
INSERT INTO `distrito` VALUES (1797, 185, 'ITE', 1);
INSERT INTO `distrito` VALUES (1798, 186, 'TARATA', 1);
INSERT INTO `distrito` VALUES (1799, 186, 'CHUCATAMANI', 1);
INSERT INTO `distrito` VALUES (1800, 186, 'ESTIQUE', 1);
INSERT INTO `distrito` VALUES (1801, 186, 'ESTIQUE-PAMPA', 1);
INSERT INTO `distrito` VALUES (1802, 186, 'SITAJARA', 1);
INSERT INTO `distrito` VALUES (1803, 186, 'SUSAPAYA', 1);
INSERT INTO `distrito` VALUES (1804, 186, 'TARUCACHI', 1);
INSERT INTO `distrito` VALUES (1805, 186, 'TICACO', 1);
INSERT INTO `distrito` VALUES (1806, 187, 'TUMBES', 1);
INSERT INTO `distrito` VALUES (1807, 187, 'CORRALES', 1);
INSERT INTO `distrito` VALUES (1808, 187, 'LA CRUZ', 1);
INSERT INTO `distrito` VALUES (1809, 187, 'PAMPAS DE HOSPITAL', 1);
INSERT INTO `distrito` VALUES (1810, 187, 'SAN JACINTO', 1);
INSERT INTO `distrito` VALUES (1811, 187, 'SAN JUAN DE LA VIRGEN', 1);
INSERT INTO `distrito` VALUES (1812, 188, 'ZORRITOS', 1);
INSERT INTO `distrito` VALUES (1813, 188, 'CASITAS', 1);
INSERT INTO `distrito` VALUES (1814, 189, 'ZARUMILLA', 1);
INSERT INTO `distrito` VALUES (1815, 189, 'AGUAS VERDES', 1);
INSERT INTO `distrito` VALUES (1816, 189, 'MATAPALO', 1);
INSERT INTO `distrito` VALUES (1817, 189, 'PAPAYAL', 1);
INSERT INTO `distrito` VALUES (1818, 190, 'CALLERIA', 1);
INSERT INTO `distrito` VALUES (1819, 190, 'CAMPOVERDE', 1);
INSERT INTO `distrito` VALUES (1820, 190, 'IPARIA', 1);
INSERT INTO `distrito` VALUES (1821, 190, 'MASISEA', 1);
INSERT INTO `distrito` VALUES (1822, 190, 'YARINACOCHA', 1);
INSERT INTO `distrito` VALUES (1823, 190, 'NUEVA REQUENA', 1);
INSERT INTO `distrito` VALUES (1824, 191, 'RAYMONDI', 1);
INSERT INTO `distrito` VALUES (1825, 191, 'SEPAHUA', 1);
INSERT INTO `distrito` VALUES (1826, 191, 'TAHUANIA', 1);
INSERT INTO `distrito` VALUES (1827, 191, 'YURUA', 1);
INSERT INTO `distrito` VALUES (1828, 192, 'PADRE ABAD', 1);
INSERT INTO `distrito` VALUES (1829, 192, 'IRAZOLA', 1);
INSERT INTO `distrito` VALUES (1830, 192, 'CURIMANA', 1);
INSERT INTO `distrito` VALUES (1831, 193, 'PURUS', 1);

-- ----------------------------
-- Table structure for egresado
-- ----------------------------
DROP TABLE IF EXISTS `egresado`;
CREATE TABLE `egresado`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoEscuela` int NOT NULL,
  `codigoPersona` int NOT NULL,
  `codigoAdmision` int NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoEscuela`(`codigoEscuela`) USING BTREE,
  INDEX `codigoPersona`(`codigoPersona`) USING BTREE,
  INDEX `codigoAdmision`(`codigoAdmision`) USING BTREE,
  CONSTRAINT `egresado_ibfk_1` FOREIGN KEY (`codigoEscuela`) REFERENCES `escuelaprofesional` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `egresado_ibfk_2` FOREIGN KEY (`codigoPersona`) REFERENCES `persona` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `egresado_ibfk_3` FOREIGN KEY (`codigoAdmision`) REFERENCES `admision` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of egresado
-- ----------------------------
INSERT INTO `egresado` VALUES (8, 1, 2, 8, '2016-02-10', '2020-09-20', 1);

-- ----------------------------
-- Table structure for escuelaprofesional
-- ----------------------------
DROP TABLE IF EXISTS `escuelaprofesional`;
CREATE TABLE `escuelaprofesional`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoFacultad` int NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `siglas` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `codigoUniversidad` int NULL DEFAULT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoFacultad`(`codigoFacultad`) USING BTREE,
  INDEX `codigoUniversidad`(`codigoUniversidad`) USING BTREE,
  CONSTRAINT `escuelaprofesional_ibfk_1` FOREIGN KEY (`codigoFacultad`) REFERENCES `facultad` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `escuelaprofesional_ibfk_2` FOREIGN KEY (`codigoUniversidad`) REFERENCES `universidad` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of escuelaprofesional
-- ----------------------------
INSERT INTO `escuelaprofesional` VALUES (1, 1, 'Ingenierí­a en Computación e Informática', 'EPICI', 1, 1, 1);
INSERT INTO `escuelaprofesional` VALUES (2, NULL, 'Ingenierí­a Agrícola', NULL, 1, 1, 1);

-- ----------------------------
-- Table structure for estudiospostgrado
-- ----------------------------
DROP TABLE IF EXISTS `estudiospostgrado`;
CREATE TABLE `estudiospostgrado`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoEgresado` int NOT NULL,
  `codigoTipo` int NOT NULL,
  `codigoUniversidad` int NULL DEFAULT NULL,
  `codigoCentroEstudios` int NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaTermino` date NOT NULL,
  `anioCertificacion` year NULL DEFAULT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoEgresado`(`codigoEgresado`) USING BTREE,
  INDEX `codigoTipo`(`codigoTipo`) USING BTREE,
  INDEX `codigoUniversidad`(`codigoUniversidad`) USING BTREE,
  INDEX `codigoCentroEstudios`(`codigoCentroEstudios`) USING BTREE,
  CONSTRAINT `estudiospostgrado_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `estudiospostgrado_ibfk_2` FOREIGN KEY (`codigoTipo`) REFERENCES `tipoestudiopostgrado` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `estudiospostgrado_ibfk_3` FOREIGN KEY (`codigoUniversidad`) REFERENCES `universidad` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `estudiospostgrado_ibfk_4` FOREIGN KEY (`codigoCentroEstudios`) REFERENCES `centroestudios` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of estudiospostgrado
-- ----------------------------

-- ----------------------------
-- Table structure for facultad
-- ----------------------------
DROP TABLE IF EXISTS `facultad`;
CREATE TABLE `facultad`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `siglas` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of facultad
-- ----------------------------
INSERT INTO `facultad` VALUES (1, 'Facultad de Ciencias Físicas y Matemáticas', 'FACFYM', 1, 1);
INSERT INTO `facultad` VALUES (2, 'Facultad de Ingeniería Mecánica Eléctrica', 'FIME', 1, 1);

-- ----------------------------
-- Table structure for modalidadadmision
-- ----------------------------
DROP TABLE IF EXISTS `modalidadadmision`;
CREATE TABLE `modalidadadmision`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of modalidadadmision
-- ----------------------------
INSERT INTO `modalidadadmision` VALUES (1, 'Ordinario', 'Examen de admisión para cualquier postulante que haya culminado el colegio.', 1);
INSERT INTO `modalidadadmision` VALUES (2, 'Extraordinario', 'Examen de admisión para alumnos de quinto año del colegio.', 1);
INSERT INTO `modalidadadmision` VALUES (3, 'Centro PRE', 'Examen de admisión para chicos que ya han culminado el colegio y están en academia.', 1);
INSERT INTO `modalidadadmision` VALUES (4, 'Exonerados', 'Examen de admisión para chicos que ocuparon los primeros puestos en su etapa académica.', 1);
INSERT INTO `modalidadadmision` VALUES (5, 'Casos Especiales', 'Examen de admisión para chicos con alguna discapacidad.', 1);
INSERT INTO `modalidadadmision` VALUES (6, 'Deportista Calificado', 'Examen de admisión para chicos que destacan en algún deporte.', 1);

-- ----------------------------
-- Table structure for modalidadtitulacion
-- ----------------------------
DROP TABLE IF EXISTS `modalidadtitulacion`;
CREATE TABLE `modalidadtitulacion`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of modalidadtitulacion
-- ----------------------------
INSERT INTO `modalidadtitulacion` VALUES (1, 'Experiencia Profesional', 'Ésta modalidad es válida para egresados que están o hayan desarrollado actividad profesional.', 1);
INSERT INTO `modalidadtitulacion` VALUES (2, 'Tesis', 'Ésta modalidad es válida para  egresados sin restricción del tiempo de egreso.', 1);
INSERT INTO `modalidadtitulacion` VALUES (3, 'Clase Modelo', 'Es una plantilla para la creación de objetos de datos según un modelo predefinido.', 1);
INSERT INTO `modalidadtitulacion` VALUES (4, 'Curso', 'Proceso o serie de estados por los que pasa una acción, un asunto, etc.', 1);

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `apellidoMaterno` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `apellidoPaterno` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `genero` tinyint(1) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `celular` char(9) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `correo` varchar(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `dni` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `estadoCivil` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `urlFoto` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `privacidad` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES (1, 'Marcelo', 'Villar', 'Velásquez', 1, '1999-02-18', '936076793', 'mvelasquezv@unprg.edu.pe', '74813707', 'S', 1, 'default.jpg', 0);
INSERT INTO `persona` VALUES (2, 'Javier Arturo', 'Sialer', 'Chavez', 1, '1999-06-12', '923020687', 'javier-arturo12@hotmail.com', '70505538', 'S', 1, 'default.jpg', 0);

-- ----------------------------
-- Table structure for personal
-- ----------------------------
DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `apellidoPaterno` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `apellidoMaterno` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `dni` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `genero` tinyint(1) NOT NULL,
  `correo` varchar(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `celular` char(9) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `nombres` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `urlFoto` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of personal
-- ----------------------------
INSERT INTO `personal` VALUES (1, 'Aquino', 'Lalupú', '42249995', 0, 'jaquino@unprg.edu.pe', '987654321', 1, 'Janet del Rosario', 'a715f7245bdfb6ee6366.png');

-- ----------------------------
-- Table structure for provincia
-- ----------------------------
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE `provincia`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoDepartamento` int NOT NULL,
  `nombre` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoDepartamento`(`codigoDepartamento`) USING BTREE,
  CONSTRAINT `provincia_ibfk_1` FOREIGN KEY (`codigoDepartamento`) REFERENCES `departamento` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of provincia
-- ----------------------------
INSERT INTO `provincia` VALUES (1, 1, 'CHACHAPOYAS ', 1);
INSERT INTO `provincia` VALUES (2, 1, 'BAGUA', 1);
INSERT INTO `provincia` VALUES (3, 1, 'BONGARA', 1);
INSERT INTO `provincia` VALUES (4, 1, 'CONDORCANQUI', 1);
INSERT INTO `provincia` VALUES (5, 1, 'LUYA', 1);
INSERT INTO `provincia` VALUES (6, 1, 'RODRIGUEZ DE MENDOZA', 1);
INSERT INTO `provincia` VALUES (7, 1, 'UTCUBAMBA', 1);
INSERT INTO `provincia` VALUES (8, 2, 'HUARAZ', 1);
INSERT INTO `provincia` VALUES (9, 2, 'AIJA', 1);
INSERT INTO `provincia` VALUES (10, 2, 'ANTONIO RAYMONDI', 1);
INSERT INTO `provincia` VALUES (11, 2, 'ASUNCION', 1);
INSERT INTO `provincia` VALUES (12, 2, 'BOLOGNESI', 1);
INSERT INTO `provincia` VALUES (13, 2, 'CARHUAZ', 1);
INSERT INTO `provincia` VALUES (14, 2, 'CARLOS FERMIN FITZCA', 1);
INSERT INTO `provincia` VALUES (15, 2, 'CASMA', 1);
INSERT INTO `provincia` VALUES (16, 2, 'CORONGO', 1);
INSERT INTO `provincia` VALUES (17, 2, 'HUARI', 1);
INSERT INTO `provincia` VALUES (18, 2, 'HUARMEY', 1);
INSERT INTO `provincia` VALUES (19, 2, 'HUAYLAS', 1);
INSERT INTO `provincia` VALUES (20, 2, 'MARISCAL LUZURIAGA', 1);
INSERT INTO `provincia` VALUES (21, 2, 'OCROS', 1);
INSERT INTO `provincia` VALUES (22, 2, 'PALLASCA', 1);
INSERT INTO `provincia` VALUES (23, 2, 'POMABAMBA', 1);
INSERT INTO `provincia` VALUES (24, 2, 'RECUAY', 1);
INSERT INTO `provincia` VALUES (25, 2, 'SANTA', 1);
INSERT INTO `provincia` VALUES (26, 2, 'SIHUAS', 1);
INSERT INTO `provincia` VALUES (27, 2, 'YUNGAY', 1);
INSERT INTO `provincia` VALUES (28, 3, 'ABANCAY', 1);
INSERT INTO `provincia` VALUES (29, 3, 'ANDAHUAYLAS', 1);
INSERT INTO `provincia` VALUES (30, 3, 'ANTABAMBA', 1);
INSERT INTO `provincia` VALUES (31, 3, 'AYMARAES', 1);
INSERT INTO `provincia` VALUES (32, 3, 'COTABAMBAS', 1);
INSERT INTO `provincia` VALUES (33, 3, 'CHINCHEROS', 1);
INSERT INTO `provincia` VALUES (34, 3, 'GRAU', 1);
INSERT INTO `provincia` VALUES (35, 4, 'AREQUIPA', 1);
INSERT INTO `provincia` VALUES (36, 4, 'CAMANA', 1);
INSERT INTO `provincia` VALUES (37, 4, 'CARAVELI', 1);
INSERT INTO `provincia` VALUES (38, 4, 'CASTILLA', 1);
INSERT INTO `provincia` VALUES (39, 4, 'CAYLLOMA', 1);
INSERT INTO `provincia` VALUES (40, 4, 'CONDESUYOS', 1);
INSERT INTO `provincia` VALUES (41, 4, 'ISLAY', 1);
INSERT INTO `provincia` VALUES (42, 4, 'LA UNION', 1);
INSERT INTO `provincia` VALUES (43, 5, 'HUAMANGA', 1);
INSERT INTO `provincia` VALUES (44, 5, 'CANGALLO', 1);
INSERT INTO `provincia` VALUES (45, 5, 'HUANCA SANCOS', 1);
INSERT INTO `provincia` VALUES (46, 5, 'HUANTA', 1);
INSERT INTO `provincia` VALUES (47, 5, 'LA MAR', 1);
INSERT INTO `provincia` VALUES (48, 5, 'LUCANAS', 1);
INSERT INTO `provincia` VALUES (49, 5, 'PARINACOCHAS', 1);
INSERT INTO `provincia` VALUES (50, 5, 'PAUCAR DEL SARA SARA', 1);
INSERT INTO `provincia` VALUES (51, 5, 'SUCRE', 1);
INSERT INTO `provincia` VALUES (52, 5, 'VICTOR FAJARDO', 1);
INSERT INTO `provincia` VALUES (53, 5, 'VILCAS HUAMAN', 1);
INSERT INTO `provincia` VALUES (54, 6, 'CAJAMARCA', 1);
INSERT INTO `provincia` VALUES (55, 6, 'CAJABAMBA', 1);
INSERT INTO `provincia` VALUES (56, 6, 'CELENDIN', 1);
INSERT INTO `provincia` VALUES (57, 6, 'CHOTA ', 1);
INSERT INTO `provincia` VALUES (58, 6, 'CONTUMAZA', 1);
INSERT INTO `provincia` VALUES (59, 6, 'CUTERVO', 1);
INSERT INTO `provincia` VALUES (60, 6, 'HUALGAYOC', 1);
INSERT INTO `provincia` VALUES (61, 6, 'JAEN', 1);
INSERT INTO `provincia` VALUES (62, 6, 'SAN IGNACIO', 1);
INSERT INTO `provincia` VALUES (63, 6, 'SAN MARCOS', 1);
INSERT INTO `provincia` VALUES (64, 6, 'SAN PABLO', 1);
INSERT INTO `provincia` VALUES (65, 6, 'SANTA CRUZ', 1);
INSERT INTO `provincia` VALUES (66, 7, 'CALLAO', 1);
INSERT INTO `provincia` VALUES (67, 8, 'CUSCO', 1);
INSERT INTO `provincia` VALUES (68, 8, 'ACOMAYO', 1);
INSERT INTO `provincia` VALUES (69, 8, 'ANTA', 1);
INSERT INTO `provincia` VALUES (70, 8, 'CALCA', 1);
INSERT INTO `provincia` VALUES (71, 8, 'CANAS', 1);
INSERT INTO `provincia` VALUES (72, 8, 'CANCHIS', 1);
INSERT INTO `provincia` VALUES (73, 8, 'CHUMBIVILCAS', 1);
INSERT INTO `provincia` VALUES (74, 8, 'ESPINAR', 1);
INSERT INTO `provincia` VALUES (75, 8, 'LA CONVENCION', 1);
INSERT INTO `provincia` VALUES (76, 8, 'PARURO', 1);
INSERT INTO `provincia` VALUES (77, 8, 'PAUCARTAMBO', 1);
INSERT INTO `provincia` VALUES (78, 8, 'QUISPICANCHI', 1);
INSERT INTO `provincia` VALUES (79, 8, 'URUBAMBA', 1);
INSERT INTO `provincia` VALUES (80, 9, 'HUANCAVELICA', 1);
INSERT INTO `provincia` VALUES (81, 9, 'ACOBAMBA', 1);
INSERT INTO `provincia` VALUES (82, 9, 'ANGARAES', 1);
INSERT INTO `provincia` VALUES (83, 9, 'CASTROVIRREYNA', 1);
INSERT INTO `provincia` VALUES (84, 9, 'CHURCAMPA', 1);
INSERT INTO `provincia` VALUES (85, 9, 'HUAYTARA', 1);
INSERT INTO `provincia` VALUES (86, 9, 'TAYACAJA', 1);
INSERT INTO `provincia` VALUES (87, 10, 'HUANUCO', 1);
INSERT INTO `provincia` VALUES (88, 10, 'AMBO', 1);
INSERT INTO `provincia` VALUES (89, 10, 'DOS DE MAYO', 1);
INSERT INTO `provincia` VALUES (90, 10, 'HUACAYBAMBA', 1);
INSERT INTO `provincia` VALUES (91, 10, 'HUAMALIES', 1);
INSERT INTO `provincia` VALUES (92, 10, 'LEONCIO PRADO', 1);
INSERT INTO `provincia` VALUES (93, 10, 'MARAÑON', 1);
INSERT INTO `provincia` VALUES (94, 10, 'PACHITEA', 1);
INSERT INTO `provincia` VALUES (95, 10, 'PUERTO INCA', 1);
INSERT INTO `provincia` VALUES (96, 10, 'LAURICOCHA', 1);
INSERT INTO `provincia` VALUES (97, 10, 'YAROWILCA', 1);
INSERT INTO `provincia` VALUES (98, 11, 'ICA', 1);
INSERT INTO `provincia` VALUES (99, 11, 'CHINCHA', 1);
INSERT INTO `provincia` VALUES (100, 11, 'NAZCA', 1);
INSERT INTO `provincia` VALUES (101, 11, 'PALPA', 1);
INSERT INTO `provincia` VALUES (102, 11, 'PISCO', 1);
INSERT INTO `provincia` VALUES (103, 12, 'HUANCAYO', 1);
INSERT INTO `provincia` VALUES (104, 12, 'CONCEPCION', 1);
INSERT INTO `provincia` VALUES (105, 12, 'CHANCHAMAYO', 1);
INSERT INTO `provincia` VALUES (106, 12, 'JAUJA', 1);
INSERT INTO `provincia` VALUES (107, 12, 'JUNIN', 1);
INSERT INTO `provincia` VALUES (108, 12, 'SATIPO', 1);
INSERT INTO `provincia` VALUES (109, 12, 'TARMA', 1);
INSERT INTO `provincia` VALUES (110, 12, 'YAULI', 1);
INSERT INTO `provincia` VALUES (111, 12, 'CHUPACA', 1);
INSERT INTO `provincia` VALUES (112, 13, 'TRUJILLO', 1);
INSERT INTO `provincia` VALUES (113, 13, 'ASCOPE', 1);
INSERT INTO `provincia` VALUES (114, 13, 'BOLIVAR', 1);
INSERT INTO `provincia` VALUES (115, 13, 'CHEPEN', 1);
INSERT INTO `provincia` VALUES (116, 13, 'JULCAN', 1);
INSERT INTO `provincia` VALUES (117, 13, 'OTUZCO', 1);
INSERT INTO `provincia` VALUES (118, 13, 'PACASMAYO', 1);
INSERT INTO `provincia` VALUES (119, 13, 'PATAZ', 1);
INSERT INTO `provincia` VALUES (120, 13, 'SANCHEZ CARRION', 1);
INSERT INTO `provincia` VALUES (121, 13, 'SANTIAGO DE CHUCO', 1);
INSERT INTO `provincia` VALUES (122, 13, 'GRAN CHIMU', 1);
INSERT INTO `provincia` VALUES (123, 13, 'VIRU', 1);
INSERT INTO `provincia` VALUES (124, 14, 'CHICLAYO', 1);
INSERT INTO `provincia` VALUES (125, 14, 'FERREÑAFE', 1);
INSERT INTO `provincia` VALUES (126, 14, 'LAMBAYEQUE', 1);
INSERT INTO `provincia` VALUES (127, 15, 'LIMA', 1);
INSERT INTO `provincia` VALUES (128, 15, 'BARRANCA', 1);
INSERT INTO `provincia` VALUES (129, 15, 'CAJATAMBO', 1);
INSERT INTO `provincia` VALUES (130, 15, 'CANTA', 1);
INSERT INTO `provincia` VALUES (131, 15, 'CAÑETE', 1);
INSERT INTO `provincia` VALUES (132, 15, 'HUARAL', 1);
INSERT INTO `provincia` VALUES (133, 15, 'HUAROCHIRI', 1);
INSERT INTO `provincia` VALUES (134, 15, 'HUAURA', 1);
INSERT INTO `provincia` VALUES (135, 15, 'OYON', 1);
INSERT INTO `provincia` VALUES (136, 15, 'YAUYOS', 1);
INSERT INTO `provincia` VALUES (137, 16, 'MAYNAS', 1);
INSERT INTO `provincia` VALUES (138, 16, 'ALTO AMAZONAS', 1);
INSERT INTO `provincia` VALUES (139, 16, 'LORETO', 1);
INSERT INTO `provincia` VALUES (140, 16, 'MARISCAL RAMON CASTILLA', 1);
INSERT INTO `provincia` VALUES (141, 16, 'REQUENA', 1);
INSERT INTO `provincia` VALUES (142, 16, 'UCAYALI', 1);
INSERT INTO `provincia` VALUES (143, 17, 'TAMBOPATA', 1);
INSERT INTO `provincia` VALUES (144, 17, 'MANU', 1);
INSERT INTO `provincia` VALUES (145, 17, 'TAHUAMANU', 1);
INSERT INTO `provincia` VALUES (146, 18, 'MARISCAL NIETO', 1);
INSERT INTO `provincia` VALUES (147, 18, 'GENERAL SANCHEZ CERRO', 1);
INSERT INTO `provincia` VALUES (148, 18, 'ILO', 1);
INSERT INTO `provincia` VALUES (149, 19, 'PASCO', 1);
INSERT INTO `provincia` VALUES (150, 19, 'DANIEL ALCIDES CARRION', 1);
INSERT INTO `provincia` VALUES (151, 19, 'OXAPAMPA', 1);
INSERT INTO `provincia` VALUES (152, 20, 'PIURA', 1);
INSERT INTO `provincia` VALUES (153, 20, 'AYABACA', 1);
INSERT INTO `provincia` VALUES (154, 20, 'HUANCABAMBA', 1);
INSERT INTO `provincia` VALUES (155, 20, 'MORROPON', 1);
INSERT INTO `provincia` VALUES (156, 20, 'PAITA', 1);
INSERT INTO `provincia` VALUES (157, 20, 'SULLANA', 1);
INSERT INTO `provincia` VALUES (158, 20, 'TALARA', 1);
INSERT INTO `provincia` VALUES (159, 20, 'SECHURA', 1);
INSERT INTO `provincia` VALUES (160, 21, 'PUNO', 1);
INSERT INTO `provincia` VALUES (161, 21, 'AZANGARO', 1);
INSERT INTO `provincia` VALUES (162, 21, 'CARABAYA', 1);
INSERT INTO `provincia` VALUES (163, 21, 'CHUCUITO', 1);
INSERT INTO `provincia` VALUES (164, 21, 'EL COLLAO', 1);
INSERT INTO `provincia` VALUES (165, 21, 'HUANCANE', 1);
INSERT INTO `provincia` VALUES (166, 21, 'LAMPA', 1);
INSERT INTO `provincia` VALUES (167, 21, 'MELGAR', 1);
INSERT INTO `provincia` VALUES (168, 21, 'MOHO', 1);
INSERT INTO `provincia` VALUES (169, 21, 'SAN ANTONIO DE PUTINA', 1);
INSERT INTO `provincia` VALUES (170, 21, 'SAN ROMAN', 1);
INSERT INTO `provincia` VALUES (171, 21, 'SANDIA', 1);
INSERT INTO `provincia` VALUES (172, 21, 'YUNGUYO', 1);
INSERT INTO `provincia` VALUES (173, 22, 'MOYOBAMBA', 1);
INSERT INTO `provincia` VALUES (174, 22, 'BELLAVISTA', 1);
INSERT INTO `provincia` VALUES (175, 22, 'EL DORADO', 1);
INSERT INTO `provincia` VALUES (176, 22, 'HUALLAGA', 1);
INSERT INTO `provincia` VALUES (177, 22, 'LAMAS', 1);
INSERT INTO `provincia` VALUES (178, 22, 'MARISCAL CACERES', 1);
INSERT INTO `provincia` VALUES (179, 22, 'PICOTA', 1);
INSERT INTO `provincia` VALUES (180, 22, 'RIOJA', 1);
INSERT INTO `provincia` VALUES (181, 22, 'SAN MARTIN', 1);
INSERT INTO `provincia` VALUES (182, 22, 'TOCACHE', 1);
INSERT INTO `provincia` VALUES (183, 23, 'TACNA', 1);
INSERT INTO `provincia` VALUES (184, 23, 'CANDARAVE', 1);
INSERT INTO `provincia` VALUES (185, 23, 'JORGE BASADRE', 1);
INSERT INTO `provincia` VALUES (186, 23, 'TARATA', 1);
INSERT INTO `provincia` VALUES (187, 24, 'TUMBES', 1);
INSERT INTO `provincia` VALUES (188, 24, 'CONTRALMIRANTE VILLA', 1);
INSERT INTO `provincia` VALUES (189, 24, 'ZARUMILLA', 1);
INSERT INTO `provincia` VALUES (190, 25, 'CORONEL PORTILLO', 1);
INSERT INTO `provincia` VALUES (191, 25, 'ATALAYA', 1);
INSERT INTO `provincia` VALUES (192, 25, 'PADRE ABAD', 1);
INSERT INTO `provincia` VALUES (193, 25, 'PURUS', 1);

-- ----------------------------
-- Table structure for tipoestudiopostgrado
-- ----------------------------
DROP TABLE IF EXISTS `tipoestudiopostgrado`;
CREATE TABLE `tipoestudiopostgrado`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tipoestudiopostgrado
-- ----------------------------
INSERT INTO `tipoestudiopostgrado` VALUES (1, 'Curso', 'Cursos de corta duración para conocer mejor un nuevo ámbito especí­fico.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (2, 'Diplomado', 'Curso de corta o mediana duración.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (3, 'Doctorado', 'Es la máxima formación académica a la que se puede optar.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (4, 'Segunda Especialidad', 'Formación de investigadores, docentes universitarios y especialistas.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (5, 'Maestria', 'Grado académico de postgrado que se consigue al completar un programa de uno a dos años.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (6, 'Idioma', 'Dominio de un idioma extranjero. ', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (7, 'Certificación', 'Procedimiento destinado a que un organismo dictamine la calidad del sistema aplicado.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (8, 'Taller', 'Espacio en el que se realiza un trabajo.​', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (9, 'Ponencia', 'Exposición por parte de alguien que da algunas ideas.', 1);
INSERT INTO `tipoestudiopostgrado` VALUES (10, 'Congreso', 'Reunión o conferencia, generalmente periódica en donde se comparte conocimiento.', 1);

-- ----------------------------
-- Table structure for titulacion
-- ----------------------------
DROP TABLE IF EXISTS `titulacion`;
CREATE TABLE `titulacion`  (
  `codigoEgresado` int NOT NULL AUTO_INCREMENT,
  `codigoModalidad` int NOT NULL,
  `fecha` date NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigoEgresado`) USING BTREE,
  INDEX `codigoModalidad`(`codigoModalidad`) USING BTREE,
  CONSTRAINT `titulacion_ibfk_1` FOREIGN KEY (`codigoEgresado`) REFERENCES `egresado` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `titulacion_ibfk_2` FOREIGN KEY (`codigoModalidad`) REFERENCES `modalidadtitulacion` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of titulacion
-- ----------------------------

-- ----------------------------
-- Table structure for universidad
-- ----------------------------
DROP TABLE IF EXISTS `universidad`;
CREATE TABLE `universidad`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `siglas` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of universidad
-- ----------------------------
INSERT INTO `universidad` VALUES (1, 'Universidad Nacional Pedro Ruiz Gallo', 'UNPRG', 1, 1);
INSERT INTO `universidad` VALUES (2, 'Universidad Nacional de Ingenierí­a', 'UNI', 1, 1);
INSERT INTO `universidad` VALUES (3, 'Pontificia Universidad Católica del Perú', 'PUCP', 1, 1);
INSERT INTO `universidad` VALUES (4, 'Universidad Santo Toribio de Mogrovejo', 'USAT', 1, 1);
INSERT INTO `universidad` VALUES (5, 'Universidad San Martí­n de Porres', 'USMP', 1, 1);
INSERT INTO `universidad` VALUES (6, 'Universidad Nacional Autónoma de Chota', 'UNACH', 1, 1);
INSERT INTO `universidad` VALUES (7, 'Universidad de Piura', 'UDEP', 1, 1);
INSERT INTO `universidad` VALUES (8, 'Universidad Nacional de Trujillo', 'UNT', 1, 1);

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `codigoPersonal` int NULL DEFAULT NULL,
  `nombre` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(90) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `tipo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `vigencia` tinyint(1) NOT NULL,
  `codigoPersona` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigoPersonal`(`codigoPersonal`) USING BTREE,
  INDEX `codigoPersona`(`codigoPersona`) USING BTREE,
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`codigoPersonal`) REFERENCES `personal` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`codigoPersona`) REFERENCES `persona` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 1, 'admin', '$2y$10$6Q5a1XK6K9Yd6HlEngRvVuk7kv3Zd5nefzx/Vygup/CwzYoFQGr1i', 'A', 1, NULL);
INSERT INTO `usuario` VALUES (2, NULL, 'marcktone', '$2y$10$lA3N.Wk6HCw/3Y3IR96dc.rX4Krbd8M.8R/AuD6zzkrPBznlkngUC', 'E', 1, 1);
INSERT INTO `usuario` VALUES (3, NULL, 'javcho', '$2y$10$YxuWg2Ggzz/Zh3rVLj15GOyuRdNHMBrR82rhWEfUFXXV5xEyTdx12', 'E', 1, 2);

SET FOREIGN_KEY_CHECKS = 1;
