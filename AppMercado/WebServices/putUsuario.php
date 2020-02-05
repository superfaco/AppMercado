<?php
    include_once("conexion.php");
    $id = $_GET["id"];
    $nombre = $_GET["nombre"];
    $sql = "update usuarios set nombre = '$nombre' where id = $id";
    
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
