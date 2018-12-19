<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Perfiles</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Perfiles</h3>
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
	        </thead>
	        <tbody>
	            <c:forEach items="${perfiles}" var="perfil">
	                <tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
	                    <td>${perfil.nombre}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    	<a href="<c:url value="/index.jsp"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>