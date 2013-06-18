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

//----------------------------------------VALIDAR USUARIO----------------------------

if($_POST['accion'] == 'validarUsuario')
	{$usuario = $_POST['usuario']; 
	if(strlen($usuario) < 5 || strlen($usuario) > 30)
		echo "0";
	// SI longitud, NO VALIDO numeros y letras
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $usuario))
		echo "1";
	// SI rellenado, SI usuario valido
	else	
		echo "2";
	}


//----------------------------------------VALIDAR PASS----------------------------

if($_POST['accion'] == 'validarPass')
	{$password = $_POST['pass']; 
	if(strlen($password) < 6 || strlen($password) > 30)
		echo "0";
	// SI longitud, NO VALIDO numeros y letras
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $password))
		echo "1";
	// SI rellenado, SI email valido
	else
		echo "2";
	}

//----------------------------------------VALIDAR EMAIL----------------------------

if($_POST['accion'] == 'validarEmail')
 {$email = $_POST['email'];
  $mail_correcto = 0;
 
if ((strlen($email) >= 6) && (substr_count($email,"@") == 1) && (substr($email,0,1) != "@") && (substr($email,strlen($email)-1,1) != "@")){ 
      	 if ((!strstr($email,"'")) && (!strstr($email,"\"")) && (!strstr($email,"\\")) && (!strstr($email,"\$")) && (!strstr($email," "))) { 
         	 //miro si tiene caracter . 
         	 if (substr_count($email,".")>= 1){ 
            	 //obtengo la terminacion del dominio 
            	 $term_dom = substr(strrchr ($email, '.'),1); 
            	 //compruebo que la terminación del dominio sea correcta 
            	 if (strlen($term_dom)>1 && strlen($term_dom)<5 && (!strstr($term_dom,"@")) ){ 
               	 //compruebo que lo de antes del dominio sea correcto 
               	 $antes_dom = substr($email,0,strlen($email) - strlen($term_dom) - 1); 
               	 $caracter_ult = substr($antes_dom,strlen($antes_dom)-1,1); 
               	 if ($caracter_ult != "@" && $caracter_ult != "."){ 
                  	 $mail_correcto = 1; 
               	 } 
            	 } 
         	 } 
      	 } 
   	} 
   	if ($mail_correcto == 1) 
      	 echo "1"; 
   	else 
      	  echo "0"; 
 }

//----------------------------------------EXISTE USUARIO---------------------------

		
 if($_POST['accion'] == 'existeUsuario')
 {	$usuario = $_POST['usuario'];	
	
	$usuario = trim($usuario);
		
		$sql= "SELECT count(usu_nombreUsuario) as contador FROM usuarios WHERE usu_nombreUsuario ='".$usuario."' ";
		
		$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
		$row = mysql_fetch_array($resultados);
	//$remId = $row['remId']; 
		if ($row['contador']>0)
			echo 0; //repetido
		else
			echo 1; //No repetido
}

//----------------------------------------EXISTE EMAIL----------------------------

		
 if($_POST['accion'] == 'existeEmail')
 {	$email = $_POST['email'];	
	
	$email = trim($email);
		
		$sql= "SELECT count(usu_email) as contador FROM usuarios WHERE usu_email ='".$email."' ";
		
		$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());
		$row = mysql_fetch_array($resultados);
	//$remId = $row['remId']; 
		if ($row['contador']>0)
			echo 0; //repetido
		else
			echo 1; //No repetido
}

//--------------------------------- REGISTRAR USUARIO ----------------------------------
if($_POST['accion'] == 'registrarUsuario')
 { 
    $email =  strip_tags(mysql_real_escape_string($_POST['email']));
	$pass = strip_tags(mysql_real_escape_string($_POST['pass']));
	$usuario = strip_tags(mysql_real_escape_string($_POST['usuario']));	
		
	$erusu = $eremail = $erpass = $eremail2 = 0 ;
 
	$permitidos = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_";
	$caracter1KO = 0;
	
		
			
	if(strlen($usuario) < 5 || strlen($pass) > 30)
		$erusu = 0;
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $pass))
		$erusu = 0;
	else
		$erusu = 1;	
	
	if(strlen($pass) < 6 || strlen($pass) > 30)
		$erpass = 0;
	else if(!preg_match("/^[0-9a-zA-Z]+$/", $pass))
		$erpass = 0;
	else
		$erpass = 1;	
		
	if ((strlen($email) >= 6) && (substr_count($email,"@") == 1) && (substr($email,0,1) != "@") && (substr($email,strlen($email)-1,1) != "@")){ 
      	 if ((!strstr($email,"'")) && (!strstr($email,"\"")) && (!strstr($email,"\\")) && (!strstr($email,"\$")) && (!strstr($email," "))) { 
         	 if (substr_count($email,".")>= 1){ 
            	 $term_dom = substr(strrchr ($email, '.'),1); 
            	 if (strlen($term_dom)>1 && strlen($term_dom)<5 && (!strstr($term_dom,"@")) ){ 
               	 $antes_dom = substr($email,0,strlen($email) - strlen($term_dom) - 1); 
               	 $caracter_ult = substr($antes_dom,strlen($antes_dom)-1,1); 
               	 if ($caracter_ult != "@" && $caracter_ult != "."){ 
                  	 $mail_correcto = 1; 
               	 } } } } } 
   	if ($mail_correcto) 
      	 $eremail = 1; 
   	else 
     { 	 $eremail = 0; }
	 		
	$sql=  "select usu_id from usuarios where usu_email = '$email'";
	$resultados=mysql_query($sql) or  die("Problemas en el select:".mysql_error());		
	if (mysql_num_rows($resultados)>0)
			$eremail2 = 0; //repetido
	else
		 $eremail2 = 1; //No repetido
				
	if ($ereusu = $eremail = $erpass = $eremail2 = 0)
	{ echo "Error al grabar";
	}
	else
	 {
	 			
		$pass = md5($pass);
		
		mysql_query("INSERT INTO usuarios (usu_pass, usu_activo, usu_email, usu_fechaAlta, usu_nombreUsuario, usu_visitasPerfil) values ('". $pass."' , '0' , '".$email."' , NOW(), '". $usuario."', '0' )");
$code = rand(9999999999, 1000000000);
//sha1(mt_rand().time().mt_rand().$_SERVER['REMOTE_ADDR'].mysql_insert_id());
mysql_query( "INSERT INTO activacion (act_code, usu_id) VALUES ('".$code."', '".mysql_insert_id()."')" );

$cuerpo = 'Hola, para activar tu cuenta haz click en el siguiente link:
'."\n".'
<a href="http://www.orienten.me/activar.php?code='.$code.'">http://www.orienten.me/activar.php?code='.$code.'</a>
O copia el siguiente link en la barra de direcciones de tu navegador:
'."\n".'
http://www.yosivoy.net/activar.php?code='.$code;


$textoEmisor = "MIME-VERSION: 1.0\r\n";
$textoEmisor .= "Content-type: text/html; charset=UTF-8\r\n";
$textoEmisor .= "From: yosivoy.net@gmail.com";

//Formateo el cuerpo del correo
//descomentar cuando lo subas a internet
//mail( $email , "Porfavor activa tu cuenta", $cuerpo, $textoEmisor);

		
		
		
	}
 }

?> 