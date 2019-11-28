<html>
    <body>
    <h3>Registar duplicados</h3>
        <p>Selecione dois itens para registar como duplicados </p>
        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT * FROM item;";
            $result = $db->prepare($sql);
            $result->execute();
            
            echo("<form action=\"duplicado_process.php\" method=\"post\"><table border=\"0\" cellspacing=\"5\">");

            $options = "";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} - Latitude: {$row['latitude']} - Longitude: {$row['longitude']} </option>\n";
            }

            echo("<select name=\"item1\">{$options}</select><br>");
            echo("<select name=\"item2\">{$options}</select><br>");
            echo("<input type=\"submit\" value=\"Registar\"></form>");

            $sql = "SELECT * FROM duplicado;";
            $result = $db->prepare($sql);
            $result->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['item1']}</td>\n");
                echo("<td>{$row['item2']}</td>\n");
                echo("</tr>\n");
            }

            echo("</table>\n");

            $db = null;
        }
        catch (PDOException $e)
        {
            echo("<p>ERROR: {$e->getMessage()}</p>");
        }
        ?>
    </body>
</html>
