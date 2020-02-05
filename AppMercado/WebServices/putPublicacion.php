<?php
    include_once("conexion.php");
    $texto = $_GET["texto"];
    $precio = $_GET["precio"];
    $sesion = $_GET["sesion"];
    $id = $_GET["id"];
    $sql = "update publicaciones set texto = '$texto', precio = $precio, sesion = $sesion where id = $id";
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
