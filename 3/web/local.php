<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
    </head>
    <body>
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="index.php">Início</a></li>
            <li role="presentation"><a href="utilizador.php">Utilizadores</a></li>
            <li role="presentation" class="active"><a href="local.php">Locais</a></li>
            <li role="presentation"><a href="item.php">Itens</a></li>
            <li role="presentation"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="local.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Locais</h1>
        </div>  

        
        <form class="container" action="local.php" method="post">
            <div class="form-group">
                <label for="nome">Nome do local</label>
                <input type="text" class="form-control" name="nome" placeholder="Exemplo: Praça dos Clérigos" required="required">
            </div>
            <div class="form-group">
                <label for="nome">Latitude</label>
                <input type="number" class="form-control" step="any" name="latitude" min="-90" max="90" placeholder="Valores entre -90 e 90" required="required"> 
            </div>
            <div class="form-group">
                <label for="nome">Longitude</label>
                <input type="number" class="form-control" step="any" name="longitude" min="-180" max="180" placeholder="Valores entre -180 e 180" required="required"> 
            </div>
            <button type="submit" class="btn btn-success">Adicionar Local</button>
        </form>
        <br>

        <?php
        try
        {
            include "settings.php";

            $nome = $_REQUEST['nome'];
            $latitude = $_REQUEST['latitude'];
            $longitude = $_REQUEST['longitude'];

            $sql = "SELECT nome, latitude, longitude FROM local_publico;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Nome do Local</th><th>Latitude</th><th>Longitude</th><th>Ações</th></tr></thead><tbody>";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['nome']}</td><td>{$row['latitude']}</td><td>{$row['longitude']}</td><td><a href=\"local.php?nome={$row['nome']}\">Remover local</a></td></tr>";
            }
            $table = $table . "</tbody></table>";
            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há locais registados</h4></div>");
            }
            else {
                echo($table);
            }
             
            if ($nome != null && $latitude == null && $longitude == null) {

                $sql = "DELETE FROM local_publico WHERE nome = :nome ";

                $result = $db->prepare($sql);
                $result->execute([':nome' => $nome]);
            }
            else if ($nome != null && $latitude != null && $longitude != null) {
                $sql = "INSERT INTO local_publico VALUES (:latitude, :longitude, :nome) ";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':latitude' => $latitude, ':longitude' => $longitude, ':nome' => $nome]);
                
            }
            $db = null;

        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4></div>");
        }
        ?>
    </body>
</html>