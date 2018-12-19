<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Usuario</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Usuario</h3>
    <form method="post" class="form-horizontal" action="userAction">
	   <c:choose>
	     <c:when test="${comando=='update'}">
	       <input type="hidden" name="action" value="actualiza"/>
	     </c:when>
	     <c:otherwise>
	       <input type="hidden" name="action" value="ingresa"/>
	     </c:otherwise>
	     </c:choose>
	   <!-- <input type="hidden" name="submitted" value="1"/> -->
	   <input type="hidden" name="id" value="${usuario.id}"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Usuario</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="usuario" placeholder="Texto" value="<c:out value="${usuario.usuario}"/>" maxlength="30" size="30">
	    </div>
	  </div>
	  <c:if test="${comando!='update'}">
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
	  </c:if>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Descripci&oacute;n</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="descripcion" placeholder="Texto" value="<c:out value="${usuario.usuario}"/>" maxlength="30" size="30">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Habilitado</label>
	    <div class="col-sm-10">
	      <input type="checkbox" name="habilitado" ${activa}/>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Perfil</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="perfil">
		  	<c:forEach items="${perfiles}" var="perfil">
            	<option value="${perfil.id}" <c:if test="${perfil.id==usuario.perfil.id}">selected</c:if>>${perfil.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Persona</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="persona">
		  	<c:forEach items="${personas}" var="persona">
            	<option value="${persona.id}" <c:if test="${persona.id==usuario.persona.id}">selected</c:if>>${persona.tipoPersona.codigo} - ${persona.nombres} ${persona.apellidoPaterno} ${persona.apellidoMaterno}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Dependencia</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="dependencia">
		  	<c:forEach items="${dependencias}" var="dependencia">
            	<option value="${dependencia.id}" <c:if test="${dependencia.id==usuario.dependencia.id}">selected</c:if>>${dependencia.siglas} - ${dependencia.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">&Aacute;rea</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="area">
		  	<c:forEach items="${areas}" var="area">
            	<option value="${area.id}" <c:if test="${area.id==usuario.area.id}">selected</c:if>>${area.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Es Jefe</label>
	    <div class="col-sm-10">
	      <input type="checkbox" name="jefe" ${es_jefe}/>
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