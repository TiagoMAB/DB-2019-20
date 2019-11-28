<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $nome = $_REQUEST['nome'];
                $latitude = $_REQUEST['latitude'];
                $longitude = $_REQUEST['longitude'];
                
                $sql = "INSERT INTO local_publico VALUES (:latitude, :longitude, :nome) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':latitude' => $latitude, ':longitude' => $longitude, ':nome' => $nome]);
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