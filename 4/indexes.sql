----------------------------------------
-- Indexes
----------------------------------------

DROP INDEX IF EXISTS index1;
DROP INDEX IF EXISTS index2;
DROP INDEX IF EXISTS index3;
DROP INDEX IF EXISTS index4;

--1.2
CREATE INDEX index1 ON correcao USING BTREE(data_hora);

--2
CREATE INDEX index2 ON incidencia USING HASH(anomalia_id);

--3.2
CREATE INDEX index3 ON correcao USING BTREE(anomalia_id);

--4
CREATE INDEX index4 ON anomalia USING BTREE(lingua, tem_anomalia_redacao, ts);