<html>
    <body>
        <?php
            $first = $_REQUEST['first'];
            $second = $_REQUEST['second'];
            $first = explode("|", $first);
            $second = explode("|", $second);

            try
            {
                include "settings.php";

                $sql = "SELECT * FROM anomalia INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id
                        INNER JOIN item ON incidencia.item_id = item.id
                        NATURAL JOIN local_publico 
                        WHERE (local_publico.latitude BETWEEN :first1 AND :second1) AND (local_publico.longitude BETWEEN :first2 AND :second2)";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':first1' => $first[0], ':second1' => $second[0], ':first2' => $first[1], ':second2' => $second[1]]);

                $db = null;
                echo("<table border=\"0\" cellspacing=\"5\">\n");
                $i = 0;
                foreach($result as $row)
                {
                    $i += 1;
                    echo("<tr>\n");
                    echo("<td>{$i}</td>\n");
                    echo("<td>{$row['anomalia_id']}</td>\n");
                    echo("</tr>\n");
                }
                    echo("</table>\n");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>