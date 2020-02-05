<?php
    include_once("conexion.php");
    $empresa = $_GET["empresa"];
    $sql = "select * from publicaciones where empresa = $empresa and borrado = 0";
    if($rs = mysqli_query($con, $sql)){
        $publicaciones = array();
        while($pub = $rs->fetch_object()){
            array_push($publicaciones, $pub);
        }
        echo json_encode($publicaciones);
    }
    mysqli_close($con);
?>
