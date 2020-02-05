<?php
    include_once("conexion.php");
    $usuario = $_GET["usuario"];
    $sql = "select * from sesiones where usuario = '$usuario' and fin is null";
    if($rs = mysqli_query($con, $sql)){
        $sesiones = array();
        while($sesion = $rs->fetch_object()){
            array_push($sesiones, $sesion);
        }
        echo json_encode($sesiones);
    }
    mysqli_close($con);
?>
