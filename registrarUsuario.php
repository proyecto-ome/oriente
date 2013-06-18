<!DOCTYPE html>
<html>
  <head>
 
 <script>   
      
	  function grabar()
	  {
   
			    	 
					 
					 var usuario = $("#usuario").val();
					 $.post("soporte/SoporteUsuario.php", { accion:'validarUsuario', usuario:usuario}, function(data){
					 if (data == 0 )
					 { alert ("La nombre de usuario es corto debe tener entre 5 y 30 caracteres");
					 formInscripcion.usuario.focus();
					 return false;			 
					 }
					 else if (data == 1 )
					  { alert ("La nombre usuario tiene caracteres no validos");
					 formInscripcion.usuario.focus();	
					 return false;			 
					 }
					 
					 var pass = $("#password").val();
					 $.post("soporte/SoporteUsuario.php", { accion:'validarPass', pass:pass}, function(data){
					 if (data == 0 )
					 { alert ("La contraseña es corta debe tener entre 6 y 30 caracteres");
					 formInscripcion.password.focus();
					 return false;			 
					 }
					 else if (data == 1 )
					  { alert ("La contraseña tiene caracteres no validos");
					 formInscripcion.password.focus();	
					 return false;			 
					 }
					
					
					$.post("soporte/SoporteUsuario.php", { accion: 'existeUsuario', usuario:usuario }, function(data){							
						if (data == 0 )
						 { 	alert ("El nombre de usuario ya Existe en la base de datos")		;	
							return false;					
						 }
					
					 var email = $("#email").val();
						$.post("soporte/SoporteUsuario.php", { accion: 'validarEmail', email:email }, function(data){
						if (data == 0 )
						  { alert ("El formato de mail es incorrecto");
							 formInscripcion.email.focus();	
							 return false;				 
						  }
					$.post("soporte/SoporteUsuario.php", { accion: 'existeEmail', email:email }, function(data){							
						if (data == 0 )
						 { 	alert ("El Usuario Con ese Email Ya exite en la base de datos")		;	
							return false;					
						  }
					 
					$.post("soporte/SoporteUsuario.php", { accion: 'registrarUsuario', email:email, pass:pass, usuario:usuario}, function(data){
							$('#formInscripcion').hide();
							alert ("El Usuario ha sido dado de alta Revise el mail para activar la cuenta");
							});						
					
					   		}); //Fin Validar Usuario
						
						}); //Fin validar email	
					}); //Fin Validar Email
					
					 });//fin Validar Pass
					 
					 });//fin Validar Usuario
	  }
  </script>
  
  
  </head>

  <body>
  
  
       <form id="formInscripcion" method="post" >
       <label class="control-label">Usuario: </label>
       <input type="text" class="input-block-level" name="usuario" id="usuario" autocomplete="off" /> 
       <br /> 
       <label class="control-label">Password: </label>
       <input type="password" class="input-block-level" name="password" id="password" autocomplete="off" />
       <label class="control-label"> (minimo 6 caracteres maximo 30)</label>
       <br />       
       <label class="control-label">Email</label>
       <input type="text" class="input-block-level" name="email" id="email" autocomplete="off" /> 
       <br />       
       <input type="button" value="Registrar" onClick="grabar();">
       </form>



 
    <script src="js/jquery.js"></script>
  
 </body>
</html>
