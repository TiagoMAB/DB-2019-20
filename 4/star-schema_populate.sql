----------------------------------------
-- Populate
----------------------------------------

INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_qualificado' FROM utilizador_qualificado);
INSERT INTO d_utilizador(email, tipo) (SELECT email, 'utilizador_regular' FROM utilizador_regular);

INSERT INTO d_tempo(dia, dia_da_semana, semana, mes, trimestre, ano) (SELECT DISTINCT EXTRACT(DAY FROM ts), EXTRACT(DOW FROM ts), EXTRACT(WEEK FROM ts), EXTRACT(MONTH FROM ts), EXTRACT(QUARTER FROM ts), EXTRACT(YEAR FROM ts) FROM anomalia);

INSERT INTO d_local(latitude, longitude, nome) (SELECT latitude, longitude, nome FROM local_publico);

INSERT INTO d_lingua(lingua) (SELECT DISTINCT lingua FROM anomalia);


INSERT INTO f_anomalia(id_utilizador, id_tempo, id_local, id_lingua, tipo_anomalia, com_proposta) (

    SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia traducao', TRUE
    	FROM anomalia NATURAL JOIN anomalia_traducao
		INNER JOIN incidencia ON incidencia.anomalia_id = anomalia.id
		INNER JOIN item ON item.id = incidencia.item_id
		INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email
		INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude
		INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
		INNER JOIN d_tempo ON EXTRACT(DAY FROM anomalia.ts) = d_tempo.dia AND EXTRACT(DOW FROM anomalia.ts) = d_tempo.dia_da_semana AND EXTRACT(WEEK FROM anomalia.ts) = d_tempo.semana AND EXTRACT(MONTH FROM anomalia.ts) = d_tempo.mes AND EXTRACT(QUARTER FROM anomalia.ts) = d_tempo.trimestre AND EXTRACT(YEAR FROM anomalia.ts) = d_tempo.ano
		WHERE anomalia.id IN (SELECT anomalia_id AS id FROM correcao)
	UNION
	SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia traducao', FALSE
		FROM anomalia NATURAL JOIN anomalia_traducao
		INNER JOIN incidencia ON incidencia.anomalia_id = anomalia.id
		INNER JOIN item ON item.id = incidencia.item_id
		INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email
		INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude
		INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
		INNER JOIN d_tempo ON EXTRACT(DAY FROM anomalia.ts) = d_tempo.dia AND EXTRACT(DOW FROM anomalia.ts) = d_tempo.dia_da_semana AND EXTRACT(WEEK FROM anomalia.ts) = d_tempo.semana AND EXTRACT(MONTH FROM anomalia.ts) = d_tempo.mes AND EXTRACT(QUARTER FROM anomalia.ts) = d_tempo.trimestre AND EXTRACT(YEAR FROM anomalia.ts) = d_tempo.ano
		WHERE anomalia.id NOT IN (SELECT anomalia_id AS id FROM correcao)
	UNION 
	SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia redacao', FALSE
		FROM anomalia
		INNER JOIN incidencia ON incidencia.anomalia_id = anomalia.id
		INNER JOIN item ON item.id = incidencia.item_id
		INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email
		INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude
		INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
		INNER JOIN d_tempo ON EXTRACT(DAY FROM anomalia.ts) = d_tempo.dia AND EXTRACT(DOW FROM anomalia.ts) = d_tempo.dia_da_semana AND EXTRACT(WEEK FROM anomalia.ts) = d_tempo.semana AND EXTRACT(MONTH FROM anomalia.ts) = d_tempo.mes AND EXTRACT(QUARTER FROM anomalia.ts) = d_tempo.trimestre AND EXTRACT(YEAR FROM anomalia.ts) = d_tempo.ano
		WHERE anomalia.id NOT IN (SELECT anomalia_id AS id FROM correcao) 
		AND anomalia.id NOT IN (SELECT id FROM anomalia_traducao)
	UNION 
	SELECT id_utilizador, id_tempo, id_local, id_lingua, 'anomalia redacao', TRUE
		FROM anomalia
		INNER JOIN incidencia ON incidencia.anomalia_id = anomalia.id
		INNER JOIN item ON item.id = incidencia.item_id
		INNER JOIN d_utilizador ON incidencia.email = d_utilizador.email
		INNER JOIN d_local ON d_local.latitude = item.latitude AND d_local.longitude = item.longitude
		INNER JOIN d_lingua ON anomalia.lingua = d_lingua.lingua
		INNER JOIN d_tempo ON EXTRACT(DAY FROM anomalia.ts) = d_tempo.dia AND EXTRACT(DOW FROM anomalia.ts) = d_tempo.dia_da_semana AND EXTRACT(WEEK FROM anomalia.ts) = d_tempo.semana AND EXTRACT(MONTH FROM anomalia.ts) = d_tempo.mes AND EXTRACT(QUARTER FROM anomalia.ts) = d_tempo.trimestre AND EXTRACT(YEAR FROM anomalia.ts) = d_tempo.ano
		WHERE anomalia.id IN (SELECT anomalia_id AS id FROM correcao) 
		AND anomalia.id NOT IN (SELECT id FROM anomalia_traducao)
)
