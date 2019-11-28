<html>
    <body>
    <h3>Registar incidências</h3>
        <p>Selecione a anomalia </p>
        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT id FROM anomalia EXCEPT (SELECT anomalia_id AS id FROM incidencia)";
            $result = $db->prepare($sql);
            $result->execute();

            $options = "";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} </option>\n";
            }

            if ($options == "") {
                echo("<p>Não há anomalias para registar incidências");
            }
            else {
                echo("<form action=\"incidencia_process.php\" method=\"post\"><table border=\"0\" cellspacing=\"5\">");

                echo("<select name=\"anomalia\">{$options}</select><br>");
                
                $sql = "SELECT id FROM item";
                $result = $db->prepare($sql);
                $result->execute();

                
                $options = "";
                $i = 0;
                foreach($result as $row)
                {
                    $i += 1;
                    $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} </option>\n";
                }
                
                echo(" <p>Selecione o item </p>");
                echo("<select name=\"item\">{$options}</select><br>");
                
                $sql = "SELECT email FROM utilizador";
                $result = $db->prepare($sql);
                $result->execute();

                
                $options = "";
                $i = 0;
                foreach($result as $row)
                {
                    $i += 1;
                    $options = $options . "<option value=\"{$row['email']}\"> {$i} - {$row['email']} </option>\n";
                }
                
                echo(" <p>Selecione o email </p>");
                echo("<select name=\"email\">{$options}</select><br><br>");

                echo("<input type=\"submit\" value=\"Registar\"></form>");
            }

            $sql = "SELECT * FROM incidencia;";
            $result = $db->prepare($sql);
            $result->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['anomalia_id']}</td>\n");
                echo("<td>{$row['item_id']}</td>\n");
                echo("<td>{$row['email']}</td>\n");
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
