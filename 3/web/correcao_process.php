<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $email = $_REQUEST['email'];
                $anomalia = $_REQUEST['anomalia'];
                $texto = $_REQUEST['texto'];
                
                $sql = "SELECT COUNT(nro) FROM proposta_de_correcao WHERE email = :email;";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':email' => $email]);

                foreach($result as $row) {
                    $nro = $row['count'] + 1;
                }
                
                $sql = "INSERT INTO proposta_de_correcao VALUES ( :email, :nro, :ts, :texto)";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro, ':ts' => date("Y-m-d h:i:s"), ':texto' => $texto]);

                $sql = "INSERT INTO correcao VALUES (:email, :nro, :anomalia)";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro, 'anomalia' => $anomalia]);


                $db = null;
                header("Location: /correcao.php");
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>