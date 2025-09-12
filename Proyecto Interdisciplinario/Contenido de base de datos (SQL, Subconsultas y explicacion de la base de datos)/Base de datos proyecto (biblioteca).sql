-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-09-2025 a las 21:14:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--
DROP DATABASE IF EXISTS `biblioteca`;
CREATE DATABASE IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `biblioteca`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

DROP TABLE IF EXISTS `libros`;
CREATE TABLE `libros` (
  `id_libro` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `autor` varchar(100) DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `publicacion` date DEFAULT NULL,
  `cantidad_disponible` int(11) DEFAULT NULL,
  `calificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id_libro`, `titulo`, `autor`, `genero`, `publicacion`, `cantidad_disponible`, `calificacion`) VALUES
(1, 'Cien años de soledad', 'Gabriel García Márquez', 'Novela', '1967-05-30', 5, 4),
(2, 'El principito', 'Antoine de Saint-Exupéry', 'Fábula', '1943-04-06', 3, 5),
(3, '1984', 'George Orwell', 'Distopía', '1949-06-08', 4, 4),
(4, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela', '1605-01-16', 2, 5),
(5, 'Harry Potter y la piedra filosofal', 'J.K. Rowling', 'Fantasía', '1997-06-26', 6, 5),
(6, 'El chirolita', 'Antoine de Saint-Exupéry', 'Ficción', '1943-06-21', 5, 4),
(7, 'El gran Gatsby', 'F. Scott Fitzgerald', 'Novela', '1948-05-21', 5, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `id_libro` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_prestamo` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `devuelto` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id_prestamo`, `id_libro`, `id_usuario`, `fecha_prestamo`, `fecha_devolucion`, `devuelto`) VALUES
(1, 1, 1, '2025-08-01', '2025-08-10', '1'),
(2, 2, 2, '2025-08-03', '2025-08-12', '0'),
(3, 3, 3, '2025-08-05', '2025-08-15', '0'),
(4, 4, 4, '2025-07-25', '2025-08-05', '1'),
(5, 5, 5, '2025-08-07', '2025-08-17', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

DROP TABLE IF EXISTS `reportes`;
CREATE TABLE `reportes` (
  `id_reporte` int(11) NOT NULL,
  `tipo_reporte` varchar(50) DEFAULT NULL,
  `fecha_generacion` date DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `resultado` text DEFAULT NULL,
  `usuario_genero` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id_reporte`, `tipo_reporte`, `fecha_generacion`, `descripcion`, `resultado`, `usuario_genero`) VALUES
(1, 'Libros más prestados', '2025-08-10', 'Informe de los libros con mayor cantidad de préstamos en el último mes', '1. Cien años de soledad - 5 préstamos\n2. El principito - 4 préstamos', 'Administrador'),
(2, 'Libros con baja disponibilidad', '2025-08-11', 'Libros con menos de 3 unidades en inventario', '1. Don Quijote de la Mancha - 2 unidades\n2. El principito - 3 unidades', 'Bibliotecario'),
(3, 'Préstamos vencidos', '2025-08-12', 'Listado de usuarios con préstamos vencidos', '1. María López - El principito\n2. Pedro Gómez - 1984', 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `direccion`, `telefono`) VALUES
(1, 'Juan Pérez', 'Calle Falsa 123', '123456789'),
(2, 'María López', 'Av. Libertad 456', '987654321'),
(3, 'Pedro Gómez', 'San Martín 789', '456789123'),
(4, 'Lucía Fernández', 'Belgrano 321', '789123456'),
(5, 'Carlos Torres', 'Mitre 654', '321654987');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id_libro`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `id_libro` (`id_libro`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id_reporte`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id_libro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`),
  ADD CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
