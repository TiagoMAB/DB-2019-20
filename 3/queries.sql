SELECT nome
FROM local_publico NATURAL JOIN (
	SELECT latitude, longitude
	FROM incidencia INNER JOIN item ON item.id = incidencia.item_id
	GROUP BY latitude, longitude
	HAVING COUNT(incidencia.anomalia_id) = (
		SELECT MAX(anom_count) FROM (
			SELECT latitude, longitude, COUNT(incidencia.anomalia_id) as anom_count
			FROM incidencia INNER JOIN item ON item.id = incidencia.item_id
			GROUP BY latitude, longitude
		) as x
	)
) as y;



SELECT email
FROM anomalia NATURAL JOIN anomalia_traducao INNER JOIN incidencia ON anomalia_traducao.id = incidencia.anomalia_id NATURAL JOIN utilizador_regular
WHERE anomalia.ts >= '2019-01-01 00:00:00' AND anomalia.ts <= '2019-06-30 23:59:59'
GROUP BY email
HAVING COUNT(id) = (
	SELECT MAX(anom_count) FROM (
		SELECT email, COUNT(id) AS anom_count 
		FROM anomalia NATURAL JOIN anomalia_traducao INNER JOIN incidencia ON anomalia_traducao.id = incidencia.anomalia_id NATURAL JOIN utilizador_regular
		WHERE anomalia.ts >= '2019-01-01 00:00:00' AND anomalia.ts <= '2019-06-30 23:59:59'
		GROUP BY email
	) as x
);



SELECT DISTINCT email
FROM (item INNER JOIN incidencia ON item.id = incidencia.item_id) I
WHERE NOT EXISTS (
	(SELECT local_publico.latitude, local_publico.longitude
	 FROM anomalia INNER JOIN incidencia ON anomalia.id = anomalia_id INNER JOIN item ON item.id = item_id RIGHT OUTER JOIN local_publico ON item.latitude = local_publico.latitude AND item.longitude = local_publico.longitude
	 WHERE (local_publico.latitude > (SELECT latitude FROM local_publico WHERE local_publico.nome = 'Rio Maior') AND (ts IS NULL OR ts >= '2019-01-01 00:00:00' AND ts <= '2019-12-31 23:59:59')))
	EXCEPT
	(SELECT latitude, longitude
	 FROM item INNER JOIN incidencia ON item.id = incidencia.item_id
	 WHERE email = I.email)
);



SELECT DISTINCT email
FROM (incidencia NATURAL JOIN correcao) A
WHERE EXISTS (
	(SELECT anomalia_id
	 FROM anomalia INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id INNER JOIN item ON incidencia.item_id = item.id
	 WHERE email = A.email AND (item.latitude < (SELECT latitude FROM local_publico WHERE local_publico.nome = 'Rio Maior') AND DATE_PART('year', ts) = DATE_PART('year', CURRENT_DATE)))
	EXCEPT
	(SELECT correcao.anomalia_id
	 FROM correcao INNER JOIN anomalia ON correcao.anomalia_id = anomalia.id INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id INNER JOIN item ON item.id = incidencia.item_id
	 WHERE correcao.email = A.email)
);