<?php
    include_once("conexion.php");
    $texto = $_GET["texto"];
    $precio = $_GET["precio"];
    $sesion = $_GET["sesion"];
    $empresa = $_GET["empresa"];
    $sql = "insert into publicaciones(texto, precio, sesion, empresa, fecha, borrado) values('$texto', $precio, $sesion, $empresa, now(), 0)";
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
