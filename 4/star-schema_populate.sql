----------------------------------------
-- Populate
----------------------------------------

INSERT INTO d_utilizador(email, tipo) SELECT email, 'utilizador_qualificado' FROM utilizador_qualificado;
INSERT INTO d_utilizador(email, tipo) SELECT email, 'utilizador_regular' FROM utilizador_regular;

INSERT INTO d_tempo(dia, dia_da_semana, semana, mes, trimestre, ano) SELECT EXTRACT(DAY FROM ts), EXTRACT(DOW FROM ts), EXTRACT(WEEK FROM ts), EXTRACT(MONTH FROM ts), EXTRACT(QUARTER FROM ts), EXTRACT(YEAR FROM ts) FROM anomalia;

INSERT INTO d_local(latitude, longitude, nome) SELECT latitude, longitude, nome FROM local_publico;

INSERT INTO d_lingua(lingua) SELECT lingua FROM anomalia;


--INSERT INTO f_anomalia(id_utilizador, id_tempo, id_local, id_lingua, tipo_anomalia, com_porposta) 
--    SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia_redacao', TRUE 
--    FROM d_utilizador NATURAL JOIN d_tempo NATURAL JOIN d_local NATURAL JOIN d_lingua NATURAL JOIN anomalia NATURAL JOIN correcao
--    WHERE 