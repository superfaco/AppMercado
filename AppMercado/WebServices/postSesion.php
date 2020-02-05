<?php
    include_once("conexion.php");
    $usuario = $_GET["usuario"];
    $sql = "insert into sesiones(inicio, usuario) values(now(), '$usuario')";
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
