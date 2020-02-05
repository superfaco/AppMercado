<?php
    require_once("conexion.php");
    $usuario = $_GET["usuario"];
    $correo = $_GET["correo"];
    $sesion = $_GET["sesion"];
    $sql = "insert into usuarios_correos(usuario, correo, sesion, fecha) values($usuario, '$correo', $sesion, now())";
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
