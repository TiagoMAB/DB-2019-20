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

DROP FUNCTION IF EXISTS verificaUtilizador;
DROP FUNCTION IF EXISTS verificaAnomalia;

CREATE FUNCTION verificaUtilizador (emailAVerificar VARCHAR(255), qualificado INTEGER)
RETURNS BOOLEAN
AS
$$
BEGIN
	IF (qualificado = 1 AND EXISTS (SELECT email FROM utilizador_regular U WHERE U.email = emailAVerificar)) OR (qualificado = 0 AND EXISTS (SELECT email FROM utilizador_qualificado U WHERE U.email = emailAVerificar)) THEN
		RETURN FALSE;
	ELSE
		RETURN TRUE;
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE FUNCTION verificaAnomalia (id2 INTEGER, zona2 BOX, lingua2 VARCHAR(255))
RETURNS BOOLEAN
AS
$$
DECLARE z1p1 POINT;
DECLARE z1p2 POINT;
DECLARE z2p1 POINT;
DECLARE z2p2 POINT;
BEGIN
    SELECT zona[0] INTO z1p1 FROM anomalia WHERE id2 = id;
    SELECT zona[1] INTO z1p2 FROM anomalia WHERE id2 = id;
	SELECT zona2[0] INTO z2p1;
	SELECT zona2[1] INTO z2p2;

    IF ((z1p1[0] < z2p2[0] OR z2p1[0] < z1p2[0] OR z1p2[1] > z2p1[1] OR z2p2[1] > z1p1[1]) AND
         lingua2 <> (SELECT lingua FROM anomalia WHERE id2 = id)) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
LANGUAGE plpgsql;

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
    FOREIGN KEY(latitude, longitude) REFERENCES local_publico(latitude, longitude) ON DELETE CASCADE);

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
    FOREIGN KEY(id) REFERENCES anomalia(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (verificaAnomalia(id, zona2, lingua2) = TRUE));
    
CREATE TABLE duplicado
   (item1 	                INTEGER	        NOT NULL,
    item2 	                INTEGER	        NOT NULL,
    PRIMARY KEY(item1, item2),
    FOREIGN KEY(item1) REFERENCES item(id) ON DELETE CASCADE,
    FOREIGN KEY(item2) REFERENCES item(id) ON DELETE CASCADE,
    CHECK (item1 < item2));

CREATE TABLE utilizador
   (email 	                VARCHAR(255)	NOT NULL,
    password	            VARCHAR(255)    NOT NULL,
    PRIMARY KEY(email));

CREATE TABLE utilizador_qualificado
   (email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE,
    CHECK (verificaUtilizador(email, 1) = TRUE));

CREATE TABLE utilizador_regular
   (email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE,
    CHECK (verificaUtilizador(email, 0) = TRUE));

CREATE TABLE incidencia
   (anomalia_id 	        INTEGER         NOT NULL,
    item_id 	            INTEGER         NOT NULL,
    email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(anomalia_id),
    FOREIGN KEY(anomalia_id) REFERENCES anomalia(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(item_id) REFERENCES item(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE);

CREATE TABLE proposta_de_correcao
   (email 	                VARCHAR(255)	NOT NULL,
    nro 	                INTEGER     	NOT NULL,
    data_hora 	            TIMESTAMP	    NOT NULL,
    texto 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email, nro),
    FOREIGN KEY(email) REFERENCES utilizador_qualificado(email) ON DELETE CASCADE);

CREATE TABLE correcao
   (email 	                VARCHAR(255)	NOT NULL,
    nro 	                INTEGER     	NOT NULL,
    anomalia_id             INTEGER         NOT NULL,
    PRIMARY KEY(email, nro, anomalia_id),
    FOREIGN KEY(email, nro) REFERENCES proposta_de_correcao(email, nro) ON DELETE CASCADE,
    FOREIGN KEY (anomalia_id) REFERENCES incidencia(anomalia_id) ON DELETE CASCADE ON UPDATE CASCADE);
