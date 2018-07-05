<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Credenciales</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Credenciales</h3>
    <form method="post" class="form-horizontal" action="userAction">
	   <input type="hidden" name="id" value="${usuario.id}"/>
	   <input type="hidden" name="action" value="credenciales"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Contrase&ntilde;a</label>
	    <div class="col-sm-10">
	      <input type="password" class="form-control" name="contrasena" placeholder="Password" maxlength="200" size="80">
	    </div>
	  </div>
  	  <div class="form-group">
	    <label class="col-sm-2 control-label">Confirmar</label>
	    <div class="col-sm-10">
	      <input type="password" class="form-control" name="confirma" placeholder="Password" maxlength="200" size="80">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'userAction?action=listarUsuarios';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>