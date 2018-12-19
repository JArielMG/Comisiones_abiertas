<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>formularioSolcitudes</title>
        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script>
            var catalogs = [];
            var indexCatalog = 0;

            var datesFields = [];
            var indexDates = 0;

            var timesFields = [];
            var indexTimes = 0;

            var numberFields = [];
            var indexNumbers = 0;
        </script>
    </head>
    <body <c:if test="${(estatus=='F') or (estatus=='RG')}"> onload="calculaMontosViaticos();"</c:if>>
        <jsp:include page="../include.jsp"/>

    <link href="${pageContext.request.contextPath}/css/alertify.bootstrap.css" id="toggleCSS" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-datepicker3.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-timepicker.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/alertify.core.css" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-timepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/alertify.min.js"></script>

    <style type="text/css">
        /**
         * Override feedback icon position
         * See http://formvalidation.io/examples/adjusting-feedback-icon-position/
         */
        #eventForm .form-control-feedback {
            top: 0;
            right: -15px;
        }

        .alertify-log-custom {
            background: blue;
        }
    </style>

    <center><h3>${nombreFormulario}</h3></center>

    <c:if test="${datosGuardados==true}">
        <h4 style="color:green;">${mensajeGuardado}</h4>
    </c:if>

    <c:if test="${comisionEnviada==true}">
        <h4 style="color:green;">${mensajeEnviada}</h4>
    </c:if>

    <c:choose>
        <c:when test="${error==true}">
            <h4>${mensajeError}</h4>
        </c:when>
        <c:when test="${autorizada==true}">
            <h4 style="color:green;">${mensajeAutorizada}</h4>
        </c:when>
        <c:otherwise>
            <c:if test="${rechazada==true}">
                <h4 style="color:red;">${mensajeRechazada}</h4>
            </c:if>
            <h4 align="center">${nombreDepedencia}</h4>
            <c:if test="${((estatus=='F') or (estatus=='RG')) and (datosGuardados!=true) and (comisionEnviada!=true)}">
                <form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/formularioAction?action=listarGastos">
                    <input type="hidden" name="id_comision" value="${idComision}"/>
                    <input type="hidden" name="estatus" id="estatuss" value="${estatus}"/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-default">Agregar gastos de la comisión</button>
                        </div>
                    </div>
                </form>
            </c:if>
            <form method="post" class="form-horizontal" onsubmit="return validarFormulario()" <c:choose><c:when test="${datosGuardados==false}">action="${pageContext.request.contextPath}/formularioAction?action=salvarDatosComision"</c:when>
                      <c:otherwise>action="${pageContext.request.contextPath}/formularioAction?action=enviar"</c:otherwise></c:choose>>
                <input type="hidden" name="id_comision" value="${idComision}"/>
                <input type="hidden" name="estatus" value="${estatus}"/>
                <c:forEach items="${seccionesFormulario}" var="seccionFormulario">
                    <h4 align="center">${seccionFormulario.etiqueta}</h4>
                    <c:forEach items="${seccionFormulario.camposFormulario}" var="campoFormulario">
                        <c:if test="${campoFormulario.tipoControl=='TEXTO'}">
                            <div class="form-group">
                                <c:if test="${campoFormulario.subtipo=='SIMPLE'}">
                                    <label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
                                        <div class="col-sm-10">
                                        <c:choose>
                                            <c:when test="${campoFormulario.tipoDato=='NUMERO'}">
                                                <input type="text" <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> class="form-control" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" maxlength="200" size="100" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> value="${campoFormulario.valorCampo}" 
                                                       <c:choose>
                                                           <c:when test="${not empty campoFormulario.clase}">
                                                               <c:choose>
                                                                   <c:when test="${(estatus=='C') or (estatus=='R')}">
                                                                       id="${campoFormulario.clase}" onchange="/*tipoZonaFunction()*/"
                                                                   </c:when>
                                                                   <c:when test="${(campoFormulario.clase == 'reintegroViaticos' or campoFormulario.clase == 'reintegroPasajes')}">
                                                                       id="${campoFormulario.clase}" onchange="calculaReintegro()"
                                                                   </c:when>
                                                                   <c:when test="${((estatus=='F') or (estatus=='RG'))}"> 
                                                                       id="${campoFormulario.clase}"
                                                                   </c:when>
                                                                   <c:when test="${(estatus=='A') or (estatus=='RV')}"> 
                                                                       id="${campoFormulario.clase}" onchange="calculaPasajesTotales()"
                                                                   </c:when>
                                                               </c:choose>
                                                           </c:when>
                                                           <c:otherwise>
                                                               name="${campoFormulario.tabla}${campoFormulario.campo}${campoFormulario.tipoDato}"
                                                           </c:otherwise>
                                                       </c:choose>>

                                                <c:choose>
                                                    <c:when test="${not empty campoFormulario.clase}">
                                                        <script>
                                                            numberFields[indexNumbers] = ['${campoFormulario.clase}'];
                                                            indexNumbers++;
                                                        </script>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <script>
                                                            numberFields[indexNumbers] = ['${campoFormulario.tabla}${campoFormulario.campo}${campoFormulario.tipoDato}'];
                                                            indexNumbers++;
                                                        </script>
                                                    </c:otherwise>
                                                </c:choose>

                                            </c:when>
                                            <c:otherwise>
                                                <input type="text" <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> class="form-control" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" maxlength="200" size="100" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> value="${campoFormulario.valorCampo}" <c:if test="${not empty campoFormulario.clase}">id ="${campoFormulario.clase}"</c:if>>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:if test="${campoFormulario.listaHabilitada==true}">
                                        <script>
                                            var catalog = [];
                                            var indexElement = 0;
                                        </script>
                                        <c:forEach items="${campoFormulario.catalogo}" var="catalogo">
                                            <script>
                                                var catalogElement = ['${catalogo.codigo}', '${catalogo.descripcion}'];
                                                catalog[indexElement] = [catalogElement];
                                                indexElement++;
                                            </script>
                                        </c:forEach>
                                        <script>
                                            catalogs[indexCatalog] = ['${campoFormulario.clase}', catalog];
                                            indexCatalog++;
                                        </script>
                                    </c:if>
                                </c:if>
                                <c:if test="${campoFormulario.subtipo=='AREA'}">
                                    <label for="col-sm-2 control-label" class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control"  <c:if test="${campoFormulario.soloLectura==true}">readonly</c:if> name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> rows="6" cols="60" <c:if test="${not empty campoFormulario.clase}">id="${campoFormulario.clase}"</c:if>>${campoFormulario.valorCampo}</textarea>
                                        </div>
                                </c:if>
                            </div>
                        </c:if>
                        <c:if test="${campoFormulario.tipoControl=='LISTA'}">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
                                    <div class="col-sm-10">
                                        <select class="form-control"  <c:if test="${campoFormulario.soloLectura==true}">disabled</c:if> name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if> <c:choose><c:when test="${campoFormulario.campo == 'denominacion_partida_VP' or campoFormulario.campo=='cve_partida_VP' or campoFormulario.campo=='denominacion_ppasajes' or campoFormulario.campo=='cve_partida_pasaje'}" >id="${campoFormulario.campo}"</c:when><c:when test="${not empty campoFormulario.clase}">id="${campoFormulario.clase}"</c:when></c:choose><c:if test="${(estatus=='C') or (estatus=='R')}"> onchange="/*tipoZonaFunction()*/"</c:if>>
                                        <c:forEach items="${campoFormulario.catalogo}" var="catalogo">
                                            <c:choose>
                                                <c:when test="${campoFormulario.campo=='pais_destino'||campoFormulario.campo=='estado_destino'||campoFormulario.campo=='ciudad_destino'||campoFormulario.campo=='pais_origen'||campoFormulario.campo=='estado_origen'||campoFormulario.campo=='ciudad_origen' }">                                                   
                                                    <option value="${catalogo.descripcion}" <c:if test="${campoFormulario.valorCampo==catalogo.descripcion}">selected</c:if>>${catalogo.descripcion}</option>
                                                </c:when>
                                                <c:otherwise>                                                    
                                                    <option value="${catalogo.codigo}" <c:if test="${campoFormulario.valorCampo==catalogo.codigo}">selected</c:if>>${catalogo.descripcion}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                         <c:if test="${campoFormulario.campo=='nombre_area'}" >
                                            <option value="${nombreAreaUsr}" selected >${nombreAreaUsr}</option>
                                         </c:if>            
                                        <c:if test="${campoFormulario.campo=='id_area'}" >
                                            <option value="${idAreaUsr}" selected >${idAreaUsr}</option>
                                        </c:if>            
                                    </select>
                                    <c:if test="${campoFormulario.campo=='nombre_area'}" >
                                        <input type="hidden" id="areaInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}" />                                                                                      
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='id_area'}" >
                                        <input type="hidden" id="cveAreaInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}" /> 
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='cve_ua_presupuesto'}" >
                                        <input  type="hidden" id="uaCveInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>                                         
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='ua_presupuesto'}" >
                                        <input  type="hidden" id="uaInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='cve_programa_pre'}" >
                                        <input  type="hidden" id="ppCveInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='programa_presupuestal'}" >
                                        <input  type="hidden" id="ppInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='cve_proyecto_estrategico'}" >
                                        <input  type="hidden" id="peCveInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='proyecto_estrategico'}" >
                                        <input  type="hidden" id="peInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='cve_proyecto_actividades'}" >
                                        <input  type="hidden" id="acCveInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='proyecto_actividades'}" >
                                        <input  type="hidden" id="acInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='homologacion'}" >
                                        <input  type="hidden" id="homoInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                    <c:if test="${campoFormulario.campo=='nivel_homologacion'}" >
                                        <input  type="hidden" id="nivHomInput" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" value="${campoFormulario.valorCampo}"/>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${campoFormulario.tipoControl=='CALENDARIO'}">
                            <div class="form-group">
                                <c:if test="${campoFormulario.subtipo=='FECHA'}">
                                    <label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
                                        <div class="col-xs-5 date">
                                        <c:if test="${campoFormulario.soloLectura==false}">
                                            <div class="input-group input-append date" id="${campoFormulario.clase}">
                                            </c:if>
                                            <input id="${campoFormulario.clase}-Texto" type="text" class="form-control" onchange="validarFechas()" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if>  value="${campoFormulario.valorCampo}" maxlength="200" size="100">
                                            <c:if test="${campoFormulario.soloLectura==false}">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </c:if>
                                    </div>
                                    <script>
                                        datesFields[indexDates] = ['${campoFormulario.clase}'];
                                        indexDates++;
                                    </script>
                                </c:if>
                                <c:if test="${campoFormulario.subtipo=='HORA'}">
                                    <label class="col-sm-2 control-label">${campoFormulario.etiqueta} <c:if test="${campoFormulario.obligatorio==1}"><b>*</b></c:if></label>
                                        <div class="col-xs-5 date">
                                        <c:if test="${campoFormulario.soloLectura==false}">
                                            <div class="input-group bootstrap-timepicker timepicker" id="datetimepicker5">
                                            </c:if>
                                            <input <c:if test="${campoFormulario.soloLectura==false}">id="${campoFormulario.clase}"</c:if> type="text" class="form-control"  readonly="readonly" name="${campoFormulario.tabla}|${campoFormulario.campo}|${campoFormulario.tipoDato}" <c:if test="${campoFormulario.obligatorio==1}">required</c:if>  value="${campoFormulario.valorCampo}" maxlength="200" size="100" data-format="hh:mm:ss">
                                            <c:if test="${campoFormulario.soloLectura==false}">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                                            </div>
                                        </c:if>
                                    </div>
                                    <script>
                                        timesFields[indexTimes] = ['${campoFormulario.clase}'];
                                        indexTimes++;
                                    </script>
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
                <script>

                    var montoViaticosEfectivo = 0;
                    var montoViaticosTarjeta = 0;
                    var montoViaticosSinComprobar = 0;
                    var montoPasajeAereo = 0;
                    var montoPasajeTerrestre = 0;
                    var montoHospedaje = 0;
                </script>
                <c:forEach items="${gastosFuncionario}" var="gastoFuncionario">
                    <script>
                        var monto = Number('${gastoFuncionario.importe}');
                        var concepto = '${gastoFuncionario.concepto}';
                        var tipoPago = '${gastoFuncionario.tipoPago}';
                        var comprobante = '${gastoFuncionario.comprobante}';

                        var valorConcepto = concepto.split(',')[0];
                                                
                        if (valorConcepto === 'V') {
                            if (tipoPago === 'E') {
                                if (comprobante === 'SI') {
                                    montoViaticosEfectivo = montoViaticosEfectivo + monto;
                                } else {
                                    montoViaticosSinComprobar = montoViaticosSinComprobar + monto;
                                }
                            } else if (tipoPago === 'TC') {
                                montoViaticosTarjeta = montoViaticosTarjeta + monto;
                            }

                        } else if (valorConcepto === 'PA') {
                            montoPasajeAereo = montoPasajeAereo + monto;
                        } else if (valorConcepto === 'PT') {
                            montoPasajeTerrestre = montoPasajeTerrestre + monto;
                        } else if (valorConcepto === 'H') {
                            montoHospedaje = montoHospedaje + monto;
                        }
                    </script>
                </c:forEach>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <c:choose>
                            <c:when test="${datosGuardados==false}">
                                <button type="submit" class="btn btn-primary">Guardar datos</button>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${comisionEnviada==false}">
                                    <button type="submit" class="btn btn-primary">Enviar</button>
                                </c:if>
                                <button type="button" class="btn btn-default" onclick="location.href = 'formularioAction?action=listarComisiones'">Regresar</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </form>
        </c:otherwise>
    </c:choose>

    <input id="tarifas" type="hidden" value="<%= request.getAttribute("tarifas")%>"/>
    <input id="pernoctas" type="hidden" value="<%= request.getAttribute("pernoctas")%>"/>

    <jsp:include page="/footer.jsp"/>
</body>



<script type="text/javascript">
    
    $(document).keydown(function (e) {
        var nodeName = e.target.nodeName.toLowerCase();
        if (e.which === 8) {
            if (e.target.readOnly === true || nodeName === 'select') {
                e.preventDefault();
            }

        }
    });

    var formularioValido = true;
    
    $(document).ready(function () {
        
        var numeroAcompaniantes = document.getElementById("numeroAcompaniantes");
        var importeAcompaniantes = document.getElementById("importeAcompaniantes");
        var gastoGasolina = document.getElementById("gastoGasolina");
        var gastoPeaje = document.getElementById("gastoPeaje");
        var gastoAutobus = document.getElementById("gastoAutobus");
        
        var costoVuelo = document.getElementById("costoVuelo");
        var costoCambioVuelo = document.getElementById("costoCambioVuelo");
        
        if(numeroAcompaniantes) $("#numeroAcompaniantes").val("0");        
        if(importeAcompaniantes) $("#importeAcompaniantes").val("0");        
        if(gastoGasolina) $("#gastoGasolina").val("0");
        if(gastoPeaje) $("#gastoPeaje").val("0");
        if(gastoAutobus) $("#gastoAutobus").val("0");
        if(gastoAutobus) $("#costoVuelo").val("0");
        if(costoCambioVuelo) $("#costoCambioVuelo").val("0");
        
        
        $("#gastoGasolina").change(function () {
            calculaMontosViaticos();
        });
        
        $("#gastoPeaje").change(function () {
            calculaMontosViaticos();
        });
        
        $("#gastoAutobus").change(function () {
            calculaMontosViaticos();
        });
        
        $("#costoVuelo").change(function () {
            calculaMontosViaticos();
        });
        $("#costoCambioVuelo").change(function () {
            calculaMontosViaticos();
        });

        var valueTipoViaje = $('#tipoViaje').val();
        
        if(valueTipoViaje === 'Nacional'){
            $("#tipoCambioTarifa").val("1");
        }
        
        
        function montoAnticipado(){
            
            if($("#tipoPago").val() === "ANT"){
                $("input[name='|monto_anticipado_viaticos|TEXTO']").val($("input[name='|tarifa_viaticos|NUMERO']").val());
            }

            $("#tipoPago").change(function (){
                if($("#tipoPago").val() == "ANT"){
                    $("input[name='|monto_anticipado_viaticos|TEXTO']").val($("input[name='|tarifa_viaticos|NUMERO']").val());
                }
            });
        }
        montoAnticipado();
        
        
        $.fn.datepicker.dates['es'] = {
            days: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"],
            daysShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
            daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"],
            months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
            today: "Hoy"
        };
        for (var i = 0; i < datesFields.length; i++) {
            $('#' + datesFields[i])
                    .datepicker({
                        format: 'yyyy-mm-dd',
                        language: 'es',
                        autoclose: true,
                        startDate: new Date()
                    });

            $('#' + datesFields[i] + '-Texto').keydown(function (e) {
                if (e.keyCode != 8 || e.keyCode != 46)
                    e.preventDefault();
            });
        }
        if (datesFields.length > 0) {
            for (var i = 0; i < datesFields.length; i++) {
                $('#' + datesFields[i])
                        .datepicker({
                            format: 'yyyy-mm-dd',
                            language: 'es',
                            autoclose: true
                        }).keyup(function (e) {
                    if (e.keyCode == 8 || e.keyCode == 46) {
                        var idName = $(this).attr('id');
                        $('#' + idName).data('datepicker').setDate('');
                        document.getElementById(idName + '-Texto').value = null;
                    }
                });

                $('#' + datesFields[i] + '-Texto').keydown(function (e) {
                    if (e.keyCode != 8 || e.keyCode != 46)
                        e.preventDefault();
                });
            }
        }
        
        
        if (timesFields.length > 0) {
            for (var i = 0; i < timesFields.length; i++){
                $('#' + timesFields[i]).timepicker({minuteStep: 1,
                showSeconds: false,
                showMeridian: false});
            }
        }

        if (numberFields.length > 0) {
            for (var i = 0; i < numberFields.length; i++)
                $('#' + numberFields[i]).keydown(function (e) {
                    // Allow: backspace, delete, tab, escape, enter and .
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                            // Allow: Ctrl+A, Command+A
                                    (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                                    // Allow: home, end, left, right, down, up
                                            (e.keyCode >= 35 && e.keyCode <= 40)) {
                                // let it happen, don't do anything
                                return;
                            }
                            // Ensure that it is a number and stop the keypress
                            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                                e.preventDefault();
                            }
                        });
        }

        //$("#tipoRepresentacion").val("${tipoRepresentacionFun}");

    <c:if test="${(estatus=='C') or (estatus=='R')}">
        
        $("select[name='|ua_presupuesto|TEXTO']").val($("#uaCveInput").val());
        $('#ppCombo').empty();
        $('#ppCombo').append($('<option>').text($('#ppInput').val())).attr('value', $('#ppCveInput').val());
        $('#peCombo').empty();
        $('#peCombo').append($('<option>').text($('#peInput').val())).attr('value', $('#peCveInput').val());
        $("#nivelHomolagacion").val("N/A");
        
        if ('${idComision}' == 0) {
            $("#tipoViaje").val("");
            $('#paisCombo').empty();
            $("#paisCombo").val("");
            $('#estadoCombo').empty();
            $("#estadoCombo").val("");
            $('#ciudadCombo').empty();
            $("#ciudadCombo").val("");

            $("#uaCombo").val("");
            $("#uaCveCombo").val("");
            $("#uaCveInput").val("");
            $("select[name='|proyecto_actividades|TEXTO']").val("");
            $("select[name='|cve_proyecto_actividades|TEXTO']").val("");

            $("#ppCombo").attr('disabled', 'disabled');
            $("#ppCombo").val("");
            $("#ppCveCombo").val("");

            $("#peCombo").attr('disabled', 'disabled');
            $("#peCombo").val("");
            $("#peCveCombo").val("");
            $("select[name='|proyecto_actividades|TEXTO']").attr('disabled', 'disabled');
            $("select[name='|cve_proyecto_actividades|TEXTO']").attr('disabled', 'disabled');
        } else {
            /*tipoZonaFunction()
            if ($("#tipoViaje").val() == 'Nacional') {
                $('#tipoZona').children('option[value="3"]').hide();
                $('#tipoZona').children('option[value="1"]').show();
                $('#tipoZona').children('option[value="2"]').show();
                $('#tipoZona').val("4");
            } else {
                $('#tipoZona').children('option[value="3"]').show();
                $('#tipoZona').children('option[value="1"]').hide();
                $('#tipoZona').children('option[value="2"]').hide();
                $('#tipoZona').val("3");
            }*/
        }

        $("#tipoViaje").on('change', function () {
            numAcuerdo();
            buscarPaisDestino();
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarPaises",
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $('#paisCombo').empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        if ($("#tipoViaje").val() == 'Nacional') {
                            if (this['nombre'] == 'México')
                                $('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
                                
                        } else {
                            //buscarPaisDestino();
                            if (this['nombre'] == 'México') {
                                $('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
                                
                            }

                        }
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            }).done(function (msg) {
                $('#paisCombo').trigger('change');
                if ($("#tipoViaje").val() == 'Nacional') {
                    $('#monedaTarifa').val("MXN");
                    $('#monedaTarifa').children('option[value="BRL"]').hide();
                    $('#monedaTarifa').children('option[value="CAD"]').hide();
                    $('#monedaTarifa').children('option[value="COP"]').hide();
                    $('#monedaTarifa').children('option[value="CRC"]').hide();
                    $('#monedaTarifa').children('option[value="GPB"]').hide();
                    $('#monedaTarifa').children('option[value="GTQ"]').hide();
                    $('#monedaTarifa').children('option[value="MUR"]').hide();
                    $('#monedaTarifa').children('option[value="SVC"]').hide();
                    $('#monedaTarifa').children('option[value="MXN"]').show();
                    $('#monedaTarifa').children('option[value="USD"]').hide();
                    $('#monedaTarifa').children('option[value="EUR"]').hide();
                } else {
                    $('#monedaTarifa').val("USD");
                    $('#monedaTarifa').children('option[value="BRL"]').hide();
                    $('#monedaTarifa').children('option[value="CAD"]').hide();
                    $('#monedaTarifa').children('option[value="COP"]').hide();
                    $('#monedaTarifa').children('option[value="CRC"]').hide();
                    $('#monedaTarifa').children('option[value="GPB"]').hide();
                    $('#monedaTarifa').children('option[value="GTQ"]').hide();
                    $('#monedaTarifa').children('option[value="MUR"]').hide();
                    $('#monedaTarifa').children('option[value="SVC"]').hide();
                    $('#monedaTarifa').children('option[value="MXN"]').hide();
                    $('#monedaTarifa').children('option[value="USD"]').show();
                    $('#monedaTarifa').children('option[value="EUR"]').show();
                }
                ajustaTarifas();
            });

        });

    </c:if>

    <c:if test="${(estatus!='C') and (estatus!='R')}">
        
        $("select[name='|ua_presupuesto|TEXTO']").val($("#uaCveInput").val());
        $('#ppCombo').empty();
        $('#ppCombo').append($('<option>').text($('#ppInput').val())).attr('value', $('#ppCveInput').val());
        $('#peCombo').empty();
        $('#peCombo').append($('<option>').text($('#peInput').val())).attr('value', $('#peCveInput').val());
        $("select[name='areas|nombre_area|TEXTO']").empty();
        $("select[name='areas|nombre_area|TEXTO']").append($('<option>').text($('#areaInput').val())).attr('value', $('#cveAreaInput').val());
        $("select[name='areas|id_area|TEXTO']").empty();
        $("select[name='areas|id_area|TEXTO']").append($('<option>').text($('#cveAreaInput').val())).attr('value', $('#cveAreaInput').val());
        $('#numAcuerdo').val($('#numAcuerdo').val());
        $('#homologacion').val($('#homoInput').val());
        $('#nivelHomolagacion').val($('#nivHomInput').val());
        /*jQuery.ajax({
         url: "${pageContext.request.contextPath}/formularioAction?action=listarPaises",
         dataType: 'json',
         success: function(data, textStatus, request) {
         $('#paisCombo').empty();
         var jsonData = $.parseJSON(request.responseText);
         $.each(jsonData, function() {
         $('#paisCombo').append($('<option>').text(this['nombre']).attr('value', this['nombre']));
         });
         },
         error: function(xhr) {
         alert('error');
         }
         }).done(function( msg ) {
         $('#paisCombo').trigger('change');
         });*/
    </c:if>
    <c:if test="${(estatus=='A') or (estatus=='RV')}">
        $("#solicitudCambio").on('change', function () {
            
            var dateField = $("#fechaSolicitudCambioVuelta").data('datepicker');
            if ($("#solicitudCambio").val() == 1) {
                dateField.setDate('');
                $("#fechaSolicitudCambioVuelta").datepicker().show();
                $("#motivoCambio").attr("readOnly", false);
                $("#costoCambioVuelta").attr("readOnly", false);
            } else {
                dateField.setDate('');
                $("#fechaSolicitudCambioVuelta").datepicker().hide();
                $("#motivoCambio").attr("readOnly", true);
                $("#costoCambioVuelta").val(0);
                $("#costoCambioVuelta").attr("readOnly", true);
            }
        });
    </c:if>
        /*Los Cambios del Fer de los filtros de PE */
        $("#uaCombo").change(function () {
            $('#uaCveCombo').val("");
            $('#uaCveCombo').val($("#uaCombo").val());
            $('#uaCveInput').val($("#uaCombo").val());
            $("#ppCombo").attr('disabled', false);

            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarProgramaPresupuestal&ua=" + utf8_encode($("#uaCombo").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $('#ppCombo').empty();
                    var jsonData = $.parseJSON(request.responseText);
                    if( jsonData.toString() == ""){
                        $("#ppCombo").attr('disabled', 'disabled');
                        $("#ppCveCombo").val("");
                    }else{
                        $.each(jsonData, function () {
                            $('#ppCombo').append($('<option>').text(this['nombrePrograma']).attr('value', this['idPrograma']));
                        });
                        $('#ppCveCombo').val($("#ppCombo").val());
                    }
                        
                },
                error: function (xhr) {
                    alert('errorF');
                }
            }).done(function (msg) {
                jQuery.ajax({
                    url: "${pageContext.request.contextPath}/formularioAction?action=listarProyectoEspecial&ua=" + utf8_encode($("#uaCombo").val()) + "&pp=" + utf8_encode($("#ppCombo").val()),
                    dataType: 'json',
                    success: function (data, textStatus, request) {
                        $('#peCombo').empty();
                        var jsonData = $.parseJSON(request.responseText);
                        if( jsonData.toString() == ""){
                            $("#peCombo").attr('disabled', 'disabled');
                            $("#peCveCombo").val("");
                        }else{
                            $.each(jsonData, function () {
                                $('#peCombo').append($('<option>').text(this['nombreProyecto']).attr('value', this['idProyecto']));
                            });
                            $('#peCveCombo').val($("#peCombo").val());
                            $("#peCombo").attr('disabled', false);
                        }
                    },
                    error: function (xhr) {
                        alert('errorF0');
                    }
                }).done(function (msg) {
                    console.log("URL :::::::::::::: " + "${pageContext.request.contextPath}/formularioAction?action=listarActividades&ua=" + utf8_encode($("#uaCombo").val()) + "&pp=" + utf8_encode($("#ppCombo").val()) + "&pe=" + utf8_encode($("#peCombo").val()));
                    jQuery.ajax({
                        url: "${pageContext.request.contextPath}/formularioAction?action=listarActividades&ua=" + utf8_encode($("#uaCombo").val()) + "&pp=" + utf8_encode($("#ppCombo").val()) + "&pe=" + utf8_encode($("#peCombo").val()),
                        dataType: 'json',
                        success: function (data, textStatus, request) {
                            $("select[name='|proyecto_actividades|TEXTO']").empty();
                            var jsonData = $.parseJSON(request.responseText);
                            if( jsonData.toString() == ""){
                                $("select[name='|proyecto_actividades|TEXTO']").attr('disabled', 'disabled');
                                $("select[name='|cve_proyecto_actividades|TEXTO']").val("");
                            }else{
                                $.each(jsonData, function () {
                                    $("select[name='|proyecto_actividades|TEXTO']").append($('<option>').text(this['nombreActividad']).attr('value', this['idActividad']));
                                });
                                $("select[name='|cve_proyecto_actividades|TEXTO']").val($("select[name='|proyecto_actividades|TEXTO']").val());
                                $("select[name='|proyecto_actividades|TEXTO']").attr('disabled', false);
                            }
                        },
                        error: function (xhr) {
                            alert('errorZ1');
                        }
                    });
                });
            });

            ////////////
        });
        $("select[name='|proyecto_actividades|TEXTO']").change(function () {
            $("select[name='|cve_proyecto_actividades|TEXTO']").val($("select[name='|proyecto_actividades|TEXTO']").val());
        });

        $("#ppCombo").change(function () {
            $('#ppCveCombo').val($("#ppCombo").val());
            $("#peCombo").attr('disabled', false);

            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarProyectoEspecial&ua=" + utf8_encode($("#uaCombo").val()) + "&pp=" + utf8_encode($("#ppCombo").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $('#peCombo').empty();
                    var jsonData = $.parseJSON(request.responseText);
                    if( jsonData.toString() == ""){
                            $("#peCombo").attr('disabled', 'disabled');
                            $("#peCveCombo").val("");
                        }else{
                            $.each(jsonData, function () {
                                $('#peCombo').append($('<option>').text(this['nombreProyecto']).attr('value', this['idProyecto']));
                            });
                            $('#peCveCombo').val($("#peCombo").val());
                            $("#peCombo").attr('disabled', false);
                        }
                    },
                error: function (xhr) {
                    alert('errorF1');
                }
            });
        });
        $("#peCombo").change(function () {
            $('#peCveCombo').val($("#peCombo").val());
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarActividades&ua=" + utf8_encode($("#uaCombo").val()) + "&pp=" + utf8_encode($("#ppCombo").val()) + "&pe=" + utf8_encode($("#peCombo").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='|proyecto_actividades|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    if( jsonData.toString() == ""){
                        $("select[name='|proyecto_actividades|TEXTO']").attr('disabled', 'disabled');
                        $("select[name='|cve_proyecto_actividades|TEXTO']").val("");
                    }else{
                        $.each(jsonData, function () {
                            $("select[name='|proyecto_actividades|TEXTO']").append($('<option>').text(this['nombreActividad']).attr('value', this['idActividad']));
                        });
                        $("select[name='|cve_proyecto_actividades|TEXTO']").val($("select[name='|proyecto_actividades|TEXTO']").val());
                        $("select[name='|proyecto_actividades|TEXTO']").attr('disabled', false);
                    }
                },
                error: function (xhr) {
                    alert('errorZ2');
                }
            });
        });
        // AQUI TERMINA
        $("#paisCombo").on('change', function () {
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarEstados&pais=" + utf8_encode($("#paisCombo").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $('#estadoCombo').empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $('#estadoCombo').append($('<option>').text(this['nombreEstado']).attr('value', this['nombreEstado']));
                    });
                       if ($("#tipoViaje").val() == 'Nacional'){
                           $('#estadoCombo').val("Ciudad de México");
                       }
                    
                },
                error: function (xhr) {
                    alert('error');
                }
            }).done(function (msg) {
                jQuery.ajax({
                    url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("#paisCombo").val()) + "&estado=" + utf8_encode($("#estadoCombo").val()),
                    dataType: 'json',
                    success: function (data, textStatus, request) {
                        $('#ciudadCombo').empty();
                        var jsonData = $.parseJSON(request.responseText);
                        $.each(jsonData, function () {
                            $('#ciudadCombo').append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                        });
                    },
                    error: function (xhr) {
                        alert('error');
                    }
                });
            });
        });


        $("#estadoCombo").on('change', function () {
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("#paisCombo").val()) + "&estado=" + utf8_encode($("#estadoCombo").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $('#ciudadCombo').empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $('#ciudadCombo').append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            });
        });

        //FER
        $("select[name='paises|pais_destino|TEXTO']").change(function () {
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarEstados&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='estados|estado_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='estados|estado_destino|TEXTO']").append($('<option>').text(this['nombreEstado']).attr('value', this['nombreEstado']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            }).done(function (msg) {
                jQuery.ajax({
                    url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                    dataType: 'json',
                    success: function (data, textStatus, request) {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                        var jsonData = $.parseJSON(request.responseText);
                        $.each(jsonData, function () {
                            $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                        });
                    },
                    error: function (xhr) {
                        alert('error');
                    }
                });
            });
        });

        $("select[name='estados|estado_destino|TEXTO']").change(function () {
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            });
        });


        $("#homologacion").change(function () {
            tipoHomologacion();
            ajustaTarifas();
        });
        
        $("#monedaTarifa").change(function () {
            ajustaTarifas();
        });

    });

    //FER
    function tipoHomologacion() {


        if ($("#homologacion").val() == '1') {
            $("#nivelHomolagacion").removeAttr("disabled");
            $("#nivelHomolagacion").attr("required", true);
            $("#nivelHomolagacion").attr("readOnly", false);
            $("#nivelHomolagacion").val("1");
            $("#justHomologacion").attr("required", true);
            $("#justHomologacion").attr("readOnly", false);
            $("#justHomologacion").removeAttr("disabled");
        } else {
            $("#justHomologacion").attr("required", true);
            $("#justHomologacion").attr("readOnly", true);
            $("#nivelHomolagacion").attr('disabled', 'disabled');
            $("#justHomologacion").attr('disabled', 'disabled');
            $("#nivelHomolagacion").val("N/A");
            $("#nivelHomolagacion").val("N/A");
            $("#justHomologacion").val("");
        }
    }
    
    function ajustaTarifas(){
        
        var tarifas = $("#tarifas").val();
        var arrayT = tarifas.split(",");
        var pernoctas = $("#pernoctas").val();
        var arrayP = pernoctas.split(",");
        
        console.log("tipoRepresentacion  :: " + $("#tipoRepresentacion").val());
               
        if ($("#tipoViaje").val() === "Nacional"){
            console.log("tipo de viaje nacional" );
            if (($("#homologacion").val() == '1') && ($("#tipoRepresentacion").val() === "Técnico")) {
                console.log("Homologacion es si");
                $("#muestraTarifaCP").val(arrayT[3]);
                $("#muestraTarifaSP").val(arrayT[1]);
                console.log("muestra Tarifa Con Pernocta :: " + arrayT[3]);
                console.log("muestra Tarifa sin Pernocta :: " + arrayT[1]);
            }else{    
                if( $("input[name='|clave_puesto|TEXTO']").val() === "HB1" ||
                    $("input[name='|clave_puesto|TEXTO']").val() === "KB2" ||
                    $("input[name='|clave_puesto|TEXTO']").val() === "KB1" ||
                    $("input[name='|clave_puesto|TEXTO']").val() === "KA4" ||
                    $("input[name='|clave_puesto|TEXTO']").val() === "KA3" ){
                        console.log("clave puesto ::: " + $("input[name='|clave_puesto|TEXTO']").val());
                        $("#muestraTarifaCP").val(arrayT[3]);
                        $("#muestraTarifaSP").val(arrayT[1]);
                        console.log("muestra Tarifa Con Pernocta :: " + arrayT[3]);
                        console.log("muestra Tarifa sin Pernocta :: " + arrayT[1]);
                }else{
                    $("#muestraTarifaCP").val(arrayT[2]);
                    $("#muestraTarifaSP").val(arrayT[0].substring(1));
                    console.log("muestra Tarifa Con Pernocta :: " + arrayT[2]);
                    console.log("muestra Tarifa sin Pernocta :: " + arrayT[0].substring(1));
                }
            }
        }else{
            $("#muestraTarifaCP").val(arrayT[4]);
            $("#muestraTarifaSP").val(arrayT[5].substring(0, arrayT[5].length -1));
            console.log("tarifa sin pernocta ::: " + arrayT[5].substring(0,4));
            console.log("tarifa sin pernocta 2 ::: " + arrayT[5]);
            console.log("tarifa con pernocta ::: " + arrayT[4]);
        }
    }

    $("#calculaMontoSP").change(function () {
        $("#muestraMontoSP").val(($("#muestraTarifaSP").val()) * ($("#calculaMontoSP").val()));
        calculaTarifa();
    });

    $("#calculaMontoCP").change(function () {
        $("#muestraMontoCP").val(($("#muestraTarifaCP").val()) * ($("#calculaMontoCP").val()));
        calculaTarifa();
    });
    
    $("#denominacion_partida_VP").change(function(){
        var cvePartida = $("#denominacion_partida_VP").val();
        $("#cve_partida_VP").val(cvePartida);
    });
    
    $("#denominacion_ppasajes").change(function(){
        var cvePartida = $("#denominacion_ppasajes").val();
        $("#cve_partida_pasaje").val(cvePartida);
    });

    function calculaTarifa() {
        var x = $("#muestraMontoCP").val();
        var y = $("#muestraMontoSP").val();
        if (x == null || y == null) {
            return 0;
        } else {
            var z = parseInt(x) + parseInt(y);
            $("#calculaTarifa").val(z);
        }

    }
    //FER

    function tipoZonaFunction() {
        var elemSinPernocta = document.getElementById("muestraTarifaSP");
        var elemConPernocta = document.getElementById("muestraTarifaCP");
        var elemTipoRepresentacion = document.getElementById("tipoRepresentacion");
        var elemHomologacion = document.getElementById("homologacion");
        var elemTipoZona = document.getElementById("tipoZona");
        var elemTarifaCorrespondiente = document.getElementById("calculaTarifa");
        var elemNumAcuerdo = document.getElementById("numAcuerdo");
        var elemTipoViaje = document.getElementById("tipoViaje");
        var elem = document.getElementById("nivelHomolagacion");

        var stringSearchSP = '';
        var stringSearchCP = '';

        var tarifaSP = 0;
        var tarifaCP = 0;

        var valorSP = 0;
        var valorCP = 0;

        if (elemHomologacion.value == '1') {
            elem.value = "1";
            $("#justHomologacion").attr("required", true);
        } else {
            elem.value = "0";
            $("#justHomologacion").removeAttr('required');
        }

        if (elemTipoViaje.value == 'Nacional') {
            stringSearchSP = 'SP' + ',' + elemTipoRepresentacion.value + ',' + elemHomologacion.value + ',' + elemTipoZona.value;
            stringSearchCP = 'CP' + ',' + elemTipoRepresentacion.value + ',' + elemHomologacion.value + ',' + elemTipoZona.value;
            $("#numAcuerdo").removeAttr('required');
            $("#monedaTarifa").val(2);
            $("#monedaTarifa").attr("readOnly", true);
        } else if (elemTipoViaje.value == 'Internacional') {
            stringSearchSP = 'SP' + ',' + elemTipoViaje.value + ',' + elemTipoZona.value;
            stringSearchCP = 'CP' + ',' + elemTipoViaje.value + ',' + elemTipoZona.value;
            $("#numAcuerdo").attr("required", true);
            $("#monedaTarifa").attr("readOnly", false);
        }


        for (var i = 0; i < catalogs.length; i++) {
            var catalogo = catalogs[i];
            var nombreCatalogo = catalogo[0];
            var filaCatalogo = catalogo[1];
            for (var k = 0; k < filaCatalogo.length; k++) {
                var elementoCatalogo = filaCatalogo[k];
                var itemCatalogo = elementoCatalogo[0];
                if (itemCatalogo[0] == stringSearchSP) {
                    valorSP = itemCatalogo[1];
                } else if (itemCatalogo[0] == stringSearchCP) {
                    valorCP = itemCatalogo[1];
                }
            }
        }

        elemSinPernocta.value = valorSP;
        elemConPernocta.value = valorCP;

        //actualizaMonto();
    }
/*
    function actualizaMonto() {

        var elemTarifaSinPernocta = document.getElementById("muestraTarifaSP");
        var elemTarifaConPernocta = document.getElementById("muestraTarifaCP");

        var elemDiasSinPernocta = document.getElementById("calculaMontoSP");
        var elemDiasConPernocta = document.getElementById("calculaMontoCP");


        var elemMontoSinPernocta = document.getElementById("muestraMontoSP");
        var elemMontoConPernocta = document.getElementById("muestraMontoCP");

        var tarifaTotal = document.getElementById("calculaTarifa");


        elemMontoSinPernocta.value = elemTarifaSinPernocta.value * elemDiasSinPernocta.value;
        elemMontoConPernocta.value = elemTarifaConPernocta.value * elemDiasConPernocta.value;
        tarifaTotal.value = Number(elemMontoSinPernocta.value) + Number(elemMontoConPernocta.value);

    } */

    function calculaMontosViaticos() {

        var viaticosEfectivo = document.getElementById("viaticosEfectivo");
        var viaticosTarjeta = document.getElementById("viaticosTarjeta");
        var viaticosSinComprobar = document.getElementById("viaticosSinComprobar");
        var gastosViaticos = document.getElementById("gastosViaticos");
        var pasajeAereo = document.getElementById("pasajeAereo");
        var pasajeTerrestre = document.getElementById("pasajeTerrestre");
        var gastosPasaje = document.getElementById("gastosPasaje");
        var gastosHospedaje = document.getElementById("gastosHospedaje");
        var gastosComision = document.getElementById("gastosComision");
        
        montoPasajeTerrestre = parseFloat(parseFloat($("#gastoGasolina").val()) + parseFloat($("#gastoPeaje").val()) + parseFloat($("#gastoAutobus").val()));
        var totalPasajeAereo = parseFloat(montoPasajeAereo + parseFloat($("#costoVuelo").val()) +  parseFloat($("#costoCambioVuelo").val()));  
        
        var montoViaticos = Number(montoViaticosEfectivo + montoViaticosTarjeta + montoViaticosSinComprobar);
        var montoPasajes = Number(totalPasajeAereo + montoPasajeTerrestre);
        var montoComision = Number(montoViaticos + montoPasajes + montoHospedaje);

        if(!montoViaticos) montoViaticos = 0;
        
        viaticosEfectivo.value = montoViaticosEfectivo;
        viaticosTarjeta.value = montoViaticosTarjeta;
        viaticosSinComprobar.value = montoViaticosSinComprobar;

        gastosViaticos.value = parseFloat(montoViaticos).toFixed(2);
        pasajeAereo.value = totalPasajeAereo.toFixed(2);
        pasajeTerrestre.value = montoPasajeTerrestre.toFixed(2);
        gastosPasaje.value = parseFloat(montoPasajes).toFixed(2);
        
        if(gastosHospedaje) {
            gastosHospedaje.value = parseFloat(montoHospedaje).toFixed(2);
        }
        
        gastosComision.value = parseFloat(montoComision).toFixed(2);

    }

    function calculaPasajesTotales() {
        var costoPasajeIda = document.getElementById("costoPasajeIda");
        var costoPasajeIda = document.getElementById("costoPasajeIda");
        var costoPasajeVuelta = document.getElementById("costoPasajeVuelta");
        var cargosServicioIda = document.getElementById("cargosServicioIda");
        var cargosServicioVuelta = document.getElementById("cargosServicioVuelta");
        var costoCambioVuelta = document.getElementById("costoCambioVuelta");
        var gastoPasaje = document.getElementById("gastoPasaje");
        var tarifaViaticos = document.getElementById("tarifaViaticos");
        var tipoCambioTarifa = document.getElementById("tipoCambioTarifa");
        var tarifaMonedaNac = document.getElementById("tarifaMonedaNac");

        var montoViaticosPesos = Number(tarifaViaticos.value) * Number(tipoCambioTarifa.value);
        var montoPasajes = Number(costoPasajeIda.value) + Number(costoPasajeVuelta.value) + Number(cargosServicioIda.value) +
                Number(cargosServicioVuelta.value) + Number(costoCambioVuelta.value);

        tarifaMonedaNac.value = montoViaticosPesos;
        gastoPasaje.value = montoPasajes;
    }

    function calculaReintegro() {
        var reintegroViaticos = document.getElementById("reintegroViaticos");
        var reintegroPasajes = document.getElementById("reintegroPasajes");
        var reintegroInai = document.getElementById("reintegroInai");

        var montoReintegro = Number(reintegroViaticos.value) + Number(reintegroPasajes.value);

        reintegroInai.value = montoReintegro;
    }

    function validarFechas() {

        var fechaSalida;
        var fechaRegreso;
        var fechaHoraSalida;
        var fechaHoraRegreso;

        var tieneFechasComision = false;
        var tieneFechasViaticos = false;

        if (datesFields.length > 0) {
            for (var i = 0; i < datesFields.length; i++)
                if (datesFields[i] == 'fechaSalidaComision') {
                    fechaSalida = document.getElementById("fechaSalidaComision-Texto");
                    tieneFechasComision = true;
                } else if (datesFields[i] == 'fechaRegresoComision') {
                    fechaRegreso = document.getElementById("fechaRegresoComision-Texto");
                    tieneFechasComision = true;
                } else if (datesFields[i] == 'fechaHoraSalida') {
                    fechaHoraSalida = document.getElementById("fechaHoraSalida-Texto");
                    tieneFechasViaticos = true;
                } else if (datesFields[i] == 'fechaHoraRegreso') {
                    fechaHoraRegreso = document.getElementById("fechaHoraRegreso-Texto");
                    tieneFechasViaticos = true;
                }
        }

        var totalDiasComision = 0;
        var totalDiasViaje = 0;

        if (tieneFechasComision) {

            if (fechaSalida.value != '' && fechaRegreso.value != '') {

                var fechaSalidaMenor = new Date(fechaSalida.value).getTime() <= new Date(fechaRegreso.value).getTime();
                totalDiasComision = (Math.floor(new Date(fechaRegreso.value).getTime() - new Date(fechaSalida.value).getTime()) / (1000 * 60 * 60 * 24)) + 1;

                if (!fechaSalidaMenor) {
                    fechaRegreso.style.borderColor = "red";
                    alertify.alert('<font color="red"><b>ERROR: La fecha de salida debe ser menor a la fecha de regreso.</b></font>');
                    formularioValido = false;
                } else {
                    fechaRegreso.style.borderColor = "green";
                    formularioValido = true;
                }

                if (totalDiasComision > 15) {
                    fechaSalida.style.borderColor = "red";
                    fechaRegreso.style.borderColor = "red";
                    alertify.alert('<font color="red"><b>ERROR: El número de días de la comisión no puede ser mayor a 15, favor de revisar las fechas de salida y regreso.</b></font>');
                    formularioValido = false;
                } else {
                    fechaSalida.style.borderColor = "green";
                    fechaRegreso.style.borderColor = "green";
                    formularioValido = true;
                }
            }
        }

        if (tieneFechasViaticos) {
            if (fechaHoraSalida.value != '' && fechaHoraRegreso.value != '') {
                var fechaHoraSalidaMenor = new Date(fechaHoraSalida.value).getTime() <= new Date(fechaHoraRegreso.value).getTime();
                totalDiasViaje = (Math.floor(new Date(fechaHoraRegreso.value).getTime() - new Date(fechaHoraSalida.value).getTime()) / (1000 * 60 * 60 * 24)) + 1;

                if (!fechaHoraSalidaMenor) {
                    fechaHoraRegreso.style.borderColor = "red";
                    alertify.alert('<font color="red"><b>ERROR: La fecha de salida del viaje debe ser menor a la fecha de regreso.</b></font>');
                    formularioValido = false;
                } else {
                    fechaHoraRegreso.style.borderColor = "green";
                    formularioValido = true;
                }

                if (totalDiasViaje > 15) {
                    fechaHoraSalida.style.borderColor = "red";
                    fechaHoraRegreso.style.borderColor = "red";
                    alertify.alert('<font color="red"><b>ERROR: El número de días del viaje de la comisión no puede ser mayor a 15, favor de revisar las fechas de salida y regreso.</b></font>');
                    formularioValido = false;
                } else {
                    fechaHoraSalida.style.borderColor = "green";
                    fechaHoraRegreso.style.borderColor = "green";
                    formularioValido = true;
                }

                var comparaFechasSalida = new Date(fechaSalida.value).getTime() - new Date(fechaHoraSalida.value).getTime();
                var comparaFechasRegreso = new Date(fechaRegreso.value).getTime() - new Date(fechaHoraRegreso.value).getTime();

                if (comparaFechasSalida != 0) {
                    fechaHoraSalida.style.borderColor = "red";
                    alertify.alert('<font color="red"><b>ERROR: La fecha de salida del viaje debe ser igual a la fecha de salida de la comisión.</b></font>');
                    formularioValido = false;
                } else {
                    fechaHoraSalida.style.borderColor = "green";
                    formularioValido = true;
                }

                /*if (comparaFechasRegreso!=0){
                 fechaHoraRegreso.style.borderColor = "red";
                 alertify.alert('<font color="red"><b>ERROR: La fecha de regreso del viaje debe ser igual a la fecha de regreso de la comisión.</b></font>');
                 formularioValido = false;
                 }else{*/
                fechaHoraRegreso.style.borderColor = "green";
                formularioValido = true;
                //}
            }

        }

    }

    function validarFormulario() {
        if (formularioValido)
            return true;
        else {
            alertify.alert('<font color="red"><b>ERROR: Revise que la información del formulario sea válida...</b></font>');
            return false;
        }
    }

    function numAcuerdo() {
        if ($("#tipoViaje").val() == 'Nacional') {
            $("#numAcuerdo").attr("readOnly", true);
            $("#numAcuerdo").val("N/A");
        } else {
            $("#numAcuerdo").attr("readOnly", false);
            $("#numAcuerdo").val("");
        }
    }

    function buscarPaisDestino() {
        if ($("#tipoViaje").val() == 'Nacional') {
            document.getElementsByName("paises|pais_destino|TEXTO")[0].value = "México";

            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Albania"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Australia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Belice"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Cuba"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Georgia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="India"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Malasia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Mozambique"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Nicaragua"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Noruega"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Puerto Rico"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Rumanía"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Alemania"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Argentina"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Bélgica"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Bolivia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Brasil"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Canadá"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Chile"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="China"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Colombia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Corea del Sur"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Costa Rica"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Ecuador"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="El Salvador"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Emiratos Árabes Unidos"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="España"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Estados Unidos de América"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Francia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Guatemala"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Honduras"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Islandia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Italia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Marruecos"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Mauricio"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="México"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Países Bajos"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Panamá"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Paraguay"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Perú"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Portugal"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Reino Unido"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="República Dominicana"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Rusia"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Singapur"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Uruguay"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Venezuela"]').hide();

            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarEstados&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='estados|estado_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='estados|estado_destino|TEXTO']").append($('<option>').text(this['nombreEstado']).attr('value', this['nombreEstado']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            }).done(function (msg) {
                jQuery.ajax({
                    url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                    dataType: 'json',
                    success: function (data, textStatus, request) {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                        var jsonData = $.parseJSON(request.responseText);
                        $.each(jsonData, function () {
                            $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                        });
                    },
                    error: function (xhr) {
                        alert('error');
                    }
                });
            });


            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            });



        } else {
            document.getElementsByName("paises|pais_destino|TEXTO")[0].value = "Alemania";
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Alemania"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Argentina"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Bélgica"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Bolivia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Brasil"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Canadá"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Chile"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="China"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Colombia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Corea del Sur"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Costa Rica"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Ecuador"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="El Salvador"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Emiratos Árabes Unidos"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="España"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Estados Unidos de América"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Francia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Guatemala"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Honduras"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Islandia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Italia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Marruecos"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Mauricio"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="México"]').hide();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Países Bajos"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Panamá"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Paraguay"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Perú"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Portugal"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Reino Unido"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="República Dominicana"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Rusia"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Singapur"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Uruguay"]').show();
            $("select[name='paises|pais_destino|TEXTO']").children('option[value="Venezuela"]').show();
            $("select[name='paises|pais_destino|TEXTO']").attr('disabled', false);
            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarEstados&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='estados|estado_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='estados|estado_destino|TEXTO']").append($('<option>').text(this['nombreEstado']).attr('value', this['nombreEstado']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            }).done(function (msg) {
                jQuery.ajax({
                    url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                    dataType: 'json',
                    success: function (data, textStatus, request) {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                        var jsonData = $.parseJSON(request.responseText);
                        $.each(jsonData, function () {
                            $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                        });
                    },
                    error: function (xhr) {
                        alert('error');
                    }
                });
            });


            jQuery.ajax({
                url: "${pageContext.request.contextPath}/formularioAction?action=listarCiudades&pais=" + utf8_encode($("select[name='paises|pais_destino|TEXTO']").val()) + "&estado=" + utf8_encode($("select[name='estados|estado_destino|TEXTO']").val()),
                dataType: 'json',
                success: function (data, textStatus, request) {
                    $("select[name='ciudades|ciudad_destino|TEXTO']").empty();
                    var jsonData = $.parseJSON(request.responseText);
                    $.each(jsonData, function () {
                        $("select[name='ciudades|ciudad_destino|TEXTO']").append($('<option>').text(this['nombreCiudad']).attr('value', this['nombreCiudad']));
                    });
                },
                error: function (xhr) {
                    alert('error');
                }
            });
        }
    }


    function utf8_encode(s) {
        return unescape(encodeURIComponent(s));
    }

    function decode_utf8(s) {
        return decodeURIComponent(escape(s));
    }
</script>
</html>
