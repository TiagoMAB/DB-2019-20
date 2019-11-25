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