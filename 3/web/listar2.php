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
            <form class="container" action="listar2.php" method="post">
                <div class="form-group">
                    <label for="nome">Latitude</label>
                    <input type="number" class="form-control" step="any" name="latitude" min="-90" max="90" placeholder="Valores entre -90 e 90" required="required"> 
                </div>
                <div class="form-group">
                    <label for="nome">Longitude</label>
                    <input type="number" class="form-control" step="any" name="longitude" min="-180" max="180" placeholder="Valores entre -180 e 180" required="required"> 
                </div>
                <div class="form-group">
                    <label for="nome">X</label>
                    <input type="number" class="form-control" step="any" name="x" min="0" max="90" placeholder="Valores entre 0 e 90" required="required"> 
                </div>
                <div class="form-group">
                    <label for="nome">Y</label>
                    <input type="number" class="form-control" step="any" name="y" min="0" max="180" placeholder="Valores entre 0 e 180" required="required"> 
                </div>
                <button type="submit" class="btn btn-success">Listar anomalias</button>
            </form>
            <br>
        </div>
        
        <?php
        
        try{
            include "settings.php";
        
            $x = $_REQUEST['x'];
            $y = $_REQUEST['y'];
            $latitude = $_REQUEST['latitude'];
            $longitude = $_REQUEST['longitude'];

            if ($_REQUEST['x'] != null && $_REQUEST['y'] != null && $_REQUEST['latitude'] != null && $_REQUEST['longitude'] != null) {
                $la1= $latitude - $x;
                $la2= $latitude + $x;
                $lo1= $longitude - $y;
                $lo2= $longitude + $y;
                $date = date("Y-m-d h:i:s");
                $date = date("Y-m-d h:i:s", strtotime("-3 months", strtotime($date)));

                $sql = "SELECT * FROM anomalia INNER JOIN incidencia ON anomalia.id = incidencia.anomalia_id
                        INNER JOIN item ON incidencia.item_id = item.id
                        NATURAL JOIN local_publico 
                        WHERE (local_publico.latitude BETWEEN :la1 AND :la2) AND (local_publico.longitude BETWEEN :lo1 AND :lo2)
                        AND anomalia.ts >= :ts ";

                $result = $db->prepare($sql);
                $result->execute([':la1' => $la1, ':la2' => $la2, ':lo1' => $lo1, ':lo2' => $lo2, ':ts' => $date]);

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
    </body>
</html>

