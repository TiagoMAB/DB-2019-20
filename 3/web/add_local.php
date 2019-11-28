<html>
    <body>
        <?php
            $nome = $_REQUEST['nome'];
            $latitude = $_REQUEST['latitude'];
            $longitude = $_REQUEST['longitude'];
            try
            {
                $host = "127.0.0.1";
                $user ="postgres";
                $password = "xxx";
                $dbname = "E3";

                $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
                $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

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