-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`zona` (
  `idzona` INT NOT NULL AUTO_INCREMENT,
  `nombreZona` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idzona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `idRoles` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRoles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(256) NOT NULL,
  `ruc` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  `notificaciones` VARCHAR(1024) NULL,
  `correo` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `estadoUsuario` VARCHAR(45) NULL,
  `codigoJurisdiccion` VARCHAR(45) NULL,
  `codigoDespachador` VARCHAR(45) NULL,
  `razonSocial` VARCHAR(100) NULL,
  `solicitudAgente` TINYINT NULL,
  `zona_idzona` INT NOT NULL,
  `isBan` TINYINT NOT NULL,
  `roles_idRoles` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  UNIQUE INDEX `ruc_UNIQUE` (`ruc` ASC) VISIBLE,
  INDEX `fk_usuario_zona1_idx` (`zona_idzona` ASC) VISIBLE,
  INDEX `fk_usuario_roles1_idx` (`roles_idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_zona1`
    FOREIGN KEY (`zona_idzona`)
    REFERENCES `mydb`.`zona` (`idzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_roles1`
    FOREIGN KEY (`roles_idRoles`)
    REFERENCES `mydb`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ordenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ordenes` (
  `idordenes` INT NOT NULL AUTO_INCREMENT,
  `estadoOrdenes` VARCHAR(45) NOT NULL,
  `fechaArribo` DATE NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idordenes`, `usuario_idusuario`),
  INDEX `fk_ordenes_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_ordenes_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(100) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `cantidadDisponible` INT NOT NULL,
  `descripcion` VARCHAR(1000) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `costoEnvio` DOUBLE NOT NULL,
  `cantidadTotal` INT NULL,
  `ordenes_idordenes` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_productos_ordenes1_idx` (`ordenes_idordenes` ASC) VISIBLE,
  CONSTRAINT `fk_productos_ordenes1`
    FOREIGN KEY (`ordenes_idordenes`)
    REFERENCES `mydb`.`ordenes` (`idordenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`distritosPorZona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`distritosPorZona` (
  `iddistritosPorZona` INT NOT NULL AUTO_INCREMENT,
  `distritos` VARCHAR(100) NOT NULL,
  `zona_idzona` INT NOT NULL,
  PRIMARY KEY (`iddistritosPorZona`),
  UNIQUE INDEX `distritos_UNIQUE` (`distritos` ASC) VISIBLE,
  INDEX `fk_distritosPorZona_zona_idx` (`zona_idzona` ASC) VISIBLE,
  CONSTRAINT `fk_distritosPorZona_zona`
    FOREIGN KEY (`zona_idzona`)
    REFERENCES `mydb`.`zona` (`idzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `nombreTienda` VARCHAR(45) NOT NULL,
  `nombreProveedor` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `ruc` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `zona_idzona` INT NOT NULL,
  `fotoProveedor` BLOB NOT NULL,
  PRIMARY KEY (`idproveedor`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `ruc_UNIQUE` (`ruc` ASC) VISIBLE,
  INDEX `fk_proveedor_zona1_idx` (`zona_idzona` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_zona1`
    FOREIGN KEY (`zona_idzona`)
    REFERENCES `mydb`.`zona` (`idzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`resenias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`resenias` (
  `idresenias` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(500) NOT NULL,
  `calidad` VARCHAR(45) NOT NULL,
  `rapidez` VARCHAR(45) NOT NULL,
  `puntuacion` INT NOT NULL,
  `foto` BLOB NULL,
  `respuesta` VARCHAR(45) NULL,
  `productos_idproductos` INT NOT NULL,
  `tituloForo` VARCHAR(200) NULL,
  `descripcionForo` VARCHAR(200) NULL,
  PRIMARY KEY (`idresenias`),
  INDEX `fk_resenias_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_resenias_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fotos` (
  `idfotos` INT NOT NULL AUTO_INCREMENT,
  `foto1` BLOB NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`idfotos`),
  INDEX `fk_fotos_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_fotos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagos` (
  `idpagos` INT NOT NULL AUTO_INCREMENT,
  `monto` DOUBLE NOT NULL,
  `numeroTarjeta` DATE NOT NULL,
  `cvv` INT NOT NULL,
  `fechaPago` DATETIME NOT NULL,
  `metodoPago` VARCHAR(45) NOT NULL,
  `estadoPago` VARCHAR(45) NOT NULL,
  `ordenes_idordenes` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idpagos`, `ordenes_idordenes`),
  INDEX `fk_pagos_ordenes1_idx` (`ordenes_idordenes` ASC) VISIBLE,
  INDEX `fk_pagos_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_ordenes1`
    FOREIGN KEY (`ordenes_idordenes`)
    REFERENCES `mydb`.`ordenes` (`idordenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`faq` (
  `idfaq` INT NOT NULL AUTO_INCREMENT,
  `respuesta` VARCHAR(200) NOT NULL,
  `pregunta` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idfaq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reposicionProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reposicionProductos` (
  `idreposicionProductos` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `fechaSolicitud` DATE NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`idreposicionProductos`),
  INDEX `fk_reposicionProductos_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_reposicionProductos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`resenias_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`resenias_has_usuario` (
  `resenias_idresenias` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`resenias_idresenias`, `usuario_idusuario`),
  INDEX `fk_resenias_has_usuario_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_resenias_has_usuario_resenias1_idx` (`resenias_idresenias` ASC) VISIBLE,
  CONSTRAINT `fk_resenias_has_usuario_resenias1`
    FOREIGN KEY (`resenias_idresenias`)
    REFERENCES `mydb`.`resenias` (`idresenias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resenias_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productos_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos_has_usuario` (
  `productos_idproductos` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`productos_idproductos`, `usuario_idusuario`),
  INDEX `fk_productos_has_usuario_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_productos_has_usuario_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_productos_has_usuario_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto_has_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto_has_proveedor` (
  `producto_idproducto` INT NOT NULL,
  `proveedor_idproveedor` INT NOT NULL,
  PRIMARY KEY (`producto_idproducto`, `proveedor_idproveedor`),
  INDEX `fk_producto_has_proveedor_proveedor1_idx` (`proveedor_idproveedor` ASC) VISIBLE,
  INDEX `fk_producto_has_proveedor_producto1_idx` (`producto_idproducto` ASC) VISIBLE,
  CONSTRAINT `fk_producto_has_proveedor_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `mydb`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_idproveedor`)
    REFERENCES `mydb`.`proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`codigosJurisdiccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`codigosJurisdiccion` (
  `idcodigos` INT NOT NULL AUTO_INCREMENT,
  `codigoJurisdiccion` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcodigos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`codigoDespachador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`codigoDespachador` (
  `idcodigoDespachador` INT NOT NULL AUTO_INCREMENT,
  `codigoDespachador` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcodigoDespachador`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
