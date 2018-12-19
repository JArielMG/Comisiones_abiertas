<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Categor&iacute;a</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Categor&iacute;a</h3>
    <form method="post" class="form-horizontal" action="categoryAction">
	   <c:choose>
	     <c:when test="${comando=='update'}">
	       <input type="hidden" name="action" value="actualiza"/>
	     </c:when>
	     <c:otherwise>
	       <input type="hidden" name="action" value="ingresa"/>
	     </c:otherwise>
	     </c:choose>
	   <!-- <input type="hidden" name="submitted" value="1"/> -->
	   <input type="hidden" name="id" value="${categoria.id}"/>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Nombre</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="nombre" placeholder="Texto" value="<c:out value="${categoria.nombre}"/>" maxlength="200" size="100">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Tope Hospedaje</label>
	    <div class="col-sm-10">
	      <input type="number" class="form-control" name="hospedaje" placeholder="Numero" value="<c:out value="${categoria.topeHospedaje}"/>" size="30">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">Tope Viáticos</label>
	    <div class="col-sm-10">
	      <input type="number" class="form-control" name="viaticos" placeholder="Numero" value="<c:out value="${categoria.topeViaticos}"/>" size="30">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-primary">Aceptar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'categoryAction?action=listar';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>