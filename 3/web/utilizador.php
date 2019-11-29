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
            <li role="presentation" class="active"><a href="utilizador.php">Utilizadores</a></li>
            <li role="presentation"><a href="local.php">Locais</a></li>
            <li role="presentation"><a href="item.php">Itens</a></li>
            <li role="presentation"><a href="anomalia.php">Anomalias</a></li>
            <li role="presentation"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="local.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>

        <div class="jumbotron text-center">
            <h1>Lista de Utilizadores</h1>
        </div>  
 
        <?php
        try
        {
            include "settings.php";

            $sql = "SELECT * FROM utilizador;";
            $result = $db->prepare($sql);
            $result->execute();

            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Email</th></tr></thead><tbody>";
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['email']}</td></tr>";
            }
            $table = $table . "</tbody></table>";
            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há utilizadores registados</h4></div>");
            }
            else {
                echo($table);
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
