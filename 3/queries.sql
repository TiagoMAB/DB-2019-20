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
FROM anomalia_traducao INNER JOIN incidencia ON anomalia_traducao.id = incidencia.anomalia_id NATURAL JOIN utilizador_regular
GROUP BY email
HAVING COUNT(id) = (
	SELECT MAX(anom_count) FROM (
		SELECT email, COUNT(id) AS anom_count 
		FROM anomalia_traducao INNER JOIN incidencia ON anomalia_traducao.id = incidencia.anomalia_id NATURAL JOIN utilizador_regular
		GROUP BY email
	) as x
);