-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema my_school
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema my_school
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `my_school` DEFAULT CHARACTER SET utf8 ;
USE `my_school` ;

-- -----------------------------------------------------
-- Table `my_school`.`persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`persons` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL DEFAULT 'none',
    `phone` VARCHAR(15) NOT NULL DEFAULT 'none',
    PRIMARY KEY (`id`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`schools`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`schools` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `address` VARCHAR(300) NOT NULL DEFAULT 'none',
    `phone` VARCHAR(150) NOT NULL DEFAULT 'none',
    `gps` VARCHAR(100) NOT NULL DEFAULT 'none',
    PRIMARY KEY (`id`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`classes` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL DEFAULT 'none',
    `schools_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_classes_schools1_idx` (`schools_id` ASC),
    CONSTRAINT `fk_classes_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`sections` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(5) NOT NULL,
    `class_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_section_class_idx` (`class_id` ASC),
    CONSTRAINT `fk_section_class` FOREIGN KEY (`class_id`)
        REFERENCES `my_school`.`classes` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`admins` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `persons_id` INT NOT NULL,
    `schools_id` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_admins_persons1_idx` (`persons_id` ASC),
    INDEX `fk_admins_schools1_idx` (`schools_id` ASC),
    CONSTRAINT `fk_admins_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_admins_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE SET NULL ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`students` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_students_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_students_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`teachers` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_teachers_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_teachers_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`parents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`parents` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_parents_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_parents_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`buses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`buses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `schools_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_buses_schools1_idx` (`schools_id` ASC),
    CONSTRAINT `fk_buses_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`subjects` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`students_has_parents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`students_has_parents` (
    `students_id` INT NOT NULL,
    `parents_id` INT NOT NULL,
    PRIMARY KEY (`students_id` , `parents_id`),
    INDEX `fk_students_has_parents_parents1_idx` (`parents_id` ASC),
    INDEX `fk_students_has_parents_students1_idx` (`students_id` ASC),
    CONSTRAINT `fk_students_has_parents_students1` FOREIGN KEY (`students_id`)
        REFERENCES `my_school`.`students` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_students_has_parents_parents1` FOREIGN KEY (`parents_id`)
        REFERENCES `my_school`.`parents` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`schools_has_teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`schools_has_teachers` (
    `schools_id` INT NOT NULL,
    `teachers_id` INT NOT NULL,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NULL,
    `id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id`),
    INDEX `fk_schools_has_teachers_teachers1_idx` (`teachers_id` ASC),
    INDEX `fk_schools_has_teachers_schools1_idx` (`schools_id` ASC),
    CONSTRAINT `fk_schools_has_teachers_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_schools_has_teachers_teachers1` FOREIGN KEY (`teachers_id`)
        REFERENCES `my_school`.`teachers` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`teachers_has_subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`teachers_has_subjects` (
    `teachers_id` INT NOT NULL,
    `subjects_id` INT NOT NULL,
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NULL,
    INDEX `fk_teachers_has_subjects_subjects1_idx` (`subjects_id` ASC),
    INDEX `fk_teachers_has_subjects_teachers1_idx` (`teachers_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_teachers_has_subjects_teachers1` FOREIGN KEY (`teachers_id`)
        REFERENCES `my_school`.`teachers` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_teachers_has_subjects_subjects1` FOREIGN KEY (`subjects_id`)
        REFERENCES `my_school`.`subjects` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`sections_has_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`sections_has_students` (
    `sections_id` INT NOT NULL,
    `students_id` INT NOT NULL,
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NULL,
    INDEX `fk_sections_has_students_students1_idx` (`students_id` ASC),
    INDEX `fk_sections_has_students_sections1_idx` (`sections_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_sections_has_students_sections1` FOREIGN KEY (`sections_id`)
        REFERENCES `my_school`.`sections` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_sections_has_students_students1` FOREIGN KEY (`students_id`)
        REFERENCES `my_school`.`students` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`schools_has_buses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`schools_has_buses` (
    `schools_id` INT NOT NULL,
    `buses_id` INT NOT NULL,
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_schools_has_buses_buses1_idx` (`buses_id` ASC),
    INDEX `fk_schools_has_buses_schools1_idx` (`schools_id` ASC),
    CONSTRAINT `fk_schools_has_buses_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_schools_has_buses_buses1` FOREIGN KEY (`buses_id`)
        REFERENCES `my_school`.`buses` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`buses_has_persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`buses_has_persons` (
    `buses_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_buses_has_persons_persons1_idx` (`persons_id` ASC),
    INDEX `fk_buses_has_persons_buses1_idx` (`buses_id` ASC),
    CONSTRAINT `fk_buses_has_persons_buses1` FOREIGN KEY (`buses_id`)
        REFERENCES `my_school`.`buses` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_buses_has_persons_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`attendances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`attendances` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `status` VARCHAR(5) NOT NULL,
    `date` DATE NOT NULL,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_attendances_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_attendances_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`exams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`exams` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `date` DATETIME NOT NULL,
    `subjects_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_exams_subjects1_idx` (`subjects_id` ASC),
    CONSTRAINT `fk_exams_subjects1` FOREIGN KEY (`subjects_id`)
        REFERENCES `my_school`.`subjects` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`exams_has_sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`exams_has_sections` (
    `exams_id` INT NOT NULL,
    `sections_id` INT NOT NULL,
    PRIMARY KEY (`exams_id` , `sections_id`),
    INDEX `fk_exams_has_sections_sections1_idx` (`sections_id` ASC),
    INDEX `fk_exams_has_sections_exams1_idx` (`exams_id` ASC),
    CONSTRAINT `fk_exams_has_sections_exams1` FOREIGN KEY (`exams_id`)
        REFERENCES `my_school`.`exams` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_exams_has_sections_sections1` FOREIGN KEY (`sections_id`)
        REFERENCES `my_school`.`sections` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`marks` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `exams_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_marks_exams1_idx` (`exams_id` ASC),
    INDEX `fk_marks_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_marks_exams1` FOREIGN KEY (`exams_id`)
        REFERENCES `my_school`.`exams` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_marks_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`timetables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`timetables` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `from_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `to_date` DATETIME NOT NULL,
    `from_time` VARCHAR(10) NOT NULL,
    `to_time` VARCHAR(10) NOT NULL,
    `subjects_id` INT NOT NULL,
    `teachers_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_timetables_subjects1_idx` (`subjects_id` ASC),
    INDEX `fk_timetables_teachers1_idx` (`teachers_id` ASC),
    CONSTRAINT `fk_timetables_subjects1` FOREIGN KEY (`subjects_id`)
        REFERENCES `my_school`.`subjects` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_timetables_teachers1` FOREIGN KEY (`teachers_id`)
        REFERENCES `my_school`.`teachers` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`feedbacks` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `subject` VARCHAR(200) NULL,
    `body` VARCHAR(1000) NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `sender_persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_feedbacks_persons1_idx` (`sender_persons_id` ASC),
    CONSTRAINT `fk_feedbacks_persons1` FOREIGN KEY (`sender_persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`feedbacks_has_receivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`feedbacks_has_receivers` (
    `feedbacks_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`feedbacks_id` , `persons_id`),
    INDEX `fk_feedbacks_has_persons_persons1_idx` (`persons_id` ASC),
    INDEX `fk_feedbacks_has_persons_feedbacks1_idx` (`feedbacks_id` ASC),
    CONSTRAINT `fk_feedbacks_has_persons_feedbacks1` FOREIGN KEY (`feedbacks_id`)
        REFERENCES `my_school`.`feedbacks` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_feedbacks_has_persons_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`announcements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`announcements` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `schools_id` INT NOT NULL,
    `classes_id` INT NOT NULL,
    `sections_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    `content` VARCHAR(500) NOT NULL DEFAULT 'none',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `fk_announcements_schools1_idx` (`schools_id` ASC),
    INDEX `fk_announcements_classes1_idx` (`classes_id` ASC),
    INDEX `fk_announcements_sections1_idx` (`sections_id` ASC),
    INDEX `fk_announcements_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_announcements_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_announcements_classes1` FOREIGN KEY (`classes_id`)
        REFERENCES `my_school`.`classes` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_announcements_sections1` FOREIGN KEY (`sections_id`)
        REFERENCES `my_school`.`sections` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_announcements_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`notifications` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(100) NOT NULL,
    `metadata` VARCHAR(100) NULL,
    `is_checked` VARCHAR(1) NOT NULL DEFAULT 0,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_notifications_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_notifications_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`bus_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`bus_locations` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `buses_id` INT NOT NULL,
    `gps` VARCHAR(100) NOT NULL,
    `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `fk_bus_locations_buses1_idx` (`buses_id` ASC),
    CONSTRAINT `fk_bus_locations_buses1` FOREIGN KEY (`buses_id`)
        REFERENCES `my_school`.`buses` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`events` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `description` VARCHAR(300) NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `schools_id` INT NOT NULL,
    `classes_id` INT NOT NULL,
    `sections_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_events_schools1_idx` (`schools_id` ASC),
    INDEX `fk_events_classes1_idx` (`classes_id` ASC),
    INDEX `fk_events_sections1_idx` (`sections_id` ASC),
    INDEX `fk_events_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_events_schools1` FOREIGN KEY (`schools_id`)
        REFERENCES `my_school`.`schools` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_events_classes1` FOREIGN KEY (`classes_id`)
        REFERENCES `my_school`.`classes` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_events_sections1` FOREIGN KEY (`sections_id`)
        REFERENCES `my_school`.`sections` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_events_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`forums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`forums` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `start_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `name` VARCHAR(150) NOT NULL DEFAULT 'none',
    `content` VARCHAR(250) NOT NULL DEFAULT 'none',
    `creator_persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_forums_persons1_idx` (`creator_persons_id` ASC),
    CONSTRAINT `fk_forums_persons1` FOREIGN KEY (`creator_persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`forum_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`forum_comments` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(300) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `forums_id` INT NOT NULL,
    `persons_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_forum_comments_forums1_idx` (`forums_id` ASC),
    INDEX `fk_forum_comments_persons1_idx` (`persons_id` ASC),
    CONSTRAINT `fk_forum_comments_forums1` FOREIGN KEY (`forums_id`)
        REFERENCES `my_school`.`forums` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_forum_comments_persons1` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `my_school`.`forum_replies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `my_school`.`forum_replies` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(300) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `persons_id` INT NOT NULL,
    `forum_comments_id` INT NOT NULL,
    `forum_replies_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_forum_comments_persons1_idx` (`persons_id` ASC),
    INDEX `fk_forum_replies_forum_comments1_idx` (`forum_comments_id` ASC),
    INDEX `fk_forum_replies_forum_replies1_idx` (`forum_replies_id` ASC),
    CONSTRAINT `fk_forum_comments_persons10` FOREIGN KEY (`persons_id`)
        REFERENCES `my_school`.`persons` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_forum_replies_forum_comments1` FOREIGN KEY (`forum_comments_id`)
        REFERENCES `my_school`.`forum_comments` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_forum_replies_forum_replies1` FOREIGN KEY (`forum_replies_id`)
        REFERENCES `my_school`.`forum_replies` (`id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
