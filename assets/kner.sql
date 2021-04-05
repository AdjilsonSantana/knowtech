-- MySQL Script generated by MySQL Workbench
-- Fri Jun 12 23:52:11 2020
-- Model: New Model    Version: 1.0
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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `nomecategoria` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`nomecategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`artigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artigo` (
  `idartigo` INT(11) NOT NULL AUTO_INCREMENT,
  `texto` LONGTEXT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL DEFAULT '',
  `categoria_nomecategoria` VARCHAR(60) NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ficheiro` VARCHAR(100) NULL DEFAULT NULL,
  `slug` VARCHAR(100) NOT NULL DEFAULT '',
  `update_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('SUBMETIDO', 'PUBLICADO') NOT NULL DEFAULT 'SUBMETIDO',
  PRIMARY KEY (`idartigo`),
  INDEX `fk_artigo_categoria_idx` (`categoria_nomecategoria` ASC),
  CONSTRAINT `fk_artigo_categoria`
    FOREIGN KEY (`categoria_nomecategoria`)
    REFERENCES `mydb`.`categoria` (`nomecategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 117
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`utilizador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`utilizador` (
  `idutilizador` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idutilizador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comentario` (
  `idcomentario` INT(11) NOT NULL,
  `texto` MEDIUMTEXT NOT NULL,
  `artigo_idartigo` INT(11) NOT NULL,
  `utilizador_idutilizador` INT(11) NOT NULL,
  PRIMARY KEY (`idcomentario`),
  INDEX `fk_comentario_artigo1_idx` (`artigo_idartigo` ASC),
  INDEX `FK_comentario_utilizador` (`utilizador_idutilizador` ASC),
  CONSTRAINT `FK_comentario_artigo`
    FOREIGN KEY (`artigo_idartigo`)
    REFERENCES `mydb`.`artigo` (`idartigo`),
  CONSTRAINT `FK_comentario_utilizador`
    FOREIGN KEY (`utilizador_idutilizador`)
    REFERENCES `mydb`.`utilizador` (`idutilizador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`migration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`migration` (
  `version` VARCHAR(180) NOT NULL,
  `apply_time` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `can_admin` SMALLINT(6) NOT NULL DEFAULT '0',
  `can_rev` SMALLINT(6) NOT NULL DEFAULT '0',
  `can_utili` SMALLINT(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NOT NULL,
  `status` SMALLINT(6) NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `auth_key` VARCHAR(255) NULL DEFAULT NULL,
  `access_token` VARCHAR(255) NULL DEFAULT NULL,
  `logged_in_ip` VARCHAR(255) NULL DEFAULT NULL,
  `logged_in_at` TIMESTAMP NULL DEFAULT NULL,
  `created_ip` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `banned_at` TIMESTAMP NULL DEFAULT NULL,
  `banned_reason` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_email` (`email` ASC),
  UNIQUE INDEX `user_username` (`username` ASC),
  INDEX `user_role_id` (`role_id` ASC),
  CONSTRAINT `user_role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`role` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profile` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `full_name` VARCHAR(255) NULL DEFAULT NULL,
  `timezone` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `profile_user_id` (`user_id` ASC),
  CONSTRAINT `profile_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`revisao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`revisao` (
  `idrevisao` INT(11) NOT NULL,
  `comentario` VARCHAR(200) NOT NULL,
  `utilizador_idutilizador` INT(11) NOT NULL,
  `artigo_idartigo` INT(11) NOT NULL,
  PRIMARY KEY (`idrevisao`),
  INDEX `FK_revisao_artigo` (`artigo_idartigo` ASC),
  INDEX `FK_revisao_utilizador` (`utilizador_idutilizador` ASC),
  CONSTRAINT `FK_revisao_artigo`
    FOREIGN KEY (`artigo_idartigo`)
    REFERENCES `mydb`.`artigo` (`idartigo`),
  CONSTRAINT `FK_revisao_utilizador`
    FOREIGN KEY (`utilizador_idutilizador`)
    REFERENCES `mydb`.`utilizador` (`idutilizador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`user_auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_auth` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `provider` VARCHAR(255) NOT NULL,
  `provider_id` VARCHAR(255) NOT NULL,
  `provider_attributes` TEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_auth_provider_id` (`provider_id` ASC),
  INDEX `user_auth_user_id` (`user_id` ASC),
  CONSTRAINT `user_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`user_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_token` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `type` SMALLINT(6) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `data` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `expired_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_token_token` (`token` ASC),
  INDEX `user_token_user_id` (`user_id` ASC),
  CONSTRAINT `user_token_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;