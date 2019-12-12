----------------------------------------
-- Populate
----------------------------------------

INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_qualificado' FROM utilizador_qualificado);
INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_regular' FROM utilizador_regular);

INSERT INTO d_tempo(dia, dia_da_semana, semana, mes, trimestre, ano) (SELECT DISTINCT EXTRACT(DAY FROM ts), EXTRACT(DOW FROM ts), EXTRACT(WEEK FROM ts), EXTRACT(MONTH FROM ts), EXTRACT(QUARTER FROM ts), EXTRACT(YEAR FROM ts) FROM anomalia);

INSERT INTO d_local(latitude, longitude, nome) (SELECT latitude, longitude, nome FROM local_publico);

INSERT INTO d_lingua(lingua) (SELECT DISTINCT lingua FROM anomalia);

INSERT INTO f_anomalia(id_utilizador, id_tempo, id_local, id_lingua, tipo_anomalia, com_proposta) VALUES (

    SELECT id_utilizador, id_tempo, id_local, id_lingua
    FROM correcao NATURAL JOIN utilizador 
	INNER JOIN anomalia ON correcao.anomalia_id = anomalia.id
	INNER JOIN anomalia_traducao ON correcao.anomalia_id = anomalia_traducao.id
	INNER JOIN incidencia ON incidencia.anomalia_id = correcao.anomalia_id
	INNER JOIN item ON item.id = incidencia.item_id
	INNER JOIN d_utilizador ON utilizador.email = d_utilizador.email
	INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude
	INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
	INNER JOIN d_tempo ON EXTRACT(DAY FROM anomalia.ts) = d_tempo.dia AND EXTRACT(DOW FROM anomalia.ts) = d_tempo.dia_da_semana AND EXTRACT(WEEK FROM anomalia.ts) = d_tempo.semana AND EXTRACT(MONTH FROM anomalia.ts) = d_tempo.mes AND EXTRACT(QUARTER FROM anomalia.ts) = d_tempo.trimestre AND EXTRACT(YEAR FROM anomalia.ts) = d_tempo.ano,
    "traducao", TRUE

)

--INSERT INTO f_anomalia(id_utilizador, id_tempo, id_local, id_lingua, tipo_anomalia, com_porposta) 
--    (SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia_redacao', incidencia.anomalia_id IN (SELECT anomalia_id FROM correcao)
--    FROM incidencia INNER JOIN anomalia ON anomalia.id = incidencia.anomalia_id INNER JOIN item ON item.id = incidencia.item_id INNER JOIN local_publico ON item.latitude = local_publico.latitude AND item.longitude = local_publico.longitude 
--         INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email INNER JOIN d_tempo ON (something) INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
--    WHERE tem_anomalia_redacao = TRUE);