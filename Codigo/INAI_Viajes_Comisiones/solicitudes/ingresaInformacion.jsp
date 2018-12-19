<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Ingreso</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Ingreso Viajes Claros</h3>
    <form method="post" class="form-horizontal" action="ingresaInfoAction">
    	<c:if test="${error.mensaje != null}">
			<c:choose>
				<c:when test="${error.codigo > 0}">
					<div class="alert alert-danger" role="alert">
					<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					<span class="sr-only">Exito:</span>
					  ${error.mensaje}
					</div>
				</c:when>
				<c:otherwise>
					<div class="alert alert-success" role="alert">
					<span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
					<span class="sr-only">Error:</span>
					  ${error.mensaje}
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
   	  <input type="hidden" name="action" value="invocar"/>
	  <div class="form-group">
	    <label for="text" class="col-sm-2 control-label">Flujo de Aprobaci&oacute;n</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="flujo">
		  	<c:forEach items="${flujos}" var="flujo">
            	<option value="${flujo.id}">${flujo.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = "<c:url value="/index.jsp"/>;">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>