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
    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/navbar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fontello.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/importer.css" rel="stylesheet">
    <!--<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet"> -->
    <link href="${pageContext.request.contextPath}/css/stickyFooter.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-d3.css" rel="stylesheet">
    
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>  -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <!-- <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> -->
</head>
<body>
	<div id="header">
		<div class="navbar navbar-default gradient-blue">
			<div class="container-fluid content">
				<div class="navbar-header">
					<a href="http://inicio.ifai.org.mx/" class="navbar-brand" target="_blank"><img src="${pageContext.request.contextPath}/img/logoifai2014.png" alt="logo"></a>
					<a href="/" class="navbar-brand"><img src="${pageContext.request.contextPath}/img/viajeslogo.png" alt="logo"></a>
			    </div>
		    </div>
		</div>
	</div>
	<script src="js/bootstrap.min.js"></script>
	<div id="content">
	<div class="container text-center col-sm-3 col-sm-offset-4 login-div">
	<form action="securityAction?action=login" method="post" class="form-horizontal">
		<c:if test="${mensaje != null}">
			<div class="alert alert-danger" role="alert">
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  <span class="sr-only">Error:</span>
			  ${mensaje}
			</div>
		</c:if>
        <h3 class="form-signin-heading">Iniciar Sesi&oacute;n</h3>
        <br/>
        <div class="form-group">
        	<label for="user" class="col-sm-4 control-label">Usuario</label>
        	<div class="col-sm-8">
        		<input type="text" id="user" name="user" class="form-control" placeholder="Usuario" required autofocus>
        	</div>
        </div>
        <div class="form-group">
        	<label for="pass" class="col-sm-4 control-label">Contrase&ntilde;a</label>
        	<div class="col-sm-8">
        		<input type="password" id="pass" name="pass" class="form-control" placeholder="Password" required>
        	</div>
        </div>
        <input type="submit" name="Ingresar" class="btn btn-sm btn-primary" value="Ingresar">
			<input type="button" name="Limpiar" class="btn btn-sm btn-default" value="Limpiar" onclick="location.href = 'login.jsp';">
    </form>

    </div>
    </div>
	<jsp:include page="/footer.jsp"/>
</body>
</html>