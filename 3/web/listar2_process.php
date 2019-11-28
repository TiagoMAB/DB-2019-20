<html>
    <body>
        <?php
            $x = $_REQUEST['x'];
            $y = $_REQUEST['y'];
            $latitude = $_REQUEST['latitude'];
            $longitude = $_REQUEST['longitude'];
            $la1= $latitude - $x;
            $la2= $latitude + $x;
            $lo1= $longitude - $y;
            $lo2= $longitude + $y;
            $date = date("Y-m-d h:i:s");
            $date = date("Y-m-d h:i:s", strtotime("-3 months", strtotime($date)));
            
            try
            {
                include "settings.php";

                $sql = "SELECT * FROM anomalia INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id
                        INNER JOIN item ON incidencia.item_id = item.id
                        NATURAL JOIN local_publico 
                        WHERE (local_publico.latitude BETWEEN :la1 AND :la2) AND (local_publico.longitude BETWEEN :lo1 AND :lo2)
                        AND anomalia.ts >= :ts ";
                
                echo("<p>$sql</p>");
                $result = $db->prepare($sql);
                $result->execute([':la1' => $la1, ':la2' => $la2, ':lo1' => $lo1, ':lo2' => $lo2, ':ts' => $date]);

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