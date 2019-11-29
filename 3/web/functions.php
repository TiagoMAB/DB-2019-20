<?php

function locais() {

    include "settings.php";

    $sql = "SELECT nome, latitude, longitude FROM local_publico;";
    $result = $db->prepare($sql);
    $result->execute();
    
    echo("<form action=\"listar1_process.php\" method=\"post\"><table border=\"0\" cellspacing=\"5\">");

    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['latitude']}|{$row['longitude']}\"> {$i} - {$row['nome']} - Latitude: {$row['latitude']} - Longitude: {$row['longitude']} </option>\n";
    }

    echo $options;
}

?>