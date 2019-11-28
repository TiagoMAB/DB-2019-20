<html>
    <body>
        <?php
            $email = $_REQUEST['email'];
            $passcode = $_REQUEST['passcode'];
            try
            {
                $host = "127.0.0.1";
                $user ="postgres";
                $password = "xxx";
                $dbname = "E3";

                $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
                $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                $sql = "UPDATE utilizador SET passcode = :passcode WHERE email = :email;";
                
                echo("<p>$sql</p>");

                $result = $db->prepare($sql);
                $result->execute([':passcode' => $passcode, ':email' => $email]);
                $db = null;
                echo("<p>Success?</p>");
            }
            catch (PDOException $e)
            {
                echo("<p>ERROR: {$e->getMessage()}</p>");
            }
        ?>
    </body>
</html>