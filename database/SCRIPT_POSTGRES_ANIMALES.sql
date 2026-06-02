
-- Proyecto: Animales vertebrados e invertebrados
-- Base sugerida: animales_educa_db
-- Servidor requerido: 172.17.42.121 usuario=alumno clave=1234

DROP TABLE IF EXISTS interacciones CASCADE;
DROP TABLE IF EXISTS preguntas CASCADE;
DROP TABLE IF EXISTS bitacora CASCADE;
DROP TABLE IF EXISTS recursos CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    clave_hash VARCHAR(64) NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('ADMIN','ESTUDIANTE')),
    estado VARCHAR(20) NOT NULL DEFAULT 'ACTIVO' CHECK (estado IN ('ACTIVO','BLOQUEADO')),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    descripcion TEXT NOT NULL,
    imagen VARCHAR(200) NOT NULL
);

CREATE TABLE recursos (
    id_recurso SERIAL PRIMARY KEY,
    categoria_id INT NOT NULL REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    titulo VARCHAR(120) NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('IMAGEN','VIDEO','AUDIO','MODELO3D')),
    url VARCHAR(300) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE preguntas (
    id_pregunta SERIAL PRIMARY KEY,
    pregunta TEXT NOT NULL,
    opcion_a VARCHAR(200) NOT NULL,
    opcion_b VARCHAR(200) NOT NULL,
    opcion_c VARCHAR(200) NOT NULL,
    respuesta_correcta CHAR(1) NOT NULL CHECK (respuesta_correcta IN ('A','B','C'))
);

CREATE TABLE interacciones (
    id_interaccion SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuarios(id_usuario),
    pregunta_id INT NOT NULL REFERENCES preguntas(id_pregunta),
    respuesta_usuario VARCHAR(20) NOT NULL,
    correcto BOOLEAN NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_revision VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE' CHECK (estado_revision IN ('PENDIENTE','APROBADO'))
);

CREATE TABLE bitacora (
    id_bitacora SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id_usuario),
    accion VARCHAR(80) NOT NULL,
    modulo VARCHAR(80) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_revision VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE' CHECK (estado_revision IN ('PENDIENTE','APROBADO'))
);

INSERT INTO usuarios(nombre, email, clave_hash, rol, estado) VALUES
('Administrador BioAula', 'admin@animales.edu', 'ac9689e2272427085e35b9d3e3e8bed88cb3434828b43b86fc0596cad4c6e270', 'ADMIN', 'ACTIVO'),
('Estudiante Demo', 'estudiante@animales.edu', '2e63a1090735f47213fea3b974418e3e42437325f313b3d3d2f6238cc22298f9', 'ESTUDIANTE', 'ACTIVO');

INSERT INTO categorias(nombre, tipo, descripcion, imagen) VALUES
('Mamiferos', 'Vertebrados', 'Animales con columna vertebral que alimentan a sus crias con leche materna. Ejemplos: perro, delfin, murcielago.', 'assets/img/mamiferos.svg'),
('Aves', 'Vertebrados', 'Animales con plumas, pico y reproduccion por huevos. Muchas especies pueden volar.', 'assets/img/aves.svg'),
('Reptiles', 'Vertebrados', 'Animales de sangre fria con escamas. Ejemplos: tortugas, serpientes y lagartos.', 'assets/img/reptiles.svg'),
('Artropodos', 'Invertebrados', 'Animales sin columna vertebral, con exoesqueleto y patas articuladas. Ejemplos: insectos y aracnidos.', 'assets/img/artropodos.svg'),
('Moluscos', 'Invertebrados', 'Animales de cuerpo blando, algunos con concha. Ejemplos: caracoles, pulpos y almejas.', 'assets/img/moluscos.svg');

INSERT INTO recursos(categoria_id, titulo, tipo, url, descripcion) VALUES
(1, 'Audio del ecosistema', 'AUDIO', 'assets/audio/ecosistema.wav', 'Audio corto usado como recurso multimedia accesible para la leccion.'),
(1, 'Modelo 3D: pez vertebrado', 'MODELO3D', 'assets/models/pez_vertebrado.glb', 'Modelo 3D con opcion de realidad aumentada en dispositivos compatibles.'),
(2, 'Imagen de aves', 'IMAGEN', 'assets/img/aves.svg', 'Imagen educativa con texto alternativo para accesibilidad.'),
(3, 'Imagen de reptiles', 'IMAGEN', 'assets/img/reptiles.svg', 'Recurso visual relacionado con vertebrados reptiles.'),
(4, 'Modelo 3D: mariposa invertebrada', 'MODELO3D', 'assets/models/mariposa_invertebrado.glb', 'Modelo 3D que representa un invertebrado.'),
(4, 'Video Powtoon CSS Validation', 'VIDEO', 'https://www.powtoon.com/embed/f7WmbGTwWFX/', 'Video de apoyo para explicar la validacion CSS y la presentacion.'),
(5, 'Imagen de moluscos', 'IMAGEN', 'assets/img/moluscos.svg', 'Recurso visual de un molusco para reforzar la categoria.');

INSERT INTO preguntas(pregunta, opcion_a, opcion_b, opcion_c, respuesta_correcta) VALUES
('Que caracteristica tienen todos los vertebrados?', 'Tienen exoesqueleto', 'Tienen columna vertebral', 'No poseen organos', 'B'),
('Cual de estos animales es invertebrado?', 'Perro', 'Aguila', 'Mariposa', 'C'),
('Los mamiferos se caracterizan principalmente por:', 'Alimentar a sus crias con leche', 'Tener plumas', 'No respirar oxigeno', 'A'),
('Los artropodos poseen:', 'Patas articuladas y exoesqueleto', 'Columna vertebral', 'Huesos internos como aves', 'A'),
('A que objetivo ODS se relaciona el proyecto?', 'Educacion de Calidad', 'Hambre Cero', 'Energia asequible', 'A');

INSERT INTO bitacora(usuario_id, accion, modulo, descripcion, estado_revision) VALUES
(1, 'INICIALIZACION', 'Base de datos', 'Se cargaron datos iniciales del proyecto educativo.', 'APROBADO'),
(1, 'RECURSO', 'Proyeccion 3D', 'Actividad de proyeccion 3D preparada para comparar un pez vertebrado y una mariposa invertebrada.', 'APROBADO');

-- Consultas para verificar
-- SELECT * FROM usuarios;
-- SELECT * FROM categorias;
-- SELECT * FROM bitacora ORDER BY fecha DESC;
