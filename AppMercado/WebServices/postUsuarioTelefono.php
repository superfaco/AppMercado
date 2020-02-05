<?php
    include_once("conexion.php");
    $telefono = $_GET["telefono"];
    $usuario = $_GET["usuario"];
    $sesion = $_GET["sesion"];
    $sql = "insert into usuarios_telefonos(usuario, telefono, sesion, fecha) values($usuario, '$telefono', $sesion, now())";
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
