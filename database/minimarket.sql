-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2025 a las 07:26:39
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
-- Base de datos: `minimarket`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT 1,
  `agregado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Verduras'),
(2, 'Carnes'),
(3, 'Frutas y Vegetales'),
(4, 'Piqueos'),
(5, 'Viveres'),
(6, 'Bebidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_historial`
--

CREATE TABLE `detalle_historial` (
  `id` int(11) NOT NULL,
  `historial_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_historial`
--

INSERT INTO `detalle_historial` (`id`, `historial_id`, `producto_id`, `nombre`, `precio`, `cantidad`, `subtotal`) VALUES
(3, 3, 7, 'Pescado', 4.50, 1, 4.50),
(4, 3, 2, 'Tomate', 4.20, 1, 4.20),
(5, 3, 1, 'Plátano', 2.50, 1, 2.50),
(6, 3, 3, 'Manzana', 2.50, 1, 2.50),
(7, 4, 2, 'Tomate', 4.20, 1, 4.20),
(9, 6, 1, 'Plátano', 2.50, 1, 2.50),
(10, 6, 3, 'Manzana', 2.50, 1, 2.50),
(11, 7, 20, 'Inka Kola', 3.50, 1, 3.50),
(12, 7, 5, 'cheetos', 1.50, 1, 1.50),
(13, 7, 1, 'Plátano', 2.50, 1, 2.50),
(14, 8, 1, 'Plátano', 2.50, 1, 2.50),
(15, 9, 1, 'Plátano', 2.50, 1, 2.50),
(16, 10, 1, 'Plátano', 2.50, 1, 2.50),
(17, 11, 1, 'Plátano', 2.50, 1, 2.50),
(18, 12, 1, 'Plátano', 2.50, 1, 2.50),
(19, 13, 1, 'Plátano', 2.50, 1, 2.50),
(20, 14, 1, 'Plátano', 2.50, 1, 2.50),
(21, 15, 1, 'Plátano', 2.50, 1, 2.50),
(22, 16, 1, 'Plátano', 2.50, 1, 2.50),
(23, 16, 2, 'Tomate', 4.20, 1, 4.20),
(24, 17, 1, 'Plátano', 2.50, 1, 2.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_compras`
--

CREATE TABLE `historial_compras` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `direccion` text NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `metodo_envio` varchar(50) NOT NULL,
  `costo_envio` decimal(10,2) NOT NULL,
  `notas` text DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha_pedido` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_compras`
--

INSERT INTO `historial_compras` (`id`, `usuario_id`, `nombre`, `apellidos`, `direccion`, `telefono`, `email`, `metodo_pago`, `metodo_envio`, `costo_envio`, `notas`, `subtotal`, `total`, `fecha_pedido`) VALUES
(3, 4, 'Jhimy', 'Banda', 'Hoyo rubio', '99430034', 'jimibanda@gmail.com', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 13.70, 13.70, '2025-05-29 01:52:43'),
(4, 5, 'Alejandro', 'Vaszqeuz', 'Atahualpa', '994300034', 'jimibanda@gmail.com', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 4.20, 4.20, '2025-05-29 01:55:26'),
(6, 6, 'Wilson', 'Huacca', 'Cajamarca', '994300034', 'wilson@gmail.com', 'Pago con cheque', 'Recogida local: S/ 8.00', 8.00, NULL, 5.00, 13.00, '2025-05-29 02:13:47'),
(7, 5, 'Alejandro', 'Vaszqeuz', 'Hoyo rubio', '994300034', 'alejandro@gmail.com', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 7.50, 7.50, '2025-05-29 03:42:30'),
(8, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:47:21'),
(9, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:50:34'),
(10, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:51:53'),
(11, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:52:29'),
(12, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:53:52'),
(13, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:55:03'),
(14, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:56:07'),
(15, 5, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 07:56:28'),
(16, 7, 'Juan', 'Torres', 'Jr san martin', '9887755432', 'junior@gmail.com', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 6.70, 6.70, '2025-05-29 08:22:43'),
(17, 4, 'Ander', 'Escalante', 'Jr Martires Uchuracay', '959149950', 'ander123@gmailom', 'Pago con cheque', 'Envío gratis', 0.00, NULL, 2.50, 2.50, '2025-05-29 08:27:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp(),
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `imagen_url`, `creado_en`, `categoria_id`) VALUES
(1, 'Plátano', 'Rico y fresco', 2.50, 'https://i.postimg.cc/wT1h4pW6/vegetable-item-3.png', '2025-05-15 05:26:52', 3),
(2, 'Tomate', 'Fresco', 4.20, 'https://i.postimg.cc/7YjSpWcS/vegetable-item-4.jpg', '2025-05-15 05:36:16', 3),
(3, 'Manzana', 'Frescos', 2.50, 'https://i.postimg.cc/wjVThth3/best-product-6.jpg', '2025-05-15 05:42:45', 3),
(4, 'Uvas', 'Verdes ,ricas y frescas', 2.30, 'https://i.postimg.cc/MpxpM0fh/best-product-5.jpg', '2025-05-15 06:08:46', 3),
(5, 'cheetos', 'ricos', 1.50, 'https://i.postimg.cc/x8M9qqff/cheetos.jpg', '2025-05-16 03:19:11', 4),
(6, 'Karinto', 'Almendras', 3.50, 'https://i.postimg.cc/BQmVH4j4/karinto.jpg', '2025-05-16 03:22:02', 4),
(7, 'Pescado', 'Rico y fresco', 4.50, 'https://i.postimg.cc/y8JvR9qy/Pescado.jpg', '2025-05-16 03:24:55', 2),
(8, 'Pollo ', 'Fresco y rico', 8.50, 'https://i.postimg.cc/Pqsz8RQd/Pollo.png', '2025-05-16 03:28:20', 2),
(9, 'Granadilla', 'Jugosas', 2.60, 'https://i.postimg.cc/13zbj4k8/granadilla.jpg', '2025-05-16 03:33:06', 3),
(10, 'Aceite ', 'Vegetal', 6.20, 'https://i.postimg.cc/T3qvZZws/Aceite-Primor.jpg', '2025-05-16 03:37:15', 5),
(11, 'Arroz', 'Graneado', 3.00, 'https://i.postimg.cc/ydWq3xPq/Arroz.jpg', '2025-05-16 03:41:18', 5),
(12, 'Col', 'fresca ', 3.50, 'https://i.postimg.cc/8Pg19d4j/Col.jpg', '2025-05-16 04:17:35', 1),
(13, 'Brocoli', 'Rico y saludable', 2.60, 'https://i.postimg.cc/1RGxgk03/fruite-item-12.jpg', '2025-05-16 04:18:44', 1),
(14, 'Milanesa', 'Fresco', 10.50, 'https://i.postimg.cc/VkTZZg9h/Milanesa.jpg', '2025-05-16 04:27:42', 2),
(15, 'Tocino', 'Rico', 12.50, 'https://i.postimg.cc/wM7srXQW/Tocino.png', '2025-05-16 04:28:43', 2),
(16, 'Pavita', 'Rica', 14.50, 'https://i.postimg.cc/SN1gjdPK/Pavita.jpg', '2025-05-16 04:29:52', 2),
(17, 'Sandia', 'Rica y fresca', 3.50, 'https://i.postimg.cc/9M96YSv1/fruite-item-9.jpg', '2025-05-16 04:31:19', 3),
(18, 'Palta', 'Fresca', 2.50, 'https://i.postimg.cc/CKqP38mx/Palta.jpg', '2025-05-16 04:32:56', 3),
(19, 'Fresas', 'Ricas', 3.50, 'https://i.postimg.cc/YSGZtZqk/Fresas.png', '2025-05-16 04:33:41', 3),
(20, 'Inka Kola', 'Rica', 3.50, 'https://i.postimg.cc/2S8fN0Z8/fruite-item-4.jpg', '2025-05-16 04:37:07', 6),
(21, 'Fanta', 'Rica', 3.50, 'https://i.postimg.cc/x8vSn75q/Fanta.png', '2025-05-16 04:37:45', 6),
(22, 'Coca Cola', 'Rica', 3.50, 'https://i.postimg.cc/85q11LVX/CocaCola.jpg', '2025-05-16 04:40:04', 6),
(23, 'Col Morada', 'Rica para ensaladas', 2.50, 'https://i.postimg.cc/cLX0vpSn/Col-Morada.png', '2025-05-16 05:29:26', 1),
(24, 'Aji', 'Picante , fresco', 1.20, 'https://i.postimg.cc/ZKMpsRY4/2.png', '2025-05-16 05:34:13', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(4, 'Ander', 'ander123@gmail.com', '$2y$10$i8huO2Qpx2Xf6LzEbN/YT.tqc2oDsjY/1ckBFKQegyhrTBr1XWYf.'),
(5, 'Alejandro', 'alejandro@gmail.com', '$2y$10$QcTg61kzQHWLL4dW2EECN.asi9YGHoz/Vouw2yspKtIjyUuCgC4AO'),
(6, 'Wilson', 'wilson@gmail.com', '$2y$10$2Scgk1VUDSUKxaZAq69zWOtjl7c0PW48tt/8qArmZl5uEgfl.SkTy'),
(7, 'Junior', 'junior@gmail.com', '$2y$10$N6zYb6FP4/qEeeeLH8W/o.e2m4dSMrnbqqKsIkK/ikGmTDi9idGyy');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_historial`
--
ALTER TABLE `detalle_historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_id` (`historial_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `historial_compras`
--
ALTER TABLE `historial_compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `detalle_historial`
--
ALTER TABLE `detalle_historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `historial_compras`
--
ALTER TABLE `historial_compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_historial`
--
ALTER TABLE `detalle_historial`
  ADD CONSTRAINT `detalle_historial_ibfk_1` FOREIGN KEY (`historial_id`) REFERENCES `historial_compras` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_historial_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_compras`
--
ALTER TABLE `historial_compras`
  ADD CONSTRAINT `historial_compras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
