-- EJERCICIOS 
-- 1
SELECT code, Name, Continent, population FROM country;

-- 2
SELECT distinct language from countrylanguage order by language;

-- 3
SELECT name as 'nombre', population as 'población' FROM country;

-- 4
SELECT name as 'nombre',GNP as 'Producto Bruto Nacional', GNPOld as 'Producto Bruto Nacional Anterior', (GNP-GNPOld) as 'Diferencia' FROM country order by name;

-- 5
SELECT name as 'nombre',population as 'habitantes',SurfaceArea as 'superficie',(population/SurfaceArea) as 'Densidad' FROM country;

-- LIMITES. Ordenamiento
-- 6
SELECT * FROM country ORDER BY Population asc;

-- 7
SELECT distinct language as 'nombre del lenguaje' FROM countrylanguage order by language asc;

-- 8
SELECT name as 'nombre', population as 'habitantes' from country order by Population asc limit 20;

-- 9
SELECT code as 'codigo', name as 'nombre', IndepYear as 'independencia' FROM country order by IndepYear DESC;

-- 10
SELECT name, continent FROM country order by LifeExpectancy DESC, SurfaceArea ASC limit 100;

-- 11
SELECT * FROM country where Population=0;

-- 12
SELECT * FROM country where LifeExpectancy>75 order by LifeExpectancy asc;

-- 13
SELECT * FROM country WHERE IndepYear>1850 and GovernmentForm like 'Constitutional Monarchy';

-- 14
SELECT * FROM country WHERE continent='Europe' order by GNP DESC limit 10;

-- 15
SELECT * FROM country where Name=LocalName;

-- 16
SELECT * FROM country WHERE IndepYear>1950;

-- 17
SELECT * FROM country HAVING Continent in ('Europe','Asia','South America');

-- 18
SELECT * FROM country Where continent<>'Africa' order by Continent;

-- 19
SELECT c.id, c.Name, c.CountryCode,c.District,c.Population FROM city c LEFT JOIN country p ON c.countryCode=p.Code WHERE p.Name like 'Argentina' having c.District<>'Buenos Aires' order by c.District;

-- 20
SELECT * FROM city HAVING Population between 125000 and 130000;

-- 21
SELECT * FROM country WHERE IndepYear is null;

-- 22
SELECT * FROM country WHERE GNPOld is null and LifeExpectancy is null;

-- 23
SELECT * FROM country WHERE Name like 'A%' and Name like '%a';

-- 24
SELECT * FROM country WHERE name like '% %';

-- 25
SELECT * FROM city WHERE Name like '%-%' or District like '%-%';

-- UNION
-- 26
SELECT p.Name,c.Name AS 'Capital' FROM country p INNER JOIN city c ON p.Capital=c.ID where p.Continent like 'South America';
SELECT p.Name,c.Name AS 'Capital' FROM country p INNER JOIN city c ON p.code=c.CountryCode where p.Continent like 'South America' and p.Capital=c.id;

-- 27
SELECT p.code, c.name, c.population FROM country p INNER JOIN city c ON p.code=c.CountryCode WHERE p.LifeExpectancy>80;

-- 28
SELECT c.Name as 'Capital' FROM city c INNER JOIN country p ON c.id=p.Capital where p.GovernmentForm like 'Federal Republic';

-- 29
SELECT l.language, p.name FROM countrylanguage l INNER JOIN country p ON l.CountryCode=p.Code WHERE l.IsOfficial=1 AND p.Population between 1000000 and 3000000;

-- 30
SELECT p.code, p.LocalName, p.Region FROM country p LEFT JOIN countrylanguage l ON p.code=l.CountryCode WHERE Language like 'Spanish';

-- 31
SELECT p.Name,c.Name FROM country p LEFT JOIN city c ON p.Capital=c.ID WHERE c.Population>(p.Population/2);

-- 32
select p.Name, p.SurfaceArea FROM country p INNER JOIN city c ON p.Capital=c.ID WHERE p.Continent like 'Africa' and c.Name=c.District;

-- 33
SELECT p.name,c.Name, p.IndepYear FROM country p LEFT JOIN city c ON p.capital=c.id WHERE p.IndepYear is not null order by p.IndepYear limit 20;

-- 34
SELECT c.Name,l.language FROM country p INNER JOIN city c ON p.code=c.CountryCode INNER JOIN countrylanguage l ON p.Code=l.CountryCode WHERE l.IsOfficial=1 HAVING l.Language not in ('Spanish','Portuguese','English','Italian','French','Dutch');

-- 35
SELECT c.name, c.population, p.name FROM country p JOIN city c ON p.code=c.CountryCode JOIN countrylanguage l ON p.Code=l.CountryCode WHERE p.Continent like 'Europe' and l.Language like 'English' order by c.Population desc limit 10;

-- 36
select population from country order by Population;
SELECT sum(p.population) as 'Pob. total', max(p.population), min(p.population), avg(p.population), count(*) FROM country p;

-- 37
SELECT count(*) as 'cantidad de paises', sum(p.population), max(p.Population), min(p.Population), avg(p.Population),p.Continent FROM country p group by p.Continent order by p.Continent;

-- 38
SELECT continent, count(*) FROM country group by Continent;

-- 39
SELECT p.code, sum(c.population) FROM country p JOIN city c ON p.Code=c.CountryCode group by c.CountryCode;

-- 40
SELECT l.language, min(l.Percentage) FROM countrylanguage l group by l.Language order by l.Language;

-- 41
SELECT GovernmentForm, avg(Population) FROM country WHERE Continent like 'Europe' group by GovernmentForm order by GovernmentForm;

-- 42
SELECT Region, avg(LifeExpectancy) FROM country group by Region order by avg(LifeExpectancy) desc limit 10;

-- 43
SELECT District,sum(Population), count(*) as'Cant. de ciudades' FROM city WHERE Population>500000 group by District order by count(*) desc limit 10;

-- 44
SELECT p.name,count(c.Name) FROM country p JOIN city c ON p.Code=c.CountryCode WHERE p.Region like 'Caribbean' group by p.Name;

-- 45
SELECT l.Language,count(p.name),sum(p.Population) FROM country p JOIN countrylanguage l ON p.Code=l.CountryCode WHERE l.IsOfficial=1 group by l.Language order by count(p.Name) desc;


-- FILTRADO DE GRUPOS
-- 46
SELECT IndepYear, count(*) FROM country WHERE IndepYear is not null group by IndepYear HAVING count(*)>1;

-- 47
SELECT p.name, count(l.language) FROM country p JOIN countrylanguage l ON p.Code=l.CountryCode group by p.name HAVING count(l.Language) between 3 and 5 order by count(l.Language) desc;

-- 48 ESTE NO ME SALIO
SELECT c.District,p.Name, sum(c.Population) as Poblacion FROM country p INNER JOIN city c ON p.Code=c.CountryCode group by c.District,p.Name HAVING sum(c.Population)<=10000 or sum(c.Population) is null order by p.Name;
SELECT 	country.`Name`,	city.District,	SUM(city.Population) AS 'Poblacion' FROM country INNER JOIN city ON country.code=city.countrycode GROUP BY country.`Name`, city.District HAVING SUM(city.Population)<10000; -- HECHO por alguien

-- 49
SELECT Region, avg(Population/SurfaceArea) as Densidad_prom FROM country group by Region HAVING Densidad_prom >((max(Population/SurfaceArea))/2);

-- 50
SELECT Language as lenguaje_oficial, round(avg(Percentage)) as porcentaje_promedio FROM countrylanguage WHERE IsOfficial=1 group by lenguaje_oficial having porcentaje_promedio<=9;

-- INUPDE DB
-- 51
SELECT * FROM clientes order by id_cliente desc;
INSERT INTO clientes (id_cliente,dni,nombre, apellido, genero, fecha_nacimiento,mail,movil,domicilio, barrio, nacionalidad) values (0,'12169851','Luis Enrique','Pérez','HOMBRE','1954-06-01','perez_luisenrique@gmail.com', '1157319468', 'Pujol 416', 'Caballito', 'Uruguay');

-- 52
INSERT INTO clientes (id_cliente,dni,nombre, apellido, genero, fecha_nacimiento,mail,movil,domicilio, barrio, nacionalidad) values (0,'17278290','Florencia','Santos','MUJER','1963-07-12','flor.santos@ma1l.com', '1148434346', 'Piran 3015', 'Villa Urquiza', 'Argentina'), (0,'16839283','Luisa Nina','Escudero','MUJER','1962-03-22','lulu62@hushma1l.com', '1175940343', 'Superi 348 1° A', 'Colegiales', 'Colombia'), (0,'19164274','Carlos Alberto','Medina','HOMBRE','1966-04-26','medinacarlosalberto@z0h0.com', '1123423451', 'Mexico 2121', 'Balvanera', 'Argentina');

-- 53
INSERT INTO clientes values (0,'36427254','Maria Sol', 'González', 'MUJER', '1992-08-15', 'ma.gon54@gma1l.com', '1136782013', 'Gurruchaga 243', 'Villa Crespo', 'Argentina');

-- 54
SELECT * FROM clientes WHERE id_cliente=85;
Update clientes set apellido='Chaves' WHERE id_cliente=85;

-- 55
INSERT INTO clientes (id_cliente,dni,nombre, apellido, genero, fecha_nacimiento,mail,movil,domicilio, barrio, nacionalidad) values (0,'1234','Luis Enrique','Pérez','HOMBRE','1954-06-01','perez_luisenrique@gmail.com', '1157319468', 'Pujol 416', 'Caballito', 'Uruguay');
SELECT * FROM clientes order by length(dni);
update clientes set dni=concat('0',dni) WHERE dni=1234;
select * FROM clientes WHERE length(DNI)=8;
UPDATE clientes set dni=concat('0',dni) WHERE length(dni)=7;



-- 56
SELECT * from clientes WHERE nombre like 'nicolas';
update clientes set nombre='Nicolás' WHERE nombre='Nicolas'; -- NO HABIA NINGUN NICOLAS SOLO SIN ACENTO

-- 57
update clientes set apellido= upper(apellido) WHERE dni like '1234';
update clientes set apellido= upper(apellido) WHERE nacionalidad<>'Argentina';

-- 58
INSERT INTO clientes (id_cliente,dni,nombre, apellido, genero, fecha_nacimiento,mail,movil,domicilio, barrio, nacionalidad) values (9804,'4444','Luis Enrique','Pérez','HOMBRE','1954-06-01','perez_luisenrique@gmail.com', '1157319468', 'Pujol 416', 'Caballito', 'Uruguay');
SELECT * from clientes WHERE id_cliente like '9804'; -- no hay cliente numero 9804
DELETE FROM clientes WHERE id_cliente like '9804';

-- 59
SELECT * FROM clientes order by id_cliente desc;
SELECT * FROM clientes WHERE mail like '%z0h0%';
DELETE FROM clientes WHERE mail like '%z0h0%';

-- 60
SELECT * FROM clientes;
SELECT * FROM clientes WHERE barrio like '%Flores%'; -- NO hay registros de ningun barrio Flores
update clientes set barrio='Flores' WHere dni=1234;
DELETE FROM clientes WHERE barrio like 'Flores';