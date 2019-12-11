----------------------------------------
-- Populate
----------------------------------------

INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_qualificado' FROM utilizador_qualificado);
INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_regular' FROM utilizador_regular);

INSERT INTO d_tempo(dia, dia_da_semana, semana, mes, trimestre, ano) (SELECT EXTRACT(DAY FROM ts), EXTRACT(DOW FROM ts), EXTRACT(WEEK FROM ts), EXTRACT(MONTH FROM ts), EXTRACT(QUARTER FROM ts), EXTRACT(YEAR FROM ts) FROM anomalia);

INSERT INTO d_local(latitude, longitude, nome) (SELECT latitude, longitude, nome FROM local_publico);

INSERT INTO d_lingua(lingua) (SELECT lingua FROM anomalia);


--INSERT INTO f_anomalia(id_utilizador, id_tempo, id_local, id_lingua, tipo_anomalia, com_porposta) 
--    (SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia_redacao', incidencia.anomalia_id IN (SELECT anomalia_id FROM correcao)
--    FROM incidencia INNER JOIN anomalia ON anomalia.id = incidencia.anomalia_id INNER JOIN item ON item.id = incidencia.item_id INNER JOIN local_publico ON item.latitude = local_publico.latitude AND item.longitude = local_publico.longitude 
--         INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email INNER JOIN d_tempo ON (something) INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
--    WHERE tem_anomalia_redacao = TRUE);