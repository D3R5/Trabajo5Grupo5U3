/* 
Trabajo Grupal 5 – Modulo 3
Rodrigo Rojas – Jorge Montoya – Joeshep López – Diego Rivera - Felipe Arias - Nicolas Gajardo
*/


-- Parte 1: Crear entorno de trabajo
-- Crear una base de datos
CREATE DATABASE tg5grupo5;

-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'grupo5'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON tg5grupo5.* TO 'grupo5'@'localhost';
FLUSH PRIVILEGES;

USE tg5grupo5;

-- Parte 2: Crear dos tablas.
/* La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido,
contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto). */
CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
contraseña VARCHAR(45) NOT NULL,
zona_horaria VARCHAR(45) DEFAULT 'UTC-3',
genero ENUM( 'm', 'f', 'o') NOT NULL,
telefono_contacto VARCHAR(45),
PRIMARY KEY (id_usuario)
);
/* La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los
usuarios a la plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la
fecha-hora actual)). */
CREATE TABLE ingreso (
id_ingreso INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
fecha_hora_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Parte 3: Modificación de la tabla
-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
ALTER TABLE usuarios
MODIFY COLUMN zona_horaria VARCHAR(45) DEFAULT 'UTC-2';

-- Parte 4: Creación de registros.
-- Para cada tabla crea 8 registros.
INSERT INTO usuarios (nombre, apellido, contraseña, zona_horaria, genero, telefono_contacto)
VALUES
('Juan', 'Pérez', 'contraseña123', 'UTC-2', 'm', '123456789'),
('María', 'García', 'segura456', 'UTC-5', 'f', '987654321'),
('Pedro', 'López', 'clave789', 'UTC+1', 'm', '234567890'),
('Ana', 'Martínez', 'pass101', 'UTC-2', 'f', '345678901'),
('Carlos', 'Rodríguez', 'secure202', 'UTC+2', 'm', '456789012'),
('Lucía', 'Hernández', 'key303', 'UTC-2', 'f', '567890123'),
('Marta', 'Fernández', 'password404', 'UTC-6', 'f', '678901234'),
('Jorge', 'Gómez', 'mypassword505', 'UTC+3', 'm', '789012345');

INSERT INTO ingreso (id_usuario)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
/* En cada primary key utilizamos el formato int, ya que almacenara los valores unicos necesarios para cada informacion.
al utilizar  VARCHAR podemos realizar cadenas de textos con maximo 45 caracteres, lo cual deberia ser suficiente para toda
la informacion necesaria.
Ademas, utilizamos ENUM para la informacion de genero del usuario, lo que permite solamente insertar 3 datos.
*/

-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).
CREATE TABLE contactos (
id_contacto INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
correo VARCHAR (45),
telefono_contacto VARCHAR(45),
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
INSERT INTO contactos (id_usuario, correo,telefono_contacto) VALUES
(1, 'juan.perez@example.com', '123456789'),
(2, 'maria.garcia@example.com', '987654321'),
(3, 'pedro.lopez@example.com', '234567890'),
(4, 'ana.martinez@example.com', '345678901'),
(5, 'carlos.rodriguez@example.com', '456789012'),
(6, 'lucia.hernandez@example.com', '567890123'),
(7, 'marta.fernandez@example.com', '678901234'),
(8, 'jorge.gomez@example.com', '789012345');

ALTER TABLE usuarios
DROP COLUMN telefono_contacto;

