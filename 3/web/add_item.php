<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $id = $_REQUEST['id'];
                $descricao = $_REQUEST['descricao'];
                $localizacao = $_REQUEST['localizacao'];
                $latitude = $_REQUEST['latitude'];
                $longitude = $_REQUEST['longitude'];
                
                $sql = "INSERT INTO item VALUES (:id, :descricao, :localizacao, :latitude, :longitude) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':id' => $id, ':descricao' => $descricao, ':localizacao' => $localizacao, ':latitude' => $latitude, ':longitude' => $longitude]);
                $db = null;
                echo("<p>Success?</p>");
                header("Location: /item.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>