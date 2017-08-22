-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-07-2017 a las 21:42:40
-- Versión del servidor: 10.1.19-MariaDB
-- Versión de PHP: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tigrebdfinal`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `promedio_empleador` (IN `username` VARCHAR(30))  begin 
	declare responsabilidad int;
	declare trato int;
	declare final int;	
set trato=(select avg(trato_e) from elige where id_empleador=username);
set responsabilidad=(select avg(resp_e) from elige where id_empleador=username); 
set final = (trato+responsabilidad)/2;
UPDATE usuario SET usuario.reputacion_empleador=final where usuario.username=username;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `promedio_trabajador` (IN `username` VARCHAR(30))  begin 
	declare responsabilidad int;
	declare trato int;
    declare calidad int;
	declare final int;
set responsabilidad=(select avg(resp_t) from elige where id_trabajador=username);
set trato=(select avg(trato_t) from elige where id_trabajador=username);
set calidad=(select avg(calidad_t) from elige where id_trabajador=username);
set final= (trato+calidad+responsabilidad)/3;
update usuario set reputacion_trabajador=final where usuario.username=username;
	end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`nombre`) VALUES
('Diseño y multimedia'),
('Finanzas y administracion'),
('Mantenimiento'),
('Marketing y ventas'),
('Redaccion y contenidos'),
('TI y Programacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elige`
--

CREATE TABLE `elige` (
  `resp_t` int(11) DEFAULT NULL,
  `trato_t` int(11) DEFAULT NULL,
  `calidad_t` int(11) DEFAULT NULL,
  `resp_e` int(11) DEFAULT NULL,
  `trato_e` int(11) DEFAULT NULL,
  `id_trabajador` varchar(30) DEFAULT NULL,
  `id_empleador` varchar(30) DEFAULT NULL,
  `id_trabajo` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `elige`
--

INSERT INTO `elige` (`resp_t`, `trato_t`, `calidad_t`, `resp_e`, `trato_e`, `id_trabajador`, `id_empleador`, `id_trabajo`) VALUES
(5, 5, 5, 3, 2, 'Combs', 'Acosta', 41),
(5, 5, 5, 3, 2, 'Combs', 'Acosta', 41),
(5, 5, 5, 5, 3, 'Combs', 'Acosta', 42),
(5, 5, 5, 1, 3, 'Combs', 'Acosta', 43),
(2, 1, 3, 5, 5, 'Combs', 'Acosta', 44);

--
-- Disparadores `elige`
--
DELIMITER $$
CREATE TRIGGER `trigger calificacion` AFTER UPDATE ON `elige` FOR EACH ROW begin 
    if new.resp_e > 0 THEN 
    	call promedio_empleador(new.id_empleador);
     end if;
    if new.resp_t > 0 then 
    	call promedio_trabajador(new.id_trabajador);
        end if;
  end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleador`
--

CREATE TABLE `empleador` (
  `reputacion_e` int(11) DEFAULT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleador`
--

INSERT INTO `empleador` (`reputacion_e`, `username`) VALUES
(3, 'Acosta'),
(NULL, 'Allison'),
(NULL, 'Armenia'),
(NULL, 'Bolivia'),
(NULL, 'Burundi'),
(NULL, 'Clayton'),
(NULL, 'Combs'),
(NULL, 'Costa Rica'),
(NULL, 'Cyprus'),
(NULL, 'Dickson'),
(NULL, 'Doyle'),
(NULL, 'Ecuador'),
(NULL, 'Ferrell'),
(NULL, 'Ford'),
(NULL, 'Frazier'),
(NULL, 'Gamble'),
(NULL, 'Glenn'),
(NULL, 'Greece'),
(NULL, 'Greer'),
(NULL, 'Hart'),
(NULL, 'Hendrix'),
(NULL, 'Hernandez'),
(NULL, 'Hong Kong'),
(NULL, 'Hopkins'),
(NULL, 'James'),
(NULL, 'Japan'),
(NULL, 'Kline'),
(NULL, 'Koch'),
(NULL, 'Korea, South'),
(NULL, 'Luxembourg'),
(NULL, 'Madden'),
(NULL, 'Maldives'),
(NULL, 'MANDARIN'),
(NULL, 'Marshall Islands'),
(NULL, 'Massey'),
(NULL, 'Maxwell'),
(NULL, 'Mcfadden'),
(NULL, 'Mcfarland'),
(NULL, 'New Caledonia'),
(NULL, 'Nixon'),
(NULL, 'Payne'),
(NULL, 'Quinn'),
(NULL, 'Reilly'),
(NULL, 'Samoa'),
(NULL, 'San Marino'),
(NULL, 'Simmons'),
(NULL, 'Skinner'),
(NULL, 'Sosa'),
(NULL, 'Stone'),
(NULL, 'Sweden'),
(NULL, 'Terrell'),
(NULL, 'Uganda'),
(NULL, 'Weaver'),
(NULL, 'Webster'),
(NULL, 'Weiss'),
(NULL, 'White'),
(NULL, 'Williamson'),
(NULL, 'Woodward'),
(NULL, 'Young'),
(NULL, 'Zambia'),
(NULL, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especializado`
--

CREATE TABLE `especializado` (
  `subcategoria` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postula`
--

CREATE TABLE `postula` (
  `precio` int(11) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `id_trabajador` varchar(30) NOT NULL,
  `id_trabajo` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `postula`
--

INSERT INTO `postula` (`precio`, `descripcion`, `id_trabajador`, `id_trabajo`) VALUES
(12770, 'Hare el mejor trabajo posible', 'Allison', 41),
(12770, 'Hare el mejor trabajo posible', 'Allison', 41),
(12770, 'Hare el mejor trabajo posible', 'Combs', 41),
(12770, 'Hare el mejor trabajo posible', 'Combs', 41),
(1220, 'Puedo hacerlo!', 'Combs', 42),
(1220, 'Puedo hacerlo!', 'Combs', 42),
(20000, 'Soy el mejor candidato', 'Combs', 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultado`
--

CREATE TABLE `resultado` (
  `r` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `resultado`
--

INSERT INTO `resultado` (`r`) VALUES
(5),
(5),
(5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `categoria` varchar(30) DEFAULT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`categoria`, `nombre`) VALUES
('Diseño y multimedia', 'Animacion'),
('Diseño y multimedia', 'Creacion y edicion de videos'),
('Diseño y multimedia', 'Diseño 3D'),
('Diseño y multimedia', 'Diseño de app movil'),
('Diseño y multimedia', 'Diseño de logo'),
('Diseño y multimedia', 'Imagen corporativa'),
('Diseño y multimedia', 'Publicidad'),
('Redaccion y contenidos', 'Publicaciones para redes socia'),
('Redaccion y contenidos', 'Redaccion de contenidos'),
('Redaccion y contenidos', 'Redaccion para sitios web'),
('Redaccion y contenidos', 'Traduccion'),
('Redaccion y contenidos', 'Transcripcion y correccion'),
('TI y Programacion', 'Aplicaciones de escritorio'),
('TI y Programacion', 'Aplicaciones moviles'),
('TI y Programacion', 'Desarrollo de juegos'),
('TI y Programacion', 'Diseño web'),
('TI y Programacion', 'Programacion web'),
('TI y Programacion', 'Tiendas virtuales'),
('TI y Programacion', 'Wordpress');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `reputacion_t` int(11) DEFAULT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `trabajador`
--

INSERT INTO `trabajador` (`reputacion_t`, `username`) VALUES
(NULL, 'Acosta'),
(NULL, 'Allison'),
(NULL, 'Armenia'),
(NULL, 'Bolivia'),
(NULL, 'Burundi'),
(NULL, 'Clayton'),
(4, 'Combs'),
(NULL, 'Costa Rica'),
(NULL, 'Cyprus'),
(NULL, 'Dickson'),
(NULL, 'Doyle'),
(NULL, 'Ecuador'),
(NULL, 'Ferrell'),
(NULL, 'Ford'),
(NULL, 'Frazier'),
(NULL, 'Gamble'),
(NULL, 'Glenn'),
(NULL, 'Greece'),
(NULL, 'Greer'),
(NULL, 'Hart'),
(NULL, 'Hendrix'),
(NULL, 'Hernandez'),
(NULL, 'Hong Kong'),
(NULL, 'Hopkins'),
(NULL, 'James'),
(NULL, 'Japan'),
(NULL, 'Kline'),
(NULL, 'Koch'),
(NULL, 'Korea, South'),
(NULL, 'Luxembourg'),
(NULL, 'Madden'),
(NULL, 'Maldives'),
(NULL, 'MANDARIN'),
(NULL, 'Marshall Islands'),
(NULL, 'Massey'),
(NULL, 'Maxwell'),
(NULL, 'Mcfadden'),
(NULL, 'Mcfarland'),
(NULL, 'New Caledonia'),
(NULL, 'Nixon'),
(NULL, 'Payne'),
(NULL, 'Quinn'),
(NULL, 'Reilly'),
(NULL, 'Samoa'),
(NULL, 'San Marino'),
(NULL, 'Simmons'),
(NULL, 'Skinner'),
(NULL, 'Sosa'),
(NULL, 'Stone'),
(NULL, 'Sweden'),
(NULL, 'Terrell'),
(NULL, 'Uganda'),
(NULL, 'Weaver'),
(NULL, 'Webster'),
(NULL, 'Weiss'),
(NULL, 'White'),
(NULL, 'Williamson'),
(NULL, 'Woodward'),
(NULL, 'Young'),
(NULL, 'Zambia'),
(NULL, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajo`
--

CREATE TABLE `trabajo` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_empleador` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(600) NOT NULL,
  `presupuesto` int(11) NOT NULL,
  `fecha_creado` date NOT NULL,
  `ciudad` varchar(30) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `zona` varchar(30) NOT NULL,
  `categoria` varchar(30) NOT NULL,
  `subcategoria` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `trabajo`
--

INSERT INTO `trabajo` (`id`, `id_empleador`, `nombre`, `descripcion`, `presupuesto`, `fecha_creado`, `ciudad`, `estado`, `zona`, `categoria`, `subcategoria`) VALUES
(41, 'Acosta', 'Nulla interdum.', 'elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis', 12778, '2016-08-22', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(42, 'Acosta', 'id nunc', 'in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia', 17815, '2015-12-15', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(43, 'Acosta', 'amet ultricies', 'enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae', 18300, '2017-03-09', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(44, 'Acosta', 'ultrices sit', 'semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim', 9168, '2017-06-07', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(45, 'Acosta', 'est. Nunc', 'ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at,', 6252, '2015-12-29', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(46, 'Acosta', 'libero et', 'venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor', 6192, '2016-11-09', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(47, 'Acosta', 'nisi nibh', 'Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non', 7213, '2017-06-08', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(48, 'Acosta', 'Morbi non', 'Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui, in sodales', 1210, '2015-07-24', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(49, 'Acosta', 'a, facilisis', 'lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut', 19919, '2016-01-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(50, 'Acosta', 'fringilla euismod', 'enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae', 2745, '2017-02-01', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(51, 'Acosta', 'Nulla interdum.', 'elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis', 12778, '2016-08-22', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(52, 'Acosta', 'id nunc', 'in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia', 17815, '2015-12-15', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(53, 'Acosta', 'amet ultricies', 'enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae', 18300, '2017-03-09', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(54, 'Acosta', 'ultrices sit', 'semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim', 9168, '2017-06-07', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(55, 'Acosta', 'est. Nunc', 'ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at,', 6252, '2015-12-29', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(56, 'Acosta', 'libero et', 'venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor', 6192, '2016-11-09', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(57, 'Acosta', 'nisi nibh', 'Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non', 7213, '2017-06-08', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones de escritorio'),
(58, 'Acosta', 'Morbi non', 'Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui, in sodales', 1210, '2015-07-24', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(59, 'Acosta', 'a, facilisis', 'lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut', 19919, '2016-01-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(60, 'Acosta', 'fringilla euismod', 'enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae', 2745, '2017-02-01', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(61, 'Bolivia', 'sit amet', 'lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque.', 15184, '2016-06-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(62, 'Bolivia', 'ipsum. Phasellus', 'tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis', 4164, '2016-06-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(63, 'Bolivia', 'ac metus', 'dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum', 9524, '2016-04-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(64, 'Bolivia', 'cursus et,', 'nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In', 16096, '2015-10-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(65, 'Bolivia', 'mi pede,', 'vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis', 9815, '2015-10-29', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(66, 'Bolivia', 'est. Nunc', 'placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada', 14096, '2017-01-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(67, 'Bolivia', 'at lacus.', 'dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.', 8393, '2016-09-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(68, 'Bolivia', 'metus. In', 'vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur', 6720, '2016-07-28', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(69, 'Bolivia', 'gravida non,', 'non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam', 8850, '2016-09-04', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(70, 'Bolivia', 'sit amet', 'nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum.', 13286, '2016-08-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(71, 'Bolivia', 'sit amet', 'lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque.', 15184, '2016-06-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(72, 'Bolivia', 'ipsum. Phasellus', 'tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis', 4164, '2016-06-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(73, 'Bolivia', 'ac metus', 'dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum', 9524, '2016-04-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(74, 'Bolivia', 'cursus et,', 'nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In', 16096, '2015-10-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Aplicaciones moviles'),
(75, 'Bolivia', 'mi pede,', 'vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis', 9815, '2015-10-29', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(76, 'Bolivia', 'est. Nunc', 'placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada', 14096, '2017-01-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(77, 'Bolivia', 'at lacus.', 'dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.', 8393, '2016-09-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(78, 'Bolivia', 'metus. In', 'vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur', 6720, '2016-07-28', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(79, 'Bolivia', 'gravida non,', 'non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam', 8850, '2016-09-04', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(80, 'Bolivia', 'sit amet', 'nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum.', 13286, '2016-08-30', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(81, 'Cyprus', 'magna. Cras', 'turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio', 10413, '2017-07-04', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(82, 'Cyprus', 'scelerisque neque', 'a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem,', 2130, '2017-01-08', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(83, 'Cyprus', 'urna et', 'massa. Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor', 7134, '2016-10-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(84, 'Cyprus', 'parturient montes,', 'ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam', 4780, '2016-04-11', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(85, 'Cyprus', 'vitae erat', 'dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at,', 10853, '2015-08-10', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(86, 'Cyprus', 'nec, imperdiet', 'Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac', 12281, '2016-12-28', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(87, 'Cyprus', 'Suspendisse sagittis.', 'arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus.', 14409, '2016-11-11', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(88, 'Cyprus', 'ligula. Aliquam', 'Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est.', 18622, '2017-06-19', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(89, 'Cyprus', 'nibh enim,', 'placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class', 8736, '2017-02-01', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(90, 'Cyprus', 'non, feugiat', 'morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam', 19856, '2015-11-15', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(91, 'Cyprus', 'magna. Cras', 'turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio', 10413, '2017-07-04', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Desarrollo de juegos'),
(92, 'Cyprus', 'scelerisque neque', 'a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem,', 2130, '2017-01-08', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(93, 'Cyprus', 'urna et', 'massa. Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor', 7134, '2016-10-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(94, 'Cyprus', 'parturient montes,', 'ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam', 4780, '2016-04-11', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(95, 'Cyprus', 'vitae erat', 'dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at,', 10853, '2015-08-10', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(96, 'Cyprus', 'nec, imperdiet', 'Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac', 12281, '2016-12-28', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(97, 'Cyprus', 'Suspendisse sagittis.', 'arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus.', 14409, '2016-11-11', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(98, 'Cyprus', 'ligula. Aliquam', 'Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est.', 18622, '2017-06-19', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Diseño web'),
(99, 'Cyprus', 'nibh enim,', 'placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class', 8736, '2017-02-01', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(100, 'Cyprus', 'non, feugiat', 'morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam', 19856, '2015-11-15', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(101, 'Dickson', 'odio vel', 'Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum.', 15959, '2016-03-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(102, 'Dickson', 'Nunc sollicitudin', 'Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna.', 9879, '2017-06-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(103, 'Dickson', 'pretium et,', 'augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent', 6100, '2016-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(104, 'Dickson', 'Cras vehicula', 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris', 19547, '2016-08-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(105, 'Dickson', 'Nam porttitor', 'erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu', 5894, '2016-06-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(106, 'Dickson', 'turpis nec', 'non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante', 4918, '2016-08-31', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(107, 'Dickson', 'amet ante.', 'et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,', 9536, '2017-05-21', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(108, 'Dickson', 'sagittis placerat.', 'Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis.', 7200, '2017-03-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(109, 'Dickson', 'senectus et', 'at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus', 11453, '2016-07-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(110, 'Dickson', 'ante. Maecenas', 'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim.', 2373, '2015-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(111, 'Dickson', 'odio vel', 'Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum.', 15959, '2016-03-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(112, 'Dickson', 'Nunc sollicitudin', 'Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna.', 9879, '2017-06-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(113, 'Dickson', 'pretium et,', 'augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent', 6100, '2016-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(114, 'Dickson', 'Cras vehicula', 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris', 19547, '2016-08-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(115, 'Dickson', 'Nam porttitor', 'erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu', 5894, '2016-06-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(116, 'Dickson', 'turpis nec', 'non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante', 4918, '2016-08-31', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(117, 'Dickson', 'amet ante.', 'et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,', 9536, '2017-05-21', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(118, 'Dickson', 'sagittis placerat.', 'Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis.', 7200, '2017-03-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(119, 'Dickson', 'senectus et', 'at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus', 11453, '2016-07-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(120, 'Dickson', 'ante. Maecenas', 'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim.', 2373, '2015-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(121, 'Dickson', 'odio vel', 'Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum.', 15959, '2016-03-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(122, 'Dickson', 'Nunc sollicitudin', 'Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna.', 9879, '2017-06-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(123, 'Dickson', 'pretium et,', 'augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent', 6100, '2016-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(124, 'Dickson', 'Cras vehicula', 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris', 19547, '2016-08-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(125, 'Dickson', 'Nam porttitor', 'erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu', 5894, '2016-06-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(126, 'Dickson', 'turpis nec', 'non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante', 4918, '2016-08-31', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(127, 'Dickson', 'amet ante.', 'et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,', 9536, '2017-05-21', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(128, 'Dickson', 'sagittis placerat.', 'Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis.', 7200, '2017-03-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(129, 'Dickson', 'senectus et', 'at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus', 11453, '2016-07-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(130, 'Dickson', 'ante. Maecenas', 'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim.', 2373, '2015-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(131, 'Dickson', 'odio vel', 'Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum.', 15959, '2016-03-20', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(132, 'Dickson', 'Nunc sollicitudin', 'Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna.', 9879, '2017-06-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(133, 'Dickson', 'pretium et,', 'augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent', 6100, '2016-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(134, 'Dickson', 'Cras vehicula', 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris', 19547, '2016-08-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(135, 'Dickson', 'Nam porttitor', 'erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu', 5894, '2016-06-14', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Programacion web'),
(136, 'Dickson', 'turpis nec', 'non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante', 4918, '2016-08-31', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(137, 'Dickson', 'amet ante.', 'et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,', 9536, '2017-05-21', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(138, 'Dickson', 'sagittis placerat.', 'Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis.', 7200, '2017-03-18', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(139, 'Dickson', 'senectus et', 'at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus', 11453, '2016-07-27', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales'),
(140, 'Dickson', 'ante. Maecenas', 'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim.', 2373, '2015-09-17', 'pzo', 'bolivar', 'Caura', 'TI y Programacion', 'Tiendas virtuales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `estado` varchar(30) NOT NULL,
  `ciudad` varchar(30) NOT NULL,
  `zona` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`estado`, `ciudad`, `zona`) VALUES
('bolivar', 'pzo', 'Caura'),
('bolivar', 'pzo', 'Centro Civico'),
('bolivar', 'pzo', 'Coreo 8'),
('bolivar', 'pzo', 'Guamo'),
('bolivar', 'pzo', 'Jardin Levante'),
('bolivar', 'pzo', 'Las garzas'),
('bolivar', 'pzo', 'Los olivos'),
('bolivar', 'pzo', 'UCAB Guayana'),
('bolivar', 'pzo', 'Unare 2'),
('bolivar', 'pzo', 'Villa Asia'),
('bolivar', 'pzo', 'Villa Granada'),
('bolivar', 'pzo', 'Villa ikavaru'),
('bolivar', 'san felix', 'Casa Familia aurea'),
('bolivar', 'san felix', 'Doña Barbara'),
('bolivar', 'san felix', 'El gallo'),
('bolivar', 'san felix', 'Guaiparo'),
('bolivar', 'san felix', 'Los alacranes'),
('bolivar', 'san felix', 'Manoa'),
('bolivar', 'san felix', 'Nueva chirica'),
('bolivar', 'san felix', 'Vista al son');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `username` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `telefono` bigint(20) DEFAULT NULL,
  `contrasena` varchar(30) NOT NULL,
  `ciudad` varchar(30) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `zona` varchar(30) NOT NULL,
  `reputacion_trabajador` int(11) UNSIGNED DEFAULT '0',
  `reputacion_empleador` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `categoria` varchar(30) DEFAULT NULL,
  `subcategoria` int(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`username`, `nombre`, `apellido`, `email`, `telefono`, `contrasena`, `ciudad`, `estado`, `zona`, `reputacion_trabajador`, `reputacion_empleador`, `categoria`, `subcategoria`) VALUES
('Acosta', 'Raphael', 'Griffith', 'dictum@egestas.ca', 353236720, 'HLF91EGR3OX', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Allison', 'Jesse', 'Tyrone', 'tellus@aliquamadipiscing.co.uk', 676762257, 'BSR74XQK6MP', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Armenia', 'Akeem', 'Garth', 'odio.Phasellus.at@montesnascet', 858923953, 'PCI07WZR3FU', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Bolivia', 'Leroy', 'Chantale', 'lorem@vitae.com', 688536150, 'VYQ36HHG2JN', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Burundi', 'Shelby', 'Darryl', 'elit.fermentum.risus@atpretium', 649185472, 'INP18EOU7XQ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Clayton', 'Levi', 'Gil', 'mattis@necdiamDuis.com', 668815501, 'SNA42BCC0UF', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Combs', 'Raphael', 'Amos', 'odio@urnaet.ca', 628270678, 'a123456789z', 'pzo', 'bolivar', 'Caura', 4, 0, NULL, NULL),
('Costa Rica', 'Violet', 'Herman', 'volutpat.Nulla.dignissim@accum', 339421871, 'SOG99WIU1TI', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Cyprus', 'Irma', 'Ocean', 'viverra@eterosProin.co.uk', 640559547, 'RFY66TDU4PG', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Dickson', 'Louis', 'Dalton', 'cursus.diam@adlitora.org', 524323144, 'IGM44IBT0WT', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Doyle', 'Charles', 'Vladimir', 'faucibus.id.libero@atvelit.co.', 113396041, 'WAS41NGE7NT', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Ecuador', 'Emmanuel', 'Damon', 'enim@luctusvulputatenisi.net', 480425754, 'VCO09OAS9ZG', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Ferrell', 'Daquan', 'Cruz', 'a.purus.Duis@tinciduntnunc.org', 427066067, 'DVH45ERG5DW', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Ford', 'Ezra', 'Tarik', 'nunc@porttitor.com', 472473336, 'KSM66DHP6NA', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Frazier', 'Vladimir', 'Kermit', 'adipiscing@felispurusac.com', 875682369, 'BNO17KDW0KD', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Gamble', 'Austin', 'Levi', 'Mauris.nulla@temporarcuVestibu', 248021013, 'BEC99XTY4NI', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Glenn', 'Deacon', 'Eagan', 'dis.parturient.montes@eratSedn', 531120588, 'KXU93HTS6JF', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Greece', 'Cade', 'Nicholas', 'eleifend.egestas.Sed@acipsumPh', 802321299, 'WGO23SNB4DL', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Greer', 'Lars', 'Carlos', 'mus@risusvariusorci.edu', 476418516, 'IQV26JIF6DD', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Hart', 'Tiger', 'Oscar', 'ipsum.dolor@risus.edu', 55424786, 'XKR59ZEZ4JO', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Hendrix', 'Drake', 'Jackson', 'nec.tellus.Nunc@penatibuset.co', 516391659, 'ANV39SLL9QA', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Hernandez', 'Jesse', 'Macaulay', 'dolor.egestas.rhoncus@urnaconv', 533915305, 'QPV78SAI0OH', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Hong Kong', 'Winifred', 'Hayfa', 'morbi@nec.edu', 565462966, 'ZFQ56LKP8SR', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Hopkins', 'Palmer', 'Acton', 'ridiculus.mus.Proin@velit.ca', 55584192, 'DTB03GER7PG', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('James', 'Maxwell', 'Elijah', 'diam.nunc@necleo.ca', 164045129, 'DSY35NZK1IV', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Japan', 'Rinah', 'Charlotte', 'ligula.Aliquam@duinec.org', 193322055, 'FFC18UDU2DG', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Kline', 'Kareem', 'Ivor', 'sed.leo@eu.edu', 440695233, 'DCH32TOB7LH', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Koch', 'Sebastian', 'Eric', 'ac.mattis.velit@ornareIn.co.uk', 999036445, 'TUF77QHQ2UK', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Korea, South', 'Hayes', 'Dale', 'vulputate.posuere.vulputate@Do', 36402160, 'OXZ82LCP8DZ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Luxembourg', 'Martina', 'Arsenio', 'magna@estNunc.org', 545072425, 'AJW31EQF1IN', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Madden', 'Dean', 'Arthur', 'netus@egestasAliquam.edu', 507398738, 'TAE25DLJ9FM', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Maldives', 'Brielle', 'Edan', 'lorem.auctor@non.org', 8653379, 'EEO82GKQ9VH', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('MANDARIN', 'PRUEBA', 'PRUEBA', 'dictum@egestas.ca', 353236720, 'HLF91EGR3OX', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Marshall Islands', 'Freya', 'Barrett', 'vitae.posuere@vulputatelacusCr', 937314760, 'DFJ54NDZ8WQ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Massey', 'Alvin', 'Zeph', 'Fusce.aliquam@incursus.co.uk', 137072454, 'DAD42CPY4UE', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Maxwell', 'Reece', 'Lee', 'purus@tortor.com', 410419022, 'GJJ52ULQ2CK', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Mcfadden', 'Carlos', 'Neil', 'amet@Loremipsumdolor.net', 471755090, 'PSG60VPJ4OT', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Mcfarland', 'Nolan', 'Gregory', 'gravida.molestie.arcu@amet.edu', 172136620, 'EWX47GOX5WI', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('New Caledonia', 'Inez', 'Sarah', 'enim.consequat@dignissimlacusA', 745982891, 'JVH80SUA5SE', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Nixon', 'Jacob', 'Coby', 'egestas.lacinia@mauris.co.uk', 826133131, 'QMB62LPL5TC', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Payne', 'Brenden', 'Zeus', 'Nulla.eget@miDuis.edu', 622538767, 'AJI96YWD3PE', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Quinn', 'Abel', 'Berk', 'ac.sem.ut@consequat.com', 60279472, 'QGA12SEH7BP', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Reilly', 'Rahim', 'Daquan', 'senectus@Sedeget.co.uk', 44621224, 'XDE26VPD9HK', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Samoa', 'Fiona', 'Montana', 'nascetur@consequatenimdiam.net', 960584058, 'BXG95MEW6RO', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('San Marino', 'Wylie', 'Kyla', 'cursus.luctus@arcuMorbisit.org', 557671939, 'NCN55KUV7EP', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Simmons', 'Davis', 'Carlos', 'fringilla@torquentper.ca', 957773661, 'NET93ZBS0RF', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Skinner', 'Leroy', 'Emery', 'tempor@leo.edu', 993234979, 'RHJ61QAQ9DW', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Sosa', 'Avram', 'Hiram', 'odio.sagittis.semper@lectusped', 802083790, 'GOP62BAH8QC', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Stone', 'Kevin', 'Oscar', 'magna@cursus.ca', 259701674, 'IBK61HQK8OT', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Sweden', 'Libby', 'Kessie', 'enim.nisl.elementum@feugiatpla', 340666045, 'XEA63LUU5TM', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Terrell', 'Ralph', 'Jacob', 'mi@Vivamus.com', 597395728, 'OES87DDN6AJ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Uganda', 'Gay', 'Medge', 'molestie.tortor.nibh@Proinvel.', 305995085, 'MIT07GRG7VJ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Weaver', 'Flynn', 'Asher', 'odio@dolordolortempus.edu', 486519826, 'XIA70BCI1GW', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Webster', 'Luke', 'Damian', 'Nulla.aliquet@fringillacursusp', 338529941, 'SLQ16YZP1JV', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Weiss', 'Brody', 'Tyler', 'lectus@telluseu.co.uk', 827650213, 'RDR62JKH9OA', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('White', 'Edan', 'Kadeem', 'amet.diam@mifelis.edu', 257629027, 'KDM85NBS6ZJ', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Williamson', 'James', 'Kennedy', 'nostra.per@acrisusMorbi.com', 181997896, 'NNA52EBY4RR', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Woodward', 'Dillon', 'Jasper', 'urna@posuerecubilia.org', 496679908, 'NIU18RZI5DG', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Young', 'Christopher', 'Wayne', 'arcu.Vivamus.sit@scelerisque.c', 66491243, 'TUR79DRZ1LL', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Zambia', 'Carl', 'Merrill', 'Nunc@auguemalesuada.com', 304337420, 'UTI46TDW7YA', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL),
('Zimbabwe', 'Ria', 'Gillian', 'ultrices.posuere@auctor.co.uk', 582072585, 'SBM49VSI7DK', 'pzo', 'bolivar', 'Caura', 0, 0, NULL, NULL);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `inicializador empleador-trabajador` AFTER INSERT ON `usuario` FOR EACH ROW BEGIN
	INSERT into trabajador(username) values (new.username);
	INSERT into empleador(username) values (new.username);
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`nombre`);

--
-- Indices de la tabla `elige`
--
ALTER TABLE `elige`
  ADD KEY `id_trabajador` (`id_trabajador`,`id_empleador`,`id_trabajo`),
  ADD KEY `id_empleador` (`id_empleador`),
  ADD KEY `id_trabajo` (`id_trabajo`);

--
-- Indices de la tabla `empleador`
--
ALTER TABLE `empleador`
  ADD PRIMARY KEY (`username`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `especializado`
--
ALTER TABLE `especializado`
  ADD PRIMARY KEY (`subcategoria`,`username`),
  ADD KEY `subcategoria` (`subcategoria`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `postula`
--
ALTER TABLE `postula`
  ADD KEY `id_trabajador` (`id_trabajador`,`id_trabajo`),
  ADD KEY `id_trabajo` (`id_trabajo`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`nombre`),
  ADD KEY `categoria` (`categoria`),
  ADD KEY `categoria_2` (`categoria`);

--
-- Indices de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD PRIMARY KEY (`username`),
  ADD KEY `username` (`username`);

--
-- Indices de la tabla `trabajo`
--
ALTER TABLE `trabajo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `id_empleador` (`id_empleador`,`ciudad`,`estado`,`zona`,`categoria`,`subcategoria`),
  ADD KEY `ciudad` (`ciudad`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`ciudad`,`estado`,`zona`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`username`),
  ADD KEY `ciudad` (`ciudad`,`estado`,`zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `trabajo`
--
ALTER TABLE `trabajo`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `elige`
--
ALTER TABLE `elige`
  ADD CONSTRAINT `elige_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `elige_ibfk_2` FOREIGN KEY (`id_empleador`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `elige_ibfk_3` FOREIGN KEY (`id_trabajo`) REFERENCES `trabajo` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleador`
--
ALTER TABLE `empleador`
  ADD CONSTRAINT `empleador_ibfk_1` FOREIGN KEY (`username`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `especializado`
--
ALTER TABLE `especializado`
  ADD CONSTRAINT `especializado_ibfk_1` FOREIGN KEY (`username`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `especializado_ibfk_2` FOREIGN KEY (`subcategoria`) REFERENCES `subcategoria` (`nombre`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `postula`
--
ALTER TABLE `postula`
  ADD CONSTRAINT `postula_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `postula_ibfk_2` FOREIGN KEY (`id_trabajo`) REFERENCES `trabajo` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `subcategoria_ibfk_1` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`nombre`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD CONSTRAINT `trabajador_ibfk_1` FOREIGN KEY (`username`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `trabajo`
--
ALTER TABLE `trabajo`
  ADD CONSTRAINT `trabajo_ibfk_1` FOREIGN KEY (`id_empleador`) REFERENCES `usuario` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trabajo_ibfk_2` FOREIGN KEY (`ciudad`) REFERENCES `ubicacion` (`ciudad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`ciudad`) REFERENCES `ubicacion` (`ciudad`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
