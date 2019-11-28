<html>
    <body>
    <h3>Listar anomalias</h3>
        <p>Selecione (x, y) e (latitude, longitude): </p>
        <form action="listar2_process.php" method="post">
        <p> X: <input type="number" step="any" name="x" min="0" max="90"/> 
            Y: <input type="number" step="any" name="y" min="0" max="180"/> 
            Latitude: <input type="number" step="any" name="latitude" min="-90" max="90"/> 
            Longitude: <input type="number" step="any" name="longitude" min="-180" max="180"/></p>
        <input type="submit" value="Listar">
    </body>
</html>
