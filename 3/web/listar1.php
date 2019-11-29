<!DOCTYPE html>
<html lang="pt">
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
            <li role="presentation"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation" class="active"><a href="listar.php">Listar</a></li>
        </ul>

        <div class="jumbotron text-center">
            <h1>Listar</h1> 
            <p>
              <a href="/listar1.php" class="btn btn-primary my-2">Listar todas as anomalias de incidências registadas na área compreendida entre dois locais públicos </a>
            </p>
            <p>
              <a href="/listar2.php" class="btn btn-primary my-2">Dados (X,Y) com (latitude, longitude) em graus expressos em notação decimal, listar todas as anomalias registadas nos últimos três meses a mais ou menos (dX, dY) graus de (latitude, longitude).</a>
            </p>
        </div>  
        
        <div>
        <?php 
        try {
            include "functions.php"; 
            
            $options = locais(); 

            $first = $_REQUEST['local1'];
            $second = $_REQUEST['local2'];
            $first = explode("|", $first);
            $second = explode("|", $second);
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"item.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
            exit();
        }
       
        if ($options != "") {
            echo ("<form class=\"container\" action=\"listar1.php\" method=\"post\">
            <div class=\"form-group\">
                    <label for=\"nome\">Local 1</label>
                    <select type=\"text\" class=\"form-control\" name=\"local1\" .\" required=\"required\">{$options}</select>
                </div>
                <div class=\"form-group\">
                    <label for=\"nome\">Local 2</label>
                    <select type=\"text\" class=\"form-control\" name=\"local2\" .\" required=\"required\">$options}</select>
                </div>
                <button type=\"submit\" class=\"btn btn-success\">Listar anomalias</button>
            </form>
            <br>");
        }
        else {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há locais registados</h4></div>");
        }

        try
        {
            if ($_REQUEST['local1'] != null && $_REQUEST['local2'] != null) {
                include "settings.php";

                $first1 = $first[0] < $second[0] ? $first[0] : $second[0];
                $second1 = $first[0] < $second[0] ? $second[0] : $first[0]; 
                $first2 = $first[1] < $second[1] ? $first[1] : $second[1];
                $second2 = $first[1] < $second[1] ? $second[1] : $first[1]; 

                $sql = "SELECT * FROM anomalia INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id
                        INNER JOIN item ON incidencia.item_id = item.id
                        NATURAL JOIN local_publico 
                        WHERE (local_publico.latitude BETWEEN :first1 AND :second1) AND (local_publico.longitude BETWEEN :first2 AND :second2)";
            

                $result = $db->prepare($sql);
                $result->execute([':first1' => $first1, ':second1' => $second1, ':first2' => $first2, ':second2' => $second2]);

                $table = "";
                $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Anomalia ID</th><th>Zona</th><th>Lingua</th><th>Data e Hora</th><th>Descrição</th><th>Redação?</th></tr></thead><tbody>";
                
                $i = 0;
                foreach($result as $row)
                {
                    $i += 1;
                    $redacao = $row['tem_anomalia_redacao'] ? "Sim" : "Não"; 
                    $table = $table . "<tr><th>{$i}</th><td>{$row['id']}</td><td>{$row['zona']}</td><td>{$row['lingua']}</td><td>{$row['ts']}</td><td>{$row['descricao']}</td><td>{$redacao}</td></tr>";
                }
                $table = $table . "</tbody></table>";
    
                if (!$i) {
                    echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há anomalias registadas entre estes 2 locais</h4></div>");
                }
                else {
                    echo($table);
                }    
            }
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"listar1.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
       </div> 
    </body>
</html>