<?php

function locais() {

    include "settings.php";

    $sql = "SELECT nome, latitude, longitude FROM local_publico;";
    $result = $db->prepare($sql);
    $result->execute();

    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['latitude']}|{$row['longitude']}\"> {$i} - {$row['nome']} - Latitude: {$row['latitude']} - Longitude: {$row['longitude']} </option>\n";
    }

    return $options;
}

function itens() {

    include "settings.php";

    $sql = "SELECT * FROM item;";
    $result = $db->prepare($sql);
    $result->execute();

    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} - Latitude: {$row['latitude']} - Longitude: {$row['longitude']} </option>\n";
    }

    return $options;
}

function emails() {

    include "settings.php";

    $sql = "SELECT email FROM utilizador";
    $result = $db->prepare($sql);
    $result->execute();
    
    
    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['email']}\"> {$i} - {$row['email']} </option>\n";
    }

    return $options;
}

function emails_qualificados() {

    include "settings.php";

    $sql = "SELECT email FROM utilizador_qualificado";
    $result = $db->prepare($sql);
    $result->execute();
    
    
    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['email']}\"> {$i} - {$row['email']} </option>\n";
    }

    return $options;
}

function anomalias() {

    include "settings.php";
    
    $sql = "SELECT id FROM anomalia EXCEPT (SELECT anomalia_id AS id FROM incidencia)";
    $result = $db->prepare($sql);
    $result->execute();
    
    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} </option>\n";
    }

    return $options;
}

function todas_anomalias() {

    include "settings.php";
    
    $sql = "SELECT anomalia_id AS id FROM incidencia";
    $result = $db->prepare($sql);
    $result->execute();
    
    $options = "";
    $i = 0;
    foreach($result as $row)
    {
        $i += 1;
        $options = $options . "<option value=\"{$row['id']}\"> {$i} - {$row['id']} </option>\n";
    }

    return $options;
}
?>