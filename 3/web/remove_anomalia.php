<html>
    <body>
        <?php
            $id = $_REQUEST['id'];
            try
            {
                include "settings.php";

                $sql = "DELETE FROM anomalia WHERE id = :id ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':id' => $id]);
                $db = null;
                echo("<p>Success?</p>");
                header("Location: /anomalia.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>