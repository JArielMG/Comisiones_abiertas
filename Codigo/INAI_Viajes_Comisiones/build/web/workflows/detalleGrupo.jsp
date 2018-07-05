<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Grupo de Aprobaci&oacute;n</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Grupo de Aprobaci&oacute;n</h3>
    <form method="post" class="form-horizontal" action="grupoAprobacionAction">
	   <c:choose>
	     <c:when test="${comando=='update'}">
	       <input type="hidden" name="action" value="actualiza"/>
	     </c:when>
	     <c:otherwise>
	       <input type="hidden" name="action" value="ingresa"/>
	     </c:otherwise>
	   </c:choose>
	   <!-- <input type="hidden" name="submitted" value="1"/> -->
	   <input type="hidden" name="id" value="${grupo.id}"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Nombre</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="nombre" placeholder="Texto" value="<c:out value="${grupo.nombre}"/>" maxlength="200" size="80">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Proceso</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="flujo">
		  	<c:forEach items="${flujos}" var="flujo">
            	<option value="${flujo.id}" <c:if test="${flujo.id==grupo.flujo.id}">selected</c:if>>${flujo.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Dependencia</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="dependencia">
		  	<c:forEach items="${dependencias}" var="dependencia">
		  		<c:if test="${dependencia.predeterminada==true}">
            		<option value="${dependencia.id}" <c:if test="${dependencia.id==grupo.dependencia.id}">selected</c:if>>${dependencia.siglas} - ${dependencia.nombre}</option>
            	</c:if>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">&Aacute;rea</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="area">
		  	<c:forEach items="${areas}" var="area">
            	<option value="${area.id}" <c:if test="${area.id==grupo.area.id}">selected</c:if>>${area.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Jerarqu&iacute;a</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="jerarquia">
		  	<c:forEach items="${jerarquias}" var="jerarquia">
            	<option value="${jerarquia.id}" <c:if test="${jerarquia.id==grupo.jerarquia.id}">selected</c:if>>${jerarquia.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'grupoAprobacionAction?action=listar';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>