<?php
    require_once("conexion.php");
    $nombreUsuario = $_GET["nombreUsuario"];
    $sql = "select * from usuarios where nombreUsuario = '$nombreUsuario'";
    if($rs = mysqli_query($con, $sql)){
        $usuarios = array();
        while($usuario = $rs->fetch_object()){
            array_push($usuarios, $usuario);
        }
        echo json_encode($usuarios);
    }
    mysqli_close($con);
?>
