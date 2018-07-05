<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ciudad</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Ciudad</h3>
    <form method="post" class="form-horizontal" action="ciudadAction">
	   <c:choose>
	     <c:when test="${comando=='update'}">
	       <input type="hidden" name="action" value="actualiza"/>
	     </c:when>
	     <c:otherwise>
	       <input type="hidden" name="action" value="ingresa"/>
	     </c:otherwise>
	     </c:choose>
	   <!-- <input type="hidden" name="submitted" value="1"/> -->
	   <input type="hidden" name="id" value="${ciudad.id}"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Nombre</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="nombre" placeholder="Texto" value="<c:out value="${ciudad.nombre}"/>" maxlength="250" size="80">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">Pa&iacute;s</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="pais">
		  	<c:forEach items="${paises}" var="pais">
            	<option value="${pais.id}" <c:if test="${pais.id==ciudad.pais.id}">selected</c:if>>${pais.clave} - ${pais.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword3" class="col-sm-2 control-label">Estado</label>
	    <div class="col-sm-10">
	      <select class="form-control" name="estado">
		  	<c:forEach items="${estados}" var="estado">
            	<option value="${estado.id}" <c:if test="${estado.id==ciudad.estado.id}">selected</c:if>>${estado.nombre}</option>
            </c:forEach>
		  </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Latitud</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="latitud" placeholder="Texto" value="<c:out value="${ciudad.latitud}"/>" maxlength="20" size="20">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Longitud</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="longitud" placeholder="Texto" value="<c:out value="${ciudad.longitud}"/>" maxlength="20" size="20">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'ciudadAction?action=listar';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>