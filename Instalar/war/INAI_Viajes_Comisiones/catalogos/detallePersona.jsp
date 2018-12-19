<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Persona</title>

        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-44786951-2']);
            _gaq.push(['_trackPageview']);

            (function () {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();
        </script>

        <link href="${pageContext.request.contextPath}/css/formValidation.min.css" rel="stylesheet">

        <script src="${pageContext.request.contextPath}/js/formValidation.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.formVal.min.js"></script>

    </head>
    <body>

        <jsp:include page="../include.jsp"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datepicker3.min.css" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>

    <style type="text/css">
        /**
         * Override feedback icon position
         * See http://formvalidation.io/examples/adjusting-feedback-icon-position/
         */
        #eventForm .form-control-feedback {
            top: 0;
            right: -15px;
        }
    </style>
    <div id="content">
        <h3>Persona</h3>
        <form method="post" class="form-horizontal" action="personAction">
            <c:choose>
                <c:when test="${comando=='update'}">
                    <input type="hidden" name="action" value="actualiza"/>
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="action" value="ingresa"/>
                </c:otherwise>
            </c:choose>
            <!-- <input type="hidden" name="submitted" value="1"/> -->
            <input type="hidden" name="id" value="${persona.id}"/>
            <div class="form-group">
                <label class="col-sm-2 control-label">Nombres</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="nombres" placeholder="Texto" value="<c:out value="${persona.nombres}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Apellido Paterno</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="apPaterno" placeholder="Texto" value="<c:out value="${persona.apellidoPaterno}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Apellido Materno</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="apMaterno" placeholder="Texto" value="<c:out value="${persona.apellidoMaterno}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">T&iacute;tulo</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="titulo" placeholder="Texto" value="<c:out value="${persona.titulo}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Correo</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" name="correo" placeholder="Email" value="<c:out value="${persona.email}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Posici&oacute;n</label>
                <div class="col-sm-10">
                    <select class="form-control" name="posicion">
                        <option value="0">No aplica</option>
                        <c:forEach items="${posiciones}" var="posicion">
                            <option value="${posicion.id}" <c:if test="${posicion.id==persona.posicion.id}">selected</c:if>>${posicion.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Cargo</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="cargo" placeholder="Texto" value="<c:out value="${persona.cargo}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Tipo de Persona</label>
                <div class="col-sm-10">
                    <select class="form-control" name="tipo_persona">
                        <c:forEach items="${tipos_personas}" var="tipo_persona">
                            <option value="${tipo_persona.id}" <c:if test="${tipo_persona.id==persona.tipoPersona.id}">selected</c:if>>${tipo_persona.descripcion}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Tipo de Integrante</label>
                <div class="col-sm-10">
                    <select class="form-control" name="tipo_integrante">
                        <c:forEach items="${tipos_integrantes}" var="tipo_integrante">
                            <option value="${tipo_integrante.id}" <c:if test="${tipo_integrante.id==persona.tipoIntegrante}">selected</c:if>> ${tipo_integrante.valor}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Categor&iacute;a</label>
                <div class="col-sm-10">
                    <select class="form-control" name="categoria">
                        <c:forEach items="${categorias}" var="categoria">
                            <option value="${categoria.id}" <c:if test="${categoria.id==persona.categoria.id}">selected</c:if>>${categoria.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Fer -->

            <div class="form-group">
                <label class="col-sm-2 control-label">Número de Empelado</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="numeroEmpleado" placeholder="Texto" value="<c:out value="${persona.numeroEmpleado}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Puesto</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="puesto" placeholder="Texto" value="<c:out value="${persona.denominacionPuesto}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Clave Puesto</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="clavePuesto" placeholder="Texto" value="<c:out value="${persona.clavePuesto}"/>" maxlength="200" size="80">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Sexo</label>
                <div class="col-sm-10">
                    <select class="form-control" name="sexo">
                            <c:if test="${persona.sexo=='M'}" >
                                <option value="${persona.sexo}">Hombre</option>
                                <option value="F">Mujer</option>
                            </c:if>
                            <c:if test="${persona.sexo=='F'}" >
                                <option value="${persona.sexo}">Mujer</option>
                                <option value="M">Hombre</option>
                            </c:if>
                            <c:if test="${persona.id==null}" >
                                <option value="M">Hombre</option>
                                <option value="F">Mujer</option>
                            </c:if>
                            
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Tipo de Representación</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="tipoRepresentacion" placeholder="Texto" value="<c:out value="${persona.tipoRepresentacion}"/>" maxlength="200" size="80">
                </div>
            </div>

            <!-- Fin de los nuevos campos del Fer -->
            <div class="form-group">
                <label class="col-sm-2 control-label">Fecha de Ingreso</label>
                <div class="col-xs-5 date">
                    <div class="input-group input-append date" id="datePicker">
                        <input type="text" class="form-control" name="fechaIngreso" readonly="readonly"/>
                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">Aceptar</button>
                    <button type="button" class="btn btn-default" onclick="location.href = 'personAction?action=listarPersonas';">Cancelar</button>
                </div>
            </div>
        </form>
    </div>
    <script>
        $(document).ready(function () {
            $('#datePicker')
                    .datepicker({
                        format: 'dd/mm/yyyy'
                    })
                    .on('changeDate', function (e) {
                        // Revalidate the date field
                        $('#eventForm').formValidation('revalidateField', 'fechaIngreso');
                    });

            $('#eventForm').formValidation({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    name: {
                        validators: {
                            notEmpty: {
                                message: 'The name is required'
                            }
                        }
                    },
                    date: {
                        validators: {
                            notEmpty: {
                                message: 'The date is required'
                            },
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'The date is not a valid'
                            }
                        }
                    }
                }
            });
        });
    </script>
    <jsp:include page="/footer.jsp"/>
</body>
</html>