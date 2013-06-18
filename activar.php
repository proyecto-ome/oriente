<!DOCTYPE html>
<html>
  <body>
  
   

    <?php
   include("conexion.php");

$code = ( int )@$_GET['code'];
$code = strip_tags(mysql_real_escape_string($code));

	$sql = "SELECT act_code, usu_id FROM activacion WHERE act_code=".$code ;
	$res = mysql_query($sql) or  die("Problemas en el select:".mysql_error() );	
	
	if(mysql_num_rows($res)==0) {
	echo "<h1 align='center'>Lo siento, el codigo de activacion no existe</h1>";
	} else {
	$codigo = mysql_fetch_array($res);
	mysql_query("UPDATE usuarios SET usu_activo = '1' WHERE usu_id = '".$codigo['usu_id']."' ");
	mysql_query("DELETE FROM activacion WHERE usu_id = '".$codigo['usu_id']."' ");
	echo "<h1 align='center'>El Nuevo Usuario ha sido activado</h1>";
	}
?>
 
  </body>
</html>
