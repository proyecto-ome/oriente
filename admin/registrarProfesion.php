<!DOCTYPE html>
<html>
  <head>
  <script src="../js/jquery.js"></script>
  
 <script type="text/javascript">
  
  $(document).ready(function(){	
  
   $.post("../soporte/SoporteArea.php",{ accion:'cargarSelectArea' },function(data)
	 { $("#selectArea").html(data);	 
	 })
	
	$("#selectArea").change(function()
	{		 		 
		$.post("../soporte/SoporteSubArea.php",{ accion: 'cargarSelectSubArea', area:$(this).val() },function(data)
		{	
			$("#selectSubArea").html(data);	
			
			$.post("../soporte/SoporteProfesion.php",{ accion:'cargarTablaProfesion', subArea:$("#selectSubArea").val() },function(data)
			{	
				$("#tblDetalle").html(data); 
			});// Fin Ajax	
		});// Fin Ajax
	}); // Fin SelecDireccion 
  
  
  });
  
	  function grabar()
	  {
   					 var subArea = $("#selectSubArea").val();
					 var profesion = $("#profesion").val();
					 var resumen = $("#resumen").val();
					 var detalle = $("#detalle").val();					 
					 
					 $.post("../soporte/SoporteProfesion.php", { accion:'validarProfesion', profesion:profesion }, function(data){
						 if (data == 0 )
						 { alert ("La nombre de la profesion debe tener entre 2 y 50 caracteres");
						 formProfesion.profesion.focus();
						 return false;			 
						 }
						
						 $.post("../soporte/SoporteProfesion.php", { accion: 'existeProfesion', profesion:profesion, subArea:subArea }, function(data){							
							if (data == 0 )
							 { 	alert ("El nombre de la profecion ya Existe en la base de datos")		;	
								formProfesion.profesion.focus();
								return false;					
							 }
							 							 
							$.post("../soporte/SoporteProfesion.php", { accion: 'registrarProfesion', subArea:subArea, resumen:resumen, detalle:detalle, profesion:profesion }, function(data){
								alert (data);
								//$('#formArea').hide();
								//window.location = "registrarArea.php";
								//location.reload();
							});						
					
					   	}); //Fin Existe Area
						
					}); //Fin validar Area
		}
  </script>
    
  </head>
  <body>
  <h1>Registrar Profesion </h1>
       <form id="formProfesion" method="post" >        
        <label>Area:</label>    
        <select id="selectArea" name="selectArea" >
        <option >Seleccione Area</option>
        </select>     
        <br />
        <label>Sub-Area:</label>    
        <select id="selectSubArea" name="selectSubArea" >
        <option >Seleccione Sub-Area</option>
        </select>   
        <br />       
       <label >Profesion: </label>
       <input type="text"  name="profesion" id="profesion" autocomplete="off" /> 
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
        <th>NOMBRE PROFESION</th>
    </tr>
    <tbody id="tblDetalle">
    </tbody>
				
</table>
 
   
  
 </body>
</html>
