<html>
    <body>
    <h3>Inserir, editar e remover correcções e propostas de correcção. </h3>
        <p>Selecione o email</p>
        <?php
        try
        {
            include "settings.php";


            echo("<form action=\"correcao_process.php\" method=\"post\"><table border=\"0\" cellspacing=\"5\">");

            $sql = "SELECT email FROM utilizador;";
            $result = $db->prepare($sql);
            $result->execute();

            $options = "";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $options = $options . "<option value=\"{$row['email']}\"> {$i} - {$row['email']}</option>\n";
            }

            echo("<select name=\"email\">{$options}</select><br><p>Selecione a anomalia</p>");

            $sql = "SELECT id FROM anomalia;";
            $result = $db->prepare($sql);
            $result->execute();

            $options = "";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']}</option>\n";
            }

            echo("<select name=\"anomalia\">{$options}</select><br><p>Insira o texto</p>");
            echo("<p>Texto: <input type=\"text\" name=\"texto\"></p>");
            echo("<input type=\"submit\" value=\"Adicionar\"></form>");

            $sql = "SELECT * FROM correcao;";
            $result = $db->prepare($sql);
            $result->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['email']}</td>\n");
                echo("<td>{$row['nro']}</td>\n");
                echo("<td>{$row['anomalia_id']}</td>\n");
                echo("<td><a href=\"remove_correcao.php?email={$row['email']}&&nro={$row['nro']}\">Remover</a></td>\n");
                echo("<td><a href=\"edit_correcao.php?email={$row['email']}&&nro={$row['nro']}\">Editar</a></td>\n");
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
