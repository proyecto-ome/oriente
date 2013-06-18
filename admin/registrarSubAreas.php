<!DOCTYPE html>
<html>
  <head>
  <script src="../js/jquery.js"></script>
  
 <script type="text/javascript">
  
  $(document).ready(function(){	
  
   $.post("../soporte/SoporteArea.php",{ accion:'cargarSelectArea' },function(data)
	 { $("#selectArea").html(data);	 
	 	
		$.post("../soporte/SoporteSubArea.php",{ accion:'cargarTablaSubAreas', area:$("#selectArea").val() },function(data)
		{	
			$("#tblDetalle").html(data); 
		});// Fin Ajax
		
	 })
	
	$("#selectArea").change(function()
	{		 		 
		$.post("../soporte/SoporteSubArea.php",{ accion:'cargarTablaSubAreas', area:$(this).val() },function(data)
		{	
			$("#tblDetalle").html(data); 
		});// Fin Ajax
    }); // Fin SelecDireccion 
  
  // $.post("../soporte/SoporteArea.php", { accion: 'cargarTablaAreas'}, function(data){
//				 $("#tblDetalle").append(data);
//				});
  
  });
  
	  function grabar()
	  {
   					 
					 var subArea = $("#subArea").val();
					 var area = $("#selectArea").val();
					 var resumen = $("#resumen").val();
					 var detalle = $("#detalle").val();					 
					 
					 $.post("../soporte/SoporteSubArea.php", { accion:'validarSubArea', subArea:subArea}, function(data){
						 if (data == 0 )
						 { alert ("La nombre de Subarea debe tener entre 2 y 50 caracteres");
						 formSubArea.subArea.focus();
						 return false;			 
						 }
						
						 $.post("../soporte/SoporteSubArea.php", { accion: 'existeSubArea', subArea:subArea, area:area }, function(data){							
							if (data == 0 )
							 { 	alert ("El nombre de SubArea ya Existe en la base de datos")		;	
								formSubArea.subArea.focus();
								return false;					
							 }
							 							 
							$.post("../soporte/SoporteSubArea.php", { accion: 'registrarSubArea', subArea:subArea, resumen:resumen, detalle:detalle, area:area }, function(data){
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
  <h1>Registrar SubArea </h1>
       <form id="formSubArea" method="post" >        
        <label>Area:</label>    
        <select id="selectArea" name="selectArea" >
        <option >Seleccione Area</option>
        </select>     
        <br />        
       <label >SubArea: </label>
       <input type="text"  name="subArea" id="subArea" autocomplete="off" /> 
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
        <th>NOMBRE SUB-AREA</th>
    </tr>
    <tbody id="tblDetalle">
    </tbody>
				
</table>
 
   
  
 </body>
</html>
