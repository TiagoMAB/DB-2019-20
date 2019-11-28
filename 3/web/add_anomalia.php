<html>
    <body>
        <?php
            $id = $_REQUEST['id'];
            $lingua = $_REQUEST['lingua'];
            $imagem = $_REQUEST['imagem'];
            $descricao = $_REQUEST['descricao'];
            $redacao = $_REQUEST['redacao'] ? true : false;
            if ($redacao == null) {
                $redacao = 0;
            }
            $zona = "(" . strval($_REQUEST['x']) . "," . strval($_REQUEST['y']) . "," . strval($_REQUEST['x1']) . "," . strval($_REQUEST['y1']) . ")";
            $x2 = $_REQUEST['x2'];
            $y2 = $_REQUEST['y2'];
            $x21 = $_REQUEST['x21'];
            $y21 = $_REQUEST['y21'];
            $lingua2 = $_REQUEST['lingua2'];
            $traducao = true;
            if ($x2 == null || $y2 == null || $x21 == null || $y21 == null || $lingua2 == null) {
                $traducao = false;
            }
            try
            {
                $host = "127.0.0.1";
                $user ="postgres";
                $password = "xxx";
                $dbname = "E3";

                $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
                $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                $sql = "INSERT INTO anomalia VALUES (:id, :zona, :imagem, :lingua, :ts, :descricao, :redacao) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':id' => $id, ':zona' => $zona, ':imagem' => $imagem, ':lingua' => $lingua, ':ts' => date("Y-m-d h:i:s"), ':descricao' => $descricao, ':redacao' => $redacao]);

                if ($traducao == true) {
                    $sql = "INSERT INTO anomalia_traducao VALUES (:id, :zona, :lingua) ";
                    $result = $db->prepare($sql);
                    $result->execute([':id' => $id, ':zona' => $zona2, ':lingua' => $lingua2]);
                }

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