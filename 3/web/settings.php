<?php
    $host = "127.0.0.1";
    $user ="postgres";
    $password = "xxx";
    $dbname = "E3";

    $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
?>