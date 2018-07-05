<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>formularioGastos</title>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
var catalogs=[];
var indexCatalog = 0;

var datesFields=[];
var indexDates = 0;
</script>
</script>

</head>
<body>

	<jsp:include page="../include.jsp"/>
	<link href="${pageContext.request.contextPath}/css/bootstrap-datepicker.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-datepicker3.min.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>
	<center><h3>${nombreFormulario}</h3></center>
	
	<c:if test="${datosGuardados==true}">
		<h4 style="color:green;">${mensajeGuardado}</h4>
	</c:if>
		
	<h4 align="center">${nombreDepedencia}</h4>
	<form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/formularioAction?action=guardarGastos">
		<input type="hidden" name="id_comision" value="${idComision}"/>
	    <input type="hidden" name="id_registro_gasto_comision" value="${idRegistroGastoComision}"/>
	    <div class="form-group">
		<c:forEach items="${elementosFormulario}" var="elementoFormulario">
			<c:if test="${elementoFormulario.tipoControl=='TEXTO'}">
				<c:if test="${elementoFormulario.subtipo=='SIMPLE'}">
					<div class="form-group">
						<label class="col-sm-2 control-label">${elementoFormulario.etiqueta}</label>
					    <div class="col-sm-10">
				  	      <input type="text" class="form-control" name="${elementoFormulario.campo}|${elementoFormulario.tipoDato}" maxlength="200" size="100" <c:if test="${elementoFormulario.obligatorio==1}">required</c:if> value="${elementoFormulario.valorCampo}">
					    </div>
				    </div>
				</c:if>
						<c:if test="${elementoFormulario.subtipo=='AREA'}">
							<div class="form-group">
								<label for="col-sm-2 control-label" class="col-sm-2 control-label">${elementoFormulario.etiqueta}</label>
							    <div class="col-sm-10">
							      <textarea class="form-control" name="${elementoFormulario.campo}|${elementoFormulario.tipoDato}" <c:if test="${elementoFormulario.obligatorio==1}">required</c:if> rows="6" cols="60">${elementoFormulario.valorCampo}</textarea>
							    </div>
						    </div>
						</c:if>
					</c:if>
					<c:if test="${elementoFormulario.tipoControl=='LISTA'}">
						<div class="form-group">
							<label class="col-sm-2 control-label">${elementoFormulario.etiqueta}</label>
						    <div class="col-sm-10">
						      <select class="form-control" name="${elementoFormulario.campo}|${elementoFormulario.tipoDato}" <c:if test="${elementoFormulario.obligatorio==1}">required</c:if>>
							  	<c:forEach items="${elementoFormulario.catalogo}" var="catalogo">
					            	<option value="${catalogo.codigo}" <c:if test="${elementoFormulario.valorCampo==catalogo.codigo}">selected</c:if>>${catalogo.descripcion}</option>
					            </c:forEach>
							  </select>
						    </div>
					    </div>
					</c:if>
					<c:if test="${elementoFormulario.tipoControl=='CALENDARIO'}">
						<c:if test="${elementoFormulario.subtipo=='FECHA'}">
							<div class="form-group">
								<label class="col-sm-2 control-label">${elementoFormulario.etiqueta}</label>
								<div class="col-xs-5 date">
										<div class="input-group input-append date" id="${elementoFormulario.campo}">
											<input id="${elementoFormulario.campo}|Texto" type="text" class="form-control" readonly="readonly" name="${elementoFormulario.campo}|${elementoFormulario.tipoDato}" <c:if test="${elementoFormulario.obligatorio==1}">required</c:if>  value="${elementoFormulario.valorCampo}" maxlength="200" size="100">
											<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
	            						</div>
								</div>
							</div>
							<script>
					            	datesFields[indexDates] = ['${elementoFormulario.campo}'];
					            	indexDates++;
					        </script>
						</c:if>
						<c:if test="${elementoFormulario.subtipo=='HORA'}">
						<div class="form-group">
							<label class="col-sm-2 control-label">${elementoFormulario.etiqueta}</label>
							<div class="col-sm-10">
								<input type="time" class="form-control" name="${elementoFormulario.campo}|${elementoFormulario.tipoDato}" <c:if test="${elementoFormulario.obligatorio==1}">required</c:if>  value="${elementoFormulario.valorCampo}" maxlength="200" size="100">
							</div>
						</div>
						</c:if>
					</c:if>
				</c:forEach>
				</div>	
		    	<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				    	<button type="submit" class="btn btn-primary">Guardar Datos</button>
				    </div>
			  	</div>
			</form>
	
	
	
	<jsp:include page="/footer.jsp"/>
</body>

<script type="text/javascript">

var formularioValido = true;

$(document).ready(function() {
	if(datesFields.length>0){
		for (var i=0;i<datesFields.length;i++){
			$('#'+datesFields[i])
        		.datepicker({
            	format: 'yyyy-mm-dd'
        	});
		}
	}
});
</script>
</html>