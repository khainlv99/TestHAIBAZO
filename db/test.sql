
CREATE TABLE Especialidad (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Medico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    dni VARCHAR(20) UNIQUE NOT NULL,
    especialidadID INT,
    FOREIGN KEY (especialidadID) REFERENCES Especialidad(id)
);

CREATE TABLE Paciente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    dni VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Turno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    pacienteID INT DEFAULT NULL,
    medicoID INT NOT NULL,
    FOREIGN KEY (pacienteID) REFERENCES Paciente(id),
    FOREIGN KEY (medicoID) REFERENCES Medico(id)
);

DELIMITER $$

CREATE PROCEDURE verEspecialidades()
BEGIN
    SELECT id, nombre FROM Especialidad;
END $$

CREATE PROCEDURE verTurnos(IN especialidadID INT)
BEGIN
    SELECT t.id, t.fecha, m.nombre, m.apellido, e.nombre 
    FROM Turno t 
    JOIN Medico m ON m.id = t.medicoID
    JOIN Especialidad e ON e.id = m.especialidadID
    WHERE t.pacienteID IS NULL AND m.especialidadID = especialidadID AND t.fecha > NOW();
END $$

CREATE PROCEDURE reservarTurno(IN turnoID INT, IN pacienteID INT)
BEGIN
    UPDATE Turno 
    SET pacienteID = pacienteID
    WHERE id = turnoID AND pacienteID IS NULL;
END $$

DELIMITER ;
-- Insert data

INSERT INTO Especialidad (nombre) VALUES
('Pediatría'),
('Cardiología'),
('Dermatología'),
('Ginecología'),
('Psiquiatría');

INSERT INTO Medico (nombre, apellido, telefono, dni, especialidadID) VALUES
('Juan', 'Pérez', '123456789', '12345678', 1),
('Ana', 'Gómez', '987654321', '87654321', 2),
('Luis', 'Martínez', '456789123', '11223344', 3),
('María', 'López', '321654987', '22334455', 4),
('Carlos', 'Fernández', '654321789', '33445566', 5);

INSERT INTO Paciente (nombre, apellido, telefono, dni) VALUES
('Pedro', 'Sánchez', '555123456', '11122233'),
('Lucía', 'Rodríguez', '555987654', '22233344'),
('Javier', 'Moreno', '555654321', '33344455'),
('Sofía', 'García', '555345678', '44455566'),
('Diego', 'Hernández', '555456789', '55566677');

INSERT INTO Turno (fecha, pacienteID, medicoID) VALUES 
('2024-10-01 09:00:00', NULL, 1),
('2024-10-01 10:30:00', NULL, 1),
('2024-10-01 14:00:00', NULL, 2),
('2024-10-01 15:30:00', NULL, 2),
('2024-10-01 16:45:00', NULL, 3),
('2024-10-02 09:15:00', NULL, 1),
('2024-10-02 10:00:00', NULL, 3),
('2024-10-02 11:30:00', NULL, 2),
('2024-10-02 14:45:00', NULL, 2),
('2024-10-02 16:00:00', NULL, 3),
('2024-10-03 08:30:00', NULL, 2),
('2024-10-03 10:30:00', NULL, 1),
('2024-10-03 12:00:00', NULL, 1),
('2024-10-03 14:15:00', NULL, 1),
('2024-10-03 16:00:00', NULL, 3),
('2024-10-04 09:00:00', NULL, 2),
('2024-10-04 11:00:00', NULL, 3),
('2024-10-04 13:30:00', NULL, 1),
('2024-10-04 15:00:00', NULL, 2),
('2024-10-04 16:45:00', NULL, 3),
('2024-10-07 08:00:00', NULL, 1),
('2024-10-07 09:30:00', NULL, 3),
('2024-10-07 12:15:00', NULL, 2),
('2024-10-07 14:00:00', NULL, 3),
('2024-10-07 15:30:00', NULL, 1),
('2024-10-08 09:00:00', NULL, 2),
('2024-10-08 10:00:00', NULL, 1),
('2024-10-08 11:00:00', NULL, 2),
('2024-10-08 14:30:00', NULL, 3),
('2024-10-08 15:30:00', NULL, 2),
('2024-10-09 09:30:00', NULL, 1),
('2024-10-09 11:00:00', NULL, 3),
('2024-10-09 13:00:00', NULL, 2),
('2024-10-09 14:45:00', NULL, 1),
('2024-10-09 16:30:00', NULL, 3),
('2024-10-10 10:00:00', NULL, 2),
('2024-10-10 11:30:00', NULL, 1),
('2024-10-10 13:00:00', NULL, 2),
('2024-10-10 15:15:00', NULL, 1),
('2024-10-10 16:30:00', NULL, 3);

DELETE FROM Turno;
DELETE FROM Paciente;
DELETE FROM Medico;
DELETE FROM Especialidad;

ALTER TABLE Turno AUTO_INCREMENT = 1;
ALTER TABLE Paciente AUTO_INCREMENT = 1;
ALTER TABLE Medico AUTO_INCREMENT = 1;
ALTER TABLE Especialidad AUTO_INCREMENT = 1;

CALL verEspecialidades();
CALL verTurnos(1);
CALL reservarTurno(1, 1);

