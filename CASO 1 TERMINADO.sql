CREATE TABLE PERS (
    Correo VARCHAR(255),
    NomU VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE CURSO (
    Nom VARCHAR(255),
    Ch INTEGER
);

DROP TABLE CURSO

CREATE TABLE INSC (
    Correo VARCHAR(255),
    Nom VARCHAR(255),
    Correod VARCHAR(255),
    Nota INTEGER
);

CREATE TABLE DICTA (
    Correo VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE TEMAS (
    Nom VARCHAR(255),
    Tema VARCHAR(255)
);
-- Insertar datos en la tabla PERS
INSERT INTO PERS (Correo, NomU, Nom)
VALUES
    ('anagarcia32@gmail.com','AnaGarcia131','Ana Garcia'),
    ('pablogomes45@gmail.com','Pablito45','Pablo Gomes'),
    ('rubengonzales104@gmail.com','RubenG10','Ruben Gonzales'),
    ('estefaniaperalta@gmail.com','Estefania22','Estefania Peralta'),
    ('gonzaloramos1978@yahoo.com.ar','GonzaloR78','Gonzalo Ramos')
	
INSERT INTO pers(Correo, NomU, nom)
	VALUES 
	('anagarcia56@gmail.com', 'AnaG56','Ana Garcia'),
	('franciscopeña52@yahoo.com.ar','FranPeña865','Gonzalo Ramos'),
	('pedroibañez@yahoo.com.ar','PedroIbañez223','Pedro Ibañez'),
	('gisellevasquez201@yahoo.com.ar','Giselle201','Giselle Vasquez'),
	('giselleV146@gmail.com','GVasquez24','Giselle Vasquez');
	
DROP TABLE TEMAS

-- Insertar datos en la tabla CURSO
INSERT INTO CURSO (Nom, Ch)
VALUES
    ('Javascript I', 50),
    ('Javascript II', 38),
    ('SQL', 25);
	
INSERT INTO CURSO (Nom, Ch)
VALUES
    ('Python I', 29),
    ('Python II', 28),
    ('Kotlin I',45),
	('Kotlin II',42);

-- Insertar datos en la tabla INSC
INSERT INTO INSC (Correo, Nom, Correod, Nota)
VALUES
    ('anagarcia56@gmail.com', 'Javascript I', 'pablogomes45@gmail.com', 7),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript I', 'pablogomes45@gmail.com', 8),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript II', 'pablogomes45@gmail.com', 7),
    ('giselleV146@gmail.com', 'Javascript II', 'pablogomes45@gmail.com', 7);
	
INSERT INTO INSC (Correo, Nom, Correod, Nota)
VALUES
	('anagarcia32@gmail.com', 'Python I', 'estefaniaperalta@gmail.com', 7),
	('franciscopeña52@yahoo.com.ar', 'Python I', 'estefaniaperalta@gmail.com', 9),
	('anagarcia32@gmail.com', 'Python II', 'pedroibañez@yahoo.com.ar', 8),
	('anagarcia56@gmail.com', 'Python II', 'estefaniaperalta@gmail.com', 6),
	('pedroibañez@yahoo.com.ar', 'Python I', 'estefaniaperalta@gmail.com', 9),
	('rubengonzales104@gmail.com', 'Kotlin I', 'gonzaloramos1978@yahoo.com.ar', 8),
	('rubengonzales104@gmail.com', 'Kotlin II', 'gonzaloramos1978@yahoo.com.ar', 6);

-- Insertar datos en la tabla DICTA
INSERT INTO DICTA (Correo, Nom)
VALUES
    ('pedroibañez@yahoo.com.ar', 'Kotlin I'),
    ('gonzaloramos1978@yahoo.com.ar', 'Python I'),
    ('gonzaloramos1978@yahoo.com.ar', 'SQL'),
    ('pablogomes45@gmail.com', 'Javascript I'),
    ('pablogomes45@gmail.com', 'Javascript II');

INSERT INTO DICTA(Correo, Nom)
	VALUES
	('estefaniaperalta@gmail.com', 'Python I'),
	('estefaniaperalta@gmail.com', 'Python II'),
	('gonzaloramos1978@yahoo.com.ar', 'Kotlin I'),
	('gonzaloramos1978@yahoo.com.ar', 'Kotlin II');

-- Insertar datos en la tabla TEMAS
INSERT INTO TEMAS (Nom, Tema)
VALUES
    ('Python I', 'Estructuras de datos'),
    ('Python I', 'Caracteristicas'),
    ('Python II', 'Aplicacion'),
    ('Python II', 'Caracteristicas'),
    ('Javascript I', 'Estructuras de datos'),
    ('Javascript I', 'Estructuras de control'),
    ('Javascript I', 'Aplicacion'),
    ('Javascript I', 'Caracteristicas'),
    ('Javascript II', 'Estructuras de datos'),
    ('Javascript II', 'Estructuras de control'),
    ('Javascript II', 'Aplicacion'),
    ('Javascript II', 'Caracteristicas'),
    ('Kotlin I', 'Estructuras de control'),
    ('Kotlin I', 'Caracteristicas'),
    ('Kotlin II', 'Estructuras de datos'),
    ('Kotlin II', 'Estructuras de control'),
    ('Kotlin II', 'Aplicacion'),
    ('Kotlin II', 'Caracteristicas');
	
INSERT INTO TEMAS(Nom, Tema)
	VALUES
	('Python I', 'Estructuras de control'),
	('Python I', 'Aplicacion'),
	('Python II', 'Estructuras de datos'),
	('Python II', 'Estructuras de control'),
	('Kotlin I', 'Estructuras de datos'),
	('Kotlin I', 'Aplicacion');
	
SELECT * FROM curso
SELECT * FROM dicta
SELECT * FROM insc
SELECT * FROM pers
SELECT * FROM temas

--7. Actualice la carga horaria del curso Ruby por 60.
UPDATE CURSO
SET ch=60
WHERE nom='Ruby'

--8. Elimine el curso Ruby I.
DELETE FROM CURSO
WHERE nom='Ruby I'

--9. Correo y nombre de todas las personas.
SELECT correo, nom FROM PERS

--10. Cantidad de cursos. select nombre, LENGTH(nombre) from verano.PERS (Ejemplo)
SELECT COUNT(*) AS cantCursos FROM CURSO

--11. Cantidad de docentes.
select COUNT(*) AS cantDoc 
FROM
	(SELECT DISTINCT correo FROM DICTA)

select COUNT(*) AS cantDoc 
FROM
	(SELECT correo FROM DICTA
	GROUP BY correo)

SELECT COUNT(DISTINCT correo) FROM DICTA;

SELECT COUNT(correo/DISTINCT correo/ *) FROM DICTA --diferentes formas
	
--Ejemplo (select correo, 'dicta', nom, 'este año' from verano.DICTA) 

--12. Nota máxima obtenida en el curso ‘’Python I‘’
SELECT MAX(nota) 
FROM INSC
WHERE nom='Python I'

--13. Nombre de los cursos ordenados por nombre
select nom as nombre from curso order by nom

--14. Nombre del curso que tiene una carga horaria superior a la de todos los cursos que dicta “pedroibañez@yahoo.com.ar”.
SELECT nom
FROM CURSO
WHERE ch > (
    SELECT MAX(ch)
    FROM CURSO
    NATURAL JOIN DICTA
    WHERE DICTA.correo = 'pedroibañez@yahoo.com.ar'
);

--15. Personas, docentes o alumnos(todos sus datos) que se llama Rosa
SELECT *
FROM PERS
WHERE nom LIKE 'Ana%';


--16. Cursos que tienen una carga horaria superior a la del curso “Kotlin I”, ordenados descendentemente por cantidad de horas.
SELECT *
FROM CURSO
WHERE ch > (
    SELECT ch
    FROM CURSO
    WHERE nom = 'Kotlin I'
)
ORDER BY ch DESC;


--17. Cursos (todos los datos) cuya carga horaria sea superior a las 40 horas reloj.
select *
from CURSO
where ch > 40

--18. Cursos (todos los datos) cuya carga horaria se encuentre entre 40 y 45 horas reloj
select *
from CURSO
where ch >= 40
INTERSECT
select *
from CURSO
where ch <= 45

SELECT *
FROM CURSO
WHERE  ch BETWEEN 40 AND 45

--19. Docentes (correo y nombre) que dictan cursos.
select DISTINCT nom,correo
from (SELECT correo FROM DICTA) NATURAL JOIN PERS

	
--20. Listado de los cursos (nombre) junto a los datos del docente que los dicta.
select * from pers natural join (select nom as nombre, correo from dicta) 

--21. Obtenga el curso (todos los datos) junto a los datos de los alumnos inscriptos. 
--Se deben incluir todos los cursos registrados más allá que no tengan alumnos inscriptos.. (Usar OUTER JOIN)
SELECT *
FROM (curso LEFT OUTER JOIN (SELECT DISTINCT * FROM (select correo, nom as nombre from INSC)  
							NATURAL JOIN PERS) AUX ON curso.nom=aux.nombre)
							
--22. Docentes (todos los datos) que dictan los cursos “Python I”
SELECT *
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python I')  
	NATURAL JOIN PERS)
	
--23. Docentes (todos los datos) que dictan los cursos “Python II”
SELECT *
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python II')  
	NATURAL JOIN PERS)
	
--24. Listado de docentes (correo) que dictan el curso “Python I” y/o “Python II”.
SELECT correo
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python I') 
	NATURAL JOIN PERS)
UNION --No hay tuplas repetidas
SELECT correo
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python II') 
	NATURAL JOIN PERS)

SELECT correo
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom IN ('Python I','Python II')) NATURAL JOIN PERS) --Hay tuplas repetidas
GROUP BY correo
	
--25. Docentes (correo) que dictan los cursos “Python I” y “Python II”.
SELECT correo
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python I')  
	NATURAL JOIN PERS)
INTERSECT
SELECT correo
FROM ((SELECT correo, nom as nombre FROM DICTA WHERE nom='Python II')  
	NATURAL JOIN PERS)
	
--26. Docentes (todos los datos) que cursaron algún curso de verano
SELECT *
FROM (SELECT correo FROM (SELECT correo FROM DICTA)aux NATURAL JOIN INSC)
NATURAL JOIN PERS

--27. Alumnos (todos los datos) que se inscribieron en el curso “Kotlin I”
SELECT *
FROM (SELECT correo FROM INSC WHERE nom='Kotlin I') NATURAL JOIN PERS

--28. Alumnos (todos los datos) que se inscribieron en el curso “Kotlin II”
SELECT *
FROM (SELECT correo FROM INSC WHERE nom='Kotlin II') NATURAL JOIN PERS

--29. Listado de alumnos (correo) que se inscribieron tanto en el curso “Kotlin I” como “Kotlin II”.
SELECT correo
FROM (SELECT correo FROM INSC WHERE nom='Kotlin I') NATURAL JOIN PERS
INTERSECT
SELECT correo
FROM (SELECT correo FROM INSC WHERE nom='Kotlin I') NATURAL JOIN PERS

--30. Alumnos (todos los datos) que aprobaron el curso “Python I” y “Python II”.
SELECT *
FROM (SELECT correo FROM INSC WHERE nota>=6 AND nom='Python I') NATURAL JOIN PERS
INTERSECT
SELECT *
FROM (SELECT correo FROM INSC WHERE nota>=6 AND nom='Python II') NATURAL JOIN PERS

--31. Alumnos (Correo) que se inscribieron en más de un curso de verano.
SELECT DISTINCT INSC.correo
FROM INSC, INSC AS AUX WHERE INSC.nom!=AUX.nom AND INSC.correo=AUX.correo

SELECT INSC.correo
FROM INSC, INSC AS AUX WHERE INSC.nom!=AUX.nom AND INSC.correo=AUX.correo
GROUP BY INSC.correo

--32. Docentes (correo) que dictan más de un curso.
SELECT correo
FROM DICTA
GROUP BY correo
HAVING COUNT(nom) > 1; --havin indica los grupos que cunplen la condicion indicada

--33. Docentes (todos los datos) que dictan más de un curso cuya carga horaria sea inferior a 30 horas reloj
SELECT correo, nomu,nom
FROM ((select nom as nombre, correo FROM DICTA) NATURAL JOIN PERS)
NATURAL JOIN (SELECT nom as nombre FROM CURSO WHERE ch<30)
GROUP BY correo, nomu, nom
HAVING COUNT(nom) > 1;

--34. Alumnos (correo) que cursaron los mismos cursos.
SELECT INSC.correo
FROM INSC, INSC AUX
WHERE INSC.correo<>AUX.correo AND INSC.nom=AUX.nom
GROUP BY INSC.correo

--35. Pares de Alumnos (todos los datos) que cursaron los mismos cursos
SELECT DISTINCT A1.correo, A1.nomu, A1.nom, A2.correo, A2.nomu, A2.nom
FROM INSC AS I1
JOIN INSC AS I2 ON I1.nom = I2.nom AND I1.correo < I2.correo --evita duplicados de pares de alumnos, ya que garantiza que solo se seleccionen combinaciones únicas de alumnos.
JOIN PERS AS A1 ON I1.correo = A1.correo
JOIN PERS AS A2 ON I2.correo = A2.correo;

--36. Pares de Alumnos que cursaron los mismos cursos con distinto profesor
SELECT DISTINCT A1.correo, A1.nomu, A2.correo, A2.nomu
FROM INSC AS I1
JOIN INSC AS I2 ON I1.nom = I2.nom AND I1.correo < I2.correo AND I1.correod<>I2.correod --evita duplicados de pares de alumnos, ya que garantiza que solo se seleccionen combinaciones únicas de alumnos.
JOIN PERS AS A1 ON I1.correo = A1.correo
JOIN PERS AS A2 ON I2.correo = A2.correo;

--37. Alumnos (todos los datos) que se inscribieron en todos los cursos de verano.
SELECT PERS.correo, PERS.nomu, PERS.nom FROM
(Select INSC.correo
from INSC
	where not exists
	(select *
	from CURSO
	where not exists
		(select *
		from INSC AX
		where AX.correo=INSC.correo
		and AX.nom=CURSO.nom)))
NATURAL JOIN PERS
GROUP BY PERS.correo, PERS.nomu, PERS.nom

SELECT DISTINCT * FROM
(Select INSC.correo
from INSC
	where not exists
	(select *
	from CURSO
	where not exists
		(select *
		from INSC AX
		where AX.correo=INSC.correo
		and AX.nom=CURSO.nom)))
NATURAL JOIN PERS

--38. Alumnos (todos los datos) que se inscribieron en todos los cursos que dicta el profesor con correo “pedroibañez@yahoo.com.ar”
SELECT DISTINCT * FROM
(Select INSC.correo
from INSC
	where INSC.correod='pedroibañez@yahoo.com.ar' AND not exists 
	(select *
	from CURSO
	where not exists
		(select *
		from INSC AX
		where AX.correo=INSC.correo
		and AX.nom=CURSO.nom)))
NATURAL JOIN PERS

--39. Nombre/s de los cursos que tienen la mayor carga horaria
SELECT nom
FROM CURSO
ORDER BY ch DESC
LIMIT 3;

--40. Especifique la Vista “Cursoscortos” que tenga los siguientes atributos nombre, carga horaria. Los cursos cortos son
--aquellos cuya carga horaria es inferior a las 40 horas

CREATE VIEW Cursoscortos AS SELECT nom, ch
FROM CURSO 
WHERE ch < 40

--WITH CHECK OPTION provoca que si seintenta insertar en la vista una tupla que no satisface lacondición de la vista, 
--esa inserción es rechazada. LosUpdates son similarmente rechazados si el nuevo valor nosatisface la condición.
CREATE VIEW Cursoscortos (nombre, carga_horaria) AS
SELECT nom, ch
FROM CURSO
WHERE ch < 40
WITH CHECK OPTION;

DROP VIEW Cursoscortos

--41. Muestre los datos contenidos en la vista, ordenados según el nombre
SELECT * FROM cursoscortos ORDER BY nombre

--42. Especifique la Vista (Alumnos_python1) que contenga los alumnos que se inscribieron en el curso “PYTHON I” correo, nombre de usuario y nombre)
CREATE VIEW Alumnos_python1 (correo, usuario, nombre) AS
SELECT PERS.correo, PERS.nomu, PERS.nom
FROM INSC JOIN PERS ON INSC.correo=PERS.correo
WHERE INSC.nom='Python I'

--43. Muestre los datos contenidos en la vista creada en el punto anterior, cuyo correo sea una cuenta de Gmail
SELECT * FROM Alumnos_python1
WHERE correo LIKE '%gmail%'








	
	