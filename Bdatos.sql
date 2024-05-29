-- Crear base de datos si no existe y usarla
CREATE DATABASE IF NOT EXISTS ferremas;
USE ferremas;

-- Crear tabla 'categorias'
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

-- Crear tabla 'marcas'
CREATE TABLE IF NOT EXISTS marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

-- Crear tabla 'productos'
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    marca_id INT NOT NULL,
    categoria_id INT NOT NULL,
    descripcion TEXT,
    FOREIGN KEY (marca_id) REFERENCES marcas(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Crear tabla 'precios'
CREATE TABLE IF NOT EXISTS precios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    fecha DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Crear tabla 'inventario'
CREATE TABLE IF NOT EXISTS inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Crear tabla 'pedidos'
CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sucursal_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Poblar la tabla 'categorias'
INSERT INTO categorias (nombre) VALUES ('Herramientas Manuales')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Herramientas Eléctricas')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Materiales Básicos')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Acabados')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Equipos de Seguridad')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Tornillos y Anclajes')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Fijaciones y Adhesivos')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO categorias (nombre) VALUES ('Equipos de Medición')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Crear una marca genérica para productos sin marca específica
INSERT INTO marcas (nombre) VALUES ('Genérica')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Poblar la tabla 'marcas'
INSERT INTO marcas (nombre) VALUES ('Bosch')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO marcas (nombre) VALUES ('Stanley')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO marcas (nombre) VALUES ('DeWalt')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO marcas (nombre) VALUES ('Makita')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);
INSERT INTO marcas (nombre) VALUES ('Black & Decker')
    ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

-- Poblar la tabla 'productos'
INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('HERR-MAN-001', 'Martillo Stanley', 
    (SELECT id FROM marcas WHERE nombre='Stanley'), 
    (SELECT id FROM categorias WHERE nombre='Herramientas Manuales'), 
    'Martillo de 16 oz Stanley con mango de madera.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('HERR-ELE-001', 'Taladro Percutor Bosch', 
    (SELECT id FROM marcas WHERE nombre='Bosch'), 
    (SELECT id FROM categorias WHERE nombre='Herramientas Eléctricas'), 
    'Taladro percutor Bosch de 500W, ideal para uso doméstico.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('MAT-BAS-001', 'Cemento Portland', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Materiales Básicos'), 
    'Cemento Portland de alta resistencia, 50kg.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('ACAB-001', 'Pintura Latex Blanca', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Acabados'), 
    'Pintura látex blanca, 4 litros, ideal para interiores.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('SEG-001', 'Casco de Seguridad Amarillo', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Equipos de Seguridad'), 
    'Casco de seguridad amarillo, con certificación ANSI.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('TOR-001', 'Tornillos para Madera 5x50mm', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Tornillos y Anclajes'), 
    'Tornillos para madera de 5x50mm, paquete de 100 unidades.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('FIJ-001', 'Adhesivo Epóxico', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Fijaciones y Adhesivos'), 
    'Adhesivo epóxico de dos componentes, 200ml.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

INSERT INTO productos (codigo, nombre, marca_id, categoria_id, descripcion) 
VALUES 
('MED-001', 'Cinta Métrica de 5m', 
    (SELECT id FROM marcas WHERE nombre='Genérica'), 
    (SELECT id FROM categorias WHERE nombre='Equipos de Medición'), 
    'Cinta métrica de 5 metros con bloqueo automático.')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), marca_id=VALUES(marca_id), categoria_id=VALUES(categoria_id), descripcion=VALUES(descripcion);

-- Poblar la tabla 'precios'
INSERT INTO precios (producto_id, fecha, valor) 
VALUES 
((SELECT id FROM productos WHERE codigo='HERR-MAN-001'), '2023-05-10', 15000.00),
((SELECT id FROM productos WHERE codigo='HERR-ELE-001'), '2023-05-10', 89090.99),
((SELECT id FROM productos WHERE codigo='MAT-BAS-001'), '2023-05-10', 7500.00),
((SELECT id FROM productos WHERE codigo='ACAB-001'), '2023-05-10', 20000.00),
((SELECT id FROM productos WHERE codigo='SEG-001'), '2023-05-10', 12000.00),
((SELECT id FROM productos WHERE codigo='TOR-001'), '2023-05-10', 8500.00),
((SELECT id FROM productos WHERE codigo='FIJ-001'), '2023-05-10', 5500.00),
((SELECT id FROM productos WHERE codigo='MED-001'), '2023-05-10', 3000.00)
ON DUPLICATE KEY UPDATE fecha=VALUES(fecha), valor=VALUES(valor);

-- Poblar la tabla 'inventario'
INSERT INTO inventario (producto_id, cantidad) 
VALUES 
((SELECT id FROM productos WHERE codigo='HERR-MAN-001'), 100),
((SELECT id FROM productos WHERE codigo='HERR-ELE-001'), 50),
((SELECT id FROM productos WHERE codigo='MAT-BAS-001'), 200),
((SELECT id FROM productos WHERE codigo='ACAB-001'), 80),
((SELECT id FROM productos WHERE codigo='SEG-001'), 150),
((SELECT id FROM productos WHERE codigo='TOR-001'), 500),
((SELECT id FROM productos WHERE codigo='FIJ-001'), 300),
((SELECT id FROM productos WHERE codigo='MED-001'), 400)
ON DUPLICATE KEY UPDATE cantidad=VALUES(cantidad);

-- Poblar la tabla 'pedidos'
INSERT INTO pedidos (sucursal_id, producto_id, cantidad, fecha, estado) 
VALUES 
(1, (SELECT id FROM productos WHERE codigo='HERR-MAN-001'), 10, '2023-05-12', 'Pendiente'),
(1, (SELECT id FROM productos WHERE codigo='HERR-ELE-001'), 5, '2023-05-12', 'Completado'),
(2, (SELECT id FROM productos WHERE codigo='MAT-BAS-001'), 20, '2023-05-12', 'Pendiente'),
(2, (SELECT id FROM productos WHERE codigo='ACAB-001'), 8, '2023-05-12', 'En Proceso'),
(3, (SELECT id FROM productos WHERE codigo='SEG-001'), 15, '2023-05-12', 'Completado'),
(3, (SELECT id FROM productos WHERE codigo='TOR-001'), 50, '2023-05-12', 'Pendiente'),
(4, (SELECT id FROM productos WHERE codigo='FIJ-001'), 30, '2023-05-12', 'En Proceso'),
(4, (SELECT id FROM productos WHERE codigo='MED-001'), 40, '2023-05-12', 'Completado')
ON DUPLICATE KEY UPDATE cantidad=VALUES(cantidad), fecha=VALUES(fecha), estado=VALUES(estado);





USE prueba2;
--aquí creamos una tabla para almacenar los datos de la consulta (id, codigo, modelo, marca, precio clp y precio en dolar)
CREATE TABLE IF NOT EXISTS productos_detallados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(255) NOT NULL,
  modelo VARCHAR(255) NOT NULL,
  marca VARCHAR(255) NOT NULL,
  precio_clp DECIMAL(10, 2) NOT NULL,
  precio_usd DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL
);




--Creación de tabla en la cual se almacenan los valores del dolar diariamente
CREATE TABLE mindicador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL
);

INSERT INTO mindicador (codigo, valor, fecha) VALUES 
('dolar', 730.50, '2024-05-28'),
('dolar', 735.60, '2024-05-27');


USE prueba2;

-- Obtener el tipo de cambio actual del dólar
SET @tipo_cambio_usd = (SELECT valor FROM mindicador WHERE codigo = 'dolar' ORDER BY fecha DESC LIMIT 1);

-- Consulta para obtener los detalles de los productos
SELECT 
    p.codigo,
    p.nombre AS modelo,
    m.nombre AS marca,
    pr.valor AS precio_clp,
    ROUND(pr.valor / @tipo_cambio_usd, 2) AS precio_usd,
    i.cantidad AS stock
FROM 
    productos p
JOIN 
    marcas m ON p.marca_id = m.id
JOIN 
    precios pr ON p.id = pr.producto_id
JOIN 
    inventario i ON p.id = i.producto_id
WHERE 
    pr.fecha = (SELECT MAX(fecha) FROM precios WHERE producto_id = p.id);