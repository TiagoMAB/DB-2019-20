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
              <a href="/listar2.php" class="btn btn-primary my-2">Dados (X,Y) com (latitude, longitude) em graus expressos em notação decimal, listar todas as anomalias registadas nos últimos três meses a mais ou menos (dX, dY) graus de (latitude, longitude)</a>
            </p>
        </div>  
    </body>
</html>


