<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Personas</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<div id="content">
	<h3>Personas</h3>
    <c:if test="${mensaje != null}">
		<div class="alert alert-danger" role="alert">
		  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		  <span class="sr-only">Error:</span>
		  ${mensaje}
		</div>
	</c:if>
	<div class="bs-example" data-example-id="simple-table" width="50%" align="center">
    <table class="table" width="70%">
        <thead>
            <th>Nombre Completo</th>
            <th>T&iacute;tulo</th>
            <th>Correo</th>
            <th>Posici&oacute;n</th>
            <th>Cargo</th>
            <th>Categor&iacute;a</th>
            <th>Tipo</th>
            <th>Ingreso</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${personas}" var="persona">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${persona.nombres} ${persona.apellidoPaterno} ${persona.apellidoMaterno}</td>
                    <td>${persona.titulo}</td>
                    <td>${persona.email}</td>
                    <td>${persona.posicion.nombre}</td>
                    <td>${persona.cargo}</td>
                    <td>${persona.categoria.nombre}</td>
                    <td>${persona.tipoPersona.descripcion}</td>
                    <td><fmt:formatDate value="${persona.fechaIngreso}" pattern="dd/MM/yyyy"/></td>
                    <td align="right"><a href="personAction?action=modificar&id=${persona.id}"><img src="img/Edit.png" title="Mofificar" height="20" width="20" class="boton"></a>
                        <a href="personAction?action=borrar&id=${persona.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="personAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>