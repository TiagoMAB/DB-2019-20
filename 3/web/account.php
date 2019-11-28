<html>
    <body>
        <h3>Utilizadores</h3>
 
        <?php
        try
        {
            $host = "127.0.0.1";
            $user ="postgres";
            $password = "xxx";
            $dbname = "E3";


            $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $sql = "SELECT email, passcode FROM utilizador;";
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
