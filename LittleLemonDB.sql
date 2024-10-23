-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db-capstone
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-capstone
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-capstone` DEFAULT CHARACTER SET utf8 COLLATE utf8_czech_ci ;
USE `db-capstone` ;

-- -----------------------------------------------------
-- Table `db-capstone`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  `ContactDetail` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NULL,
  `TableNumber` VARCHAR(255) NULL,
  `CustomerID` INT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_customer_id_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `db-capstone`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Menu` (
  `MenuID` INT NOT NULL,
  `ItemName` VARCHAR(255) NULL,
  `ItemType` VARCHAR(255) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Orders` (
  `OrderID` INT NOT NULL,
  `Date` DATE NULL,
  `Quantity` INT NULL,
  `TotalCost` DECIMAL(10,2) NULL,
  `BookingID` INT NOT NULL,
  `MenuID` INT NULL,
  `DeliveryID` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_booking_id_idx` (`BookingID` ASC) VISIBLE,
  INDEX `fk_menu_id_idx` (`MenuID` ASC) VISIBLE,
  INDEX `fk_delivery_id_idx` (`DeliveryID` ASC) VISIBLE,
  CONSTRAINT `fk_booking_id`
    FOREIGN KEY (`BookingID`)
    REFERENCES `db-capstone`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_id`
    FOREIGN KEY (`MenuID`)
    REFERENCES `db-capstone`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_id`
    FOREIGN KEY (`DeliveryID`)
    REFERENCES `db-capstone`.`Delivery` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone`.`Staff` (
  `StaffID` INT NOT NULL,
  `Role` VARCHAR(255) NULL,
  `Name` VARCHAR(255) NULL,
  `Salary` DECIMAL(10,2) NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
