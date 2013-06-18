<?php
include("../conexion.php");

function escapaCadena($cadena) {
	 $nopermitidos = array("'",'\\','<','>',"\"",";","#","%",'#','%',"=","(",")",'=','(',')',); 
    $cadena = str_replace($nopermitidos, "", $cadena); 
    	
    if(get_magic_quotes_gpc() != 0) {
        $cadena = stripslashes($cadena);
    }
    return mysql_real_escape_string($cadena);
}  

//----------------------------------------VALIDAR PROFECION----------------------------

if($_POST['accion'] == 'validarProfesion')
	{$profesion = $_POST['profesion']; 
	if(strlen($profesion) < 2 || strlen($profesion) > 50)
		echo "0";
	else	
		echo "1";
	}

//----------------------------------------EXISTE PROFECION---------------------------
		
 if($_POST['accion'] == 'existeProfesion')
 {	$subArea = $_POST['subArea'];
 	$profesion = $_POST['profesion'];	
	
	$profesion = trim($profesion);
		
		$sql= "SELECT count(prof_id) as contador FROM profesiones WHERE  prof_nombre = '".$profesion."' and suba_nombre='".$subArea."' ";
		$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
		$row = mysql_fetch_array($resultados);
		if ($row['contador']>0)
			echo 0; //repetido
		else
			echo 1; //No repetido
}


//--------------------------------- REGISTRAR PROFESION ----------------------------------
if($_POST['accion'] == 'registrarProfesion')
 { 
    $subArea =  strip_tags($_POST['subArea']);
	$profesion =  trim(strip_tags(mysql_real_escape_string($_POST['profesion'])));
	$resumen = trim(strip_tags(mysql_real_escape_string($_POST['resumen'])));
	$detalle = trim(strip_tags(mysql_real_escape_string($_POST['detalle'])));		
	
	$canVisitas=0;
	$canMegusta=0; 
	$erusu = $erarea =  0 ;
 
	if(strlen($profesion) < 2 || strlen($profesion) > 50)
		$erusu = 0;
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $profesion))
		$erusu = 0;
	else
		$erusu = 1;	
			 		
	$sql=  "SELECT count(prof_id) as contador FROM profesiones WHERE  prof_nombre = '".$profesion."' and suba_id='".$subArea."'  ";
	$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());		
	if (mysql_num_rows($resultados)>0)
			$erarea = 0; //repetido
	else
		 $erarea = 1; //No repetido	
		 			
	if ($erusu = $erarea = 0)
	{ echo "Error al grabar";
	}
	else
	 {
	 	$sql= "INSERT INTO profesiones (prof_nombre, prof_resumen, prof_detalle, prof_cantvistas, prof_cantmegusta, prof_fechaalta, suba_id) 
	VALUES ('".$profesion."','". $resumen."', '". $detalle."', '".$canVisitas."', '".$canMegusta."', NOW() ,'".$subArea."' )" ;	
			mysql_query($sql) or  die("Problemas en el select:".mysql_error());
			echo "La profesion ha sido registrada correctamente";
	}
 }
 
 //---------------------------CARGAR tabla Profesiones ----------------
if($_POST['accion'] == 'cargarTablaProfesion')
{	$subArea =  strip_tags($_POST['subArea']); 
$var = "";
 $sql= "SELECT prof_id Ids, UPPER(prof_nombre) Nombre FROM profesiones WHERE  suba_id = '".$subArea."' ORDER BY Nombre";
 $resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
While($row = mysql_fetch_array($resultados)) 
   { 
		$var= $var . "<tr><td>".$row['Ids']."</td><td>".$row['Nombre']."</td></tr> ";
	}
echo $var;	
}


?> 