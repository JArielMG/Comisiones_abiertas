<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="mx.org.inai.viajesclaros.admin.model.SesionVO"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bienvenido a Viajes Claros</title>
<!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/navbar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fontello.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/importer.css" rel="stylesheet">
    <!--<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet"> -->
    <link href="${pageContext.request.contextPath}/css/stickyFooter.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-d3.css" rel="stylesheet">
    
    <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>  -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <!-- <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> -->
</head>
<% SesionVO sesion = (SesionVO)request.getSession().getAttribute("sesion"); %>
<body>
	<div id="header">
		<div class="navbar navbar-default gradient-blue">
			<div class="container-fluid content">
				<div class="navbar-header">
					<a href="http://inicio.ifai.org.mx/" class="navbar-brand" target="_blank"><img src="${pageContext.request.contextPath}/img/logoifai2014.png" alt="logo"></a>
					<a href="/" class="navbar-brand"><img src="${pageContext.request.contextPath}/img/viajeslogo.png" alt="logo"></a>
			    </div>
		    </div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<div class="container">

      <!-- Static navbar -->
      <nav class="navbar-menu navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><%=sesion.getUsuario()%></a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
              <% if (sesion.getPerfil().getNombre().equals("Administrador") || sesion.getPerfil().getNombre().equals("Configurador")) {%>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Cat&aacute;logos <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="${pageContext.request.contextPath}/userAction?action=listarUsuarios">Usuarios</a></li>
                  <li><a href="${pageContext.request.contextPath}/personAction?action=listarPersonas">Personas</a></li>
                  <li><a href="${pageContext.request.contextPath}/personAction?action=listarTipos">Tipos de Persona</a></li>
                  <li><a href="${pageContext.request.contextPath}/posicionAction?action=listar">Posiciones</a></li>
                  <li><a href="${pageContext.request.contextPath}/userAction?action=listarPerfiles">Perfiles</a></li>
                  <li><a href="${pageContext.request.contextPath}/categoryAction?action=listar">Categor&iacute;as</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Organizaci&oacute;n</li>
                  <li><a href="${pageContext.request.contextPath}/dependenciaAction?action=listar">Dependencias</a></li>
                  <li><a href="${pageContext.request.contextPath}/areaAction?action=listar">&Aacute;reas</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Operaci&oacute;n</li>
                  <li><a href="${pageContext.request.contextPath}/paisAction?action=listar">Pa&iacute;ses</a></li>
                  <li><a href="${pageContext.request.contextPath}/estadoAction?action=listar">Estados</a></li>
                  <li><a href="${pageContext.request.contextPath}/ciudadAction?action=listar">Ciudades</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Configuradores <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="${pageContext.request.contextPath}/procesosAction?action=listar">Flujos de Trabajo</a></li>
                  <li><a href="${pageContext.request.contextPath}/grupoAprobacionAction?action=listar">Grupos de Aprobaci&oacute;n</a></li>
                  <li><a href="${pageContext.request.contextPath}/jerarquiaAction?action=listar">Jerarqu&iacute;as</a></li>
                </ul>
              </li>
              <% } %>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Solicitudes <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <% if (!sesion.getPerfil().getNombre().equals("Carga_Masiva")) {%>
                  <li><a href="${pageContext.request.contextPath}/formularioAction?action=oficioComision">Solicitud de Comisi&oacute;n</a></li>
                  <li><a href="${pageContext.request.contextPath}/formularioAction?action=oficioViaticos">Solicitud de Vi&aacute;ticos y Hospedaje</a></li>
                  <li><a href="${pageContext.request.contextPath}/formularioAction?action=oficioGastos">Ingreso de Comprobantes de Gastos</a></li>
                  <li><a href="${pageContext.request.contextPath}/formularioAction?action=oficioPublicacion">Solicitud de Publicaci&oacute;n</a></li>
                  <li><a href="${pageContext.request.contextPath}/formularioAction?action=listarReportesComisiones">Reportes Comisiones</a></li>
                  <!--<li><a href="${pageContext.request.contextPath}/ingresaInfoAction?action=ingreso">Solicitud Demo de WF</a></li>-->
                  <% } %>
                  <% if (sesion.getPerfil().getNombre().equals("Carga_Masiva") || sesion.getPerfil().getNombre().equals("Administrador")) {%>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Otras dependencias</li>
                  <li><a href="${pageContext.request.contextPath}/carga/cargaArchivo.jsp">Interfaz de Carga</a></li>
                  <% } %>
                </ul>
              </li>
              <% if (!sesion.getPerfil().getNombre().equals("Carga_Masiva")) {%>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Aprobaciones <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="${pageContext.request.contextPath}/notificacionAction?action=listar">Notificaciones de aprobaci&oacute;n</a></li>
                  <!--<li><a href="#">Listado de flujos de aprobaci&oacute;n</a></li>-->
                </ul>
              </li>
              <% } %>
              <!-- <li><a href="#">Acerca de</a></li>
              <li><a href="#">Contacto</a></li> -->
              <li><a href="${pageContext.request.contextPath}/logout">Cerrar Sesi&oacute;n</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div> <!-- /container -->
</body>
</html>