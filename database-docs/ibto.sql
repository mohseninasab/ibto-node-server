-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ibto
-- -----------------------------------------------------
-- This database contains all the data of Iranian Blood Transfusion Organization

-- -----------------------------------------------------
-- Schema ibto
--
-- This database contains all the data of Iranian Blood Transfusion Organization
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibto` DEFAULT CHARACTER SET utf8 ;
USE `ibto` ;

-- -----------------------------------------------------
-- Table `ibto`.`subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibto`.`subjects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(20) NOT NULL,
  `lastName` VARCHAR(20) NOT NULL,
  `bloodType` VARCHAR(5) NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  `address` VARCHAR(200) NULL,
  `city` VARCHAR(20) NULL,
  `phoneNumber` VARCHAR(15) NULL,
  `nationalCode` BIGINT(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE,
  UNIQUE INDEX `nationalCode_UNIQUE` (`nationalCode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibto`.`offices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibto`.`offices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(400) NULL,
  `city` VARCHAR(100) NULL,
  `phoneNumber` VARCHAR(15) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibto`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibto`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `employeeNumber` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(15) NULL,
  `address` VARCHAR(200) NULL,
  `city` VARCHAR(45) NULL,
  `role` VARCHAR(20) NOT NULL,
  `office` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `employeeNumber_UNIQUE` (`employeeNumber` ASC) VISIBLE,
  INDEX `fk_staff_offices1_idx` (`office` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE,
  CONSTRAINT `fk_staff_offices1`
    FOREIGN KEY (`office`)
    REFERENCES `ibto`.`offices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibto`.`donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibto`.`donations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `serial` VARCHAR(45) NOT NULL,
  `date` DATETIME NULL,
  `donor` INT NOT NULL,
  `patient` INT NULL,
  `expDate` DATETIME NULL,
  `phlebotomist` INT NOT NULL,
  `examiner` INT NULL,
  `donationOffice` INT NOT NULL,
  `laboratory` INT NULL,
  `usable` TINYINT NULL DEFAULT 0,
  `other` VARCHAR(300) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_donations_users_idx` (`donor` ASC) VISIBLE,
  INDEX `fk_donations_users1_idx` (`patient` ASC) VISIBLE,
  INDEX `fk_donations_staff1_idx` (`phlebotomist` ASC) VISIBLE,
  INDEX `fk_donations_staff2_idx` (`examiner` ASC) VISIBLE,
  INDEX `fk_donations_offices1_idx` (`donationOffice` ASC) VISIBLE,
  INDEX `fk_donations_offices2_idx` (`laboratory` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `serial_UNIQUE` (`serial` ASC) VISIBLE,
  CONSTRAINT `fk_donations_users`
    FOREIGN KEY (`donor`)
    REFERENCES `ibto`.`subjects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donations_users1`
    FOREIGN KEY (`patient`)
    REFERENCES `ibto`.`subjects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donations_staff1`
    FOREIGN KEY (`phlebotomist`)
    REFERENCES `ibto`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donations_staff2`
    FOREIGN KEY (`examiner`)
    REFERENCES `ibto`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donations_offices1`
    FOREIGN KEY (`donationOffice`)
    REFERENCES `ibto`.`offices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_donations_offices2`
    FOREIGN KEY (`laboratory`)
    REFERENCES `ibto`.`offices` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ibto` ;

-- -----------------------------------------------------
-- Placeholder table for view `ibto`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibto`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `ibto`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibto`.`view1`;
USE `ibto`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
