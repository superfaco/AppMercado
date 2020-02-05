<?php
    require_once("conexion.php");
    $nombre = $_GET["nombre"];
    $nombreUsuario = $_GET["nombreUsuario"];
    $contrasena = $_GET["contrasena"];
    $sql = "insert into usuarios(nombre, nombreUsuario, contrasena, fecha) values('$nombre', '$nombreUsuario', '$contrasena', now())";
    $res = array();
    $o = array("rs" => "");
    if($rs = mysqli_query($con, $sql)){
        $o["rs"] = "1";
    }else{
        $o["rs"] = "0";
    }
    $o = (object)$o;
    array_push($res, $o);
    echo json_encode($res);
    mysqli_close($con);
?>
