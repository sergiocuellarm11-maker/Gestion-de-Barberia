CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS barberos (
    id_barbero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_barbero INT,
    servicio VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2),
    fecha_cita DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_barbero) REFERENCES barberos(id_barbero)
);

CREATE TABLE IF NOT EXISTS cambios_barbero_logs (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT,
    id_barbero_anterior INT,
    id_barbero_nuevo INT,
    fecha_cambio DATETIME,
    motivo VARCHAR(255),
    FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);


INSERT INTO clientes (nombre, telefono, email) VALUES
('Carlos Mendoza', '3112345678', 'carlos.mendoza@email.com'),
('Andrés Silva', '3209876543', 'andres.silva@email.com'),
('Mateo Gómez', '3154561230', 'mateo.gomez@email.com'),
('Juan David Pérez', '3001112233', 'juan.perez@email.com'),
('Santiago Castro', '3125554433', 'santiago.castro@email.com');

INSERT INTO barberos (nombre, especialidad) VALUES
('Jeison Clavijo', 'Cortes modernos y degradados (Fade)'),
('Diego Forero', 'Perfilado de barba y diseño'),
('Óscar Ortiz', 'Corte clásico y tijera');

INSERT INTO citas (id_cliente, id_barbero, servicio, precio, fecha_cita) VALUES
(1, 1, 'Corte Degradado', 25000.00, '2026-06-15 10:00:00'),
(2, 2, 'Perfilado de Barba', 18000.00, '2026-06-15 11:30:00'),
(3, 1, 'Corte y Barba Combo', 38000.00, '2026-06-16 14:00:00'),
(4, 3, 'Corte Clásico', 20000.00, '2026-06-16 16:00:00');


SELECT 
    c.servicio AS `Asset name`, 
    b.nombre AS `Department name`, 
    cl.nombre AS `Asset SN`
FROM citas c
INNER JOIN barberos b ON c.id_barbero = b.id_barbero
INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente;


SELECT 
    c.servicio AS `Asset name`, 
    b.nombre AS `Department name`, 
    cl.nombre AS `Asset SN`
FROM citas c
INNER JOIN barberos b ON c.id_barbero = b.id_barbero
INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente
WHERE c.servicio LIKE '%Corte%';


SELECT 
    c.servicio AS `Asset name`, 
    b.nombre AS `Department name`, 
    cl.nombre AS `Asset SN`
FROM citas c
INNER JOIN barberos b ON c.id_barbero = b.id_barbero
INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente
WHERE b.nombre = 'Jeison Clavijo';


SELECT COUNT(*) AS `Total Registros`
FROM citas;

START TRANSACTION;

UPDATE citas 
SET id_barbero = 2 
WHERE id_cita = 1;

INSERT INTO cambios_barbero_logs (id_cita, id_barbero_anterior, id_barbero_nuevo, fecha_cambio, motivo)
VALUES (1, 1, 2, NOW(), 'Cliente solicitó cambio de estilista por tiempo');

COMMIT;

SELECT 
    l.id_log,
    c.servicio,
    b1.nombre AS `Barbero Anterior`,
    b2.nombre AS `Barbero Nuevo`,
    l.fecha_cambio,
    l.motivo
FROM cambios_barbero_logs l
INNER JOIN citas c ON l.id_cita = c.id_cita
INNER JOIN barberos b1 ON l.id_barbero_anterior = b1.id_barbero
INNER JOIN barberos b2 ON l.id_barbero_nuevo = b2.id_barbero;


SELECT 
    b.nombre AS `Barbero`, 
    COUNT(l.id_log) AS `Total Cambios Desde Él`
FROM cambios_barbero_logs l
INNER JOIN barberos b ON l.id_barbero_anterior = b.id_barbero
GROUP BY b.nombre
ORDER BY `Total Cambios Desde Él` DESC
LIMIT 1;

SELECT 
    b.id_barbero, 
    b.nombre, 
    COUNT(c.id_cita) AS `Total Citas Asignadas`
FROM barberos b
INNER JOIN citas c ON b.id_barbero = c.id_barbero
GROUP BY b.id_barbero, b.nombre
ORDER BY `Total Citas Asignadas` DESC
LIMIT 1;


SELECT 
    c.servicio, 
    COUNT(l.id_log) AS `Cantidad Cambiados`
FROM cambios_barbero_logs l
INNER JOIN citas c ON l.id_cita = c.id_cita
GROUP BY c.servicio;


SELECT COUNT(c.id_cita) AS `Citas Sin Cambios`
FROM citas c
LEFT JOIN cambios_barbero_logs l ON c.id_cita = l.id_cita
WHERE l.id_cita IS NULL;