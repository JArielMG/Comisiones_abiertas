<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Lista de Generación de Reportes de Comisiones</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Lista de Generación de Reportes de Comisiones</h3>
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
                	<td><a href="formularioAction?action=generarReporte&id_comision=${valorTabla.idComision}&id_tipo_persona=${idTipoPersona}&id_flujo=1"><p>${valorTabla.f1}</p></a></td>
                	<td><a href="formularioAction?action=generarReporte&id_comision=${valorTabla.idComision}&id_tipo_persona=${idTipoPersona}&id_flujo=2"><p>${valorTabla.f2}</p></a></td>
                	<td><a href="formularioAction?action=generarReporte&id_comision=${valorTabla.idComision}&id_tipo_persona=${idTipoPersona}&id_flujo=3"><p>${valorTabla.f3}</p></a></td>
                	<td><a href="formularioAction?action=generarReporte&id_comision=${valorTabla.idComision}&id_tipo_persona=${idTipoPersona}&id_flujo=4"><p>${valorTabla.f4}</p></a></td>                	
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>