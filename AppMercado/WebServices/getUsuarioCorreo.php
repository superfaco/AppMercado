<?php
    require_once("conexion.php");
    $correo = $_GET["correo"];
    $usuario = $_GET["usuario"];
    $sql = "select * from usuarios_correos where correo = '$correo' and usuario = $usuario";
    if($rs = mysqli_query($con, $sql)){
        $ucs = array();
        while($uc = $rs->fetch_object()){
            array_push($ucs, $uc);
        }
        echo json_encode($ucs);
    }
    mysqli_close($con);
?>
