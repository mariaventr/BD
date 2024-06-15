CREATE TABLE Lugar (
    codL INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    altura FLOAT,
    pais VARCHAR(50),
    latitud FLOAT,
    longitud FLOAT
);

CREATE TABLE Competencia (
    num INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    fecha DATE,
    dificultad INTEGER CHECK (dificultad BETWEEN 1 AND 6),
    codL INTEGER,
    FOREIGN KEY (codL) REFERENCES Lugar(codL) ON DELETE CASCADE
);

CREATE TABLE Competidor (
    cuil INTEGER PRIMARY KEY,
    nya VARCHAR(50),
    sexo CHAR(1) CHECK (sexo IN ('M', 'F', 'O')),
    telc VARCHAR(20),
    twitter VARCHAR(50),
    cantseguidores INTEGER
);

CREATE TABLE Participa (
    cuil INTEGER,
    num INTEGER,
    cumple CHAR(2) CHECK (cumple IN ('SI', 'NO')),
    PRIMARY KEY (cuil, num),
    FOREIGN KEY (cuil) REFERENCES Competidor(cuil) ON DELETE CASCADE,
    FOREIGN KEY (num) REFERENCES Competencia(num) ON DELETE CASCADE
);

INSERT INTO Lugar (codL, nombre, altura, pais, latitud, longitud) VALUES
(1, 'Montaña Blanca', 2750, 'Argentina', -34.6037, -58.3816),
(2, 'Valle Verde', 1500, 'Chile', -33.4489, -70.6693),
(3, 'Cerro Azul', 3000, 'Bolivia', -16.5000, -68.1500);
INSERT INTO Competencia (num, nombre, fecha, dificultad, codL) VALUES
(1, 'Caminata Blanca', '2023-06-15', 3, 1),
(2, 'Carrera Verde', '2023-07-20', 4, 2),
(3, 'Escalada Azul', '2023-08-25', 5, 3);
INSERT INTO Competidor (cuil, nya, sexo, telc, twitter, cantseguidores) VALUES
(101, 'Juan Perez', 'M', '123-4567', '@juanperez', 1500),
(102, 'Ana Gomez', 'F', '234-5678', '@anagomez', 2000),
(103, 'Luis Silva', 'M', '345-6789', '@luissilva', 1800);
INSERT INTO Participa (cuil, num, cumple) VALUES
(101, 1, 'SI'),
(101, 2, 'NO'),
(102, 1, 'SI'),
(102, 3, 'SI'),
(103, 2, 'SI');

INSERT INTO Participa (cuil, num, cumple) VALUES
(102, 5, 'SI')
	
1)
SELECT COMPETENCIA.nombre, COUNT(PARTICIPA.cuil) as cantParticipantes
FROM COMPETENCIA JOIN PARTICIPA ON COMPETENCIA.num=PARTICIPA.num
WHERE COMPETENCIA.codL=2
GROUP BY COMPETENCIA.nombre

2)
SELECT COMPETENCIA.nombre, COMPETENCIA.dificultad
FROM COMPETENCIA 
JOIN LUGAR ON COMPETENCIA.codL=LUGAR.codL
WHERE LUGAR.nombre='Cerro Azul' AND EXTRACT(YEAR FROM COMPETENCIA.fecha)=2023

3)
SELECT *
FROM COMPETENCIA
WHERE num NOT IN(
	SELECT PARTICIPA.num 
	FROM COMPETIDOR
	JOIN PARTICIPA ON COMPETIDOR.cuil=PARTICIPA.cuil
	WHERE COMPETIDOR.sexo='F'
)

4)
INSERT INTO Lugar (codL, nombre, altura, pais, latitud, longitud) VALUES
(4, 'Himalaya', 8848, 'Nepal', 27.9881, 86.9250),
(5, 'Aconcagua', 6962, 'Argentina', -32.6532, -70.0109);

INSERT INTO Competencia (num, nombre, fecha, dificultad, codL) VALUES
(4, 'Ascenso Himalaya', '2023-09-10', 6, 4),
(5, 'Descenso Aconcagua', '2023-10-15', 5, 5);

INSERT INTO Competidor (cuil, nya, sexo, telc, twitter, cantseguidores) VALUES
(104, 'Carlos Ramirez', 'M', '456-7890', '@carlosramirez', 2500),
(105, 'Maria Lopez', 'F', '567-8901', '@marialopez', 3000);

INSERT INTO Participa (cuil, num, cumple) VALUES
(104, 4, 'SI'),  -- Carlos Ramirez en "Ascenso Himalaya"
(104, 5, 'SI'),  -- Carlos Ramirez en "Descenso Aconcagua"
(105, 4, 'SI'),  -- Maria Lopez en "Ascenso Himalaya"
(105, 3, 'SI');  -- Maria Lopez en "Escalada Azul"



SELECT *
FROM COMPETIDOR
WHERE cuil IN(
	SELECT PARTICIPA.cuil
	FROM PARTICIPA
	JOIN COMPETENCIA ON PARTICIPA.num=COMPETENCIA.num
	JOIN LUGAR ON COMPETENCIA.codL=LUGAR.codL
	WHERE LUGAR.nombre='Himalaya'
)
INTERSECT
SELECT *
FROM COMPETIDOR
WHERE cuil NOT IN(
	SELECT PARTICIPA.cuil
	FROM PARTICIPA
	JOIN COMPETENCIA ON PARTICIPA.num=COMPETENCIA.num
	JOIN LUGAR ON COMPETENCIA.codL=LUGAR.codL
	WHERE LUGAR.nombre='Aconcagua'
)

5)
SELECT *
FROM COMPETENCIA 
JOIN
(SELECT num, COUNT(cuil)
FROM PARTICIPA
WHERE cumple='SI'
GROUP BY num
HAVING COUNT(cuil)>=5)AUX
ON AUX.num=COMPETENCIA.num

6) 
SELECT COUNT(codL) as cantLugares
FROM COMPETENCIA 
WHERE dificultad=3

7)
SELECT twitter
FROM COMPETIDOR 
WHERE NOT EXISTS(
	SELECT *
	FROM COMPETENCIA 
	WHERE EXTRACT(YEAR FROM COMPETENCIA.fecha)=2023 AND NOT EXISTS(
		SELECT *
		FROM PARTICIPA X
		WHERE X.cuil=COMPETIDOR.cuil
		AND COMPETENCIA.num=X.num
	)
)

