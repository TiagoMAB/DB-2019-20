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
            <li role="presentation" class="active"><a href="item.php">Itens</a></li>
            <li role="presentation"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Itens</h1>
        </div>  
        <?php 
        try {
            include "functions.php"; $options = locais(); 
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"item.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
            exit();
        }
        ?>

        
        <form class="container" action="item.php" method="post">
            <div class="form-group">
                <label for="nome">Id do item</label>
                <input type="number" class="form-control" name="id" min="0" placeholder="Exemplo: 2334 (> 0)" required="required">
            </div>
            <div class="form-group">
                <label for="nome">Descrição</label>
                <input type="text" class="form-control" name="descricao" placeholder="Exemplo: O item A apresenta a carateristica X e Y." required="required"> 
            </div>
            <div class="form-group">
                <label for="nome">Localizacão</label>
                <input type="text" class="form-control" name="localizacao" placeholder="Exemplo: O item A refere-se a posição X   ." required="required"> 
            </div>
            <div class="form-group">
                <label for="nome">Local Público do Item</label>
                <select type="text" class="form-control" name="local" placeholder="Exemplo: O item A refere-se a posição X   ." required="required"><?php echo $options; ?></select>
            </div>
            <button type="submit" class="btn btn-success">Adicionar Item</button>
        </form>
        <br>

        <?php
        try
        {
            include "settings.php";

            $id = $_REQUEST['id'];
            $descricao = $_REQUEST['descricao'];
            $localizacao = $_REQUEST['localizacao'];
            $local = $_REQUEST['local'];
            
            if ($id && $descricao && $localizacao && $local) {

                $local = explode("|", $local);
                $sql = "INSERT INTO item VALUES (:id, :descricao, :localizacao, :latitude, :longitude) ";

                $result = $db->prepare($sql);
                $result->execute([':id' => $id, ':descricao' => $descricao, ':localizacao' => $localizacao, ':latitude' => $local[0], ':longitude' => $local[1]]);
                $db = null;
                header("Location: /item.php");
                exit();
            }
            else if ($id) {
                $sql = "DELETE FROM item WHERE id = :id ";

                $result = $db->prepare($sql);
                $result->execute([':id' => $id]);
                $db = null;
                header("Location: /item.php");
                exit();
            }

            $sql = "SELECT id, descricao, localizacao, latitude, longitude FROM item;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>ID</th><th>Descrição</th><th>Localização</th><th>Latitude</th><th>Longitude</th><th>Ações</th></tr></thead><tbody>";
            
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['id']}</td><td>{$row['descricao']}</td><td>{$row['localizacao']}</td><td>{$row['latitude']}</td><td>{$row['longitude']}</td><td><a href=\"item.php?id={$row['id']}\">Remover</a></td></tr>";
            }
            $table = $table . "</tbody></table>";

            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há itens registados</h4></div>");
            }
            else {
                echo($table);
            }

            $db = null;
            
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"item.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
    </body>
</html>

