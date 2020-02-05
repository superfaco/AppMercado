<?php
    include_once("conexion.php");
    $nombre = $_GET["nombre"];
    $direccion = $_GET["direccion"];
    $sesion = $_GET["sesion"];
    $sql = "insert into empresas(nombre, direccion, sesion, fecha) values('$nombre', '$direccion', $sesion, now())";
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
