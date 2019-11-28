<html>
    <body>
    <h3>Operações</h3>
    <h3>Change passcode for account <?=$_REQUEST['email']?></h3>
        <form action="update.php" method="post">
        <p><input type="hidden" name="email" value="<?=$_REQUEST['email']?>"/></p>
        <p>New passcode: <input type="text" name="passcode"/></p>
    </body>
</html>