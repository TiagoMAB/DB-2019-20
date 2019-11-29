
<?php include "functions.php"; $options = itens(); ?>

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
            <li role="presentation"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation" class="active"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Duplicados</h1>
        </div>  

        <form class="container" action="duplicado.php" method="post">
        <div class="form-group">
                <label for="nome">Item 1</label>
                <select type="text" class="form-control" name="item1" ." required="required"><?php echo $options; ?></select>
            </div>
            <div class="form-group">
                <label for="nome">Item 2</label>
                <select type="text" class="form-control" name="item2" ." required="required"><?php echo $options; ?></select>
            </div>
            <button type="submit" class="btn btn-success">Registar Duplicado</button>
        </form>
        <br>

        <?php
        try
        {
            include "settings.php";

            $item1 = $_REQUEST['item1'];
            $item2 = $_REQUEST['item2'];

            if ($item1 && $item2) {
                $sql = "INSERT INTO duplicado VALUES (:item1, :item2) ";

                $result = $db->prepare($sql);
                $result->execute([':item1' => $item1, ':item2' => $item2]);

                $db = null;
                header("Location: /duplicado.php");
                exit;
            }

            $sql = "SELECT * FROM duplicado;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Item ID 1</th><th>Item ID 2</th></tr></thead><tbody>";
            
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['item1']}</td><td>{$row['item2']}</td><td>{$row['localizacao']}</td><td>{$row['latitude']}</td><td>{$row['longitude']}</td></tr>";
            }
            $table = $table . "</tbody></table>";

            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há duplicados registados</h4></div>");
            }
            else {
                echo($table);
            }

            $db = null;
            
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"duplicado.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
    </body>
</html>