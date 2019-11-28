<html>
    <body>
        <?php
            $email = $_REQUEST['email'];
            $passcode = $_REQUEST['passcode'];
            try
            {
                include "settings.php";

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