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

if($_POST['accion'] == 'validarSubArea')
	{$SubArea = $_POST['subArea']; 
	if(strlen($subArea) < 2 || strlen($subArea) > 50)
		echo "0";
	else	
		echo "1";
	}


//----------------------------------------EXISTE AREA---------------------------

		
 if($_POST['accion'] == 'existeSubArea')
 {	$subArea = $_POST['subArea'];
 	$area = $_POST['area'];	
	
	$subArea = trim($subArea);
		
		$sql= "SELECT count(suba_nombre) as contador FROM subareas WHERE suba_nombre='".$subArea."' and are_id = '".$area."' ";
		$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
		$row = mysql_fetch_array($resultados);
	//$remId = $row['remId']; 
		if ($row['contador']>0)
			echo 0; //repetido
		else
			echo 1; //No repetido
}


//--------------------------------- REGISTRAR USUARIO ----------------------------------
if($_POST['accion'] == 'registrarSubArea')
 { 
    $area =  strip_tags($_POST['area']);
	$subArea =  trim(strip_tags(mysql_real_escape_string($_POST['subArea'])));
	$resumen = trim(strip_tags(mysql_real_escape_string($_POST['resumen'])));
	$detalle = trim(strip_tags(mysql_real_escape_string($_POST['detalle'])));		
	 
	$erusu = $erarea =  0 ;
 
	if(strlen($subArea) < 2 || strlen($subArea) > 50)
		$erusu = 0;
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $area))
		$erusu = 0;
	else
		$erusu = 1;	
			 		
	$sql=  "SELECT count(suba_nombre) as contador FROM subareas WHERE suba_nombre='".$subArea."' and are_id = '".$area."' ";
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
	 	$sql= "INSERT INTO subareas( suba_nombre, suba_resumen, suba_detalle, are_id)  VALUES ('". $subArea."', '". $resumen."', '". $detalle."','".$area."' )" ;	
			mysql_query($sql) or  die("Problemas en el select:".mysql_error());
			echo "El area ha sido registrada correctamente";
		
	}
 }
 
 
 //---------------------------CARGAR tabla SUBAREA X AREA ----------------
if($_POST['accion'] == 'cargarTablaSubAreas')
{	$area =  strip_tags($_POST['area']); 
$var = "";
 $sql= "SELECT suba_id Ids, UPPER(suba_nombre) Nombre FROM subareas WHERE are_id = '".$area."' ORDER BY Nombre";
 $resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
While($row = mysql_fetch_array($resultados)) 
   { 
		$var= $var . "<tr><td>".$row['Ids']."</td><td>".$row['Nombre']."</td></tr> ";
	}
echo $var;	
}

//---------------------------CARGAR COMBO SELECT SUBAREA x Area ----------------
if($_POST['accion'] == 'cargarSelectSubArea')
{	
	$area =  strip_tags($_POST['area']);
	
$var = "";
$sql= "SELECT suba_id, UPPER(suba_nombre) Nombre FROM subareas WHERE are_id = '". $area . "' ";
$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
While($row = mysql_fetch_array($resultados)) 
   { 
		$var = $var . "<option value='".$row['suba_id']."'>".$row['Nombre']." </option> ";
	}
echo $var;	
}
 
?> 