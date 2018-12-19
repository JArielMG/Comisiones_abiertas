<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Pa&iacute;ses</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Pa&iacute;ses</h3>
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
            <th>Clave</th>
            <th>Nombre</th>
            <th>Predeterminado</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${paises}" var="pais">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${pais.clave}</td>
                    <td>${pais.nombre}</td>
                    <td><c:choose>
							<c:when test="${pais.predeterminado==true}">
						       S&iacute;
						    </c:when>
						    <c:otherwise>
						       No
						    </c:otherwise>
						</c:choose>
                    </td>
                    <td align="right"><a href="paisAction?action=modificar&id=${pais.id}"><img src="img/Edit.png" title="Mofificar" height="20" width="20" class="boton"></a>
                        <a href="paisAction?action=borrar&id=${pais.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="paisAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>