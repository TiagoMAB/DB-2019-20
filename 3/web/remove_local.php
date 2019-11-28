<html>
    <body>
        <?php
            $nome = $_REQUEST['nome'];
            try
            {
                include "settings.php";

                $sql = "DELETE FROM local_publico WHERE nome = :nome ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':nome' => $nome]);
                $db = null;
                echo("<p>Success?</p>");
                header("Location: /local.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>