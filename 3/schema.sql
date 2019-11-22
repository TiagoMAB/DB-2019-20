
DROP TABLE IF EXISTS local_publico cascade;
DROP TABLE IF EXISTS item cascade;
DROP TABLE IF EXISTS anomalia cascade;
DROP TABLE IF EXISTS anomalia_traducao cascade;
DROP TABLE IF EXISTS duplicado cascade;
DROP TABLE IF EXISTS utilizador cascade;
DROP TABLE IF EXISTS utilizador_qualificado cascade;
DROP TABLE IF EXISTS utilizador_regular cascade;
DROP TABLE IF EXISTS incidencia cascade;
DROP TABLE IF EXISTS proposta_de_correcao cascade;
DROP TABLE IF EXISTS correcao cascade;



CREATE TABLE local_publico
   (latitude 	FLOAT	NOT NULL,
    longitude 	FLOAT	NOT NULL,
    nome 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_local_publico PRIMARY KEY(latitude, longitude));

CREATE TABLE item
   (id 	INTEGER	NOT NULL,
    descricao 	VARCHAR(255)	NOT NULL,
    localizacao 	VARCHAR(255)	NOT NULL,
    latitude 	FLOAT	NOT NULL,
    longitude 	FLOAT	NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY(id),
    CONSTRAINT fk_item_local_publico FOREIGN KEY(latitude, longitude) REFERENCES local_publico(latitude, longitude));

CREATE TABLE anomalia
   (id 	INTEGER	NOT NULL,
    zona	VARCHAR(255)	NOT NULL,
    imagem 	VARCHAR(255)	NOT NULL,
    lingua 	VARCHAR(255)	NOT NULL,
    ts 	TIMESTAMP	NOT NULL,
    descricao 	VARCHAR(255)	NOT NULL,
    tem_anomalia_redacao  BIT(1)	NOT NULL,
    CONSTRAINT pk_anomalia PRIMARY KEY(id));

CREATE TABLE anomalia_traducao
   (id 	INTEGER	NOT NULL,
    zona2	VARCHAR(255)	NOT NULL,
    lingua2 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_anomalia_traducao PRIMARY KEY(id),
    CONSTRAINT fk_anomalia_traducao_anomalia FOREIGN KEY(id) REFERENCES anomalia(id));
    --CONSTRAINT chk_anomalia_traducao CHECK (zona2 <> (SELECT zona FROM anomalia WHERE id = pk_anomalia_traducao) AND lingua2 <> (SELECT lingua FROM anomalia WHERE id = pk_anomalia_traducao)));

CREATE TABLE duplicado
   (item1 	INTEGER	NOT NULL,
    item2 	INTEGER	NOT NULL,
    CONSTRAINT pk_duplicado PRIMARY KEY(item1, item2),
    CONSTRAINT fk_duplicado_item1 FOREIGN KEY(item1) REFERENCES item(id),
    CONSTRAINT fk_duplicado_item2 FOREIGN KEY(item2) REFERENCES item(id));
    CONSTRAINT chk_duplicado CHECK (item1 < item2));

CREATE TABLE utilizador
   (email 	VARCHAR(255)	NOT NULL,
    passsword	VARCHAR(255) NOT NULL, ---deliberate sss as password seems to be a term used by the language
    CONSTRAINT pk_utilizador PRIMARY KEY(email));

CREATE TABLE utilizador_qualificado
   (email 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_utilizador_qualificado PRIMARY KEY(email),
    CONSTRAINT fk_utilizador_qualificado_utilizador FOREIGN KEY(email) REFERENCES utilizador(email));
    --CONSTRAINT chk_utilizador_qualificado CHECK (email NOT IN (SELECT email FROM utilizador_regular)));

CREATE TABLE utilizador_regular
   (email 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_utilizador_regular PRIMARY KEY(email),
    CONSTRAINT fk_utilizador_regular_utilizador FOREIGN KEY(email) REFERENCES utilizador(email));
    --CONSTRAINT chk_utilizador_regular CHECK (email NOT IN (SELECT email FROM utilizador_qualificado)));

CREATE TABLE incidencia
   (anomalia_id 	INTEGER NOT NULL,
    item_id 	INTEGER NOT NULL,
    email 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_incidencia PRIMARY KEY(anomalia_id),
    CONSTRAINT fk_incidencia_anomalia FOREIGN KEY(anomalia_id) REFERENCES anomalia(id),
    CONSTRAINT fk_incidencia_item FOREIGN KEY(item_id) REFERENCES item(id),
    CONSTRAINT fk_incidencia_utilizador FOREIGN KEY(email) REFERENCES utilizador(email));

CREATE TABLE proposta_de_correcao
   (email 	VARCHAR(255)	NOT NULL,
    nro 	VARCHAR(255)	NOT NULL,
    data_hora 	TIMESTAMP	NOT NULL,
    texto 	VARCHAR(255)	NOT NULL,
    CONSTRAINT pk_proposta_de_correcao PRIMARY KEY(email, nro),
    CONSTRAINT fk_proposta_de_correcao_utilizador_qualificado FOREIGN KEY(email) REFERENCES utilizador_qualificado(email));

    ---Não percebo a parte em que diz que "email e nro têm de figurar em correcao"

CREATE TABLE correcao
   (email 	VARCHAR(255)	NOT NULL,
    nro 	VARCHAR(255)	NOT NULL,
    anomalia_id     INTEGER     NOT NULL,
    CONSTRAINT pk_proposta_de_correcao PRIMARY KEY(email, nro, anomalia_id),
    CONSTRAINT fk_correcao_proposta_de_correcao FOREIGN KEY(email, nro) REFERENCES proposta_de_correcao(email, nro),
    CONSTRAINT fk_correcao_incidencia FOREIGN KEY (anomalia_id) REFERENCES incidencia(anomalia_id));

----------------------------------------
-- Populate Relations 
----------------------------------------

---insert into customer values ('Adams',	'Main Street',	'Lisbon');