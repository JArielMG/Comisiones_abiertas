<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Listado de comisiones del usuario</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Listado de comisiones del usuario</h3>
	<form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/formularioAction?action=verDetalleComision">
		<input type="hidden" name="id_comision" value="0"/>
	    <div class="form-group">
			<div class="col-sm-offset-0 col-sm-2">
		   		<button type="submit" class="btn btn-default">Agregar nueva comisión</button>
		   	</div>
		</div>
	</form>
    <div class="bs-example" data-example-id="simple-table" width="50%" align="center">
    <table class="table" width="70%">
        <thead>
            <c:forEach items="${encabezados}" var="encabezado">
            	<th>${encabezado}</th>
            </c:forEach>
        </thead>
        <tbody>
            <c:forEach items="${valoresTabla}" var="valorTabla">
                <tr>
                	<td>${valorTabla.idComision}</p></td>
                	<td><a href="formularioAction?action=verDetalleComision&id_comision=${valorTabla.idComision}"><p>${valorTabla.estatus}</p></a></td>
                	<td>${valorTabla.fechaSalida}</td>
                	<td>${valorTabla.fechaRegreso}</td>
                	<td>${valorTabla.paisDestino}</td>
                	<td>${valorTabla.ciudadDestino}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>