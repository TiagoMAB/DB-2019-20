<html>
    <body>
    <h3>Anomalias</h3>
        <p>Inserir nova anomalia: </p>
        <form action="add_anomalia.php" method="post">
            <p> 
                Id: <input type="number" name="id">  
                Lingua: <input type="text" name="lingua">
                Imagem: <input type="text" name="imagem"> <!-- Alterar para binario--> 
                Descrição: <input type="text" name="descricao"> 
                Redação?: <input type="checkbox" name="redacao" value=1> 
            </p>
            <p>
                X: <input type="number" step="0.1" name="x">
                Y: <input type="number" step="0.1" name="y">
                X1: <input type="number" step="0.1" name="x1">
                Y1: <input type="number" step="0.1" name="y1">  
            </p>
            <p>
                X 2: <input type="number" step="0.1" name="x2">
                Y 2: <input type="number" step="0.1" name="y2"> 
                X 21: <input type="number" step="0.1" name="x21">
                Y 21: <input type="number" step="0.1" name="y21"> 
                Lingua 2: <input type="text" name="lingua2">
            </p>
            <input type="submit" value="Adicionar">
        </form>
        <?php
        try
        {
            
            include "settings.php";

            $sql = "SELECT * FROM anomalia;";
            $result = $db->prepare($sql);
            $result->execute();

            $sql1 = "SELECT id FROM anomalia_traducao;";
            $result1 = $db->prepare($sql1);
            $result1->execute();

            echo("<table border=\"0\" cellspacing=\"5\">\n");
            $i = 0;
            foreach($result as $row)
            {
                $i += 1;
                echo("<tr>\n");
                echo("<td>{$i}</td>\n");
                echo("<td>{$row['id']}</td>\n");
                echo("<td>{$row['zona']}</td>\n");
                echo("<td>{$row['lingua']}</td>\n");
                echo("<td>{$row['ts']}</td>\n");
                echo("<td>{$row['descricao']}</td>\n");
                echo("<td>{$row['tem_anomalia_redacao']}</td>\n");
                foreach($result1 as $row1)
                {
                    if ($row['id'] == $row1['id']) {
                        echo("<td>Traduction</td>\n");
                    }
                }
                echo("<td><a href=\"remove_anomalia.php?id={$row['id']}\">Remover Anomalia</a></td>\n");
                echo("</tr>\n");
            }
                echo("</table>\n");

            $db = null;
        }
        catch (PDOException $e)
        {
            echo("<p>ERROR: {$e->getMessage()}</p>");
        }
        ?>
    </body>
</html>
