<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Ciudades</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Ciudades</h3>
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
            <th>Nombre</th>
            <th>Pa&iacute;s</th>
            <th>Estado</th>
            <th>Latitud</th>
            <th>Longitud</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${ciudades}" var="ciudad">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${ciudad.nombre}</td>
                    <td>${ciudad.pais.clave} - ${ciudad.pais.nombre}</td>
                    <td>${ciudad.estado.nombre}</td>
                    <td>${ciudad.latitud}</td>
                    <td>${ciudad.longitud}</td>
                    <td align="right"><a href="ciudadAction?action=modificar&id=${ciudad.id}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
                        <a href="ciudadAction?action=borrar&id=${ciudad.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="ciudadAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>