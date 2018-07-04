<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Dependencias</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Dependencias</h3>
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
            <th>Siglas</th>
            <th>Nombre</th>
            <th>Predeterminada</th>
            <th>&nbsp;</th>
        </thead>
        <tbody>
            <c:forEach items="${dependencias}" var="dependencia">
                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                    <td>${dependencia.siglas}</td>
                    <td>${dependencia.nombre}</td>
                    <td><c:choose>
							<c:when test="${dependencia.predeterminada==true}">
						       S&iacute;
						    </c:when>
						    <c:otherwise>
						       No
						    </c:otherwise>
						</c:choose>
                    </td>
                    <td align="right"><a href="dependenciaAction?action=modificar&id=${dependencia.id}"><img src="img/Edit.png" title="Mofificar" height="20" width="20" class="boton"></a>
                        <a href="dependenciaAction?action=borrar&id=${dependencia.id}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="dependenciaAction?action=agregar"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>