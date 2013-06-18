-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 18, 2013 at 09:14 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `orientenme`
--

-- --------------------------------------------------------

--
-- Table structure for table `activacion`
--

CREATE TABLE IF NOT EXISTS `activacion` (
  `act_id` bigint(15) NOT NULL AUTO_INCREMENT,
  `usu_id` bigint(15) NOT NULL,
  `act_code` bigint(11) NOT NULL,
  PRIMARY KEY (`act_id`),
  KEY `usu_id` (`usu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `activacion`
--

INSERT INTO `activacion` (`act_id`, `usu_id`, `act_code`) VALUES
(3, 3, 1000212743);

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `are_id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'Primaria de Areas',
  `are_nombre` varchar(50) NOT NULL COMMENT 'Nombre del area',
  `are_resumen` text COMMENT 'Resumen del area',
  `are_detalle` text COMMENT 'Detalle del area',
  `are_icono` varchar(200) DEFAULT NULL COMMENT 'Ruta al icono del area',
  PRIMARY KEY (`are_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`are_id`, `are_nombre`, `are_resumen`, `are_detalle`, `are_icono`) VALUES
(2, 'salud', 'area de la salud', 'estab todas las arear relacionadas a la salud', NULL),
(3, 'tecnologia', 'areas informaticas', 'areas de info todo relacionado a la tecnologia', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comentarios`
--

CREATE TABLE IF NOT EXISTS `comentarios` (
  `com_id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de los comentarios',
  `com_ip` varchar(50) NOT NULL COMMENT 'Se guarda IP de la maquina que lo envio',
  `com_detalle` text NOT NULL COMMENT 'Cuerpo, texto del comentario',
  `com_respuesta` bigint(15) NOT NULL COMMENT 'Id del comentario padre',
  `com_megusta` int(7) NOT NULL COMMENT 'Cantidad de me gusta del comentario',
  `com_fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha y hora de realizado el comentario',
  `usu_id` bigint(15) NOT NULL COMMENT 'Foranea al usuario que lo deja',
  `tio_id` bigint(15) NOT NULL COMMENT 'Foranea al testimonio donde se deja',
  PRIMARY KEY (`com_id`),
  KEY `com_respuesta` (`com_respuesta`,`usu_id`,`tio_id`),
  KEY `usu_id` (`usu_id`),
  KEY `tio_id` (`tio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `consultas`
--

CREATE TABLE IF NOT EXISTS `consultas` (
  `con_id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la consulta',
  `con_asunto` varchar(100) NOT NULL COMMENT 'Asunto de la consulta',
  `con_detalle` text NOT NULL,
  `con_respuesta` bigint(15) DEFAULT NULL COMMENT 'Respuesta, como tambien es consulta se le pasa la foranea del id de la consulta padre.',
  `con_puntos` int(7) DEFAULT NULL COMMENT 'Puntos que posee la consulta',
  `con_fechaenvio` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha en que se envió la consulta',
  `con_fechacierre` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha en que cerró la consulta',
  `usu_idemisor` bigint(15) NOT NULL COMMENT 'Id del usuario que envía la consulta',
  `usu_iddestino` bigint(15) NOT NULL COMMENT 'Id del usuario que recibe la consulta.',
  PRIMARY KEY (`con_id`),
  KEY `con_respuesta` (`con_respuesta`,`usu_idemisor`,`usu_iddestino`),
  KEY `usu_idemisor` (`usu_idemisor`),
  KEY `usu_iddestino` (`usu_iddestino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Las consultas que se realizan entre usuarios.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `detalletest`
--

CREATE TABLE IF NOT EXISTS `detalletest` (
  `test_id` bigint(15) NOT NULL COMMENT 'Foranea al test que hace cada usuario',
  `ptest_id` int(3) NOT NULL COMMENT 'Foranea a las preguntas de cada test',
  `rtest_id` int(5) NOT NULL COMMENT 'Foranea a las respuestas posibles de cada pregunta del test',
  PRIMARY KEY (`test_id`,`ptest_id`,`rtest_id`),
  KEY `ptest_id` (`ptest_id`),
  KEY `rtest_id` (`rtest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `detalletipotest`
--

CREATE TABLE IF NOT EXISTS `detalletipotest` (
  `tipt_id` int(2) NOT NULL COMMENT 'Foranea al tipo de test',
  `test_id` bigint(15) NOT NULL COMMENT 'Foranea al test que hace cada usuario',
  `ptest_id` int(3) NOT NULL COMMENT 'Foranea a las preguntas de ese test',
  PRIMARY KEY (`tipt_id`,`test_id`,`ptest_id`),
  KEY `test_id` (`test_id`),
  KEY `ptest_id` (`ptest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `localidades`
--

CREATE TABLE IF NOT EXISTS `localidades` (
  `loc_id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de Localidad',
  `loc_nombre` varchar(50) NOT NULL COMMENT 'Nombre de la Localidad',
  `pro_id` int(7) NOT NULL COMMENT 'Foranea a provincia',
  PRIMARY KEY (`loc_id`),
  KEY `prov_id` (`pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paises`
--

CREATE TABLE IF NOT EXISTS `paises` (
  `pai_id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria pais',
  `pai_cod` varchar(20) NOT NULL COMMENT 'Codigo del pais',
  `pai_nombre` varchar(50) NOT NULL COMMENT 'Nombre del pais',
  PRIMARY KEY (`pai_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=236 ;

--
-- Dumping data for table `paises`
--

INSERT INTO `paises` (`pai_id`, `pai_cod`, `pai_nombre`) VALUES
(1, 'AFG', 'AFGANISTAN'),
(2, 'ALB', 'ALBANIA'),
(3, 'DEU', 'ALEMANIA'),
(4, 'AND', 'ANDORRA'),
(5, 'AGO', 'ANGOLA'),
(6, 'AIA', 'ANGUILLA'),
(7, 'MKD', 'ANT.REP.YUGOSLAVIA DE MACEDONIA'),
(8, 'ATG', 'ANTIGUA Y BARBUDA'),
(9, 'ANT', 'ANTILLAS NEERLANDESAS'),
(10, 'SAU', 'ARABIA SAUDITA'),
(11, 'DZA', 'ARGELIA'),
(12, 'ARG', 'ARGENTINA'),
(13, 'ABW', 'ARUBA'),
(14, 'AUS', 'AUSTRALIA'),
(15, 'AUT', 'AUSTRIA'),
(16, 'AZE', 'AZERBAIJAN'),
(17, 'BHS', 'BAHAMAS'),
(18, 'BHR', 'BAHREIN'),
(19, 'BGD', 'BANGLADESH'),
(20, 'BRB', 'BARBADOS'),
(21, 'BEL', 'BELGICA'),
(22, 'BLZ', 'BELICE'),
(23, 'BEN', 'BENIN'),
(24, 'BMU', 'BERMUDAS'),
(25, 'BTN', 'BHUTAN'),
(26, 'BLR', 'BIOLORRUSIA'),
(27, 'BOL', 'BOLIVIA'),
(28, 'BIH', 'BOSNIAHERZEGOVINA'),
(29, 'BWA', 'BOTSUANA'),
(30, 'BRA', 'BRASIL'),
(31, 'BRN', 'BRUNEI'),
(32, 'BGR', 'BULGARIA'),
(33, 'BFA', 'BURKINAFASO'),
(34, 'BDT', 'BURUNDI'),
(35, 'KHM', 'CAMBOYA (KAMPUCHEA)'),
(36, 'CMR', 'CAMERUN'),
(37, 'CAN', 'CANADA'),
(38, 'TCD', 'CHAD'),
(39, 'CHL', 'CHILE'),
(40, 'CHN', 'CHINA'),
(41, 'CYP', 'CHIPRE'),
(42, 'VAT', 'CIUDAD DEL VATICANO'),
(43, 'COL', 'COLOMBIA'),
(44, 'COM', 'COMORAS'),
(45, 'COG', 'CONGO'),
(46, 'PRK', 'COREA DEL NORTE'),
(47, 'KOR', 'COREA DEL SUR'),
(48, 'CIV', 'COSTA DE MARFIL'),
(49, 'CRI', 'COSTA RICA'),
(50, 'HRV', 'CROACIA'),
(51, 'CUB', 'CUBA'),
(52, 'DNK', 'DINAMARCA'),
(53, 'DMA', 'DOMINICA'),
(54, 'ECU', 'ECUADOR'),
(55, 'EGY', 'EGIPTO'),
(56, 'SLV', 'EL SALVADOR'),
(57, 'ARE', 'EMIRATOS ARABES UNIDOS'),
(58, 'ERI', 'ERITREA'),
(59, 'SVN', 'ESLOVENIA'),
(60, 'ESP', 'ESPAÑA'),
(61, 'USA', 'ESTADOS UNIDOS DE AMERICA'),
(62, 'EST', 'ESTONIA'),
(63, 'ETH', 'ETIOPIA'),
(64, 'FJI', 'FIJI(FIDJI)'),
(65, 'PHL', 'FILIPINAS'),
(66, 'FIN', 'FINLANDIA'),
(67, 'FRA', 'FRANCIA'),
(68, 'GAB', 'GABON'),
(69, 'GMB', 'GAMBIA'),
(70, 'GEO', 'GEORGIA'),
(71, 'GHA', 'GHANA'),
(72, 'GIB', 'GIBRALTAR'),
(73, 'GRD', 'GRANADA'),
(74, 'GRC', 'GRECIA'),
(75, 'GRL', 'GROENLANDIA'),
(76, 'GLP', 'GUADALUPE'),
(77, 'GUM', 'GUAM'),
(78, 'GTM', 'GUATEMALA'),
(79, 'GUF', 'GUAYANA FRANCESA'),
(80, 'GGY', 'GUERNESEY'),
(81, 'GIN', 'GUINEA'),
(82, 'GNQ', 'GUINEA ECUATORIAL'),
(83, 'GNB', 'GUINEABISSEAU'),
(84, 'GUY', 'GUYANA'),
(85, 'HTI', 'HAITI'),
(86, 'HND', 'HONDURAS'),
(87, 'HMD', 'HONG KONG'),
(88, 'HUN', 'HUNGRIA'),
(89, 'IND', 'INDIA'),
(90, 'IDN', 'INDONESIA'),
(91, 'IRN', 'IRAN'),
(92, 'IRQ', 'IRAQ'),
(93, 'IRL', 'IRLANDA'),
(94, 'BVT', 'ISLA BOUVET'),
(95, 'IMN', 'ISLA DE MAN'),
(96, 'SGS', 'ISLA GEORGIAS Y SANDWICH DEL SUR'),
(97, 'MUS', 'ISLA MAURICIO'),
(98, 'NFK', 'ISLA NORFOLK'),
(99, 'SYC', 'ISLA SEYCHELLES'),
(100, 'TKL', 'ISLA TOKELAU'),
(101, 'ISL', 'ISLANDIA'),
(102, 'ALA', 'ISLAS ALAND'),
(103, 'CYM', 'ISLAS CAIMAN'),
(104, 'CCK', 'ISLAS COCOS (COCOS ISLANDS)'),
(105, 'COK', 'ISLAS COOK'),
(106, 'FRO', 'ISLAS DE FEROE'),
(107, 'CXR', 'ISLAS DE NAVIDAD'),
(108, 'HMD', 'ISLAS HEARD Y MCDONALD'),
(109, 'FLK', 'ISLAS MALVINAS'),
(110, 'MNP', 'ISLAS MARIANAS DEL NORTE'),
(111, 'MHL', 'ISLAS MARSHALL'),
(112, 'TCA', 'ISLAS TURCAS Y CAICOS'),
(113, 'UMI', 'ISLAS ULTRAMARINAS DE USA'),
(114, 'VGB', 'ISLAS VIRGENES BRITANICAS'),
(115, 'VIR', 'ISLAS VIRGENES de los ESTADOS UNIDOS'),
(117, 'ISR', 'ISRAEL'),
(118, 'ITA', 'ITALIA'),
(119, 'JAM', 'JAMAICA'),
(120, 'JPN', 'JAPON'),
(121, 'JEY', 'JERSEY'),
(122, 'JOR', 'JORDANIA'),
(123, 'KAZ', 'KAZAJSTAN'),
(124, 'KEN', 'KENIA'),
(125, 'KGE', 'KIRGUIZISTAN'),
(126, 'KIR', 'KIRIBATI'),
(127, 'KWT', 'KUWAIT'),
(128, 'LAO', 'LAOS'),
(129, 'LSO', 'LESOTO'),
(130, 'LVA', 'LETONIA'),
(131, 'LBN', 'LIBANO'),
(132, 'LBR', 'LIBERIA'),
(133, 'LBY', 'LIBIA'),
(134, 'LIE', 'LIECHTENSTEIN'),
(135, 'LTU', 'LITUANIA'),
(136, 'LUX', 'LUXEMBURGO'),
(137, 'MAC', 'MACAO'),
(138, 'MDG', 'MADAGASCAR'),
(139, 'MYS', 'MALASIA ORIENTALOCCIDENTAL'),
(140, 'MWI', 'MALAWI'),
(141, 'MDV', 'MALDIVAS (ISLAS)'),
(142, 'MLI', 'MALI'),
(143, 'MLT', 'MALTA'),
(144, 'MAR', 'MARRUECOS'),
(145, 'MTQ', 'MARTINICA'),
(146, 'MRT', 'MAURITANIA'),
(147, 'MYT', 'MAYOTE'),
(148, 'MEX', 'MEXICO'),
(149, 'FSM', 'MICRONESIA (FEDERACION ESTADOS)'),
(150, 'MDA', 'MOLDAVIA'),
(151, 'MCO', 'MONACO'),
(152, 'MNG', 'MONGOLIA'),
(153, 'MSR', 'MONTSERRAT'),
(154, 'MOZ', 'MOZAMBIQUE'),
(155, 'MMR', 'MYANMAR (BIRMANIA)'),
(156, 'NAM', 'NAMIBIA'),
(157, 'NRU', 'NAURU'),
(158, 'NPL', 'NEPAL'),
(159, 'NIC', 'NICARAGUA'),
(160, 'NER', 'NIGER'),
(161, 'NGA', 'NIGERIA'),
(162, 'NIU', 'NIUE'),
(163, 'NOR', 'NORUEGA'),
(164, 'NCL', 'NUEVA CALEDONIA'),
(165, 'NZL', 'NUEVA ZELANDA'),
(166, 'OMN', 'OMAN'),
(167, 'NLD', 'PAISES BAJOS (HOLANDA)'),
(168, 'PAK', 'PAKISTAN'),
(169, 'PLW', 'PALAU'),
(170, 'PAN', 'PANAMA'),
(171, 'PNG', 'PAPUANUEVA GUINEA'),
(172, 'PRY', 'PARAGUAY'),
(173, 'PER', 'PERU'),
(174, 'PCN', 'PITCAIRN ISLAS'),
(175, 'PYF', 'POLINESIA FRANCESA'),
(176, 'POL', 'POLONIA'),
(177, 'PRT', 'PORTUGAL'),
(178, 'PRI', 'PUERTO RICO'),
(179, 'QAT', 'QATAR'),
(180, 'GBR', 'REINO UNIDO'),
(181, 'SCG', 'REP.FED.YUGOESLAVIA SERBIA MONTENEGRO'),
(182, 'CPV', 'REPUBLICA CABO VERDE'),
(183, 'CAF', 'REPUBLICA CENTRO AFRICANA'),
(184, 'CZE', 'REPUBLICA CHECA'),
(185, 'DOM', 'REPUBLICA DOMINICANA'),
(186, 'SVK', 'REPUBLICA ESLOVACA'),
(187, 'RWA', 'RUANDA'),
(188, 'ROU', 'RUMANIA'),
(189, 'RUS', 'RUSIA'),
(190, 'SLB', 'SALOMON ISLAS'),
(191, 'WSM', 'SAMOA'),
(192, 'ASM', 'SAMOA AMERICANA'),
(193, 'KNA', 'SAN CRISTOBAL y NEVIS'),
(194, 'SMR', 'SAN MARINO'),
(195, 'SPM', 'SAN PEDRO y MIQUELON'),
(196, 'VCT', 'SAN VICENTE Y LAS GRANADINAS'),
(197, 'SHN', 'SANTA HELENA Y ASCENCION'),
(198, 'LCA', 'SANTA LUCIA'),
(199, 'STP', 'SANTO TOME Y PRINCIPE'),
(200, 'SEN', 'SENEGAL'),
(201, 'SLE', 'SIERRA LEONA'),
(202, 'SGP', 'SINGAPUR'),
(203, 'SYR', 'SIRIA'),
(204, 'SOM', 'SOMALIA'),
(205, 'LKA', 'SRI LANKA (CEILAN)'),
(206, 'SWZ', 'SUAZILANDIA'),
(207, 'ZAF', 'SUDAFRICA'),
(208, 'SDN', 'SUDAN'),
(209, 'SWE', 'SUECIA'),
(210, 'CHE', 'SUIZA'),
(211, 'SUR', 'SURINAN'),
(212, 'THA', 'TAILANDIA'),
(213, 'TWN', 'TAIWAN'),
(214, 'TZA', 'TANZANIA'),
(215, 'TJK', 'TAYIKISTAN'),
(216, 'IOT', 'TERRITORIO BRITANICO OCEANO INDICO'),
(217, 'TGO', 'TOGO'),
(218, 'TON', 'TONGA'),
(219, 'TTO', 'TRINIDAD Y TOBAGO'),
(220, 'TUN', 'TUNEZ'),
(221, 'TKM', 'TURKMENISTAN'),
(222, 'TUR', 'TURQUIA'),
(223, 'TUV', 'TUVALU (ISLAS ELLICE)'),
(224, 'UKR', 'UCRANIA'),
(225, 'UGA', 'UGANDA'),
(226, 'URY', 'URUGUAY'),
(227, 'UZB', 'UZBEKISTAN'),
(228, 'VUT', 'VANUATU'),
(229, 'VEN', 'VENEZUELA'),
(230, 'VNM', 'VIETNAM'),
(231, 'YEM', 'YEMEN'),
(232, 'DJI', 'YIBUTI'),
(233, 'COD', 'ZAIRE'),
(234, 'ZMB', 'ZAMBIA'),
(235, 'ZWE', 'ZIMBABUE');

-- --------------------------------------------------------

--
-- Table structure for table `preguntastest`
--

CREATE TABLE IF NOT EXISTS `preguntastest` (
  `ptest_id` int(3) NOT NULL AUTO_INCREMENT COMMENT 'Primaria de las preguntas del test',
  `ptest_preg` varchar(300) NOT NULL COMMENT 'Pregunta',
  `ptest_estado` varchar(30) NOT NULL COMMENT 'Activada o desactivada',
  PRIMARY KEY (`ptest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `profesiones`
--

CREATE TABLE IF NOT EXISTS `profesiones` (
  `prof_id` int(6) NOT NULL AUTO_INCREMENT,
  `prof_nombre` varchar(100) NOT NULL COMMENT 'Titulo de la profesión',
  `prof_resumen` text COMMENT 'Resumen de la profesión',
  `prof_detalle` text COMMENT 'Detalle de la profesión (cuerpo)',
  `prof_cantvistas` bigint(15) NOT NULL COMMENT 'Cantidad de veces vista',
  `prof_cantmegusta` int(7) NOT NULL COMMENT 'Cantidad de veces vista la profesion',
  `prof_fechaalta` datetime NOT NULL COMMENT 'Fecha que se le dio de alta',
  `prof_imagen` varchar(200) DEFAULT NULL COMMENT 'Ruta de la imagen',
  `suba_id` int(5) NOT NULL COMMENT 'Foranea a las subareas',
  PRIMARY KEY (`prof_id`),
  KEY `suba_id` (`suba_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `profesiones`
--

INSERT INTO `profesiones` (`prof_id`, `prof_nombre`, `prof_resumen`, `prof_detalle`, `prof_cantvistas`, `prof_cantmegusta`, `prof_fechaalta`, `prof_imagen`, `suba_id`) VALUES
(1, 'Analista en Sistemas', 'analista en sistemas informaticos', 'es el analisis y diseÃ±os de sistemas informaticos', 0, 0, '2013-06-16 18:58:53', NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `provincias`
--

CREATE TABLE IF NOT EXISTS `provincias` (
  `pro_id` int(7) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria Provincia',
  `pro_nombre` varchar(50) NOT NULL COMMENT 'Nombre de la Provincia',
  `pai_id` int(4) NOT NULL COMMENT 'Foranea al pais',
  PRIMARY KEY (`pro_id`),
  KEY `pai_id` (`pai_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=612 ;

--
-- Dumping data for table `provincias`
--

INSERT INTO `provincias` (`pro_id`, `pro_nombre`, `pai_id`) VALUES
(1, 'Aguascalientes', 148),
(2, '	Baja California	', 148),
(3, '	Baja California Sur	', 148),
(4, '	Campeche	', 148),
(5, '	Chiapas	', 148),
(6, '	Chihuahua	', 148),
(7, '	Coahuila de Zaragoza	', 148),
(8, '	Colima	', 148),
(9, '	Distrito Federal	', 148),
(10, '	Durango	', 148),
(11, '	Guanajuato	', 148),
(12, '	Guerrero	', 148),
(13, '	Hidalgo	', 148),
(14, '	Jalisco	', 148),
(15, '	México	', 148),
(16, '	Michoacán de Ocampo	', 148),
(17, '	Morelos	', 148),
(18, '	Nayarit	', 148),
(19, '	Nuevo León	', 148),
(20, '	Oaxaca	', 148),
(21, '	Puebla	', 148),
(22, '	Querétaro de Arteaga	', 148),
(23, '	Quintana Roo	', 148),
(24, '	San Luis Potosí	', 148),
(25, '	Sinaloa	', 148),
(26, '	Sonora	', 148),
(27, '	Tabasco	', 148),
(28, '	Tamaulipas	', 148),
(29, '	Tlaxcala	', 148),
(30, '	Veracruz-Llave	', 148),
(31, '	Yucatán	', 148),
(32, '	Zacatecas	', 148),
(33, '	Andalucía	', 60),
(34, '	Castilla y León	', 60),
(35, '	Castilla-La Mancha	', 60),
(36, '	Catalunya	', 60),
(37, '	Ceuta	', 60),
(38, '	Comunidad Autónoma de Aragón	', 60),
(39, '	Comunidad Autónoma de Canarias	', 60),
(40, '	Comunidad Autónoma de Cantabria	', 60),
(41, '	Comunidad de Madrid	', 60),
(42, '	Comunitat Autònoma de les Illes Balears	', 60),
(43, '	Comunitat Valenciana	', 60),
(44, '	Euskal Autonomia Erkidegoa	', 60),
(45, '	Extremadura	', 60),
(46, '	Galicia	', 60),
(47, '	La Rioja	', 60),
(48, '	Navarra	', 60),
(49, '	Principado de Asturias	', 60),
(50, '	Región de Murcia	', 60),
(51, '	Antioquia	', 43),
(52, '	Arauca	', 43),
(53, '	Bolívar	', 43),
(54, '	Boyacá	', 43),
(55, '	Caldas	', 43),
(56, '	Casanare	', 43),
(57, '	Córdoba	', 43),
(58, '	Cundinamarca	', 43),
(59, '	Departamento del Amazonas	', 43),
(60, '	Departamento del Atlántico	', 43),
(61, '	Departamento del Caquetá	', 43),
(62, '	Departamento del Cauca	', 43),
(63, '	Departamento del Cesar	', 43),
(64, '	Departamento del Chocó	', 43),
(65, '	Departamento del Guainía	', 43),
(66, '	Departamento del Guaviare	', 43),
(67, '	Departamento del Huila	', 43),
(68, '	Departamento del Magdalena	', 43),
(69, '	Departamento del Meta	', 43),
(70, '	Departamento del Putumayo	', 43),
(71, '	Departamento del Quindío	', 43),
(72, '	Departamento del Valle del Cauca	', 43),
(73, '	Departamento del Vaupés	', 43),
(74, '	Departamento del Vichada	', 43),
(75, '	Distrito Capital de Bogotá	', 43),
(76, '	La Guajira	', 43),
(77, '	Nariño	', 43),
(78, '	Norte de Santander	', 43),
(79, '	Providencia y Santa Catalina, Archipiélago de San', 43),
(80, '	Risaralda	', 43),
(81, '	Santander	', 43),
(82, '	Sucre	', 43),
(83, '	Tolima	', 43),
(84, '	Buenos Aires	', 12),
(85, '	Catamarca	', 12),
(86, '	Córdoba	', 12),
(87, '	Chaco	', 12),
(88, '	Chubut	', 12),
(89, '	Ciudad Autonóma de Buenos Aires	', 12),
(90, '	Corrientes	', 12),
(91, '	Entre Ríos	', 12),
(92, '	Formosa	', 12),
(93, '	Jujuy	', 12),
(94, '	La Pampa	', 12),
(95, '	La Rioja	', 12),
(96, '	Mendoza	', 12),
(97, '	Misiones	', 12),
(98, '	Neuquén	', 12),
(99, '	Río Negro	', 12),
(100, '	Salta	', 12),
(101, '	San Juan	', 12),
(102, '	San Luis	', 12),
(103, '	Santa Cruz	', 12),
(104, '	Santa Fe	', 12),
(105, '	Santiago del Estero	', 12),
(106, '	Tierra del Fuego	', 12),
(107, '	Tucumán	', 12),
(108, '	Amazonas	', 173),
(109, '	Ancash	', 173),
(110, '	Apurímac	', 173),
(111, '	Arequipa	', 173),
(112, '	Ayacucho	', 173),
(113, '	Cajamarca	', 173),
(114, '	Cusco	', 173),
(115, '	Huancavelica	', 173),
(116, '	Huánuco	', 173),
(117, '	Ica	', 173),
(118, '	Junín	', 173),
(119, '	La Libertad	', 173),
(120, '	Lambayeque	', 173),
(121, '	Lima	', 173),
(122, '	Loreto	', 173),
(123, '	Madre de Dios	', 173),
(124, '	Moquegua	', 173),
(125, '	Pasco	', 173),
(126, '	Piura	', 173),
(127, '	Provincia Constitucional del Callao	', 173),
(128, '	Provincia de Lima	', 173),
(129, '	Puno	', 173),
(130, '	San Martín	', 173),
(131, '	Tacna	', 173),
(132, '	Tumbes	', 173),
(133, '	Ucayali	', 173),
(134, '	Dependencias Federales	', 229),
(135, '	Distrito Federal	', 229),
(136, '	Estado Amazonas	', 229),
(137, '	Estado Anzoátegui	', 229),
(138, '	Estado Apure	', 229),
(139, '	Estado Aragua	', 229),
(140, '	Estado Barinas	', 229),
(141, '	Estado Bolívar	', 229),
(142, '	Estado Carabobo	', 229),
(143, '	Estado Cojedes	', 229),
(144, '	Estado Falcón	', 229),
(145, '	Estado Guárico	', 229),
(146, '	Estado Lara	', 229),
(147, '	Estado Mérida	', 229),
(148, '	Estado Miranda	', 229),
(149, '	Estado Monagas	', 229),
(150, '	Estado Nueva Esparta	', 229),
(151, '	Estado Portuguesa	', 229),
(152, '	Estado Sucre	', 229),
(153, '	Estado Táchira	', 229),
(154, '	Estado Trujillo	', 229),
(155, '	Estado Vargas	', 229),
(156, '	Estado Yaracuy	', 229),
(157, '	Estado Zulia	', 229),
(158, '	Territorio Federal Delta Amacuro	', 229),
(159, '	Región Aisén del General Carlos Ibáñez del Campo	', 39),
(160, '	Región de Antofagasta	', 39),
(161, '	Región de Arica y Parinacota	', 39),
(162, '	Región de Atacama	', 39),
(163, '	Región de Coquimbo	', 39),
(164, '	Región de la Araucanía	', 39),
(165, '	Región de Los Lagos	', 39),
(166, '	Región de Los Ríos	', 39),
(167, '	Región de Magallanes y de la Antártica Chilena	', 39),
(168, '	Región de Tarapacá	', 39),
(169, '	Región de Valparaíso	', 39),
(170, '	Región del Biobío	', 39),
(171, '	Región del Libertador General Bernardo O''Higgins	', 39),
(172, '	Región del Maule	', 39),
(173, '	Región Metropolitana de Santiago	', 39),
(174, '	Alta Verapaz	', 78),
(175, '	Baja Verapaz	', 78),
(176, '	Chimaltenango	', 78),
(177, '	Chiquimula	', 78),
(178, '	Departamento del Petén	', 78),
(179, '	Departamento del Quiché	', 78),
(180, '	El Progreso	', 78),
(181, '	Escuintla	', 78),
(182, '	Guatemala	', 78),
(183, '	Huehuetenango	', 78),
(184, '	Izabal	', 78),
(185, '	Jalapa	', 78),
(186, '	Jutiapa	', 78),
(187, '	Quetzaltenango	', 78),
(188, '	Retalhuleu	', 78),
(189, '	Sacatepéquez	', 78),
(190, '	San Marcos	', 78),
(191, '	Santa Rosa	', 78),
(192, '	Sololá	', 78),
(193, '	Suchitepéquez	', 78),
(194, '	Totonicapán	', 78),
(195, '	Zacapa	', 78),
(196, '	Provincia de Bolívar	', 54),
(197, '	Provincia de Cotopaxi	', 54),
(198, '	Provincia de El Oro	', 54),
(199, '	Provincia de Esmeraldas	', 54),
(200, '	Provincia de Francisco de Orellana	', 54),
(201, '	Provincia de Galápagos	', 54),
(202, '	Provincia de Imbabura	', 54),
(203, '	Provincia de Loja	', 54),
(204, '	Provincia de Los Ríos	', 54),
(205, '	Provincia de Manabí	', 54),
(206, '	Provincia de Morona Santiago	', 54),
(207, '	Provincia de Napo	', 54),
(208, '	Provincia de Pichincha	', 54),
(209, '	Provincia de Santa Elena	', 54),
(210, '	Provincia de Santo Domingo de los Tsáchilas	', 54),
(211, '	Provincia de Sucumbíos	', 54),
(212, '	Provincia de Zamora Chinchipe	', 54),
(213, '	Provincia del Azuay	', 54),
(214, '	Provincia del Cañar	', 54),
(215, '	Provincia del Carchi	', 54),
(216, '	Provincia del Chimborazo	', 54),
(217, '	Provincia del Guayas	', 54),
(218, '	Provincia del Pastaza	', 54),
(219, '	Provincia del Tungurahua	', 54),
(220, '	Municipio Especial Isla de la Juventud	', 51),
(221, '	Provincia de Camagüey	', 51),
(222, '	Provincia de Ciego de Ávila	', 51),
(223, '	Provincia de Cienfuegos	', 51),
(224, '	Provincia de Ciudad de La Habana	', 51),
(225, '	Provincia de Guantánamo	', 51),
(226, '	Provincia de Holguín	', 51),
(227, '	Provincia de La Habana	', 51),
(228, '	Provincia de Matanzas	', 51),
(229, '	Provincia de Pinar del Río	', 51),
(230, '	Provincia de Sancti Spíritus	', 51),
(231, '	Provincia de Santiago de Cuba	', 51),
(232, '	Provincia de Villa Clara	', 51),
(233, '	Provincia Granma	', 51),
(234, '	Puerto Padre	', 51),
(235, '	Chuquisaca	', 27),
(236, '	Cochabamba	', 27),
(237, '	Departamento del Beni	', 27),
(238, '	La Paz	', 27),
(239, '	Oruro	', 27),
(240, '	Pando	', 27),
(241, '	Potosí	', 27),
(242, '	Santa Cruz	', 27),
(243, '	Tarija	', 27),
(244, '	Distrito Nacional	', 185),
(245, '	Provincia de Azua	', 185),
(246, '	Provincia de Baoruco	', 185),
(247, '	Provincia de Barahona	', 185),
(248, '	Provincia de Dajabón	', 185),
(249, '	Provincia de El Seíbo	', 185),
(250, '	Provincia de Elías Piña	', 185),
(251, '	Provincia de Hato Mayor	', 185),
(252, '	Provincia de Independencia	', 185),
(253, '	Provincia de La Altagracia	', 185),
(254, '	Provincia de La Romana	', 185),
(255, '	Provincia de La Vega	', 185),
(256, '	Provincia de Monseñor Nouel	', 185),
(257, '	Provincia de Monte Cristi	', 185),
(258, '	Provincia de Monte Plata	', 185),
(259, '	Provincia de Pedernales	', 185),
(260, '	Provincia de Peravia	', 185),
(261, '	Provincia de Puerto Plata	', 185),
(262, '	Provincia de Salcedo	', 185),
(263, '	Provincia de Samaná	', 185),
(264, '	Provincia de San Cristóbal	', 185),
(265, '	Provincia de San José de Ocoa	', 185),
(266, '	Provincia de San Juan	', 185),
(267, '	Provincia de San Pedro de Macorís	', 185),
(268, '	Provincia de Santiago	', 185),
(269, '	Provincia de Santiago Rodríguez	', 185),
(270, '	Provincia de Santo Domingo	', 185),
(271, '	Provincia de Valverde	', 185),
(272, '	Provincia Duarte	', 185),
(273, '	Provincia Espaillat	', 185),
(274, '	Provincia María Trinidad Sánchez	', 185),
(275, '	Provincia Sánchez Ramírez	', 185),
(276, '	Atlántida	', 86),
(277, '	Choluteca	', 86),
(278, '	Colón	', 86),
(279, '	Comayagua	', 86),
(280, '	Copán	', 86),
(281, '	Cortés	', 86),
(282, '	Departmento de Francisco Morazán	', 86),
(283, '	Departmento de La Paz	', 86),
(284, '	El Paraíso	', 86),
(285, '	Gracias a Dios	', 86),
(286, '	Intibucá	', 86),
(287, '	Islas de la Bahía	', 86),
(288, '	Lempira	', 86),
(289, '	Ocotepeque	', 86),
(290, '	Olancho	', 86),
(291, '	Santa Bárbara	', 86),
(292, '	Valle	', 86),
(293, '	Yoro	', 86),
(294, '	Ahuachapán	', 56),
(295, '	Cabañas	', 56),
(296, '	Chalatenango	', 56),
(297, '	Cuscatlán	', 56),
(298, '	La Libertad	', 56),
(299, '	La Paz	', 56),
(300, '	La Unión	', 56),
(301, '	Morazán	', 56),
(302, '	San Miguel	', 56),
(303, '	San Salvador	', 56),
(304, '	San Vicente	', 56),
(305, '	Santa Ana	', 56),
(306, '	Sonsonate	', 56),
(307, '	Usulután	', 56),
(308, '	Alto Paraguay	', 172),
(309, '	Asunción	', 172),
(310, '	Ñeembucú	', 172),
(311, '	Boquerón	', 172),
(312, '	Caaguazú	', 172),
(313, '	Caazapá	', 172),
(314, '	Canindeyú	', 172),
(315, '	Concepción	', 172),
(316, '	Departamento Central	', 172),
(317, '	Departamento del Alto Paraná	', 172),
(318, '	Departamento del Amambay	', 172),
(319, '	Departamento del Guairá	', 172),
(320, '	Itapúa	', 172),
(321, '	la Cordillera	', 172),
(322, '	Misiones	', 172),
(323, '	Paraguarí	', 172),
(324, '	Presidente Hayes	', 172),
(325, '	San Pedro	', 172),
(326, '	Boaco	', 159),
(327, '	Carazo	', 159),
(328, '	Chinandega	', 159),
(329, '	Chontales	', 159),
(330, '	Estelí	', 159),
(331, '	Granada	', 159),
(332, '	Jinotega	', 159),
(333, '	León	', 159),
(334, '	Madriz	', 159),
(335, '	Managua	', 159),
(336, '	Masaya	', 159),
(337, '	Matagalpa	', 159),
(338, '	Nueva Segovia	', 159),
(339, '	Río San Juan	', 159),
(340, '	Región Autónoma Atlántico Norte	', 159),
(341, '	Región Autónoma Atlántico Sur	', 159),
(342, '	Rivas	', 159),
(343, '	Provincia de Alajuela	', 49),
(344, '	Provincia de Cartago	', 49),
(345, '	Provincia de Guanacaste	', 49),
(346, '	Provincia de Heredia	', 49),
(347, '	Provincia de Limón	', 49),
(348, '	Provincia de Puntarenas	', 49),
(349, '	Provincia de San José	', 49),
(350, '	Añasco	', 178),
(351, '	Adjuntas	', 178),
(352, '	Aguada	', 178),
(353, '	Aguadilla	', 178),
(354, '	Aguas Buenas	', 178),
(355, '	Aibonito	', 178),
(356, '	Arecibo	', 178),
(357, '	Arroyo	', 178),
(358, '	Barceloneta	', 178),
(359, '	Barranquitas	', 178),
(360, '	San Juan	', 178),
(361, '	Comarca de San Blas	', 170),
(362, '	Provincia de Bocas del Toro	', 170),
(363, '	Provincia de Chiriquí	', 170),
(364, '	Provincia de Coclé	', 170),
(365, '	Provincia de Colón	', 170),
(366, '	Provincia de Herrera	', 170),
(367, '	Provincia de Los Santos	', 170),
(368, '	Provincia de Panamá	', 170),
(369, '	Provincia de Veraguas	', 170),
(370, '	Provincia del Darién	', 170),
(371, '	Artigas	', 226),
(372, '	Canelones	', 226),
(373, '	Cerro Largo	', 226),
(374, '	Colonia	', 226),
(375, '	Durazno	', 226),
(376, '	Flores	', 226),
(377, '	Florida	', 226),
(378, '	Lavalleja	', 226),
(379, '	Maldonado	', 226),
(380, '	Montevideo	', 226),
(381, '	Paysandú	', 226),
(382, '	Río Negro	', 226),
(383, '	Rivera	', 226),
(384, '	Rocha	', 226),
(385, '	Salto	', 226),
(386, '	San José	', 226),
(387, '	Soriano	', 226),
(388, '	Tacuarembó	', 226),
(389, '	Treinta y Tres	', 226),
(390, '	Provincia de Annobón	', 82),
(391, '	Provincia de Bioko Norte	', 82),
(392, '	Provincia de Bioko Sur	', 82),
(393, '	Provincia de Centro Sur	', 82),
(394, '	Provincia de Kié-Ntem	', 82),
(395, '	Provincia de Litoral	', 82),
(396, '	Provincia de Wele-Nzas	', 82),
(397, '	Angeles City	', 65),
(398, '	Antipolo	', 65),
(399, '	Bacolod City	', 65),
(400, '	Bago City	', 65),
(401, '	Baguio City	', 65),
(402, '	Bais City	', 65),
(403, '	Batangas City	', 65),
(404, '	Butuan City	', 65),
(405, '	Cabanatuan City	', 65),
(406, '	Cadiz City	', 65),
(407, '	Calbayog City	', 65),
(408, '	Caloocan City	', 65),
(409, '	Canlaon City	', 65),
(410, '	Cavite City	', 65),
(411, '	Cebu City	', 65),
(412, '	City of Malaybalay	', 65),
(413, '	City of Manila	', 65),
(414, '	Cotabato City	', 65),
(415, '	Dagupan City	', 65),
(416, '	Danao City	', 65),
(417, '	Dapitan City	', 65),
(418, '	Davao City	', 65),
(419, '	Dipolog City	', 65),
(420, '	Dumaguete City	', 65),
(421, '	General Santos City	', 65),
(422, '	Gingoog City	', 65),
(423, '	Iloilo City	', 65),
(424, '	Iriga City	', 65),
(425, '	La Carlota City	', 65),
(426, '	Laoag City	', 65),
(427, '	Lapu-Lapu City	', 65),
(428, '	Legaspi City	', 65),
(429, '	Lipa City	', 65),
(430, '	Lucena City	', 65),
(431, '	Makati City	', 65),
(432, '	Mandaluyong	', 65),
(433, '	Mandaue City	', 65),
(434, '	Marawi City	', 65),
(435, '	Marikina	', 65),
(436, '	Mountain Province	', 65),
(437, '	Naga City	', 65),
(438, '	Olongapo City	', 65),
(439, '	Ormoc City	', 65),
(440, '	Oroquieta City	', 65),
(441, '	Ozamis City	', 65),
(442, '	Pagadian City	', 65),
(443, '	Palayan City	', 65),
(444, '	Pasay City	', 65),
(445, '	Pasig	', 65),
(446, '	Province of  Zamboanga del Sur	', 65),
(447, '	Province of Abra	', 65),
(448, '	Province of Agusan del Norte	', 65),
(449, '	Province of Agusan del Sur	', 65),
(450, '	Province of Aklan	', 65),
(451, '	Province of Albay	', 65),
(452, '	Province of Antique	', 65),
(453, '	Province of Aurora	', 65),
(454, '	Province of Basilan	', 65),
(455, '	Province of Bataan	', 65),
(456, '	Province of Batanes	', 65),
(457, '	Province of Batangas	', 65),
(458, '	Province of Benguet	', 65),
(459, '	Province of Bohol	', 65),
(460, '	Province of Bukidnon	', 65),
(461, '	Province of Bulacan	', 65),
(462, '	Province of Cagayan	', 65),
(463, '	Province of Camarines Norte	', 65),
(464, '	Province of Camarines Sur	', 65),
(465, '	Province of Camiguin	', 65),
(466, '	Province of Capiz	', 65),
(467, '	Province of Catanduanes	', 65),
(468, '	Province of Cavite	', 65),
(469, '	Province of Cebu	', 65),
(470, '	Province of Davao del Norte	', 65),
(471, '	Province of Davao del Sur	', 65),
(472, '	Province of Davao Oriental	', 65),
(473, '	Province of Eastern Samar	', 65),
(474, '	Province of Ifugao	', 65),
(475, '	Province of Ilocos Norte	', 65),
(476, '	Province of Ilocos Sur	', 65),
(477, '	Province of Iloilo	', 65),
(478, '	Province of Isabela	', 65),
(479, '	Province of Kalinga-Apayao	', 65),
(480, '	Province of La Union	', 65),
(481, '	Province of Laguna	', 65),
(482, '	Province of Lanao del Sur	', 65),
(483, '	Province of Leyte	', 65),
(484, '	Province of Maguindanao	', 65),
(485, '	Province of Marinduque	', 65),
(486, '	Province of Masbate	', 65),
(487, '	Province of Mindoro Occidental	', 65),
(488, '	Province of Mindoro Oriental	', 65),
(489, '	Province of Misamis Occidental	', 65),
(490, '	Province of Misamis Oriental	', 65),
(491, '	Province of Negros Occidental	', 65),
(492, '	Province of Negros Oriental	', 65),
(493, '	Province of North Cotabato	', 65),
(494, '	Province of Northern Samar	', 65),
(495, '	Province of Nueva Ecija	', 65),
(496, '	Province of Nueva Vizcaya	', 65),
(497, '	Province of Palawan	', 65),
(498, '	Province of Pampanga	', 65),
(499, '	Province of Pangasinan	', 65),
(500, '	Province of Quezon	', 65),
(501, '	Province of Quirino	', 65),
(502, '	Province of Rizal	', 65),
(503, '	Province of Romblon	', 65),
(504, '	Province of Samar	', 65),
(505, '	Province of Siquijor	', 65),
(506, '	Province of Sorsogon	', 65),
(507, '	Province of South Cotabato	', 65),
(508, '	Province of Southern Leyte	', 65),
(509, '	Province of Sultan Kudarat	', 65),
(510, '	Province of Sulu	', 65),
(511, '	Province of Surigao del Norte	', 65),
(512, '	Province of Surigao del Sur	', 65),
(513, '	Province of Tarlac	', 65),
(514, '	Province of Tawi-Tawi	', 65),
(515, '	Province of Zambales	', 65),
(516, '	Province of Zamboanga del Norte	', 65),
(517, '	Puerto Princesa City	', 65),
(518, '	Quezon City	', 65),
(519, '	Roxas City	', 65),
(520, '	San Carlos City	', 65),
(521, '	San Carlos City	', 65),
(522, '	San Jose City	', 65),
(523, '	San Juan	', 65),
(524, '	San Pablo City	', 65),
(525, '	Silay City	', 65),
(526, '	Surigao City	', 65),
(527, '	Tacloban City	', 65),
(528, '	Tagaytay City	', 65),
(529, '	Tagbilaran City	', 65),
(530, '	Tangub City	', 65),
(531, '	Toledo City	', 65),
(532, '	Trece Martires City	', 65),
(533, '	Zamboanga City	', 65),
(534, '	Alabama	', 61),
(535, '	Alaska	', 61),
(536, '	Arizona	', 61),
(537, '	Arkansas	', 61),
(538, '	California	', 61),
(539, '	Colorado	', 61),
(540, '	Connecticut	', 61),
(541, '	Delaware	', 61),
(542, '	Florida	', 61),
(543, '	Georgia	', 61),
(544, '	Hawaii	', 61),
(545, '	Idaho	', 61),
(546, '	Illinois	', 61),
(547, '	Indiana	', 61),
(548, '	Iowa	', 61),
(549, '	Kansas	', 61),
(550, '	Kentucky	', 61),
(551, '	Louisiana	', 61),
(552, '	Maine	', 61),
(553, '	Maryland	', 61),
(554, '	Massachusetts	', 61),
(555, '	Michigan	', 61),
(556, '	Minnesota	', 61),
(557, '	Mississippi	', 61),
(558, '	Missouri	', 61),
(559, '	Montana	', 61),
(560, '	Nebraska	', 61),
(561, '	Nevada	', 61),
(562, '	New Hampshire	', 61),
(563, '	New Jersey	', 61),
(564, '	New Mexico	', 61),
(565, '	New York	', 61),
(566, '	North Carolina	', 61),
(567, '	North Dakota	', 61),
(568, '	of Columbia	', 61),
(569, '	Ohio	', 61),
(570, '	Oklahoma	', 61),
(571, '	Oregon	', 61),
(572, '	Pennsylvania	', 61),
(573, '	Rhode Island	', 61),
(574, '	South Carolina	', 61),
(575, '	South Dakota	', 61),
(576, '	Tennessee	', 61),
(577, '	Texas	', 61),
(578, '	Utah	', 61),
(579, '	Vermont	', 61),
(580, '	Virginia	', 61),
(581, '	Washington	', 61),
(582, '	West Virginia	', 61),
(583, '	Wisconsin	', 61),
(584, '	Wyoming	', 61),
(585, '	Acre	', 30),
(586, '	Alagoas	', 30),
(587, '	Amapá	', 30),
(588, '	Amazonas	', 30),
(589, '	Bahia	', 30),
(590, '	Ceará	', 30),
(591, '	Distrito Federal	', 30),
(592, '	Espírito Santo	', 30),
(593, '	Goiás	', 30),
(594, '	Maranhão	', 30),
(595, '	Mato Grosso	', 30),
(596, '	Mato Grosso do Sul	', 30),
(597, '	Minas Gerais	', 30),
(598, '	Paraíba	', 30),
(599, '	Parana	', 30),
(600, '	Pará	', 30),
(601, '	Pernambuco	', 30),
(602, '	Piauí	', 30),
(603, '	Rio de Janeiro	', 30),
(604, '	Rio Grande do Norte	', 30),
(605, '	Rio Grande do Sul	', 30),
(606, '	Rondônia	', 30),
(607, '	Roraima	', 30),
(608, '	Santa Catarina	', 30),
(609, '	São Paulo	', 30),
(610, '	Sergipe	', 30),
(611, '	Tocantins	', 30);

-- --------------------------------------------------------

--
-- Table structure for table `respuestastest`
--

CREATE TABLE IF NOT EXISTS `respuestastest` (
  `rtest_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'Primaria de las respuestas del test',
  `rtest_respuesta` varchar(300) NOT NULL COMMENT 'Respuestas posibles a las preguntas',
  `ptest_id` int(3) NOT NULL COMMENT 'Foranea a la pregunta que le corresponde a las respuestas',
  PRIMARY KEY (`rtest_id`),
  KEY `ptest_id` (`ptest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `resultadotest`
--

CREATE TABLE IF NOT EXISTS `resultadotest` (
  `test_id` bigint(15) NOT NULL COMMENT 'Compuesta foranea a cada test de cada usuario',
  `prof_id` int(10) NOT NULL COMMENT 'Compuesta foranea de profesiones',
  `rest_afinidad` float NOT NULL COMMENT 'Porcentaje de afinidad de cada usuario para cada una de todas las profesiones',
  PRIMARY KEY (`test_id`,`prof_id`),
  KEY `prof_id` (`prof_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `subareas`
--

CREATE TABLE IF NOT EXISTS `subareas` (
  `suba_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de subareas',
  `suba_nombre` varchar(50) NOT NULL COMMENT 'Nombre de la subarea',
  `suba_resumen` varchar(500) DEFAULT NULL COMMENT 'Resumen de la subarea',
  `suba_detalle` text COMMENT 'Detalle de la subarea',
  `suba_icono` text COMMENT 'Icono de la subarea',
  `are_id` int(4) NOT NULL COMMENT 'Foranea a las areas',
  PRIMARY KEY (`suba_id`),
  KEY `are_id` (`are_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `subareas`
--

INSERT INTO `subareas` (`suba_id`, `suba_nombre`, `suba_resumen`, `suba_detalle`, `suba_icono`, `are_id`) VALUES
(1, 'medicina', 'asd', 'asdad', NULL, 2),
(4, 'bioquimica', 'area medicas bioquimica', 'la medicina quimica', NULL, 2),
(5, 'Sistemas', 'sistemas informaticos', 'sistemas de computadora programacion', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `test_id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'Primaria del test',
  `usu_id` bigint(15) NOT NULL COMMENT 'Foranea al usuario que respondio el test',
  `test_estadoavance` int(4) NOT NULL COMMENT 'Id de la ultima pregunta que respondio',
  `test_fechainicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha que inicio el test',
  `test_fechafin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha que lo termino',
  PRIMARY KEY (`test_id`),
  KEY `usu_id` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `testimonios`
--

CREATE TABLE IF NOT EXISTS `testimonios` (
  `tio_id` bigint(15) NOT NULL AUTO_INCREMENT,
  `tio_titulo` varchar(100) NOT NULL COMMENT 'Titulo del testimonio',
  `tio_detalle` text COMMENT 'Detalle del testimonio',
  `tio_puntos` int(7) NOT NULL COMMENT 'Puntos del testimonio',
  `tio_cantidad` int(7) NOT NULL COMMENT 'Cantidad de veces que lo han puntuado. (para sacar estadisticas)',
  `tio_linkvideo` varchar(200) DEFAULT NULL COMMENT 'Link al video del testimonio',
  `tio_megusta` int(7) NOT NULL COMMENT 'Cantidad de me gusta que tiene el testimonio',
  `prof_id` int(6) NOT NULL COMMENT 'Foranea a las profesiones',
  `usu_id` bigint(15) NOT NULL COMMENT 'Foranea al usuario que posteo el testimonio',
  PRIMARY KEY (`tio_id`),
  KEY `prof_id` (`prof_id`,`usu_id`),
  KEY `usu_id` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tipotest`
--

CREATE TABLE IF NOT EXISTS `tipotest` (
  `tipt_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'Primaria del tipo de test',
  `tipt_nombre` varchar(100) NOT NULL COMMENT 'Nombre del test',
  `tipt_detalle` text NOT NULL COMMENT 'Informacion sobre ese tipo de test',
  `tipt_cantpreg` int(3) NOT NULL COMMENT 'Cantidad de preguntas que posee ese tipo de test',
  `tipt_fechacreac` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Fecha en que se introduce el test al sistema',
  PRIMARY KEY (`tipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tipousuarios`
--

CREATE TABLE IF NOT EXISTS `tipousuarios` (
  `tiu_id` int(3) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de tipo de usuario',
  `tiu_nombre` varchar(50) NOT NULL COMMENT 'Nombre del tipo de usuario',
  `tiu_estado` int(2) NOT NULL COMMENT 'Estado (1=Activado ó 0=Desactivado)',
  PRIMARY KEY (`tiu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `usu_id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de tabla',
  `usu_nombre` varchar(50) DEFAULT NULL COMMENT 'Nombre usuario',
  `usu_apellido` varchar(50) DEFAULT NULL COMMENT 'Apellido usuario',
  `usu_sexo` varchar(15) DEFAULT NULL COMMENT 'Sexo usuario',
  `usu_fechaNac` date DEFAULT NULL COMMENT 'Fecha nacimiento usuario',
  `usu_nombreUsuario` varchar(30) NOT NULL COMMENT 'Nombre de usuario en la web',
  `usu_email` varchar(100) NOT NULL COMMENT 'Mail del usuario',
  `usu_pass` varchar(50) NOT NULL COMMENT 'Password de su cuenta',
  `usu_fechaAlta` datetime NOT NULL COMMENT 'Fecha que se dio de alta',
  `usu_fechaBaja` datetime DEFAULT NULL COMMENT 'Fecha que se dio de baja',
  `usu_detalleProfesion` text COMMENT 'Solo para tipo de usuario profesional, que describa lo que hace.',
  `usu_visitasPerfil` int(7) NOT NULL COMMENT 'Contador visitas en perfil de usuario',
  `usu_avatar` varchar(200) DEFAULT NULL COMMENT 'Ruta de la imagen del avatar',
  `loc_id` bigint(15) DEFAULT NULL COMMENT 'Clave foranea de la localidad',
  `pai_id` int(4) DEFAULT NULL COMMENT 'Clave foranea al pais',
  `tiu_id` int(3) DEFAULT NULL COMMENT 'Clave foranea al tipo de usuario',
  `usu_activo` int(1) NOT NULL COMMENT '0=inactivo, 1=activo',
  PRIMARY KEY (`usu_id`),
  KEY `loc_id` (`loc_id`,`pai_id`,`tiu_id`),
  KEY `pai_id` (`pai_id`),
  KEY `tiu_id` (`tiu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`usu_id`, `usu_nombre`, `usu_apellido`, `usu_sexo`, `usu_fechaNac`, `usu_nombreUsuario`, `usu_email`, `usu_pass`, `usu_fechaAlta`, `usu_fechaBaja`, `usu_detalleProfesion`, `usu_visitasPerfil`, `usu_avatar`, `loc_id`, `pai_id`, `tiu_id`, `usu_activo`) VALUES
(2, NULL, NULL, NULL, NULL, 'fanqy', 'fanqyfanqy@hotmail.com', 'f1c86e54af7d48fd1d97a0da254a7955', '2013-06-12 00:00:00', NULL, NULL, 0, NULL, NULL, NULL, NULL, 1),
(3, NULL, NULL, NULL, NULL, 'electro', 'electrolivery@gmail.com', 'f1c86e54af7d48fd1d97a0da254a7955', '2013-06-12 01:42:59', NULL, NULL, 0, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usuprofesiones`
--

CREATE TABLE IF NOT EXISTS `usuprofesiones` (
  `prof_id` int(6) NOT NULL COMMENT 'Compuesta con foranea de la profesion',
  `usu_id` bigint(15) NOT NULL COMMENT 'Compuesta con la foranea del usuario',
  `upro_detalleprofesion` text COMMENT 'Detalle de la profesion',
  PRIMARY KEY (`prof_id`,`usu_id`),
  KEY `usu_id` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activacion`
--
ALTER TABLE `activacion`
  ADD CONSTRAINT `activacion_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`);

--
-- Constraints for table `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`com_respuesta`) REFERENCES `comentarios` (`com_id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`),
  ADD CONSTRAINT `comentarios_ibfk_3` FOREIGN KEY (`tio_id`) REFERENCES `testimonios` (`tio_id`);

--
-- Constraints for table `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`con_respuesta`) REFERENCES `consultas` (`con_id`),
  ADD CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`usu_idemisor`) REFERENCES `usuarios` (`usu_id`),
  ADD CONSTRAINT `consultas_ibfk_3` FOREIGN KEY (`usu_iddestino`) REFERENCES `usuarios` (`usu_id`);

--
-- Constraints for table `detalletest`
--
ALTER TABLE `detalletest`
  ADD CONSTRAINT `detalletest_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`test_id`),
  ADD CONSTRAINT `detalletest_ibfk_2` FOREIGN KEY (`ptest_id`) REFERENCES `preguntastest` (`ptest_id`),
  ADD CONSTRAINT `detalletest_ibfk_3` FOREIGN KEY (`rtest_id`) REFERENCES `respuestastest` (`rtest_id`);

--
-- Constraints for table `detalletipotest`
--
ALTER TABLE `detalletipotest`
  ADD CONSTRAINT `detalletipotest_ibfk_1` FOREIGN KEY (`tipt_id`) REFERENCES `tipotest` (`tipt_id`),
  ADD CONSTRAINT `detalletipotest_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`test_id`),
  ADD CONSTRAINT `detalletipotest_ibfk_3` FOREIGN KEY (`ptest_id`) REFERENCES `preguntastest` (`ptest_id`);

--
-- Constraints for table `localidades`
--
ALTER TABLE `localidades`
  ADD CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `provincias` (`pro_id`);

--
-- Constraints for table `profesiones`
--
ALTER TABLE `profesiones`
  ADD CONSTRAINT `profesiones_ibfk_1` FOREIGN KEY (`suba_id`) REFERENCES `subareas` (`suba_id`);

--
-- Constraints for table `provincias`
--
ALTER TABLE `provincias`
  ADD CONSTRAINT `provincias_ibfk_1` FOREIGN KEY (`pai_id`) REFERENCES `paises` (`pai_id`);

--
-- Constraints for table `respuestastest`
--
ALTER TABLE `respuestastest`
  ADD CONSTRAINT `respuestastest_ibfk_1` FOREIGN KEY (`ptest_id`) REFERENCES `preguntastest` (`ptest_id`);

--
-- Constraints for table `resultadotest`
--
ALTER TABLE `resultadotest`
  ADD CONSTRAINT `resultadotest_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `profesiones` (`prof_id`),
  ADD CONSTRAINT `resultadotest_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`test_id`);

--
-- Constraints for table `subareas`
--
ALTER TABLE `subareas`
  ADD CONSTRAINT `subareas_ibfk_1` FOREIGN KEY (`are_id`) REFERENCES `areas` (`are_id`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`);

--
-- Constraints for table `testimonios`
--
ALTER TABLE `testimonios`
  ADD CONSTRAINT `testimonios_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `profesiones` (`prof_id`),
  ADD CONSTRAINT `testimonios_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tiu_id`) REFERENCES `tipousuarios` (`tiu_id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`pai_id`) REFERENCES `paises` (`pai_id`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`loc_id`) REFERENCES `localidades` (`loc_id`);

--
-- Constraints for table `usuprofesiones`
--
ALTER TABLE `usuprofesiones`
  ADD CONSTRAINT `usuprofesiones_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `profesiones` (`prof_id`),
  ADD CONSTRAINT `usuprofesiones_ibfk_2` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
