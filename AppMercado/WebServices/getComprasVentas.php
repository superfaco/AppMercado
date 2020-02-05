<?php
    include_once("conexion.php");
    $empresa = $_GET["empresa"];
    $sql = "select * from vw_compras_ventas where id = $empresa";
    if($rs = mysqli_query($con, $sql)){
        $compvtas = array();
        while($cv = $rs->fetch_object()){
            array_push($compvtas, $cv);
        }
        echo json_encode($compvtas);
    }
    mysqli_close($con);
?>
