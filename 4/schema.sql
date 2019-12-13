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
DROP FUNCTION IF EXISTS cancel_anomalia_traducao_zona_func;
DROP FUNCTION IF EXISTS cancel_anomalia_zona_func;
DROP FUNCTION IF EXISTS verify_utilizador_proc;
DROP FUNCTION IF EXISTS verify_utilizador_regular_proc;
DROP FUNCTION IF EXISTS verify_utilizador_qualificado_proc;
DROP FUNCTION IF EXISTS remove_utilizador_proc;

DROP TRIGGER IF EXISTS cancel_anomalia_traducao_zona_insert ON anomalia_traducao;
DROP TRIGGER IF EXISTS cancel_anomalia_traducao_zona_update ON anomalia_traducao;
DROP TRIGGER IF EXISTS cancel_anomalia_zona_update ON anomalia;
DROP TRIGGER IF EXISTS verify_utilizador ON utilizador;
DROP TRIGGER IF EXISTS verify_utilizador_regular ON utilizador_regular;
DROP TRIGGER IF EXISTS verify_utilizador_qualificado ON utilizador_qualificado;
DROP TRIGGER IF EXISTS remove_utilizador_regular ON utilizador_regular;
DROP TRIGGER IF EXISTS remove_utilizador_qualificado ON utilizador_qualificado;

----------------------------------------
-- Functions
----------------------------------------

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

----------------------------------------
-- Tables
----------------------------------------

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
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE);

CREATE TABLE utilizador_regular
   (email 	                VARCHAR(255)	NOT NULL,
    PRIMARY KEY(email),
    FOREIGN KEY(email) REFERENCES utilizador(email) ON DELETE CASCADE);

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



----------------------------------------
-- Triggers
----------------------------------------

--RI-1
CREATE FUNCTION cancel_anomalia_traducao_zona_func()
RETURNS TRIGGER 
AS
$$
DECLARE z1p1 POINT;
DECLARE z1p2 POINT;
DECLARE z2p1 POINT;
DECLARE z2p2 POINT;
BEGIN 
    SELECT zona[0] INTO z1p1 FROM anomalia WHERE new.id = anomalia.id;
    SELECT zona[1] INTO z1p2 FROM anomalia WHERE new.id = anomalia.id;
    SELECT new.zona2[0] INTO z2p1;
	SELECT new.zona2[1] INTO z2p2;
    IF NOT (z1p1[0] < z2p2[0] OR z2p1[0] < z1p2[0] OR z1p2[1] > z2p1[1] OR z2p2[1] > z1p1[1]) THEN
        RAISE EXCEPTION '(RI-1) A zona da anomalia_tradução, % %, não se pode sobrepor à zona da anomalia correspondente, % %', z2p1,z2p2,z1p1,z1p2;
    END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER cancel_anomalia_traducao_zona_insert BEFORE INSERT ON anomalia_traducao
FOR EACH ROW EXECUTE FUNCTION cancel_anomalia_traducao_zona_func();

CREATE TRIGGER cancel_anomalia_traducao_zona_update BEFORE UPDATE ON anomalia_traducao
FOR EACH ROW EXECUTE FUNCTION cancel_anomalia_traducao_zona_func();

CREATE FUNCTION cancel_anomalia_zona_func()
RETURNS TRIGGER 
AS
$$
DECLARE z1p1 POINT;
DECLARE z1p2 POINT;
DECLARE z2p1 POINT;
DECLARE z2p2 POINT;
BEGIN
    IF EXISTS (SELECT * FROM anomalia_traducao WHERE anomalia_traducao.id = new.id) THEN
        SELECT zona2[0] INTO z2p1 FROM anomalia_traducao WHERE new.id = anomalia_traducao.id;
        SELECT zona2[1] INTO z2p2 FROM anomalia_traducao WHERE new.id = anomalia_traducao.id;
        SELECT new.zona[0] INTO z1p1;
        SELECT new.zona[1] INTO z1p2;
        IF NOT (z1p1[0] < z2p2[0] OR z2p1[0] < z1p2[0] OR z1p2[1] > z2p1[1] OR z2p2[1] > z1p1[1]) THEN
            RAISE EXCEPTION '(RI-1) A zona da anomalia_tradução, % %, não se pode sobrepor à zona da anomalia correspondente, % %', z2p1,z2p2,z1p1,z1p2;
        END IF;
    END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER cancel_anomalia_zona_update BEFORE UPDATE ON anomalia
FOR EACH ROW EXECUTE FUNCTION cancel_anomalia_zona_func();


-- RI 4, 5 e 6

CREATE FUNCTION verify_utilizador_proc()
RETURNS TRIGGER
AS
$$
BEGIN
    IF (NOT EXISTS (SELECT email FROM utilizador_regular WHERE utilizador_regular.email = new.email) AND NOT EXISTS (SELECT email FROM utilizador_qualificado WHERE utilizador_qualificado.email = new.email)) THEN
        RAISE EXCEPTION '(RI-4) email, %, tem de figurar em ​utilizador_regular ou em ​utilizador_qualificado', new.email;
	END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE FUNCTION remove_utilizador_proc()
RETURNS TRIGGER
AS
$$
BEGIN
    IF (EXISTS (SELECT email FROM utilizador WHERE utilizador.email = old.email) AND NOT EXISTS (SELECT email FROM utilizador_regular WHERE utilizador_regular.email = old.email) AND NOT EXISTS (SELECT email FROM utilizador_qualificado WHERE utilizador_qualificado.email = old.email)) THEN
        RAISE EXCEPTION '(RI-4) email, %, tem de figurar em ​utilizador_regular ou em ​utilizador_qualificado', old.email;
	END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE FUNCTION verify_utilizador_qualificado_proc()
RETURNS TRIGGER
AS
$$
BEGIN
    IF (EXISTS (SELECT email FROM utilizador_regular WHERE utilizador_regular.email = new.email)) THEN
        RAISE EXCEPTION '(RI-5) email, %, nao pode figurar ​utilizador_regular ', new.email;
	END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE FUNCTION verify_utilizador_regular_proc()
RETURNS TRIGGER
AS
$$
BEGIN
    IF (EXISTS (SELECT email FROM utilizador_qualificado WHERE utilizador_qualificado.email = new.email)) THEN
        RAISE EXCEPTION '(RI-6) email, %, nao pode figurar utilizador_qualificado ', new.email;
	END IF;
    return new;
END;
$$
LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER verify_utilizador AFTER INSERT ON utilizador
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE PROCEDURE verify_utilizador_proc();

CREATE TRIGGER verify_utilizador_regular BEFORE INSERT ON utilizador_regular
FOR EACH ROW EXECUTE PROCEDURE verify_utilizador_regular_proc();

CREATE TRIGGER verify_utilizador_qualificado BEFORE INSERT ON utilizador_qualificado
FOR EACH ROW EXECUTE PROCEDURE verify_utilizador_qualificado_proc();

CREATE CONSTRAINT TRIGGER remove_utilizador_regular AFTER DELETE ON utilizador_regular
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE PROCEDURE remove_utilizador_proc();

CREATE CONSTRAINT TRIGGER remove_utilizador_qualificado AFTER DELETE ON utilizador_qualificado
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE PROCEDURE remove_utilizador_proc();
