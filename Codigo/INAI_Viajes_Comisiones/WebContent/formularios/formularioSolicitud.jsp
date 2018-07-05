<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>formularioSolcitudes</title>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
var catalogs=[];
var indexCatalog = 0;

var datesFields=[];
var indexDates=0;

var timesFields=[];
var indexTimes=0;

var numberFields=[];
var indexNumbers=0;
</script>
</head>
<body <c:if test="${(estatus=='F') or (estatus=='RG')}"> onload="calculaMontosViaticos();"</c:if>>
	<jsp:include page="../include.jsp"/>
	
	<link href="${pageContext.request.contextPath}/css/alertify.bootstrap.css" id="toggleCSS" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-datepicker.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-datepicker3.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-timepicker.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/alertify.core.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap-timepicker.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/alertify.min.js"></script>
	
	<style type="text/css">
	/**
	 * Override feedback icon position
	 * See http://formvalidation.io/examples/adjusting-feedback-icon-position/
	 */
	#eventForm .form-control-feedback {
	    top: 0;
	    right: -15px;
	}
	
	.alertify-log-custom {
			background: blue;
		}
	</style>
	
	<center><h3>${nombreFormulario}</h3></center>
	
	<c:if test="${datosGuardados==true}">
		<h4 style="color:green;">${mensajeGuardado}</h4>
	</c:if>
	
	<c:if test="${comisionEnviada==true}">
		<h4 style="color:green;">${mensajeEnviada}</h4>
	</c:if>
		
	<c:choose>
		<c:when test="${error==true}">
			<h4>${mensajeError}</h4>
		</c:when>
		<c:when test="${autorizada==true}">
			<h4 style="color:green;">${mensajeAutorizada}</h4>
		</c:when>
		<c:otherwise>
			<c:if test="${rechazada==true}">
				<h4 style="color:red;">${mensajeRechazada}</h4>
			</c:if>
			<h4 align="center">${nombreDepedencia}</h4>
			<c:if test="${((estatus=='F') or (estatus=='RG')) and (datosGuardados!=true) and (comisionEnviada!=true)}">
				<form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/formularioAction?action=listarGastos">
				<input type="hidden" name="id_comision" value="${idComision}"/>
	       		<input type="hidden" name="estatus" value="${estatus}"/>
	       		<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
		   				<button type="submit" class="btn btn-default">Agregar gastos de la comisión</button>
		   			</div>
		   		</div>
		   		</form>
			</c:if>
			<form method="post" class="form-horizontal" onsubmit="return validarFormulario()" <c:choose><c:when test="${datosGuardados==false}">action="${pageContext.request.contextPath}/formularioAction?action=salvarDatosComision"</c:when>
			<c:otherwise>action="${pageContext.request.contextPath}/formularioAction?action=enviar"</c:otherwise></c:choose>>
	       <input type="hidden" name="id_comision" value="${idComision}"/>
	       <input type="hidden" name="estatus" value="${estatus}"/>
			<c:forEach items="${seccionesFormulario}" var="seccionFormulario">
				<h4 align="center">${seccionFormulario.etiqueta}</h4>
				<c:forEach items="${seccionFormulario.camposFormulario}" var="campoFormulario">
					<c:if test="${campoFormulario.tipoControl=='TEXTO'}">
						<div class="form-group">
						<c:if test="${campoFormulario.subtipo=='SIMPLE'}">
							<label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
						    <div class="col-sm-10">
						    	<c:choose>
							    	<c:when test="${campoFormulario.tipoDato=='NUMERO'}">
							      		<input type="text" <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> class="form-control" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" maxlength="200" size="100" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> value="${campoFormulario.valorCampo}" 
							      		<c:choose>
							      			<c:when test="${not empty campoFormulario.clase}">
							      				<c:choose>
							      					<c:when test="${(estatus=='C') or (estatus=='R')}">
							      						id="${campoFormulario.clase}" onchange="tipoZonaFunction()"
							      					</c:when>
							      					<c:when test="${(campoFormulario.clase == 'reintegroViaticos' or campoFormulario.clase == 'reintegroPasajes')}">
							      						id="${campoFormulario.clase}" onchange="calculaReintegro()"
							      					</c:when>
							      					<c:when test="${((estatus=='F') or (estatus=='RG'))}"> 
							      						id="${campoFormulario.clase}"
							      					</c:when>
							      					<c:when test="${(estatus=='A') or (estatus=='RV')}"> 
							      						id="${campoFormulario.clase}" onchange="calculaPasajesTotales()"
							      					</c:when>
							      				</c:choose>
							      			</c:when>
							      			<c:otherwise>
							      				name="${campoFormulario.tabla}${campoFormulario.campo}${campoFormulario.tipoDato}"
							      			</c:otherwise>
							      		</c:choose>>
										      		
			            				<c:choose>
			            					<c:when test="${not empty campoFormulario.clase}">
			            						<script>
								            		numberFields[indexNumbers] = ['${campoFormulario.clase}'];
								            		indexNumbers++;
								            	</script>
								           	</c:when>
							      			<c:otherwise>
							      				<script>
								            		numberFields[indexNumbers] = ['${campoFormulario.tabla}${campoFormulario.campo}${campoFormulario.tipoDato}'];
								            		indexNumbers++;
								            	</script>
							      			</c:otherwise>
								        </c:choose>
								            	
							      	</c:when>
							      	<c:otherwise>
							      		<input type="text" <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> class="form-control" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" maxlength="200" size="100" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> value="${campoFormulario.valorCampo}" <c:if test="${not empty campoFormulario.clase}">id ="${campoFormulario.clase}"</c:if>>
							      	</c:otherwise>
						      	</c:choose>
						    </div>
						    <c:if test="${campoFormulario.listaHabilitada==true}">
						    	<script>
						    		var catalog =[];
						    		var indexElement = 0;
						    	</script>
						    	<c:forEach items="${campoFormulario.catalogo}" var="catalogo">
							    	<script>
						    			var catalogElement=['${catalogo.codigo}','${catalogo.descripcion}'];
						    			catalog[indexElement]=[catalogElement];
						    			indexElement++;
							    	</script>
					            </c:forEach>
					            <script>
					            	catalogs[indexCatalog] = ['${campoFormulario.clase}',catalog];
				    				indexCatalog++;
					            </script>
				            </c:if>
						</c:if>
						<c:if test="${campoFormulario.subtipo=='AREA'}">
							<label for="col-sm-2 control-label" class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
						    <div class="col-sm-10">
						      <textarea class="form-control"  <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> rows="6" cols="60" <c:if test="${not empty campoFormulario.clase}">id="${campoFormulario.clase}"</c:if>>${campoFormulario.valorCampo}</textarea>
						    </div>
						</c:if>
						</div>
					</c:if>
					<c:if test="${campoFormulario.tipoControl=='LISTA'}">
						<div class="form-group">
						<label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
					    <div class="col-sm-10">
					      <select class="form-control"  <c:if test="${campoFormulario.soloLectura==true}">disabled</c:if> name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> <c:if test="${not empty campoFormulario.clase}">id="${campoFormulario.clase}"</c:if><c:if test="${(estatus=='C') or (estatus=='R')}"> onchange="tipoZonaFunction()"</c:if>>
						  	<c:forEach items="${campoFormulario.catalogo}" var="catalogo">
				            		<c:choose>
				            			<c:when test="${campoFormulario.campo=='pais_destino'||campoFormulario.campo=='estado_destino'||campoFormulario.campo=='ciudad_destino'||campoFormulario.campo=='pais_origen'||campoFormulario.campo=='estado_origen'||campoFormulario.campo=='ciudad_origen'||campoFormulario.campo=='nombre_area'}">
				            				<option value="${catalogo.descripcion}" <c:if test="${campoFormulario.valorCampo==catalogo.descripcion}">selected</c:if>>${catalogo.descripcion}</option>
				            			</c:when>
				            			<c:otherwise>
				            				<option value="${catalogo.codigo}" <c:if test="${campoFormulario.valorCampo==catalogo.codigo}">selected</c:if>>${catalogo.descripcion}</option>
				            			</c:otherwise>
				            		</c:choose>
				            </c:forEach>
						  </select>
					    </div>
					    </div>
					</c:if>
					<c:if test="${campoFormulario.tipoControl=='CALENDARIO'}">
						<div class="form-group">
						<c:if test="${campoFormulario.subtipo=='FECHA'}">
							<label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
							<div class="col-xs-5 date">
								<c:if test="${campoFormulario.soloLectura==false}">
									<div class="input-group input-append date" id="${campoFormulario.clase}">
								</c:if>
								<input id="${campoFormulario.clase}-Texto" type="text" class="form-control" onchange="validarFechas()" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if>  value="${campoFormulario.valorCampo}" maxlength="200" size="100">
								<c:if test="${campoFormulario.soloLectura==false}">
										<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
            						</div>
            					</c:if>
            				</div>
            				<script>
					            	datesFields[indexDates] = ['${campoFormulario.clase}'];
					            	indexDates++;
					        </script>
						</c:if>
						<c:if test="${campoFormulario.subtipo=='HORA'}">
							<label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
							<div class="col-xs-5 date">
								<c:if test="${campoFormulario.soloLectura==false}">
									<div class="input-group bootstrap-timepicker timepicker">
								</c:if>
									<input <c:if test="${campoFormulario.soloLectura==false}">id="${campoFormulario.clase}"</c:if> type="text" class="form-control"  readonly="readonly" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if>  value="${campoFormulario.valorCampo}" maxlength="200" size="100">
								<c:if test="${campoFormulario.soloLectura==false}">
									<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
            					</div>
            					</c:if>
            				</div>
            				<script>
					            	timesFields[indexTimes] = ['${campoFormulario.clase}'];
					            	indexTimes++;
					        </script>
						</c:if>
						</div>
					</c:if>
				</c:forEach>
		    </c:forEach>
		    
		    	<script>

		    		var montoViaticosEfectivo=0;
		    		var montoViaticosTarjeta=0;
		    		var montoViaticosSinComprobar=0;
		    		var montoPasajeAereo=0;
		    		var montoPasajeTerrestre=0;
		    		var montoHospedaje=0;
		    	</script>
		    <c:forEach items="${gastosFuncionario}" var="gastoFuncionario">
		    	<script>
		    		var monto = Number('${gastoFuncionario.importe}');
		    		var concepto = '${gastoFuncionario.concepto}';
		    		var tipoPago = '${gastoFuncionario.tipoPago}';
		    		var comprobante = '${gastoFuncionario.comprobante}';

		    		var valorConcepto = concepto.split(',')[0];

		    		if (valorConcepto == 'V'){
			    		if (tipoPago == 'E'){
				    		if (comprobante == 'SI'){
				    			montoViaticosEfectivo = montoViaticosEfectivo + monto;
				    		}else{
				    			montoViaticosSinComprobar = montoViaticosSinComprobar + monto;
						    }
			    		}else if (tipoPago == 'TC'){
			    			montoViaticosTarjeta = montoViaticosTarjeta + monto;
				    	}

		    		}else if (valorConcepto == 'PA'){
		    			montoPasajeAereo = montoPasajeAereo + monto;
		    		}else if (valorConcepto == 'PT'){
		    			montoPasajeTerrestre = montoPasajeTerrestre + monto;
		    		}else if (valorConcepto == 'H'){
		    			montoHospedaje = montoHospedaje + monto;
		    		}         		
		    	</script>
		    </c:forEach>
		    
		    	<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				    	<c:choose>
					    	<c:when test="${datosGuardados==false}">
								<button type="submit" class="btn btn-primary">Guardar datos</button>
							</c:when>
							<c:otherwise>
								<c:if test="${comisionEnviada==false}">
									<button type="submit" class="btn btn-primary">Enviar</button>
								</c:if>
								<button type="button" class="btn btn-default" onclick="location.href ='formularioAction?action=listarComisiones'">Regresar</button>
							</c:otherwise>
						</c:choose>
				    </div>
			  	</div>
			</form>
		</c:otherwise>
	</c:choose>
	
	
	
	<jsp:include page="/footer.jsp"/>
</body>



<script type="text/javascript">

$(document).keydown(function(e) {
    var nodeName = e.target.nodeName.toLowerCase();
    if (e.which === 8) {
        if (e.target.readOnly === true || nodeName === 'select') {
            e.preventDefault();
        }
        
    }
});

var formularioValido = true;

$(document).ready(function() {
	$.fn.datepicker.dates['es'] = {
	        days: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"],
	        daysShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
	        daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"],
	        months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
	        monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
	        today: "Hoy"
	    };
	
	if(datesFields.length>0){
		for (var i=0;i<datesFields.length;i++){
			$('#'+datesFields[i])
        		.datepicker({
            	format: 'yyyy-mm-dd',
                language: 'es',
                autoclose: true
        	}).keyup(function(e) {
			    if(e.keyCode == 8 || e.keyCode == 46) {
			    	var idName = $(this).attr('id');
			    	$('#'+idName).data('datepicker').setDate('');
			    	document.getElementById(idName+'-Texto').value=null;
			    }
			});
		
			$('#'+datesFields[i]+'-Texto').keydown(function (e){
					if(e.keyCode != 8 || e.keyCode != 46) 
						e.preventDefault();
				});
		}
	}


	if(timesFields.length>0){
		for (var i=0;i<timesFields.length;i++)
			$('#'+timesFields[i]).timepicker({minuteStep: 1});
	}
	
	if(numberFields.length>0){
		for (var i=0;i<numberFields.length;i++)
			$('#'+numberFields[i]).keydown(function (e) {
				// Allow: backspace, delete, tab, escape, enter and .
		        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
		             // Allow: Ctrl+A, Command+A
		            (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
		             // Allow: home, end, left, right, down, up
		            (e.keyCode >= 35 && e.keyCode <= 40)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        // Ensure that it is a number and stop the keypress
		        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
		            e.preventDefault();
		        }
            });
	}

	//$("#tipoRepresentacion").val("${tipoRepresentacionFun}");

	<c:if test="${(estatus=='C') or (estatus=='R')}">
		if('${idComision}'==0){
			$("#tipoViaje").val("");
			$('#paisCombo').empty();
			$("#paisCombo").val("");
			$('#estadoCombo').empty();
			$("#estadoCombo").val("");
			$('#ciudadCombo').empty();
			$("#ciudadCombo").val("");

			$("#uaCombo").val("");
			$("#uaCveCombo").val("");

			$("#ppCombo").val("");
			$("#ppCveCombo").val("");

			$("#peCombo").val("");
			$("#peCveCombo").val("");
		}else{
			tipoZonaFunction();
			if ($("#tipoViaje").val()=='1'){
				$('#tipoZona').children('option[value="3"]').hide();
				$('#tipoZona').children('option[value="1"]').show();
				$('#tipoZona').children('option[value="2"]').show();
				$('#tipoZona').val("1");
			}else{
				$('#tipoZona').children('option[value="3"]').show();
				$('#tipoZona').children('option[value="1"]').hide();
				$('#tipoZona').children('option[value="2"]').hide();
				$('#tipoZona').val("3");
			}
		}

		$("#tipoViaje").on('change', function(){
			jQuery.ajax({
				url: "${pageContext.request.contextPath}/formularioAction?action=listarPaises",
				dataType: 'json',
				success: function(data, textStatus, request) {
					$('#paisCombo').empty();
					var jsonData = $.parseJSON(request.responseText);
					$.each(jsonData, function() {
						if ($("#tipoViaje").val()=='1'){
							if (this['nombre']=='México')
								$('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
						}else{
							if (this['nombre']!='México')
								$('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
						}
					});
				},
				error: function(xhr) {
					alert('error');
				}
			}).done(function( msg ) {
				$('#paisCombo').trigger('change');
				if ($("#tipoViaje").val()=='1'){
					$('#tipoZona').children('option[value="3"]').hide();
					$('#tipoZona').children('option[value="1"]').show();
					$('#tipoZona').children('option[value="2"]').show();
					$('#tipoZona').val("1");
				}else{
					$('#tipoZona').children('option[value="3"]').show();
					$('#tipoZona').children('option[value="1"]').hide();
					$('#tipoZona').children('option[value="2"]').hide();
					$('#tipoZona').val("3");
				}
			  });
			
		});
		
		
		$("#uaCombo").on('change', function(){
			$('#uaCveCombo').val("");
			$('#uaCveCombo').val($("#uaCombo").val());
		});
		
		$("#ppCombo").on('change', function(){
			$('#ppCveCombo').val("");
			$('#ppCveCombo').val($("#ppCombo").val());
		});
		
		$("#peCombo").on('change', function(){
			var comboValArray = $("#peCombo").val().split('-');
			$('#peCveCombo').val("");
			$('#peCveCombo').val(comboValArray[2]);
		});
	</c:if>

	<c:if test="${(estatus!='C') and (estatus!='R')}">
		/*jQuery.ajax({
			url: "${pageContext.request.contextPath}/formularioAction?action=listarPaises",
			dataType: 'json',
			success: function(data, textStatus, request) {
				$('#paisCombo').empty();
				var jsonData = $.parseJSON(request.responseText);
				$.each(jsonData, function() {
					$('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
				});
			},
			error: function(xhr) {
				alert('error');
			}
		}).done(function( msg ) {
			$('#paisCombo').trigger('change');
		});*/
	</c:if>
	<c:if test="${(estatus=='A') or (estatus=='RV')}">	
		$("#solicitudCambio").on('change', function(){
			var dateField = $("#fechaSolicitudCambioVuelta").data('datepicker'); 
			if ($("#solicitudCambio").val()==1){
				dateField.setDate('');
				$("#fechaSolicitudCambioVuelta").datepicker().show();
				$("#motivoCambio").attr("readOnly", false);
				$("#costoCambioVuelta").attr("readOnly", false);
			}else{
				dateField.setDate('');
				$("#fechaSolicitudCambioVuelta").datepicker().hide();
				$("#motivoCambio").attr("readOnly", true);
				$("#costoCambioVuelta").val(0);
				$("#costoCambioVuelta").attr("readOnly", true);
			}
		});
	</c:if>
	$("#paisCombo").on('change', function(){
		jQuery.ajax({
			url: "${pageContext.request.contextPath}/formularioAction?action=listarEstados&pais="+utf8_encode($("#paisCombo").val()),
			dataType: 'json',
			success: function(data, textStatus, request) {
				$('#estadoCombo').empty();
				var jsonData = $.parseJSON(request.responseText);
				$.each(jsonData, function() {
					$('#estadoCombo').append($('<option>').text(this['nombreEstado']).attr('value', this['nombreEstado']));
				});
			},
			error: function(xhr) {
				alert('error');
			}
		}).done(function( msg ) {
			jQuery.ajax({
				url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais="+utf8_encode($("#paisCombo").val())+"&estado="+utf8_encode($("#estadoCombo").val()),
				dataType: 'json',
				success: function(data, textStatus, request) {
					$('#ciudadCombo').empty();
					var jsonData = $.parseJSON(request.responseText);
					$.each(jsonData, function() {
						$('#ciudadCombo').append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
					});
				},
				error: function(xhr) {
					alert('error');
				}
			});
		  });
	});
	

	$("#estadoCombo").on('change', function(){
		jQuery.ajax({
			url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais="+utf8_encode($("#paisCombo").val())+"&estado="+utf8_encode($("#estadoCombo").val()),
			dataType: 'json',
			success: function(data, textStatus, request) {
				$('#ciudadCombo').empty();
				var jsonData = $.parseJSON(request.responseText);
				$.each(jsonData, function() {
					$('#ciudadCombo').append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
				});
			},
			error: function(xhr) {
				alert('error');
			}
		});
	});
    
});


function tipoZonaFunction(){
	var elemSinPernocta = document.getElementById("muestraTarifaSP");
	var elemConPernocta = document.getElementById("muestraTarifaCP");
	var elemTipoRepresentacion = document.getElementById("tipoRepresentacion");
	var elemHomologacion = document.getElementById("homologacion");
	var elemTipoZona = document.getElementById("tipoZona");
	var elemTarifaCorrespondiente = document.getElementById("calculaTarifa");
	var elemNumAcuerdo = document.getElementById("numAcuerdo");

	var elemTipoViaje = document.getElementById("tipoViaje");

	var elem = document.getElementById("nivelHomolagacion");

	var stringSearchSP = '';
	var stringSearchCP = '';
	
	var tarifaSP=0;
	var tarifaCP=0;

	var valorSP=0;
	var valorCP=0;

	if (elemHomologacion.value=='1'){
		elem.value = "1";
		$("#justHomologacion").attr("required", true);
	}else{
		elem.value = "0";
		$("#justHomologacion").removeAttr('required');
	}
	
	if (elemTipoViaje.value=='1'){
		stringSearchSP = 'SP'+','+elemTipoRepresentacion.value+','+elemHomologacion.value+','+elemTipoZona.value;
		stringSearchCP = 'CP'+','+elemTipoRepresentacion.value+','+elemHomologacion.value+','+elemTipoZona.value;
		$("#numAcuerdo").removeAttr('required');
		$("#monedaTarifa").val(2);
		$("#monedaTarifa").attr("readOnly", true);
	}else if (elemTipoViaje.value=='2'){
		stringSearchSP = 'SP'+','+elemTipoViaje.value+','+elemTipoZona.value;
		stringSearchCP = 'CP'+','+elemTipoViaje.value+','+elemTipoZona.value;
		$("#numAcuerdo").attr("required", true);
		$("#monedaTarifa").attr("readOnly", false);
	}
		
		
	for (var i=0;i<catalogs.length;i++){
		var catalogo = catalogs[i];
		var nombreCatalogo = catalogo[0];
		var filaCatalogo = catalogo[1];
		for (var k=0;k<filaCatalogo.length;k++){
			var elementoCatalogo = filaCatalogo[k];
			var itemCatalogo = elementoCatalogo[0];
			if (itemCatalogo[0]==stringSearchSP){
				valorSP=itemCatalogo[1];
			}else if (itemCatalogo[0]==stringSearchCP){
				valorCP=itemCatalogo[1];
			}
		}
	}	

	elemSinPernocta.value = valorSP;
	elemConPernocta.value = valorCP;
	
	actualizaMonto();
}

function actualizaMonto(){

	var elemTarifaSinPernocta = document.getElementById("muestraTarifaSP");
	var elemTarifaConPernocta = document.getElementById("muestraTarifaCP");

	var elemDiasSinPernocta = document.getElementById("calculaMontoSP");
	var elemDiasConPernocta = document.getElementById("calculaMontoCP");


	var elemMontoSinPernocta = document.getElementById("muestraMontoSP");
	var elemMontoConPernocta = document.getElementById("muestraMontoCP");

	var tarifaTotal = document.getElementById("calculaTarifa");

	
	elemMontoSinPernocta.value = elemTarifaSinPernocta.value*elemDiasSinPernocta.value;
	elemMontoConPernocta.value = elemTarifaConPernocta.value*elemDiasConPernocta.value;
	tarifaTotal.value=Number(elemMontoSinPernocta.value)+Number(elemMontoConPernocta.value);
	
}

function calculaMontosViaticos(){

	var viaticosEfectivo = document.getElementById("viaticosEfectivo");
	var viaticosTarjeta = document.getElementById("viaticosTarjeta");
	var viaticosSinComprobar = document.getElementById("viaticosSinComprobar");
	var gastosViaticos = document.getElementById("gastosViaticos");
	var pasajeAereo = document.getElementById("pasajeAereo");
	var pasajeTerrestre = document.getElementById("pasajeTerrestre");
	var gastosPasaje = document.getElementById("gastosPasaje");
	var gastosHospedaje =  document.getElementById("gastosHospedaje");
	var gastosComision = document.getElementById("gastosComision");
	
	var montoViaticos=Number(montoViaticosEfectivo+montoViaticosTarjeta+montoViaticosSinComprobar);
	var montoPasajes= Number(montoPasajeAereo+montoPasajeTerrestre);
	var montoComision=Number(montoViaticos+montoPasajes+montoHospedaje);
	
	viaticosEfectivo.value = montoViaticosEfectivo;
	viaticosTarjeta.value = montoViaticosTarjeta;
	viaticosSinComprobar.value = montoViaticosSinComprobar;

	gastosViaticos.value = montoViaticos;
	pasajeAereo.value = montoPasajeAereo;
	pasajeTerrestre.value = montoPasajeTerrestre;
	gastosPasaje.value = montoPasajes;
	gastosHospedaje.value = montoHospedaje;
	gastosComision.value = montoComision;
	
}

function calculaPasajesTotales(){
	var costoPasajeIda = document.getElementById("costoPasajeIda");
	var costoPasajeIda = document.getElementById("costoPasajeIda");
	var costoPasajeVuelta = document.getElementById("costoPasajeVuelta");
	var cargosServicioIda = document.getElementById("cargosServicioIda");
	var cargosServicioVuelta = document.getElementById("cargosServicioVuelta");
	var costoCambioVuelta = document.getElementById("costoCambioVuelta");
	var gastoPasaje = document.getElementById("gastoPasaje");
	var tarifaViaticos = document.getElementById("tarifaViaticos");
	var tipoCambioTarifa  = document.getElementById("tipoCambioTarifa");
	var tarifaMonedaNac = document.getElementById("tarifaMonedaNac");
	
	var montoViaticosPesos = Number(tarifaViaticos.value)*Number(tipoCambioTarifa.value);
	var montoPasajes=Number(costoPasajeIda.value)+Number(costoPasajeVuelta.value)+Number(cargosServicioIda.value)+
	Number(cargosServicioVuelta.value)+Number(costoCambioVuelta.value);

	tarifaMonedaNac.value = montoViaticosPesos;
	gastoPasaje.value = montoPasajes;
}

function calculaReintegro(){
	var reintegroViaticos = document.getElementById("reintegroViaticos");
	var reintegroPasajes = document.getElementById("reintegroPasajes");
	var reintegroInai = document.getElementById("reintegroInai");
	
	var montoReintegro=Number(reintegroViaticos.value)+Number(reintegroPasajes.value);

	reintegroInai.value = montoReintegro;
}

function validarFechas(){

	var fechaSalida;
	var fechaRegreso;
	var fechaHoraSalida;
	var fechaHoraRegreso;

	var tieneFechasComision = false;
	var tieneFechasViaticos = false;

	if(datesFields.length>0){
		for (var i=0;i<datesFields.length;i++)
			
			if (datesFields[i]=='fechaSalidaComision'){
				fechaSalida = document.getElementById("fechaSalidaComision-Texto");
				tieneFechasComision = true;
			}else if (datesFields[i]=='fechaRegresoComision'){
				fechaRegreso = document.getElementById("fechaRegresoComision-Texto");
				tieneFechasComision = true;
			}else if (datesFields[i]=='fechaHoraSalida'){
				fechaHoraSalida = document.getElementById("fechaHoraSalida-Texto");
				tieneFechasViaticos = true;
			}else if (datesFields[i]=='fechaHoraRegreso'){
				fechaHoraRegreso = document.getElementById("fechaHoraRegreso-Texto");
				tieneFechasViaticos = true;
			}
	}

	var totalDiasComision = 0;
	var totalDiasViaje = 0;

	if (tieneFechasComision){
		
		if (fechaSalida.value!=''&&fechaRegreso.value!=''){
		
			var fechaSalidaMenor = new Date(fechaSalida.value).getTime() <= new Date(fechaRegreso.value).getTime();
			totalDiasComision = (Math.floor(new Date(fechaRegreso.value).getTime() - new Date(fechaSalida.value).getTime())/ (1000 * 60 * 60 * 24))+1;
	
			if (!fechaSalidaMenor){
				fechaRegreso.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: La fecha de salida debe ser menor a la fecha de regreso.</b></font>');
				formularioValido = false;
			}else{
				fechaRegreso.style.borderColor = "green";
				formularioValido = true;
			}
	
			if (totalDiasComision>15){
				fechaSalida.style.borderColor = "red";
				fechaRegreso.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: El número de días de la comisión no puede ser mayor a 15, favor de revisar las fechas de salida y regreso.</b></font>');
				formularioValido = false;
			}else{
				fechaSalida.style.borderColor = "green";
				fechaRegreso.style.borderColor = "green";
				formularioValido = true;
			}
		}
	}

	if (tieneFechasViaticos){
		if (fechaHoraSalida.value!=''&&fechaHoraRegreso.value!=''){
			var fechaHoraSalidaMenor = new Date(fechaHoraSalida.value).getTime() <= new Date(fechaHoraRegreso.value).getTime();
			totalDiasViaje = (Math.floor(new Date(fechaHoraRegreso.value).getTime() - new Date(fechaHoraSalida.value).getTime())/ (1000 * 60 * 60 * 24))+1;
	
			if (!fechaHoraSalidaMenor){
				fechaHoraRegreso.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: La fecha de salida del viaje debe ser menor a la fecha de regreso.</b></font>');
				formularioValido = false;
			}else{
				fechaHoraRegreso.style.borderColor = "green";
				formularioValido = true;
			}
	
			if (totalDiasViaje>15){
				fechaHoraSalida.style.borderColor = "red";
				fechaHoraRegreso.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: El número de días del viaje de la comisión no puede ser mayor a 15, favor de revisar las fechas de salida y regreso.</b></font>');
				formularioValido = false;
			}else{
				fechaHoraSalida.style.borderColor = "green";
				fechaHoraRegreso.style.borderColor = "green";
				formularioValido = true;
			}
	
			var comparaFechasSalida = new Date(fechaSalida.value).getTime() - new Date(fechaHoraSalida.value).getTime();
			var comparaFechasRegreso = new Date(fechaRegreso.value).getTime() - new Date(fechaHoraRegreso.value).getTime();
			
			if (comparaFechasSalida!=0){
				fechaHoraSalida.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: La fecha de salida del viaje debe ser igual a la fecha de salida de la comisión.</b></font>');
				formularioValido = false;
			}else{
				fechaHoraSalida.style.borderColor = "green";
				formularioValido = true;
			}
	
			/*if (comparaFechasRegreso!=0){
				fechaHoraRegreso.style.borderColor = "red";
				alertify.alert('<font color="red"><b>ERROR: La fecha de regreso del viaje debe ser igual a la fecha de regreso de la comisión.</b></font>');
				formularioValido = false;
			}else{*/
				fechaHoraRegreso.style.borderColor = "green";
				formularioValido = true;
			//}
		}
			
	}
	
}

function validarFormulario(){
	if (formularioValido)
		return true;
	else{
		alertify.alert('<font color="red"><b>ERROR: Revise que la información del formulario sea válida...</b></font>');
		return false;
	}
}


function utf8_encode(s) {
	return unescape(encodeURIComponent(s));
}

function decode_utf8(s) {
	return decodeURIComponent(escape(s));
}
</script>
</html>