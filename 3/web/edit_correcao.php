<html>
    <body>
        <?php
            try
            {
                include "settings.php";

                $email = $_REQUEST['email'];
                $nro = $_REQUEST['nro'];
                $texto = $_REQUEST['texto'];

                if ($texto) {
                    echo($texto);
                    $sql = "UPDATE proposta_de_correcao SET texto = :texto WHERE email = :email AND nro =:nro;";
                
                    echo("<p>$sql</p>");

                    $result = $db->prepare($sql);
                    $result->execute([':texto' => $texto, ':email' => $email, ':nro' => $nro]);

                    header("Location: /correcao.php");
                }
                
                $sql = "SELECT texto FROM proposta_de_correcao WHERE email = :email AND nro =:nro;";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro]);

                foreach ($result as $row) {
                    echo("<p>Texto atual:\n {$row['texto']}</p>");
                }

                echo("<form action=\"edit_correcao.php?email={$email}&&nro={$nro}\" method=\"post\"><p>Altere</p><p>Texto: <input type=\"text\" name=\"texto\" value={$row['texto']}></p>");
                echo("<input type=\"submit\" value=\"Alterar\"></form>");

                $db = null;
                exit;
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>