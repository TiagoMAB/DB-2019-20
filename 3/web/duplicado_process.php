<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $item1 = $_REQUEST['item1'];
                $item2 = $_REQUEST['item2'];
                
                echo($item1);
                echo("<br>");
                echo($item2);

                $sql = "INSERT INTO duplicado VALUES (:item1, :item2) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':item1' => $item1, ':item2' => $item2]);

                $db = null;
                echo("<p>Success?</p>");
                header("Location: /duplicado.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>