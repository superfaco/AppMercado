<?php
    include_once("conexion.php");
    $usuario = $_GET["usuario"];
    $sql = "select emp.* from empresas emp join sesiones ses on ses.id = emp.sesion where ses.usuario = $usuario";
    if($rs = mysqli_query($con, $sql)){
        $empresas = array();
        while($emp = $rs->fetch_object()){
            array_push($empresas, $emp);
        }
        echo json_encode($empresas);
    }
    mysqli_close($con);
?>
