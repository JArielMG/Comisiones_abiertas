<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notificaciones Pendientes de Aprobar</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Notificaciones Pendientes de Aprobar</h3>
    <c:if test="${mensaje != null}">
		<c:choose>
			<c:when test="${mensaje == 'Notificaci&oacute;n respondida.'}">
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
	<div class="bs-example" data-example-id="simple-table" width="50%" align="center">
	    <table class="table" width="70%">
	        <thead>
	            <th>Instancia</th>
	            <th>Flujo</th>
	            <th>Nombre</th>
	            <th>Solicitante</th>
	            <th>Fecha Solicitud</th>
	        </thead>
	        <tbody>
	            <c:forEach items="${notificaciones}" var="notificacion">
	                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
	                    <td>${notificacion.instanceId.instancia}</td>
	                    <td>${notificacion.instanceId.flujo.nombre}</td>
	                    <td>${notificacion.display}</td>
	                    <td>${notificacion.actor.persona.nombres} ${notificacion.actor.persona.apellidoPaterno} ${notificacion.actor.persona.apellidoMaterno}</td>
	                    <td><fmt:formatDate value="${notificacion.lastUpdateDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
	                    <td align="right"><a href="notificacionAction?action=detalle&id=${notificacion.id}&instance=${notificacion.instanceId.instancia}&tipo=${notificacion.actor.persona.tipoPersona.id}"><img src="img/Help.png" title="Detalles" height="30" width="30" class="boton"></a></td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    	<a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>