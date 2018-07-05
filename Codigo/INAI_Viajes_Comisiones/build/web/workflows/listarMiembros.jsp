<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Miembros de Jerarqu&iacute;a</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Miembros de Jerarqu&iacute;a</h3>
    <c:if test="${mensaje != null}">
		<div class="alert alert-danger" role="alert">
		  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		  <span class="sr-only">Error:</span>
		  ${mensaje}
		</div>
	</c:if>
	<div class="bs-example" data-example-id="simple-table" width="50%" align="center">
	<form method="post" class="form-horizontal" action="miembroAction">
		<input type="hidden" name="idJerar" value="${idJerar}"/>
	    <table class="table" width="70%">
	        <thead>
	            <th>Jerarqu&iacute;a</th>
	            <th>Usuario</th>
	            <th>&nbsp;</th>
	        </thead>
	        <tbody>
	            <c:forEach items="${miembros}" var="miembro">
	                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
	                    <td>${miembro.jerarquia.nombre}</td>
	                    <td>${miembro.usuario.usuario} - ${miembro.usuario.persona.nombres} ${miembro.usuario.persona.apellidoPaterno} ${miembro.usuario.persona.apellidoMaterno}</td>
	                    <td align="right">
	                      <a href="miembroAction?action=modificar&id=${miembro.id}&idJerar=${miembro.jerarquia.id}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
	                      <a href="miembroAction?action=borrar&id=${miembro.id}&idJerar=${miembro.jerarquia.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    <a href="miembroAction?action=agregar&idJerar=${idJerar}"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
	    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
	    </div>
    </form>
    <jsp:include page="/footer.jsp"/>
</body>
</html>