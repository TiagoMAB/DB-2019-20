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