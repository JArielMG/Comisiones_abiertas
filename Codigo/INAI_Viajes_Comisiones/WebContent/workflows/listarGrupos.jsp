<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Grupos de Aprobaci&oacute;n</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Grupos de Aprobaci&oacute;n</h3>
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
            <th>Flujo</th>
            <th>Dependencia</th>
            <th>&Aacute;rea</th>
            <th>Jerarqu&iacute;a</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${grupos}" var="grupo">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${grupo.nombre}</td>
                    <td>${grupo.proceso.nombre}</td>
                    <td>${grupo.dependencia.siglas} - ${grupo.dependencia.nombre}</td>
                    <td>${grupo.area.nombre}</td>
                    <td>${grupo.jerarquia.nombre}</td>
                    <td align="right">
                      <c:if test="${grupo.editable==true}">
                    	<a href="grupoAprobacionAction?action=modificar&id=${grupo.id}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
                        <a href="grupoAprobacionAction?action=borrar&id=${grupo.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a>
                      </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="grupoAprobacionAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>