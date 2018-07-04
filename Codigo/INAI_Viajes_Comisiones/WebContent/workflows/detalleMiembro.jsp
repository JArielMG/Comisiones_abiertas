<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Jerarqu&iacute;a</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Jerarqu&iacute;a</h3>
    <form method="post" class="form-horizontal" action="miembroAction">
	   <c:choose>
	     <c:when test="${comando=='update'}">
	       <input type="hidden" name="action" value="actualiza"/>
	     </c:when>
	     <c:otherwise>
	       <input type="hidden" name="action" value="ingresa"/>
	     </c:otherwise>
	   </c:choose>
	   <!-- <input type="hidden" name="submitted" value="1"/> -->
	   <input type="hidden" name="idJerar" value="${idJerar}"/>
	   <input type="hidden" name="id" value="${miembro.id}"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Jerarqu&iacute;a</label>
	    <div class="col-sm-10">
	      <c:choose>
		     <c:when test="${jerarquia==null}">
		       <input type="text" class="form-control" name="nombre" placeholder="Texto" value="<c:out value="${miembro.jerarquia.nombre}"/>" maxlength="200" size="80" readonly="readonly">
		     </c:when>
		     <c:otherwise>
		       <input type="text" class="form-control" name="nombre" placeholder="Texto" value="<c:out value="${jerarquia.nombre}"/>" maxlength="200" size="80" readonly="readonly">
		     </c:otherwise>
		  </c:choose>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Usuario</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="usuario">
		  	<c:forEach items="${usuarios}" var="usuario">
            	<option value="${usuario.id}" <c:if test="${usuario.id==miembro.usuario.id}">selected</c:if>>${usuario.usuario} - ${usuario.persona.nombres} ${usuario.persona.apellidoPaterno} ${usuario.persona.apellidoMaterno}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'miembroAction?action=listar&idJerar=${idJerar}';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>