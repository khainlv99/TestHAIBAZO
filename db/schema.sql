
CREATE DATABASE IF NOT EXISTS `turnos`;
USE `turnos`;

CREATE TABLE `Especialidad` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `Medico` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `apellido` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(15) DEFAULT NULL,
    `dni` VARCHAR(20) NOT NULL,
    `especialidadID` INT,
    PRIMARY KEY (`id`),
    UNIQUE KEY `dni_UNIQUE` (`dni`),
    CONSTRAINT `fk_especialidad_medico` FOREIGN KEY (`especialidadID`) REFERENCES `Especialidad` (`id`)
) ENGINE=InnoDB;

CREATE TABLE `Paciente` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `apellido` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(15) DEFAULT NULL,
    `dni` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `dni_UNIQUE` (`dni`)
) ENGINE=InnoDB;

CREATE TABLE `Turno` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `fecha` DATETIME NOT NULL,
    `pacienteID` INT DEFAULT NULL,
    `medicoID` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_medico_turno` FOREIGN KEY (`medicoID`) REFERENCES `Medico` (`id`),
    CONSTRAINT `fk_paciente_turno` FOREIGN KEY (`pacienteID`) REFERENCES `Paciente` (`id`)
) ENGINE=InnoDB;

DELIMITER $$
CREATE PROCEDURE `reservarTurno`(
    IN turnoID INT,
    IN pacienteID INT
)
BEGIN
    UPDATE Turno 
    SET pacienteID = pacienteID
    WHERE id = turnoID AND pacienteID IS NULL;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `verEspecialidades`()
BEGIN
    SELECT id, nombre FROM Especialidad;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `verTurnos`(
    IN especialidadID INT
)
BEGIN
    SELECT t.id, t.fecha, m.nombre, m.apellido, e.nombre
    FROM Turno t
    JOIN Medico m ON m.id = t.medicoID
    JOIN Especialidad e ON e.id = m.especialidadID
    WHERE t.pacienteID IS NULL AND m.especialidadID = especialidadID AND t.fecha > NOW();
END$$
DELIMITER ;

