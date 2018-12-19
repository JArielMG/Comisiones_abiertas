<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Usuarios</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<div id="content">
	<h3>Usuarios</h3>
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
            <th>Usuario</th>
            <th>Descripci&oacute;n</th>
            <th>Habilitado</th>
            <th>Perfil</th>
            <th>Persona</th>
            <th>Dependencia</th>
            <th>&Aacute;rea</th>
            <th>Es Jefe</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${usuarios}" var="usuario">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${usuario.usuario}</td>
                    <td>${usuario.descripcion}</td>
                    <td><c:choose>
							<c:when test="${usuario.habilitado==true}">
						       S&iacute;
						    </c:when>
						    <c:otherwise>
						       No
						    </c:otherwise>
						</c:choose>
                    </td>
                    <td>${usuario.perfil.nombre}</td>
                    <td>${usuario.persona.nombres} ${usuario.persona.apellidoPaterno} ${usuario.persona.apellidoMaterno}</td>
                    <td>${usuario.dependencia.siglas}</td>
                    <td>${usuario.area.nombre}</td>
                    <td><c:choose>
							<c:when test="${usuario.jefeArea==true}">
						       S&iacute;
						    </c:when>
						    <c:otherwise>
						       No
						    </c:otherwise>
						</c:choose>
                    </td>
                    <td align="right"><a href="userAction?action=modificar&id=${usuario.id}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
                    	<a href="userAction?action=contrasena&id=${usuario.id}"><img src="img/Keys.png" title="Contrase&ntilde;a" height="20" width="20" class="boton"></a>
                        <a href="userAction?action=borrar&id=${usuario.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="userAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    </div>
    <jsp:include page="../footer.jsp"/>
</body>
</html>