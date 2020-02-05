<?php
    require_once("conexion.php");
    $telefono = $_GET["telefono"];
    $usuario = $_GET["usuario"];
    $sql = "select * from usuarios_telefonos where telefono = '$telefono' and usuario = $usuario";
    if($rs = mysqli_query($con, $sql)){
        $telefonos = array();
        while($tel = $rs->fetch_object()){
            array_push($telefonos, $tel);
        }
        echo json_encode($telefonos);
    }
    mysqli_close($con);
?>
