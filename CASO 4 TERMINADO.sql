create table Persona (
    nom varchar(30) not null constraint pers_pk primary key,
    fechanac date
);
create table Pelicula (
    titulo varchar(40) not null constraint pel_pk primary key,
    estreno date,
	lema varchar(60)
);

CREATE TABLE Actua
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );
CREATE TABLE Dirige
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );

create table Sigue (
    seguido varchar(30) not null,
    seguidor varchar(30) not null,
	primary key(seguido,seguidor),
	foreign key(seguido) references Persona(nom) on delete cascade,
    foreign key(seguidor) references Persona(nom) on delete cascade
);

insert into Persona values
        ('Keanu Reeves','1964-03-23'),
        ('Carrie-Anne Moss','1967-03-29'),
        ('Hugo Weaving','1960-03-30'),
        ('Emil Eifrem','1978-10-20'),
		('Al Pacino','1940-10-20'),
		('Charlize Theron','1975-10-20'),
		('Lilly Wachowski','1967-05-27'),
		('Taylor Hackford','1944-08-13'),
		('Paul Blythe','2009-12-13');
insert into Pelicula values
        ('The Matrix','1990-09-13','Welcome to the Real World'),
        ('The Matrix Revolutions','2003-04-19','Everything that has a beginning has an end'),
        ('The Devils Advocate','1997-08-30','Evil has its winning ways');
		
Insert into Actua values
     ('Keanu Reeves','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Emil Eifrem','The Matrix'),
	 ('Al Pacino','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Lilly Wachowski','The Matrix Revolutions'),
	 ('Al Pacino','The Matrix Revolutions'),
	 ('Keanu Reeves','The Devils Advocate'),
	 ('Al Pacino','The Devils Advocate');

Insert into Dirige values
     ('Carrie-Anne Moss','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Devils Advocate'),
	 ('Taylor Hackford','The Devils Advocate');
Insert into Sigue values
     ('Keanu Reeves','Hugo Weaving'),
     ('Keanu Reeves','Al Pacino'),
	 ('Emil Eifrem','Lilly Wachowski'),
	 ('Keanu Reeves','Paul Blythe'),
	 ('Al Pacino','Keanu Reeves');

--1. Personas (nombre) que han actuado en más de una película estrenada en el año 1990.
SELECT nom, titulo
FROM ACTUA NATURAL JOIN PELICULA
WHERE estreno>'1990-01-01' AND estreno<'1990-12-31'
GROUP BY nom
HAVING COUNT(titulo)>1
--2. Películas (título y lema) en las que han actuado solamente personas que nacieron antes del 1970.
SELECT titulo,lema 
FROM PELICULA
WHERE NOT EXISTS(
		SELECT 1 
		FROM ACTUA JOIN PERSONA ON PERSONA.nom=ACTUA.nom
		WHERE PERSONA.fechanac >= '1970-01-01'
		AND ACTUA.titulo=PELICULA.titulo
	)

--3. Personas (todos los datos) que han actuado en todas las películas dirigidas por Carrie-Anne Moss.
SELECT *
FROM PERSONA
WHERE NOT EXISTS(
	SELECT 1
	FROM PELICULA NATURAL JOIN (SELECT titulo FROM DIRIGE WHERE nom='Carrie-Anne Moss')
	WHERE NOT EXISTS(
			SELECT 1 
			FROM ACTUA
			WHERE ACTUA.nom=PERSONA.nom
			AND ACTUA.titulo=PELICULA.titulo
	)
)

SELECT *
FROM PERSONA p
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT titulo 
        FROM DIRIGE 
        WHERE nom = 'Carrie-Anne Moss'
    ) d
    WHERE NOT EXISTS (
        SELECT 1
        FROM ACTUA a
        WHERE a.nom = p.nom 
        AND a.titulo = d.titulo
    )
);

--4. Obtener el título y fecha de estreno de las películas dirigidas por Keanu Reeves.
SELECT titulo, estreno
FROM PELICULA NATURAL JOIN DIRIGE
WHERE nom='Keanu Reeves'

-- 5. Personas (todos los datos) que han actuado y/o dirigido en las mismas Películas en las que actuó Keanu Reeves.
SELECT *
FROM PERSONA
WHERE nom IN (
    SELECT nom
    FROM ACTUA
    WHERE titulo IN (
        SELECT titulo
        FROM ACTUA
        WHERE nom = 'Keanu Reeves'
    )
)
UNION
SELECT *
FROM PERSONA 
WHERE nom in(
    SELECT nom
    FROM DIRIGE
    WHERE titulo IN (
        SELECT titulo
        FROM ACTUA
        WHERE nom = 'Keanu Reeves'
    )
);


--6. Personas (nombre) que han actuado en las películas The Matrix y The Matrix Revolutions.
SELECT PERSONA.nom
FROM PERSONA JOIN ACTUA ON PERSONA.nom=ACTUA.nom
WHERE ACTUA.titulo in ('The Matrix')
GROUP BY PERSONA.nom
INTERSECT
SELECT PERSONA.nom
FROM PERSONA JOIN ACTUA ON PERSONA.nom=ACTUA.nom
WHERE ACTUA.titulo in ('The Matrix Revolutions')
GROUP BY PERSONA.nom

-- 7. Persona/s (todos los datos) que ha/n dirigido más películas.
SELECT *
FROM PERSONA
NATURAL JOIN (
    SELECT nom
    FROM DIRIGE
    GROUP BY nom
    HAVING COUNT(*) = (
        SELECT MAX(cant)
        FROM (
            SELECT COUNT(*) as cant
            FROM DIRIGE
            GROUP BY nom
        )
    )
);

--8. Nombre de la persona junto a la cantidad de películas que ha dirigido.
SELECT nom, COUNT(titulo) as peliculas
FROM DIRIGE
GROUP BY nom

--9. Personas (todos sus datos) que han participado actuando y dirigiendo la misma película.
SELECT *
FROM DIRIGE,ACTUA WHERE
DIRIGE.nom=ACTUA.nom AND DIRIGE.titulo=ACTUA.titulo

--10.Título de la película junto a la cantidad de personas que participaron actuando y/o dirigiendo. (consultar)
SELECT DIRIGE.titulo, COUNT(DISTINCT ACTUA.nom)+COUNT(DISTINCT DIRIGE.nom)
FROM DIRIGE JOIN ACTUA ON DIRIGE.titulo=ACTUA.titulo
GROUP BY DIRIGE.titulo



	