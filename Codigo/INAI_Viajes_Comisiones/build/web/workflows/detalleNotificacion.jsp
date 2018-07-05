<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Detalles de la Notificaci&oacute;n</title>
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Detalles de la Notificaci&oacute;n</h3>
    <form method="post" class="form-group" action="notificacionAction">
	  <input type="hidden" name="action" value="responde"/>
	  <input type="hidden" name="instance" value="${instance}"/>
	  <input type="hidden" name="id" value="${id}"/>
	  <div>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		  <c:forEach items="${detalle.secciones}" var="seccion" varStatus="posicion">
		  	<c:choose>
		  		<c:when test="${posicion.index==0}">
		  			<li role="presentation" class="active"><a href="#<c:out value="${seccion.nombreSeccion}"/>" aria-controls="home" role="tab" data-toggle="tab">${seccion.etiqueta}</a></li>
		  		</c:when>
		  		<c:otherwise>
		  		<li role="presentation"><a href="#<c:out value="${seccion.nombreSeccion}"/>" aria-controls="home" role="tab" data-toggle="tab">${seccion.etiqueta}</a></li>
		  		</c:otherwise>
		  	</c:choose>
		  </c:forEach>
		  </ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		  	<c:forEach items="${detalle.secciones}" var="seccion" varStatus="posicion">
				<c:choose>
			  		<c:when test="${posicion.index==0}">
			  			<div role="tabpanel" class="tab-pane active" id="${seccion.nombreSeccion}">
			  		</c:when>
			  		<c:otherwise>
			  			<div role="tabpanel" class="tab-pane" id="${seccion.nombreSeccion}">
			  		</c:otherwise>
			  	</c:choose>
			  				<c:forEach items="${seccion.detalle}" var="registro">
			  					<div class="form-group">
			  						<label class="col-sm-3 control-label">${registro.etiqueta}</label>
								    <div class="col-sm-8">
								    	<c:choose> 
								    		<c:when test="${registro.subtipo=='AREA'}">
												<textarea class="form-control" readonly placeholder="${registro.valorTexto}${registro.valorNumerico}${registro.valorFecha}"></textarea>
										    </c:when>
										    <c:otherwise>
										    	<input class="form-control" type="text" placeholder="${registro.valorTexto}${registro.valorNumerico}${registro.valorFecha}" readonly>
										    </c:otherwise>
										</c:choose>
								    </div>
							    </div>
			  				</c:forEach>
			  			</div>
			</c:forEach>
		  </div>
	  </div>
	  <br>
	  <div class="form-group">
	    <label class="col-sm-3 control-label">Comentarios</label>
	    <div class="col-sm-8">
	      <input type="text" class="form-control" name="comentarios" placeholder="Texto" maxlength="80" size="80">
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="button" class="btn btn-primary" onclick="location.href = 'notificacionAction?action=responde&resp=Aprobar&instance=${instance}&id=${id}&comentarios='+this.form.comentarios.value;">Aprobar</button>
	      <button type="button" class="btn btn-danger" onclick="location.href = 'notificacionAction?action=responde&resp=Rechazar&instance=${instance}&id=${id}&comentarios='+this.form.comentarios.value;">Rechazar</button>
	      <button type="button" class="btn btn-default" onclick="location.href = 'notificacionAction?action=listar';">Cancelar</button>
	    </div>
	  </div>
	</form>
	<jsp:include page="/footer.jsp"/>
</body>
</html>