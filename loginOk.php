<?php session_start();  
include("conexion.php");
?>
<!DOCTYPE html>
<html>
<head>
</head>

<body>

<h1 align="center">Login</h1>

<?php
if(trim($_POST['login_username']) == '' or trim($_POST['login_password']) == '')
{
echo "<h3 align='center'>Nombre de usuario o contraseña incorrecta, pongase en contacto con orientenme@gmail.com</h3><br>";
}
else
{   
	$email =  strip_tags(mysql_real_escape_string($_POST['login_username']));
	$pass = strip_tags(mysql_real_escape_string($_POST['login_password']));
 
    $email = trim($email);
	$pass = md5($pass);

$sql = "SELECT usu_activo, usu_id, usu_pass, usu_email FROM usuarios WHERE usu_email='". $email."' AND usu_pass = '".$pass."' ";	
$res = mysql_query($sql) or  die("Problemas en el select:".mysql_error() );	
$row = mysql_fetch_array($res);
	if(mysql_num_rows($res)==0)
	{
		echo "<h3 align='center'>Nombre de usuario o contraseña incorrecta, pongase en contacto con orientenme@gmail.com</h3><br>";
	}
	
	else
	{	
	$_SESSION['userid'] = $row['usu_id']; 
	echo "<h3 align='center'>Usuario Logeado Correctamente</h3>";
	}
}
 ?>
 
</body>
</html>
