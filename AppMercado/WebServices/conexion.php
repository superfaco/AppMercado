<?php
    /*
     Despachador de conexiones simple.
     */
	$host = "localhost";
	$db = "dbmercado";
	$usr = "root";
	$pass = "";
	
	$con = mysqli_connect($host, $usr, $pass, $db);
	if(mysqli_connect_errno()){
	    echo 'No se pudo conectar a la base de datos : ' . mysqli_connect_error;
	}
?>
