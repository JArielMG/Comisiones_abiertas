<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Lista de Gastos a Comprobar</title>
<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/Comandos.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/navbar.css" rel="stylesheet">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<jsp:include page="../include.jsp"/>
	<h3>Lista de Gastos a Comprobar</h3>
    <c:if test="${mensaje != null}">
		<div class="alert alert-danger" role="alert">
		  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		  <span class="sr-only">Error:</span>
		  ${mensaje}
		</div>
	</c:if>
	<div class="bs-example" data-example-id="simple-table" width="50%" align="center">
    <table class="table" width="70%">
        <thead>
            <c:forEach items="${encabezados}" var="encabezado">
            	<th>${encabezado}</th>
            </c:forEach>
        </thead>
        <tbody>
        	<c:set var="idRegistro" scope="page" value="-1"/>
            <c:forEach items="${valoresTabla}" var="valorTabla">
                <c:if test="${valorTabla.idRegistroGastoComision!=idRegistro}">
                	<c:if test="${idRegistro!=-1}">
                			<td align="right"><a href="formularioAction?action=modificarGasto&id_comision=${idComision}&id_registro=${idRegistro}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
                        	<a href="formularioAction?action=borrarGasto&id_comision=${idComision}&id_registro=${idRegistro}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
                        </tr>
                	</c:if>
                	<tr onmouseover="this.className='focus'" onmouseout="this.className='unfocus'">
                </c:if>
                	<td>${valorTabla.valor} <c:if test="${valorTabla.valor=='factura.pdf'}"><a href="formularioAction?action=verFacturaGasto&id_comision=${idComision}&id_registro=${idRegistro}"><img src="img/Search.png" title="Ver Factura" height="20" width="20" class="boton"></a> </c:if> </td>
                	
                <c:if test="${valorTabla.idRegistroGastoComision!=idRegistro}">
                	<c:set var="idRegistro" scope="page" value="${valorTabla.idRegistroGastoComision}"/>
                </c:if>
            </c:forEach>
            <c:if test="${not empty valoresTabla}">
	            	<td align="right"><a href="formularioAction?action=modificarGasto&id_comision=${idComision}&id_registro=${idRegistro}"><img src="img/Edit.png" title="Modificar" height="20" width="20" class="boton"></a>
	                <a href="formularioAction?action=borrarGasto&id_comision=${idComision}&id_registro=${idRegistro}"><img src="img/Remove.png" title="Eliminar" height="20" width="20" class="boton"></a></td>
	            </tr>
            </c:if>
        </tbody>
    </table>
    <a href="formularioAction?action=agregarGasto&id_comision=${idComision}"><img src="img/Add.png" title="Agregar" height="40" width="40" class="boton"></a>
    <a href="<c:url value="formularioAction?action=oficioGastos"/>"><img src="img/Home.png" title="Inicio" height="40" width="40" class="boton"></a>    
    <button type="button" class="btn btn-default" onclick="location.href = 'formularioAction?action=verDetalleComision&id_comision=${idComision}';">Regresar</button>
    
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>