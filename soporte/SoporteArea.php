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

//----------------------------------------VALIDAR AREA----------------------------

if($_POST['accion'] == 'validarArea')
	{$area = $_POST['area']; 
	if(strlen($area) < 2 || strlen($area) > 50)
		echo "0";
	else	
		echo "1";
	}


//----------------------------------------EXISTE AREA---------------------------

		
 if($_POST['accion'] == 'existeArea')
 {	$area = $_POST['area'];	
	
	$area = trim($area);
		
		$sql= "SELECT count(are_nombre) as contador FROM areas WHERE are_nombre ='".$area."' ";
		
		$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
		$row = mysql_fetch_array($resultados);
	//$remId = $row['remId']; 
		if ($row['contador']>0)
			echo 0; //repetido
		else
			echo 1; //No repetido
}


//--------------------------------- REGISTRAR USUARIO ----------------------------------
if($_POST['accion'] == 'registrarArea')
 { 
    $area =  trim(strip_tags(mysql_real_escape_string($_POST['area'])));
	$resumen = trim(strip_tags(mysql_real_escape_string($_POST['resumen'])));
	$detalle = trim(strip_tags(mysql_real_escape_string($_POST['detalle'])));		
	 
	$erusu = $erarea =  0 ;
 
	if(strlen($area) < 2 || strlen($area) > 50)
		$erusu = 0;
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $area))
		$erusu = 0;
	else
		$erusu = 1;	
			 		
	$sql=  "SELECT count(are_nombre) as contador FROM areas WHERE are_nombre ='".$area."' ";	
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
	 	$sql= "INSERT INTO areas(are_nombre, are_resumen, are_detalle) VALUES ('". $area."', '". $resumen."', '". $detalle."' )" ;	
			mysql_query($sql) or  die("Problemas en el select:".mysql_error());
			echo "El area ha sido registrada correctamente";
		
	}
 }
 
 //---------------------------CARGAR tabla AREA ----------------
if($_POST['accion'] == 'cargarTablaAreas')
{	
$var = "";
 $sql= "SELECT are_id Ids, UPPER(are_nombre) Nombre FROM areas order by Nombre";
$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
While($row = mysql_fetch_array($resultados)) 
   { 
		$var= $var . "<tr><td>".$row['Ids']."</td><td>".$row['Nombre']."</td></tr> ";
	}
echo $var;	
}

//---------------------------CARGAR COMBO SELECT AREA ----------------
if($_POST['accion'] == 'cargarSelectArea')
{	
$var = "";
$sql= "SELECT are_id, UPPER(are_nombre) Nombre FROM areas ORDER BY Nombre";
$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
While($row = mysql_fetch_array($resultados)) 
   { 
		$var = $var . "<option value='".$row['are_id']."'>".$row['Nombre']." </option> ";
	}
echo $var;	
}

?> 