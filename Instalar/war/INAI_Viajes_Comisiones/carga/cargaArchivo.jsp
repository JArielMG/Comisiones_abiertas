<%@page import="mx.org.inai.viajesclaros.admin.service.DependenciaServices"%>
<%@page import="mx.org.inai.viajesclaros.admin.model.DependenciaVO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%	DependenciaServices depServ = new DependenciaServices();
	ArrayList<DependenciaVO> dependencias = depServ.obtenerDependencias();
	request.setAttribute("dependencias", dependencias);
%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="es" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Carga de Archivos</title>
<!-- Bootstrap -->
    <!--<link href="../css/bootstrap.min.css" rel="stylesheet">-->
</head>
<body>
	<jsp:include page="/include.jsp"/>
	<div id="content">
	<h2 class="text-center">Interfaz de Carga</h2>
	<br/>
	<form method="post" class="form-horizontal" action="uploadFileAction" enctype="multipart/form-data" id="miForm">
		<c:if test="${mensaje != null}">
			<c:choose>
				<c:when test="${mensaje == 'Archivo cargado exitosamente'}">
					<div class="alert alert-success" role="alert">
					<span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger" role="alert">
					<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
				</c:otherwise>
			</c:choose>
			  <span class="sr-only">Error:</span>
			  ${mensaje}
			</div>
		</c:if>
		<div class="form-group">
     		<label for="col-sm-2 control-label" class="col-sm-2 control-label">Dependencia</label>
     		<div class="col-sm-10">
       			<select class="form-control" name="dependencia">
     				<c:forEach items="${dependencias}" var="dependencia">
     				  <c:if test="${!dependencia.predeterminada}">
            			<option value="${dependencia.id}">${dependencia.siglas} - ${dependencia.nombre}</option>
            		  </c:if>
            		</c:forEach>
    			</select>
     		</div>
   		</div>
   		<div class="form-group">
			<label class="col-sm-2 control-label">Tipo</label>
		    <div class="col-sm-10">
		      <select class="form-control" name="tipo">
				<option value="0" selected>(please select:)</option>
				<option value="CSV">CSV</option>
				<option value="XML">XML</option>
			  </select>
		    </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">Archivo</label>
		    <div class="col-sm-10">
		      <input type="file" name="archivo">
		      <p class="help-block">Seleccionar un achivo XML o CSV para carga.</p>
		    </div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
		      <input type="submit" name="submit" value="Cargar" class="btn btn-primary" />
			  <input type="submit" name="submit" value="Descargar Layout" class="btn btn-info" />					   
			  <button type="button" class="btn btn-default" onclick="location.href = 'cargaArchivo.jsp';">Limpiar</button>
		    </div>
		</div>
	</form>
	</div>
	<jsp:include page="/footer.jsp"/>
</body>
</html>