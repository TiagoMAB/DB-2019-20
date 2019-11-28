<html>
    <body>
        <h3>Locais</h3>
        <p>Inserir novo item: </p>
        <form action="add_item.php" method="post">
        <p> Id: <input type="number" name="id"/> 
            Descrição: <input type="text" name="descricao"/> 
            Localizacão: <input type="text" name="localizacao"/> 
            Latitude: <input type="number" step="any" name="latitude"/> 
            Longitude: <input type="number" step="any" name="longitude"/></p>
        <input type="submit" value="Adicionar">
        </form>

        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT id, descricao, localizacao, latitude, longitude FROM item;";
            $result = $db->prepare($sql);
            $result->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['id']}</td>\n");
                echo("<td>{$row['descricao']}</td>\n");
                echo("<td>{$row['localizacao']}</td>\n");
                echo("<td>{$row['latitude']}</td>\n");
                echo("<td>{$row['longitude']}</td>\n");
                echo("<td><a href=\"remove_item.php?id={$row['id']}\">Remover item</a></td>\n");
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
