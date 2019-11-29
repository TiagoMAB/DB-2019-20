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
            <li role="presentation" class="active"><a href="correcao.php">Correções e Propostas de Correção</a></li>
            <li role="presentation"><a href="incidencia.php">Incidências</a></li>
            <li role="presentation"><a href="duplicado.php">Duplicados</a></li>
            <li role="presentation"><a href="listar.php">Listar</a></li>
        </ul>
        
        <div class="jumbotron text-center">
            <h1>Correções e Propostas de Correção</h1>
        </div>  

        <?php 
        try {
            include "functions.php"; 
            
            $emails = emails();
            $anomalias = todas_anomalias(); 
            $texto = $_REQUEST['texto'];
            $flag = $_REQUEST['flag'];
            $email = $_REQUEST['email'];
            $anomalia = $_REQUEST['anomalia'];
            $nro = $_REQUEST['nro'];
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"item.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
            exit();
        }
       
        if ($texto != null && $flag != null) {
            echo ("<form class=\"container\" action=\"correcao.php?email={$email}&&nro={$nro}&&texto={$texto}\" method=\"post\">
                <div class=\"form-group\">
                    <label for=\"nome\">Texto</label>
                    <input type=\"text\" class=\"form-control\" name=\"texto\" placeholder=\"{$texto}\" required=\"required\">
                </div>
                <button type=\"submit\" class=\"btn btn-success\">Editar</button>
            </form>
            <br>");
        }
        else if ($anomalias != "" && $emails != "" ) {
            echo ("<form class=\"container\" action=\"correcao.php\" method=\"post\">
            <div class=\"form-group\">
                    <label for=\"nome\">Email</label>
                    <select type=\"text\" class=\"form-control\" name=\"email\" .\" required=\"required\">{$emails}</select>
                </div>
                <div class=\"form-group\">
                    <label for=\"nome\">Anomalia</label>
                    <select type=\"text\" class=\"form-control\" name=\"anomalia\" .\" required=\"required\">{$anomalias}</select>
                </div>
                <div class=\"form-group\">
                    <label for=\"nome\">Texto</label>
                    <input type=\"text\" class=\"form-control\" name=\"texto\" placeholder=\"Exemplo: Praça dos Clérigos\" required=\"required\">
                </div>
                <button type=\"submit\" class=\"btn btn-success\">Registar</button>
            </form>
            <br>");
        }
        else {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há anomalias ou emails para registar correções</h4></div>");
        }
 
        try
        {
            include "settings.php";
            
            if ($email != null && $anomalia != null && $texto != null ) {
                $sql = "SELECT COUNT(nro) FROM proposta_de_correcao WHERE email = :email;";

                $result = $db->prepare($sql);
                $result->execute([':email' => $email]);

                foreach($result as $row) {
                    $nro = $row['count'] + 1;
                }
                
                $sql = "INSERT INTO proposta_de_correcao VALUES ( :email, :nro, :ts, :texto)";

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro, ':ts' => date("Y-m-d h:i:s"), ':texto' => $texto]);

                $sql = "INSERT INTO correcao VALUES (:email, :nro, :anomalia)";

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro, 'anomalia' => $anomalia]);
            }
            else if ($email != null && $nro != null && $texto != null && $flag == null){ 
                $sql = "UPDATE proposta_de_correcao SET texto = :texto WHERE email = :email AND nro =:nro;";

                $result = $db->prepare($sql);
                $result->execute([':texto' => $texto, ':email' => $email, ':nro' => $nro]);
            }
            else if ($email != null && $nro != null && $texto == null) {
                $sql = "DELETE FROM proposta_de_correcao WHERE email = :email AND nro = :nro ";

                $result = $db->prepare($sql);
                $result->execute([':email' => $email, ':nro' => $nro]);

            }

            $sql = "SELECT * FROM correcao NATURAL JOIN proposta_de_correcao;";
            $result = $db->prepare($sql);
            $result->execute();
            
            $table = "";
            $table = $table . "<table class=\"table table-hover \"><thead><tr><th>#</th><th>Email</th><th>NRO</th><th>Anomalia ID</th><th>Texto</th><th>Data e Hora</th><th>Ações</th></tr></thead><tbody>";
            
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                $table = $table . "<tr><th>{$i}</th><td>{$row['email']}</td><td>{$row['nro']}</td><td>{$row['anomalia_id']}</td><td>{$row['texto']}</td><td>{$row['data_hora']}</td><td><a href=\"correcao.php?email={$row['email']}&&nro={$row['nro']}&&texto={$row['texto']}&&flag=0\">Editar</a> - <a href=\"correcao.php?email={$row['email']}&&nro={$row['nro']}\">Remover</a></td></tr>";
            }
            $table = $table . "</tbody></table>";

            if (!$i) {
                echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 text-center alert-dismissible fade in\" role=\"alert\"><h4>Não há correções registadas</h4></div>");
            }
            else {
                echo($table);
            }

            $db = null;
            
        }
        catch (PDOException $e)
        {
            echo("<div class=\"alert alert-danger col-md-4 col-md-offset-4 alert-dismissible fade in\" role=\"alert\"><h4>ERROR: {$e->getMessage()}</h4>
            <a href=\"correcao.php\" type=\"button\" class=\"btn btn-danger\">Reload</a></div>");
        }
        ?>
    </body>
</html>