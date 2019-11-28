<html>
    <body>
        <h3>Utilizadores</h3>
 
        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT * FROM utilizador;";
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
                echo("<td>{$row['passcode']}</td>\n");
                echo("<td><a href=\"password.php?email={$row['email']}\">Change password</a></td>\n");
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
