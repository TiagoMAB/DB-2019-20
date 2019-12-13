DROP TABLE IF EXISTS d_utilizador CASCADE;
DROP TABLE IF EXISTS d_tempo CASCADE;
DROP TABLE IF EXISTS d_local CASCADE;
DROP TABLE IF EXISTS d_lingua CASCADE;
DROP TABLE IF EXISTS f_anomalia CASCADE;

----------------------------------------
-- Tables
----------------------------------------

CREATE TABLE d_utilizador
   (id_utilizador           SERIAL	        NOT NULL,
    email 	                VARCHAR(255)	NOT NULL,
    tipo 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(id_utilizador));

CREATE TABLE d_tempo
   (id_tempo                SERIAL	        NOT NULL,
    dia 	                INTEGER	        NOT NULL,
    dia_da_semana           INTEGER 	    NOT NULL,
    semana                  INTEGER	        NOT NULL,
    mes                     INTEGER 	    NOT NULL,
    trimestre               INTEGER	        NOT NULL,
    ano                     INTEGER	        NOT NULL,
    PRIMARY KEY(id_tempo));

CREATE TABLE d_local
   (id_local                SERIAL	        NOT NULL,
    latitude 	            FLOAT	        NOT NULL,
    longitude 	            FLOAT	        NOT NULL,
    nome 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(id_local));

CREATE TABLE d_lingua
    (id_lingua              SERIAL          NOT NULL,
     lingua 	            VARCHAR(255)	NOT NULL,
     PRIMARY KEY(id_lingua));

DROP TABLE IF EXISTS f_anomalia CASCADE;

CREATE TABLE f_anomalia
    (id_utilizador           SERIAL	        NOT NULL,
     id_tempo                SERIAL	        NOT NULL,
     id_local                SERIAL	        NOT NULL,
     id_lingua               SERIAL         NOT NULL,
     tipo_anomalia           VARCHAR(255)    NOT NULL,
     com_proposta            BOOLEAN        NOT NULL,
     PRIMARY KEY(id_utilizador, id_tempo, id_local, id_lingua),
     FOREIGN KEY(id_utilizador) REFERENCES d_utilizador(id_utilizador) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(id_tempo) REFERENCES d_tempo(id_tempo) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(id_local) REFERENCES d_local(id_local) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(id_lingua) REFERENCES d_lingua(id_lingua) ON DELETE CASCADE ON UPDATE CASCADE);