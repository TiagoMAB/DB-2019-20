
DROP TABLE IF EXISTS local_publico CASCADE;
DROP TABLE IF EXISTS item CASCADE;
DROP TABLE IF EXISTS anomalia CASCADE;
DROP TABLE IF EXISTS anomalia_traducao CASCADE;
DROP TABLE IF EXISTS duplicado CASCADE;
DROP TABLE IF EXISTS utilizador CASCADE;
DROP TABLE IF EXISTS utilizador_qualificado CASCADE;
DROP TABLE IF EXISTS utilizador_regular CASCADE;
DROP TABLE IF EXISTS incidencia CASCADE;
DROP TABLE IF EXISTS proposta_de_correcao CASCADE;
DROP TABLE IF EXISTS correcao CASCADE;



CREATE TABLE local_publico
   (latitude 	            FLOAT	        NOT NULL,
    longitude 	            FLOAT	        NOT NULL,
    nome 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(latitude, longitude),
    CHECK (latitude <= 90 AND latitude >= -90),
    CHECK (longitude <= 180 AND latitude >= -180));

CREATE TABLE item
   (id 	                    INTEGER	        NOT NULL,
    descricao 	            VARCHAR(255)	NOT NULL,
    localizacao 	        VARCHAR(255)	NOT NULL,
    latitude 	            FLOAT	        NOT NULL,
    longitude 	            FLOAT	        NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(latitude, longitude) REFERENCES local_publico(latitude, longitude) ON DELETE CASCADE,
    CHECK (latitude <= 90 AND latitude >= -90),
    CHECK (longitude <= 180 AND latitude >= -180));

CREATE TABLE anomalia
   (id 	                    INTEGER	        NOT NULL,
    zona	                BOX             NOT NULL,
    imagem 	                BYTEA   	    NOT NULL,
    lingua 	                VARCHAR(255)	NOT NULL,
    ts 	                    TIMESTAMP	    NOT NULL,
    descricao 	            VARCHAR(255)	NOT NULL,
    tem_anomalia_redacao    BOOLEAN	        NOT NULL,
    PRIMARY KEY(id));

CREATE TABLE anomalia_traducao
   (id 	                    INTEGER	        NOT NULL,
    zona2	                BOX         	NOT NULL,
    lingua2 	            VARCHAR(255)	NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES anomalia(id) ON DELETE CASCADE ON UPDATE CASCADE);
    --CONSTRAINT chk_anomalia_traducao CHECK (zona2 <> (SELECT zona FROM anomalia WHERE id = pk_anomalia_traducao) AND lingua2 <> (SELECT lingua FROM anomalia WHERE id = pk_anomalia_traducao)));

CREATE TABLE duplicado
   (item1 	                INTEGER	        NOT NULL,
    item2 	                INTEGER	        NOT NULL,
    PRIMARY KEY(item1, item2),
    FOREIGN KEY(item1) REFERENCES item(id) ON DELETE CASCADE,
    FOREIGN KEY(item2) REFERENCES item(id) ON DELETE CASCADE,
    CHECK (item1 < item2));

CREATE TABLE utilizador
   (email 	                VARCHAR(255)	NOT NULL,
    passsword	            VARCHAR(255)    NOT NULL,
    PRIMARY KEY(email),
    CHECK (email LIKE '%@%'));

CREATE TABLE utilizador_qualificado
   (email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE,
    CHECK (email LIKE '%@%'));
    --CHECK (email NOT IN (SELECT email FROM utilizador_regular)));

CREATE TABLE utilizador_regular
   (email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE,
    CHECK (email LIKE '%@%'));
    --CHECK (email NOT IN (SELECT email FROM utilizador_qualificado)));

CREATE TABLE incidencia
   (anomalia_id 	        INTEGER         NOT NULL,
    item_id 	            INTEGER         NOT NULL,
    email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(anomalia_id),
    FOREIGN KEY(anomalia_id) REFERENCES anomalia(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(item_id) REFERENCES item(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE,
    CHECK (email LIKE '%@%'));

CREATE TABLE proposta_de_correcao
   (email 	                VARCHAR(255)	NOT NULL,
    nro 	                INTEGER     	NOT NULL,
    data_hora 	            TIMESTAMP	    NOT NULL,
    texto 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email, nro),
    FOREIGN KEY(email) REFERENCES utilizador_qualificado(email) ON DELETE CASCADE,
    CHECK (email LIKE '%@%'));

CREATE TABLE correcao
   (email 	                VARCHAR(255)	NOT NULL,
    nro 	                VARCHAR(255)	NOT NULL,
    anomalia_id             INTEGER         NOT NULL,
    PRIMARY KEY(email, nro, anomalia_id),
    FOREIGN KEY(email, nro) REFERENCES proposta_de_correcao(email, nro) ON DELETE CASCADE,
    FOREIGN KEY (anomalia_id) REFERENCES incidencia(anomalia_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (email LIKE '%@%'));
