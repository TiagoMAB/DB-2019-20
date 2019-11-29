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
            <li role="presentation" class="active"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Incidências</h1>
        </div>  

        <?php 
        try {

            include "settings.php";
            include "functions.php"; 
            
            $anomalia = $_REQUEST['anomalia'];
            $item = $_REQUEST['item'];
            $email = $_REQUEST['email'];

            if ($anomalia && $item && $email) {
                $sql = "INSERT INTO incidencia VALUES (:anomalia, :item, :email) ";

                $result = $db->prepare($sql);
                $result->execute([':anomalia' => $anomalia, ':item' => $item, ':email' => $email]);

                $db = null;
                header("Location: /incidencia.php");
                exit();
            }
            
            $anomalias = anomalias();  
            $itens = itens();
            $emails = emails();
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"incidencia.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
            exit();
        }

        if ($anomalias != "") {
            echo("<form class=\"container\" action=\"incidencia.php\" method=\"post\">
                <div class=\"form-group\">
                    <label for=\"nome\">Anomalia</label>
                    <select type=\"text\" class=\"form-control\" name=\"anomalia\" .\" required=\"required\">{$anomalias}?></select>
                </div>
                <div class=\"form-group\">
                    <label for=\"nome\">Item</label>
                    <select type=\"text\" class=\"form-control\" name=\"item\" .\" required=\"required\">{$itens}</select>
                </div>
                <div class=\"form-group\">
                    <label for=\"nome\">Email</label>
                    <select type=\"text\" class=\"form-control\" name=\"email\" .\" required=\"required\">{$emails}</select>
                </div>
                <button type=\"submit\" class=\"btn btn-success\">Registar Incidência</button>
            </form>
            <br>");
        }
        else {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há anomalias para registar incidências</h4></div>");
        }

        try
        {
            include "settings.php";

            $anomalia = $_REQUEST['anomalia'];
            $item = $_REQUEST['item'];
            $email = $_REQUEST['email'];

            if ($anomalia && $item && $email) {
                $sql = "INSERT INTO incidencia VALUES (:anomalia, :item, :email) ";
    
                $result = $db->prepare($sql);
                $result->execute([':anomalia' => $anomalia, ':item' => $item, ':email' => $email]);
    
                $db = null;
                header("Location: /incidencia.php");
                exit();
            }

            $sql = "SELECT * FROM incidencia;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Anomalia ID</th><th>Item ID</th><th>Email</th></tr></thead><tbody>";
            
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['anomalia_id']}</td><td>{$row['item_id']}</td><td>{$row['email']}</td></tr>";
            }
            $table = $table . "</tbody></table>";

            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há incidências registadas</h4></div>");
            }
            else {
                echo($table);
            }

            $db = null;
            
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"incidencia.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
    </body>
</html>