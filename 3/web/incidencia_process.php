<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $anomalia = $_REQUEST['anomalia'];
                $item = $_REQUEST['item'];
                $email = $_REQUEST['email'];

                
                echo($item1);
                echo("<br>");
                echo($item2);

                $sql = "INSERT INTO incidencia VALUES (:anomalia, :item, :email) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':anomalia' => $anomalia, ':item' => $item, ':email' => $email]);

                $db = null;
                echo("<p>Success?</p>");
                header("Location: /incidencia.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>