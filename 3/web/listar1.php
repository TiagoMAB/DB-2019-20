<html>
    <body>
    <h3>Listar anomalias</h3>
        <p>Selecione dois locais para listar as anomalias de incidências registadas na área compreendida entre eles: </p>
        <?php
        try
        {

            include "settings.php";

            $sql = "SELECT nome, latitude, longitude FROM local_publico;";
            $result = $db->prepare($sql);
            $result->execute();
            
            echo("<form action=\"listar1_process.php\" method=\"post\"><table border=\"0\" cellspacing=\"5\">");

            $options = "";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $options = $options . "<option value=\"{$row['latitude']}|{$row['longitude']}\"> {$i} - {$row['nome']} - Latitude: {$row['latitude']} - Longitude: {$row['longitude']} </option>\n";
            }

            echo("<select name=\"first\">{$options}</select><br>");
            echo("<select name=\"second\">{$options}</select><br>");

            echo("<input type=\"submit\" value=\"Listar\"></form>");

            $db = null;
        }
        catch (PDOException $e)
        {
            echo("<p>ERROR: {$e->getMessage()}</p>");
        }
        ?>
    </body>
</html>
