<?php
    require_once("conexion.php");
    $correo = $_GET["correo"];
    $id = $_GET["id"];
    $sesion = $_GET["sesion"];
    
    $sql = "update usuarios_correos set correo = '$correo', sesion = $sesion, fecha = now() where id = $id";
    
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
