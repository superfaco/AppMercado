<?php
    include_once("conexion.php");
    $id = $_GET["id"];
    $telefono = $_GET["telefono"];
    $sesion = $_GET["sesion"];
    $sql = "update usuarios_telefonos set telefono = '$telefono', sesion = $sesion, fecha = now() where id = $id";
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
