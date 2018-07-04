<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inicio de Sesion</title>
<!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fontello.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/importer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/stickyFooter.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-d3.css" rel="stylesheet">
</head>
<body>
	<div id="header" data-ng-controller="headerCTL">
		<div class="container container-fixed">
			<div class="menu">
				<a href="http://inicio.ifai.org.mx/" class="logo ifai-logo" target="_blank"><img src="${pageContext.request.contextPath}/img/logoifai2014.png" alt="logo"></a>
				<a href="/" class="logo viajes-logo"><img src="${pageContext.request.contextPath}/img/viajeslogo.png" alt="logo"></a>
		            <div class="clear"></div>
		    </div>
		</div>
	</div>
	<script src="js/bootstrap.min.js"></script>
	
	<div class="container">
	<form action="securityAction?action=login" method="post" class="form-signin">
		<c:if test="${mensaje != null}">
			<div class="alert alert-danger" role="alert">
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  <span class="sr-only">Error:</span>
			  ${mensaje}
			</div>
		</c:if>
        <h2 class="form-signin-heading">Ingrese identificaci&oacute;n</h2>
        <label for="inputText" class="sr-only">Usuario</label>
        <input type="text" id="user" name="user" class="form-control" placeholder="Usuario" required autofocus>
        <label for="inputPassword" class="sr-only">Contrase&ntilde;a</label>
        <input type="password" id="pass" name="pass" class="form-control" placeholder="Password" required>
        <input type="submit" name="Ingresar" class="btn btn-sm btn-primary" value="Ingresar">
		<input type="button" name="Limpiar" class="btn btn-sm btn-default" value="Limpiar" onclick="document.getElementById('user').value = ''; document.getElementById('pass').value = '';">
    </form>

    </div>
    <br><br><br><br><br><br><br>
	<jsp:include page="/footer.jsp"/>
</body>
</html>