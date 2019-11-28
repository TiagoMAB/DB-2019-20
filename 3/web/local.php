<html>
    <body>
        <h3>Locais</h3>
        <p>Inserir novo local: </p>
        <form action="add_local.php" method="post">
        <p> Nome do local: <input type="text" name="nome"/> 
            Latitude: <input type="number" step="any" name="latitude"/> 
            Longitude: <input type="number" step="any" name="longitude"/></p>
        <input type="submit" value="Adicionar">
        </form>

        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT nome, latitude, longitude FROM local_publico;";
            $result = $db->prepare($sql);
            $result->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['nome']}</td>\n");
                echo("<td>{$row['latitude']}</td>\n");
                echo("<td>{$row['longitude']}</td>\n");
                echo("<td><a href=\"remove_local.php?nome={$row['nome']}\">Remover local</a></td>\n");
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
