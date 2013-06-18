<!DOCTYPE html>
<html>
  <head>
  <script src="../js/jquery.js"></script>
  
 <script type="text/javascript">
  
  $(document).ready(function(){	
  
   $.post("../soporte/SoporteArea.php", { accion: 'cargarTablaAreas'}, function(data){
				 $("#tblDetalle").append(data);
				 				
				});
  });
  
	  function grabar()
	  {
   					 var area = $("#area").val();
					 var resumen = $("#resumen").val();
					 var detalle = $("#detalle").val();					 
					 
					 $.post("../soporte/SoporteArea.php", { accion:'validarArea', area:area}, function(data){
						 if (data == 0 )
						 { alert ("La nombre de area debe tener entre 2 y 50 caracteres");
						 formArea.area.focus();
						 return false;			 
						 }
						
						 $.post("../soporte/SoporteArea.php", { accion: 'existeArea', area:area }, function(data){							
							if (data == 0 )
							 { 	alert ("El nombre de Area ya Existe en la base de datos")		;	
								formArea.area.focus();
								return false;					
							 }
							 							 
							$.post("../soporte/SoporteArea.php", { accion: 'registrarArea', area:area, resumen:resumen, detalle:detalle }, function(data){
								alert (data);
								//$('#formArea').hide();
								//window.location = "registrarArea.php";
								location.reload();
							});						
					
					   	}); //Fin Existe Area
						
					}); //Fin validar Area
		}
  </script>
    
  </head>
  <body>
  <h1>Registrar Area </h1>
       <form id="formArea" method="post" >
       <label >Area: </label>
       <input type="text"  name="area" id="area" autocomplete="off" /> 
       <br /> 
       <label >resumen: </label>
       <textarea name="resumen" rows="3"  name="resumen" id="resumen" ></textarea>
       <br />       
       <label >detalle: </label>
       <textarea name="detalle" rows="3"  name="detalle" id="detalle"></textarea>
       <br /> <br />        
       <input type="button" value="Registrar" onClick="grabar();">
       </form>
<br/><br/> 
<table>
    <tr>
        <th>ID</th>
        <th>NOMBRE</th>
    </tr>
    <tbody id="tblDetalle">
    </tbody>
				
</table>
 
   
  
 </body>
</html>
