<?php
    include_once("conexion.php");
    $usuario = $_GET["usuario"];
    $sql = "select * from usuarios_telefonos where usuario = $usuario";
    if($rs = mysqli_query($con, $sql)){
        $uts = array();
        while($ut = $rs->fetch_object()){
            array_push($uts, $ut);
        }
        echo json_encode($uts);
    }
    mysqli_close($con);
?>
