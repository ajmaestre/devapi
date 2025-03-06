
CREATE TABLE IF NOT EXISTS datos_personales(
    codigo SERIAL PRIMARY KEY,
    tipo_id CHAR(2) NOT NULL,
    id VARCHAR(16) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(30),
    nombre1 VARCHAR(20) NOT NULL,
    nombre2 VARCHAR(30),
    sexo CHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);
