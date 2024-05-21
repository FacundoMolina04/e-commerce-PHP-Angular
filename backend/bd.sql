
CREATE TABLE `Usuario` (
  `ci` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `fechanac` DATE NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `imagen` VARCHAR(255) DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Administrador` (
  `ci` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ci`),
  CONSTRAINT `fk_administrador_usuario` FOREIGN KEY (`ci`) REFERENCES `Usuario` (`ci`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Comprador` (
  `ci` VARCHAR(50) NOT NULL,
  `cel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ci`),
  CONSTRAINT `fk_comprador_usuario` FOREIGN KEY (`ci`) REFERENCES `Usuario` (`ci`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Compra` (
  `IDcompra` INT AUTO_INCREMENT,
  `fechaCompra` DATE NOT NULL,
  `costoCarrito` DECIMAL(10, 2) NOT NULL,
  `depto` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `ci` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IDcompra`),
  CONSTRAINT `fk_compra_comprador` FOREIGN KEY (`ci`) REFERENCES `Comprador` (`ci`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Carrito` (
  `idCarrito` INT AUTO_INCREMENT,
  `costoCarrito` DECIMAL(10, 2) NOT NULL,
  `cupon` DECIMAL(10, 2) DEFAULT NULL,
  `ci` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCarrito`),
  CONSTRAINT `fk_carrito_comprador` FOREIGN KEY (`ci`) REFERENCES `Comprador` (`ci`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Productos` (
  `id` VARCHAR(50) NOT NULL,
  `precio` DECIMAL(10, 2) NOT NULL,
  `stock` INT NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `imagen` VARCHAR(255) DEFAULT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `admin_ci` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_productos_administrador` FOREIGN KEY (`admin_ci`) REFERENCES `Administrador` (`ci`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `PCArmados` (
  `id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pcarmados_productos` FOREIGN KEY (`id`) REFERENCES `Productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Componentes` (
  `id` VARCHAR(50) NOT NULL,
  `categoria` ENUM('COMPONENTES', 'NOTEBOOKS', 'PERIFERICOS') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_componentes_productos` FOREIGN KEY (`id`) REFERENCES `Productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Componentes_PCArmado` (
  `idPC` VARCHAR(50) NOT NULL,
  `idComponente` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idPC`, `idComponente`),
  CONSTRAINT `fk_componentes_pcarmado_pcarmados` FOREIGN KEY (`idPC`) REFERENCES `PCArmados` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_componentes_pcarmado_componentes` FOREIGN KEY (`idComponente`) REFERENCES `Componentes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `Carrito_Productos` (
  `idCarrito` INT NOT NULL,
  `idProducto` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCarrito`, `idProducto`),
  CONSTRAINT `fk_carrito_productos_carrito` FOREIGN KEY (`idCarrito`) REFERENCES `Carrito` (`idCarrito`) ON DELETE CASCADE,
  CONSTRAINT `fk_carrito_productos_productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

