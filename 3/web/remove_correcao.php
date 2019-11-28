<html>
    <body>
        <?php
            $email = $_REQUEST['email'];
            $nro = $_REQUEST['nro'];

            try
            {
                include "settings.php";

                $sql = "DELETE FROM proposta_de_correcao WHERE email = :email AND nro = :nro ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro]);
                $db = null;
                echo("<p>Success?</p>");
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