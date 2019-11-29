<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/file.css">
    </head>
    <body>
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="index.php">Início</a></li>
            <li role="presentation"><a href="utilizador.php">Utilizadores</a></li>
            <li role="presentation"><a href="local.php">Locais</a></li>
            <li role="presentation"><a href="item.php">Itens</a></li>
            <li role="presentation" class="active"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Anomalias</h1>
        </div>  

        
        <form class="container" action="anomalia.php" method="post">
            <div class="form-group">
                <label for="nome">Anomalia ID</label>
                <input type="number" class="form-control" name="id" placeholder="Exemplo: 234" required="required">
            </div>
            <div class="form-group">
                <label for="nome">Lingua</label>
                <input type="text" class="form-control" name="lingua" placeholder="Exemplo: Português" required="required"> 
            </div>
            <div class="form-group">
                <label for="nome">Imagem</label>
                <input type="text" class="form-control" name="imagem" placeholder="Exemplo: Imagem" required="required"> 
            </div>
            <div class="form-group">
                <label for="nome">Descrição</label>
                <input type="text" class="form-control" name="descricao" placeholder="Exemplo: A anomalia refere-se a X e Y." required="required"> 
            </div>
            <div class="form-inline">
                <div class="form-group">
                    <label for="x">X1  </label>
                    <input type="number" class="form-control" step="any" name="x" placeholder="Introduza um valor" required="required">
                    <label for="y">  Y1  </label>
                    <input type="number" class="form-control" step="any" name="y" placeholder="Introduza um valor" required="required">
                    <label for="x1">  X2  </label>
                    <input type="number" class="form-control" step="any" name="x1" placeholder="Introduza um valor" required="required">
                    <label for="y1">  Y2  </label>
                    <input type="number" class="form-control" step="any" name="y1" placeholder="Introduza um valor" required="required"> 
                    <label for="redacao">  Redação? </label>
                    <input type="checkbox" name="redacao" value=1> 
                </div>
            </div>
            <br>
            <button type="submit" class="btn btn-success">Adicionar Anomalia </button>
            <br> <br>
            <div class="form-group">
                <label for="lingua2">Lingua 2</label>
                <input type="text" class="form-control" name="lingua2" placeholder="Exemplo: Português"> 
            </div>
            <div class="form-inline">
                <div class="form-group">
                    <label for="x">X1</label>
                    <input type="number" class="form-control" step="any" name="x2" placeholder="Introduza um valor">
                    <label for="y">  Y1</label>
                    <input type="number" class="form-control" step="any" name="y2" placeholder="Introduza um valor">
                    <label for="x1">  X2 </label>
                    <input type="number" class="form-control" step="any" name="x21" placeholder="Introduza um valor">
                    <label for="y1">  Y2</label>
                    <input type="number" class="form-control" step="any" name="y21" placeholder="Introduza um valor"> 
                </div>
            </div>
            <br>
            <button type="submit" class="btn btn-success">Adicionar Anomalia de Tradução</button>
            <small class="text-muted">Só é adicionada se todos os campos forem preenchidos </small>
        </form>
        <br>

        <?php
        try
        {
            include "settings.php";

            if ($_REQUEST['id'] != null && $_REQUEST['mode'] != null) {
                $id = $_REQUEST['id'];

                $sql = "DELETE FROM anomalia WHERE id = :id ";

                $result = $db->prepare($sql);
                $result->execute([':id' => $id]);
            }
            else if ($_REQUEST['id'] != null && $_REQUEST['mode'] == null) {
                $id = $_REQUEST['id'];
                $lingua = $_REQUEST['lingua'];
                $imagem = $_REQUEST['imagem'];
                $descricao = $_REQUEST['descricao'];
                $redacao = $_REQUEST['redacao'];
                if ($redacao == null) {
                    $redacao = 0;
                }
                $zona = "(" . strval($_REQUEST['x1']) . "," . strval($_REQUEST['y1']) . "),(" . strval($_REQUEST['x']) . "," . strval($_REQUEST['y']) . ")";
                $x2 = $_REQUEST['x2'];
                $y2 = $_REQUEST['y2'];
                $x21 = $_REQUEST['x21'];
                $y21 = $_REQUEST['y21'];
                $lingua2 = $_REQUEST['lingua2'];
                $traducao = true;
                if ($x2 == null || $y2 == null || $x21 == null || $y21 == null || $lingua2 == null) {
                    $traducao = false;
                }

                try {
                    $db->beginTransaction();
                    
                    $sql = "INSERT INTO anomalia VALUES (:id, :zona, :imagem, :lingua, :ts, :descricao, :redacao) ";

                    $result = $db->prepare($sql);
                    $result->execute([':id' => $id, ':zona' => $zona, ':imagem' => $imagem, ':lingua' => $lingua, ':ts' => date("Y-m-d h:i:s"), ':descricao' => $descricao, ':redacao' => $redacao]);

                    if ($traducao == true) {
                        $zona2 = "(" . strval($_REQUEST['x2']) . "," . strval($_REQUEST['y2']) . "," . strval($_REQUEST['x21']) . "," . strval($_REQUEST['y21']) . ")";
                        echo $zona2;
                        $sql = "INSERT INTO anomalia_traducao VALUES (:id, :zona, :lingua) ";
                        $result = $db->prepare($sql);
                        $result->execute([':id' => $id, ':zona' => $zona2, ':lingua' => $lingua2]);
                    }
                    $db->commit();
                } catch (PDOException $e) {
                    $db->rollBack();
                    echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
                    <a href=\"anomalia.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
                }
            }

            $sql = "SELECT * FROM anomalia;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Anomalia ID</th><th>Zona</th><th>Lingua</th><th>Data e Hora</th><th>Descrição</th><th>Redação?</th><th>Ações</th></tr></thead><tbody>";
                
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $redacao = $row['tem_anomalia_redacao'] ? "Sim" : "Não"; 
                $table = $table . "<tr><th>{$i}</th><td>{$row['id']}</td><td>{$row['zona']}</td><td>{$row['lingua']}</td><td>{$row['ts']}</td><td>{$row['descricao']}</td><td>{$redacao}</td><td><a href=\"anomalia.php?mode=0&&id={$row['id']}\">Remover</a></td></tr>";
            }
            $table = $table . "</tbody></table>";

            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há anomalias registadas entre estes 2 locais</h4></div>");
            }
            else {
                echo($table);
            }  

            $db = null;
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"anomalia.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
    </body>
</html>