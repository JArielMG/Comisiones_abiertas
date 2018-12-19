package mx.org.inai.viajesclaros.admin.view;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
//import java.sql.Connection;
import java.sql.SQLException;
//import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.hibernate.Session;
//import org.hibernate.engine.jdbc.spi.JdbcConnectionAccess;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.service.jdbc.connections.spi.ConnectionProvider;

//import org.apache.shiro.SecurityUtils;
import mx.org.inai.viajesclaros.admin.model.BonitaErrorVO;
//import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.model.CamposFormulario;
import mx.org.inai.viajesclaros.admin.model.CatalogoElement;
import mx.org.inai.viajesclaros.admin.model.CiudadVO;
import mx.org.inai.viajesclaros.admin.model.Comisiones;
import mx.org.inai.viajesclaros.admin.model.ComisionesUsuario;
import mx.org.inai.viajesclaros.admin.model.DatosFuncionariosVO;
import mx.org.inai.viajesclaros.admin.model.EstadoVO;
import mx.org.inai.viajesclaros.admin.model.FlujosComisionesVO;
//import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.model.GastosComision;
import mx.org.inai.viajesclaros.admin.model.ListaGastosComision;
import mx.org.inai.viajesclaros.admin.model.PaisVO;
import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.model.RegistrosGastosComisionVO;
import mx.org.inai.viajesclaros.admin.model.ReporteFlujoComisionVO;
//import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesFormulario;
import mx.org.inai.viajesclaros.admin.model.SesionVO;
import mx.org.inai.viajesclaros.admin.model.TrActividadPresupuestalVO;
import mx.org.inai.viajesclaros.admin.model.TrProgramaEspecialVO;
import mx.org.inai.viajesclaros.admin.model.TrProgramaPresupuestalVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.service.BonitaServices;
import mx.org.inai.viajesclaros.admin.service.CiudadServices;
import mx.org.inai.viajesclaros.admin.service.EstadoServices;
//import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
//import mx.org.inai.viajesclaros.admin.service.DependenciaServices;
import mx.org.inai.viajesclaros.admin.service.FormulariosServices;
import mx.org.inai.viajesclaros.admin.service.PaisServices;
import mx.org.inai.viajesclaros.admin.service.PersonaServices;
import mx.org.inai.viajesclaros.admin.service.ProcesoServices;
import mx.org.inai.viajesclaros.admin.service.TrActividadPresupuestalService;
import mx.org.inai.viajesclaros.admin.service.TrProgramaEspecialService;
import mx.org.inai.viajesclaros.admin.service.TrProgramaPresupuestalServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;
import mx.org.inai.viajesclaros.admin.util.EstatusComisiones;
//import mx.org.inai.viajesclaros.admin.util.TipoControl;
import mx.org.inai.viajesclaros.admin.util.TipoDato;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

@WebServlet(name = "FormularioAction", urlPatterns = {"/formularioAction"})
@MultipartConfig
public class FormularioAction extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PaisServices paisSrv = new PaisServices();

    private EstadoServices edoSrv = new EstadoServices();

    private CiudadServices ciudadSrv = new CiudadServices();

    private FormulariosServices formSrv = new FormulariosServices();

    private PersonaServices personServ = new PersonaServices();

    private TrProgramaPresupuestalServices ppServ = new TrProgramaPresupuestalServices();

    private TrProgramaEspecialService peServ = new TrProgramaEspecialService();

    private TrActividadPresupuestalService acServ = new TrActividadPresupuestalService();

//	private DependenciaServices depenServ = new DependenciaServices();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FormularioAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String destino = "login.jsp";
        String action = request.getParameter("action");

        SimpleDateFormat formatterDate = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatterDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        SimpleDateFormat formatterTime = new SimpleDateFormat("HH:mm");

        if (action == null) {
            action = "captura";
        }

        if (action.equals("listarComisiones")) {
            SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
            String username = sesion.getUsuario();//currentUser.getPrincipal().toString();

            //Se obtienen los datos del funcionario
            ArrayList<DatosFuncionariosVO> datosFuncionario = formSrv.obtenerDatosFuncionario(username);

            //Se valida que exista el funcionario
            if (datosFuncionario != null && !datosFuncionario.isEmpty()) {
                DatosFuncionariosVO funcionario = datosFuncionario.get(0);

                List<String> encabezados = new ArrayList<String>();
                encabezados.add(0, "Id comisión");
                encabezados.add(1, "Estatus");
                encabezados.add(2, "Fecha salida");
                encabezados.add(3, "Fecha regreso");
                encabezados.add(4, "País destino");
                encabezados.add(5, "Ciudad destino");

                List<ComisionesUsuario> comisionesUsuario = formSrv.obtenerComisionesUsuario(funcionario.getIdPersona());

                request.setAttribute("encabezados", encabezados);
                request.setAttribute("valoresTabla", comisionesUsuario);
                //Se valida que exista una comisión en curso
            }
        } else if (action.equals("verDetalleComision")) {
            //org.apache.shiro.subject.Subject currentUser = SecurityUtils.getSubject();
            SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
            String username = sesion.getUsuario();//currentUser.getPrincipal().toString();

            //Se obtiene las tarifas
            List<String> tarifas = formSrv.obtenerTarifas();
            List<String> pernocta = formSrv.obtenerPernocta();

            //Se obtienen los datos del funcionario
            ArrayList<DatosFuncionariosVO> datosFuncionario = formSrv.obtenerDatosFuncionario(username);

            //Se valida que exista el funcionario
            if (datosFuncionario != null && !datosFuncionario.isEmpty()) {
                DatosFuncionariosVO funcionario = datosFuncionario.get(0);

                //Se busca la comision seleccionada
                String idComision = request.getParameter("id_comision");

                ArrayList<Comisiones> comisionFuncionario = formSrv.obtenerComisionFuncionario(Integer.valueOf(idComision));

                //Se valida que exista la comisión
                if (comisionFuncionario != null && !comisionFuncionario.isEmpty()) {

                    Comisiones comisionEnCurso = comisionFuncionario.get(0);
                    String estatusTexto = regresaEstatusComisionEmpleado(comisionEnCurso.getEstatus());

                    List<SeccionesFormulario> seccionesFormulario = new ArrayList<SeccionesFormulario>();

                    if (comisionEnCurso.getEstatus().equals("C") || comisionEnCurso.getEstatus().equals("EA") || comisionEnCurso.getEstatus().equals("R")) {
                        seccionesFormulario = formSrv.getCamposFormulario(1, funcionario.getIdTipoPersona(), funcionario.getTipoRepresentacion());
                    } else if (comisionEnCurso.getEstatus().equals("A") || comisionEnCurso.getEstatus().equals("EV") || comisionEnCurso.getEstatus().equals("RV")) {
                        seccionesFormulario = formSrv.getCamposFormulario(2, funcionario.getIdTipoPersona(), funcionario.getTipoRepresentacion());// AQUI Flujo 2 
                    } else if (comisionEnCurso.getEstatus().equals("F") || comisionEnCurso.getEstatus().equals("EG") || comisionEnCurso.getEstatus().equals("RG")) {
                        seccionesFormulario = formSrv.getCamposFormulario(3, funcionario.getIdTipoPersona(), funcionario.getTipoRepresentacion());
                    } else if (comisionEnCurso.getEstatus().equals("CM") || comisionEnCurso.getEstatus().equals("EP") || comisionEnCurso.getEstatus().equals("RP")) {
                        seccionesFormulario = formSrv.getCamposFormulario(4, funcionario.getIdTipoPersona(), funcionario.getTipoRepresentacion());
                    }

                    for (SeccionesFormulario seccionFormulario : seccionesFormulario) {
                        for (CamposFormulario campoFormulario : seccionFormulario.getCamposFormulario()) {
                            if (campoFormulario.getTipoDato().equals(TipoDato.NUMERO)) {
                                campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), campoFormulario.getCampo(), (short) 1));
                            } else if (campoFormulario.getTipoDato().equals(TipoDato.TEXTO)) {
                                switch(campoFormulario.getCampo()){ 
                                    case "nombre_area":                                        
                                        request.setAttribute("nombreAreaUsr", campoFormulario.getValorCampo());
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "nombre_area", (short) 2));
                                    break;
                                    case "id_area":
                                        request.setAttribute("idAreaUsr", campoFormulario.getValorCampo());
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "id_area", (short) 2));
                                    break;
                                    case "ua_presupuesto":
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "ua_presupuesto", (short) 2));
                                        System.out.println("#################### R- R Comision: " +  comisionEnCurso.getIdComision() + " #### valor: - " + formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "ua_presupuesto", (short) 2));
                                    break;
                                    case "programa_presupuestal":
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "programa_presupuestal", (short) 2));
                                        System.out.println("#################### R- R Comision: " +  comisionEnCurso.getIdComision() + " #### valor: - " + formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "programa_presupuestal", (short) 2));
                                    break;
                                    case "proyecto_estrategico":
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "proyecto_estrategico", (short) 2));
                                        System.out.println("#################### R- R Comision: " +  comisionEnCurso.getIdComision() + " #### valor: - " + formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "proyecto_estrategico", (short) 2));
                                    break;
                                    case "proyecto_actividades":
                                        String act = "";
                                        act = 
                                            formSrv.obtenerTrNombreAc(
                                            formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "cve_proyecto_actividades", (short) 2),
                                            formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "cve_ua_presupuesto", (short) 2),
                                            formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "cve_programa_pre", (short) 2),
                                            formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), "cve_proyecto_estrategico", (short) 2)).get(0);
                                        if(act.equals("") || act == null){
                                            act = " ";
                                        }
                                        campoFormulario.setValorCampo(act);
                                    break;
                                    default:
                                        campoFormulario.setValorCampo(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), campoFormulario.getCampo(), (short) 2));
                                    break;
                                }
                            } else if (campoFormulario.getTipoDato().equals(TipoDato.FECHA)) {
                                try {
                                    if (campoFormulario.getSubtipo().equals("HORA")) {
                                        campoFormulario.setValorCampo(formatterTime.format(formatterDateTime.parse(formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), campoFormulario.getCampo(), (short) 3))));
                                    } else {
                                        String fechaString = formSrv.obtenerDetalleComision(comisionEnCurso.getIdComision(), campoFormulario.getTabla(), campoFormulario.getCampo(), (short) 3);
                                        if (fechaString != null && !fechaString.equals("")) {
                                            campoFormulario.setValorCampo(formatterDate.format(formatterDate.parse(fechaString)));
                                        } else {
                                            campoFormulario.setValorCampo("");
                                        }
                                    }
                                } catch (ParseException e) {
                                    // TODO Auto-generated catch block
                                    e.printStackTrace();
                                }
                            }

                        }
                    }

                    if (comisionEnCurso.getEstatus().equals("C") || comisionEnCurso.getEstatus().equals("EA") || comisionEnCurso.getEstatus().equals("R")) {
                        // Se setean los atributos para el formulario cuando el estatus es "C"
                        if (comisionEnCurso.getEstatus().equals("C")) {
                            request.setAttribute("error", false);
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("nombreFormulario", "Solicitud de comisión");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("nombreArea", funcionario.getNombreArea());
                            request.setAttribute("idArea", funcionario.getIdArea());
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "C");

                            // Se setean los atributos para el formulario cuando el estatus es "R"
                        } else if (comisionEnCurso.getEstatus().equals("R")) {
                            request.setAttribute("nombreFormulario", "Solicitud de comisión");
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("error", false);
                            request.setAttribute("rechazada", true);
                            request.setAttribute("mensajeRechazada", estatusTexto + ". Favor de corregir su solicitud a fin de que sea aprobada.");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "R");

                            // Se setean los atributos para el formulario cuando el estatus es "A"
                            /*}else if(comisionEnCurso.getEstatus().equals("A")){
							request.setAttribute("nombreFormulario", "Solicitud de comisión");
							request.setAttribute("error", false);
							request.setAttribute("autorizada", true);
							request.setAttribute("mensajeAutorizada", estatusTexto+". Favor de llenar el formulario de solicitud de viáticos y pasajes.");
					
                             */
                            // Se setean los atributos para el formulario cuando el estatus es "EA"
                        } else if (comisionEnCurso.getEstatus().equals("EA")) {
                            request.setAttribute("nombreFormulario", "Solicitud de comisión");
                            request.setAttribute("error", true);
                            request.setAttribute("mensajeError", "Su comisión se encuentra con el estatus: \"" + estatusTexto + ". Debe esperar a la aprobación de la misma a fin de continuar con la solicitud de viáticos y pasajes.");
                        }

                        // Se setean los atributos para el formulario cuando el estatus es otro distinto a los anteriores
                        /*else{
							request.setAttribute("nombreFormulario", "Solicitud de comisión");
							request.setAttribute("error", true);
							request.setAttribute("mensajeError", "Su comisi�n esta en curso con el estatus: \""+estatusTexto+"\". \nSeleccione el men� correspondiente para continuar con el proceso de la misma o puede imprimir su solicitud en el men� \"Reportes comisiones\".");
						}*/
                    } else if (comisionEnCurso.getEstatus().equals("A") || comisionEnCurso.getEstatus().equals("EV") || comisionEnCurso.getEstatus().equals("RV")) {
                        // Se setean los atributos para el formulario cuando el estatus es "C"
                        if (comisionEnCurso.getEstatus().equals("A")) { //RR
                            request.setAttribute("error", false);
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("nombreFormulario", "Solicitud de viáticos y pasajes");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "A");

                            // Se setean los atributos para el formulario cuando el estatus es "R"
                        } else if (comisionEnCurso.getEstatus().equals("RV")) {
                            request.setAttribute("nombreFormulario", "Solicitud de viáticos y pasajes");
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("error", false);
                            request.setAttribute("rechazada", true);
                            request.setAttribute("mensajeRechazada", estatusTexto + ". Favor de corregir su solicitud a fin de que sea aprobada.");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "RV");

                            // Se setean los atributos para el formulario cuando el estatus es "A"
                            /*}else if(comisionEnCurso.getEstatus().equals("F")){
							request.setAttribute("nombreFormulario", "Solicitud de vi�ticos y pasajes");
							request.setAttribute("error", false);
							request.setAttribute("autorizada", true);
							request.setAttribute("mensajeAutorizada", estatusTexto+". Favor de llenar el informe de comisi�n y el desglose de gastos al regreso de su comisi�n conforme a los Lineamientos internos que regulan la asignaci�n de comisiones, vi�ticos y pasajes nacionales e internacionales para el Instituto Nacional de Transparencia, Acceso a la Informaci�n y Protecci�n de Datos Personales.");
					
                             */
                            // Se setean los atributos para el formulario cuando el estatus es "EA"
                        } else if (comisionEnCurso.getEstatus().equals("EV")) {
                            request.setAttribute("nombreFormulario", "Solicitud de viáticos y pasajes");
                            request.setAttribute("error", true);
                            request.setAttribute("mensajeError", "Su comisión se encuentra con el estatus: \"" + estatusTexto + ". Debe esperar a la aprobación de la misma a fin de continuar con la solicitud de viáticos y pasajes.");
                        }

                        // Se setean los atributos para el formulario cuando el estatus es otro distinto a los anteriores
                        /*else{
							request.setAttribute("nombreFormulario", "Solicitud de vi�ticos y pasajes");
							request.setAttribute("error", true);
							request.setAttribute("mensajeError", "Su comisi�n esta en curso con el estatus: \""+estatusTexto+"\". \nSeleccione el men� correspondiente para continuar con el proceso de la misma o puede imprimir su solicitud en el men� \"Reportes comisiones\".");
						}*/
                    } else if (comisionEnCurso.getEstatus().equals("F") || comisionEnCurso.getEstatus().equals("EG") || comisionEnCurso.getEstatus().equals("RG")) {
                        // Se setean los atributos para el formulario cuando el estatus es "C"
                        if (comisionEnCurso.getEstatus().equals("F")) {
                            request.setAttribute("error", false);
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("nombreFormulario", "Desglose de gastos");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "F");

                            // Se setean los atributos para el formulario cuando el estatus es "R"
                        } else if (comisionEnCurso.getEstatus().equals("RG")) {
                            request.setAttribute("nombreFormulario", "Desglose de gastos");
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("error", false);
                            request.setAttribute("rechazada", true);
                            request.setAttribute("mensajeRechazada", estatusTexto + ". Favor de corregir su solicitud a fin de que sea aprobada.");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "RG");

                            // Se setean los atributos para el formulario cuando el estatus es "A"
                            /*}else if(comisionEnCurso.getEstatus().equals("CM")){
							request.setAttribute("nombreFormulario", "Desglose de gastos");
							request.setAttribute("error", false);
							request.setAttribute("autorizada", true);
							request.setAttribute("mensajeAutorizada", estatusTexto+". Favor de llenar el formulario de publicaci�n de la comisi�n.");
                             */
                            // Se setean los atributos para el formulario cuando el estatus es "EA"
                        } else if (comisionEnCurso.getEstatus().equals("EG")) {
                            request.setAttribute("nombreFormulario", "Desglose de gastos");
                            request.setAttribute("error", true);
                            request.setAttribute("mensajeError", "Su comisión se encuentra con el estatus: \"" + estatusTexto + ". Debe esperar a la aprobación de la misma a fin de continuar con el desglose de gastos.");
                        }

                        // Se setean los atributos para el formulario cuando el estatus es otro distinto a los anteriores
                        /*else{
							request.setAttribute("nombreFormulario", "Desglose de gastos");
							request.setAttribute("error", true);
							request.setAttribute("mensajeError", "Su comisi�n esta en curso con el estatus: \""+estatusTexto+"\". \nSeleccione el men� correspondiente para continuar con el proceso de la misma o puede imprimir su solicitud en el men� \"Reportes comisiones\".");
						}*/
                        List<RegistrosGastosComisionVO> gastosFuncionario = formSrv.obtenerRegistrosGastosIdComision(comisionEnCurso.getIdComision());

                        if (gastosFuncionario != null && gastosFuncionario.size() > 0) {
                            request.setAttribute("gastosFuncionario", gastosFuncionario);
                        } else {
                            request.setAttribute("gastosFuncionario", "");
                        }
                    } else if (comisionEnCurso.getEstatus().equals("CM") || comisionEnCurso.getEstatus().equals("EP") || comisionEnCurso.getEstatus().equals("RP") || comisionEnCurso.getEstatus().equals("P")) {
                        // Se setean los atributos para el formulario cuando el estatus es "CM"
                        if (comisionEnCurso.getEstatus().equals("CM")) {
                            request.setAttribute("error", false);
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("nombreFormulario", "Informe de comisión");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "CM");

                            // Se setean los atributos para el formulario cuando el estatus es "R"
                        } else if (comisionEnCurso.getEstatus().equals("RP")) {
                            request.setAttribute("nombreFormulario", "Informe de comisión");
                            request.setAttribute("idComision", comisionEnCurso.getIdComision());
                            request.setAttribute("error", false);
                            request.setAttribute("rechazada", true);
                            request.setAttribute("mensajeRechazada", estatusTexto + ". Favor de corregir su informe a fin de que sea aprobado.");
                            request.setAttribute("seccionesFormulario", seccionesFormulario);
                            request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                            request.setAttribute("estatus", "RP");

                            // Se setean los atributos para el formulario cuando el estatus es "A"
                        } else if (comisionEnCurso.getEstatus().equals("P")) {
                            request.setAttribute("nombreFormulario", "Informe de comisión");
                            request.setAttribute("error", false);
                            request.setAttribute("autorizada", true);
                            request.setAttribute("mensajeAutorizada", estatusTexto + ". Ha finalizado el proceso de publicación de la comisión.");

                            // Se setean los atributos para el formulario cuando el estatus es "EA"
                        } else if (comisionEnCurso.getEstatus().equals("EP")) {
                            request.setAttribute("nombreFormulario", "Informe de comisión");
                            request.setAttribute("error", true);
                            request.setAttribute("mensajeError", "Su comisión se encuentra con el estatus: \"" + estatusTexto + ". Debe esperar a la aprobaci�n de la misma a fin de continuar con el proceso de publicaci�n.");
                        }

                        // Se setean los atributos para el formulario cuando el estatus es otro distinto a los anteriores
                        /*else{
							request.setAttribute("nombreFormulario", "Informe de comisi�n");
							request.setAttribute("error", true);
							request.setAttribute("mensajeError", "Su comisi�n esta en curso con el estatus: \""+estatusTexto+"\". \nSeleccione el men� correspondiente para continuar con el proceso de la misma  o puede imprimir su solicitud en el men� \"Reportes comisiones\".");
						}*/
                    }

                } //Caso que aplica para cuando el funcionario no tiene comisiones en curso
                else if (comisionFuncionario != null && comisionFuncionario.isEmpty() && idComision.equals("0")) {
                    
                    // Se obtiene el formulario vac�o
                    List<SeccionesFormulario> seccionesFormulario = formSrv.getCamposFormulario(1, funcionario.getIdTipoPersona(), funcionario.getTipoRepresentacion());

                    PersonaVO param = new PersonaVO();
                    param.setEmail(funcionario.getEmail());
                    PersonaVO persona = personServ.obtenPersonaByMail(param);
                    System.out.println("########## PERSONA " + persona.getEmail());

                    // Se precargan los datos del funcionario en el formulario
                    for (SeccionesFormulario seccionFormulario : seccionesFormulario) {
                        for (CamposFormulario campoFormulario : seccionFormulario.getCamposFormulario()) {
                            if (campoFormulario.getCampo().equals("area_ads_aprueba")) {
                                if (funcionario.getIdTipoPersona().equals(1)) {
                                    campoFormulario.setValorCampo(formSrv.obtenerUnidadAdministrativa(funcionario.getUsuario()).get(0));
                                } else {
                                    if((formSrv.obtenerAreaAprobador(funcionario.getUsuario(), 1).get(0)).equals("0")){
                                        campoFormulario.setValorCampo("");
                                    }else{
                                        campoFormulario.setValorCampo(formSrv.obtenerAreaAprobador(funcionario.getUsuario(), 1).get(0));
                                    }
                                }
                            } else if (campoFormulario.getCampo().equals("nombres")) {
                                campoFormulario.setValorCampo(funcionario.getNombres());
                            } else if (campoFormulario.getCampo().equals("apellido_paterno")) {
                                campoFormulario.setValorCampo(funcionario.getApellidoPaterno());
                            } else if (campoFormulario.getCampo().equals("apellido_materno")) {
                                campoFormulario.setValorCampo(funcionario.getApellidoMaterno());
                            } else if (campoFormulario.getCampo().equals("numero_empleado")) {
                                if (persona.getNumeroEmpleado() == null) {
                                    campoFormulario.setValorCampo("");
                                } else {
                                    campoFormulario.setValorCampo(persona.getNumeroEmpleado().toString());
                                }
                            } else if (campoFormulario.getCampo().equals("denominacion_puesto")) {
                                if (persona.getDenominacionPuesto() == null) {
                                    campoFormulario.setValorCampo("");
                                } else {
                                    campoFormulario.setValorCampo(persona.getDenominacionPuesto());
                                }
                            } else if (campoFormulario.getCampo().equals("clave_puesto")) {
                                if (persona.getClavePuesto() == null) {
                                    campoFormulario.setValorCampo("");
                                } else {
                                    campoFormulario.setValorCampo(persona.getClavePuesto());
                                }
                            } else if (campoFormulario.getCampo().equals("cargo")) {
                                campoFormulario.setValorCampo(funcionario.getCargo());
                            } else if (campoFormulario.getCampo().equals("email")) {
                                campoFormulario.setValorCampo(funcionario.getEmail());
                            } else if (campoFormulario.getCampo().equals("sexo")) {
                                if (persona.getSexo() == null) {
                                    campoFormulario.setValorCampo("");
                                } else {
                                    if (persona.getSexo() == "F") {
                                        campoFormulario.setValorCampo("Mujer");
                                    } else {
                                        campoFormulario.setValorCampo("Hombre");
                                    }
                                }
                            } else if (campoFormulario.getCampo().equals("tipo_de_representacion")) {
                                if (persona.getClavePuesto() == null) {
                                    campoFormulario.setValorCampo("");
                                } else {
                                    campoFormulario.setValorCampo(persona.getTipoRepresentacion());
                                }
                            } else if (campoFormulario.getCampo().equals("tipo_de_miembro")) {
                                
                                    if (persona.getTipoIntegrante() == null) {
                                        campoFormulario.setValorCampo("N/A");
                                    } else {
                                        campoFormulario.setValorCampo(personServ.obtenerTipoIntegrante(persona.getId()));
                                    }
                            } else if (campoFormulario.getCampo().equals("INAI_tipo_de_representacion")) {
                                campoFormulario.setValorCampo(funcionario.getTipoRepresentacion());
                            }
                        }
                    }

                    // Se setean los atributos para el formulario de la comisi�n reci�n creada
                    request.setAttribute("error", false);
                    // Se setea idComision como 0 para indicar que 
                    request.setAttribute("idComision", 0);
                    request.setAttribute("nombreFormulario", "Solicitud de comisión");
                    request.setAttribute("seccionesFormulario", seccionesFormulario);
                    request.setAttribute("nombreDepedencia", funcionario.getNombreDependencia());
                    request.setAttribute("nombreAreaUsr", funcionario.getNombreArea());
                    request.setAttribute("idAreaUsr", funcionario.getIdArea().toString());
                    request.setAttribute("estatus", "C");
                    request.setAttribute("tarifas", Arrays.toString(tarifas.toArray()));
                    request.setAttribute("pernoctas", Arrays.toString(pernocta.toArray()));
                }/*else{
					if (action.equals("oficioViaticos"))
						request.setAttribute("nombreFormulario", "Solicitud de vi�ticos y pasajes");
					else if (action.equals("oficioGastos"))
						request.setAttribute("nombreFormulario", "Desglose de gastos");
					else if (action.equals("oficioPublicacion"))
						request.setAttribute("nombreFormulario", "Informe de comisi�n");
					request.setAttribute("error", true);
					request.setAttribute("mensajeError", "Actualmente no cuenta con comisiones en curso. Si desea crear una comisi�n vaya al men� \"Solicitud de Comisi�n\"");
				}*/

                request.setAttribute("tipoRepresentacionFun", funcionario.getTipoRepresentacion());

                // Se setean los atributos para generar un mensaje de error al no haber encontrado informaci�n del funcionario
            } else {
                request.setAttribute("nombreFormulario", "Solicitud de comisión");
                request.setAttribute("error", true);
                request.setAttribute("mensajeError", "No se encontro información del funcionario para realizar la Solicitud de Comisión");
            }
            request.setAttribute("datosGuardados", false);

            // Se ejecuta para salvar informaci�n del formulario
        } //Se ejecuta al cargar el formulario de solicitud  de comisi�n
        else if (action.equals("salvarDatosComision")) {
            String idComisionString = request.getParameter("id_comision");
            String estatus = request.getParameter("estatus");
            Integer idComision = Integer.valueOf(idComisionString);
            SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
            String username = sesion.getUsuario();

            //Se obtienen los datos del funcionario
            ArrayList<DatosFuncionariosVO> datosFuncionario = formSrv.obtenerDatosFuncionario(username);

            if (idComision.intValue() == 0) {
                

                //Se valida que exista el funcionario
                if (datosFuncionario != null && !datosFuncionario.isEmpty()) {
                    DatosFuncionariosVO funcionario = datosFuncionario.get(0);
                    // Se crea una nueva comisi�n con el estatus "C"
                    idComision = formSrv.insertarNuevaComision("C", funcionario.getIdDependencia(), funcionario.getIdPersona(), funcionario.getIdUsuario());
                }
            }

            List<String> parameterNames = new ArrayList<String>(request.getParameterMap().keySet());// AQUI
            System.out.println("estatus :" + estatus);
            if (estatus.equals("C")){
                DatosFuncionariosVO funcionario = datosFuncionario.get(0);
                parameterNames.add(52,"|cve_programa_pre|TEXTO");
                parameterNames.add(54,"|cve_proyecto_estrategico|TEXTO");
                parameterNames.add(56,"|cve_proyecto_actividades|TEXTO");
                
                    for (String parameterName : parameterNames) {
                    String tabla = "", campo = "", tipoDato = "";

                    String valorParam = "";
                    switch (parameterName){
                        case "areas|nombre_area|TEXTO":
                             valorParam = funcionario.getNombreArea();
                            break;
                        case "areas|id_area|TEXTO":
                             valorParam = funcionario.getIdArea().toString();
                            break;
                        case "|ua_presupuesto|TEXTO":
                             valorParam = (formSrv.obtenerTrNombreUa(request.getParameter("|ua_presupuesto|TEXTO"))).get(0);
                            break;
                        case "|cve_ua_presupuesto|TEXTO":
                             valorParam = request.getParameter("|ua_presupuesto|TEXTO");                         
                            break;
                        case "|programa_presupuestal|TEXTO":
                             valorParam = (formSrv.obtenerTrNombrePp(request.getParameter("|programa_presupuestal|TEXTO"))).get(0);
                            break;
                        case "|cve_programa_pre|TEXTO":
                             valorParam = request.getParameter("|programa_presupuestal|TEXTO");
                            break;
                        case "|proyecto_estrategico|TEXTO":                        
                             valorParam = formSrv.obtenerTrNombrePe(request.getParameter("|proyecto_estrategico|TEXTO"),request.getParameter("|programa_presupuestal|TEXTO"),request.getParameter("|ua_presupuesto|TEXTO")).get(0);
                            break;
                        case "|cve_proyecto_estrategico|TEXTO":
                             valorParam = request.getParameter("|proyecto_estrategico|TEXTO");
                            break;
                        case "|proyecto_actividades|TEXTO":
                             valorParam = formSrv.obtenerTrNombreAc(request.getParameter("|proyecto_actividades|TEXTO"),request.getParameter("|ua_presupuesto|TEXTO"),request.getParameter("|programa_presupuestal|TEXTO"),request.getParameter("|proyecto_estrategico|TEXTO")).get(0);
                            break;
                        case "|cve_proyecto_actividades|TEXTO":
                             valorParam = request.getParameter("|proyecto_actividades|TEXTO");
                            break;
                        case "|nivel_homologacion|TEXTO":
                            if(request.getParameter("|nivel_homologacion|TEXTO").isEmpty()){
                                valorParam = "N/A";
                            }else{
                                valorParam = request.getParameter("|nivel_homologacion|TEXTO");
                            }
                            break;
                        default:
                            valorParam = request.getParameter(parameterName);
                            break;
                    }

                    String[] paramTablaCampo = parameterName.split("\\|");

                    System.out.println(" Param name::::::: " + parameterName);

                    if (paramTablaCampo.length == 3) {
                        tabla = paramTablaCampo[0];
                        campo = paramTablaCampo[1];
                        tipoDato = paramTablaCampo[2];
                    } else if (paramTablaCampo.length == 2) {
                        campo = paramTablaCampo[0];
                        tipoDato = paramTablaCampo[1];
                    }

                    System.out.println(tabla + " - " + campo + " - " + valorParam);

                    if (tipoDato.equals(TipoDato.TEXTO)) {
                        formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, valorParam, Double.valueOf(0), null, Short.valueOf("2"));
                    } else if (tipoDato.equals(TipoDato.NUMERO)) {
                        if (valorParam != null && !valorParam.equals("")) {
                            formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(valorParam), null, Short.valueOf("1"));
                        } else {
                            formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf("0"), null, Short.valueOf("1"));
                        }
                    } else if (tipoDato.equals(TipoDato.FECHA)) {
                        try {
                            if (campo.startsWith("hora")) {
                                java.util.Date fechaComodin = new java.util.Date();
                                String fechaComodinFormat = formatterDate.format(fechaComodin);
                                String tempDate = fechaComodinFormat + " " + valorParam;

                                System.out.println("tempDate: " + tempDate + " formatterDateTime.parse(tempDate): " + formatterDateTime.parse(tempDate));
                                formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), formatterDateTime.parse(tempDate), Short.valueOf("3"));
                            } else {
                                if (valorParam.equals("")) {
                                    formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), null, Short.valueOf("3"));
                                } else {
                                    formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), formatterDate.parse(valorParam), Short.valueOf("3"));
                                }
                            }
                        } catch (NumberFormatException | ParseException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
                
            }else{
                    for (String parameterName : parameterNames) {
                    String tabla = "", campo = "", tipoDato = "";

                    String valorParam = "";

                    valorParam = request.getParameter(parameterName);

                    String[] paramTablaCampo = parameterName.split("\\|");

                    System.out.println(" Param name::::::: " + parameterName);

                    if (paramTablaCampo.length == 3) {
                        tabla = paramTablaCampo[0];
                        campo = paramTablaCampo[1];
                        tipoDato = paramTablaCampo[2];
                    } else if (paramTablaCampo.length == 2) {
                        campo = paramTablaCampo[0];
                        tipoDato = paramTablaCampo[1];
                    }

                    System.out.println(tabla + " - " + campo + " - " + valorParam);

                    if (tipoDato.equals(TipoDato.TEXTO)) {
                        formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, valorParam, Double.valueOf(0), null, Short.valueOf("2"));
                    } else if (tipoDato.equals(TipoDato.NUMERO)) {
                        if (valorParam != null && !valorParam.equals("")) {
                            formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(valorParam), null, Short.valueOf("1"));
                        } else {
                            formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf("0"), null, Short.valueOf("1"));
                        }
                    } else if (tipoDato.equals(TipoDato.FECHA)) {
                        try {
                            if (campo.startsWith("hora")) {
                                java.util.Date fechaComodin = new java.util.Date();
                                String fechaComodinFormat = formatterDate.format(fechaComodin);
                                String tempDate = fechaComodinFormat + " " + valorParam;

                                System.out.println("tempDate: " + tempDate + " formatterDateTime.parse(tempDate): " + formatterDateTime.parse(tempDate));
                                formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), formatterDateTime.parse(tempDate), Short.valueOf("3"));
                            } else {
                                if (valorParam.equals("")) {
                                    formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), null, Short.valueOf("3"));
                                } else {
                                    formSrv.insertarActualizarComisionDetalle(idComision, tabla, campo, null, Double.valueOf(0), formatterDate.parse(valorParam), Short.valueOf("3"));
                                }
                            }
                        } catch (NumberFormatException | ParseException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
            }
            
            if (estatus.equals("C") || estatus.equals("R")) {
                request.setAttribute("nombreFormulario", "Solicitud de comisión");
            } else if (estatus.equals("A") || estatus.equals("RV")) {
                request.setAttribute("nombreFormulario", "Solicitud de viáticos y pasajes");
            } else if (estatus.equals("F") || estatus.equals("RG")) {
                request.setAttribute("nombreFormulario", "Desglose de gastos");
            } else if (estatus.equals("CM") || estatus.equals("RP")) {
                request.setAttribute("nombreFormulario", "Solicitud de publicación");
            }

            request.setAttribute("idComision", idComision);
            request.setAttribute("estatus", estatus);
            request.setAttribute("datosGuardados", true);
            request.setAttribute("comisionEnviada", false);
            request.setAttribute("mensajeGuardado", "Se han guardado los datos Éxitosamente. Puede proceder a enviar su solicitud o regresar al formulario para realizar cambios antes de su envío. ");

        } else if (action.equals("enviar")) {
            String idComisionString = request.getParameter("id_comision");
            SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
            String sFlujo = "";
            String estatus = request.getParameter("estatus");

            if (estatus.equals("C") || estatus.equals("R")) {
                sFlujo = "1";
                request.setAttribute("nombreFormulario", "Solicitud de comisión");
            } else if (estatus.equals("A") || estatus.equals("RV")) {
                sFlujo = "2";
                request.setAttribute("nombreFormulario", "Solicitud de viáticos y pasajes");
            } else if (estatus.equals("F") || estatus.equals("RG")) {
                sFlujo = "3";
                request.setAttribute("nombreFormulario", "Desglose de gastos");
            } else if (estatus.equals("CM") || estatus.equals("RP")) {
                sFlujo = "4";
                request.setAttribute("nombreFormulario", "Solicitud de publicación");
            }

            Integer idFlujo = Integer.parseInt(sFlujo);

            ProcesoVO param = new ProcesoVO();
            param.setId(idFlujo);

            ProcesoServices procServ = new ProcesoServices();
            BonitaServices bonServ = new BonitaServices();

            ProcesoVO proceso = procServ.obtenerProceso(param);

            BonitaErrorVO error = bonServ.invocaProceso(proceso, sesion.getUsuario(), Integer.valueOf(idComisionString));

            formSrv.actualizaEstatusComision(Integer.valueOf(idComisionString), regresaSiguienteEstatusComision(estatus));

            request.setAttribute("comisionEnviada", true);
            request.setAttribute("mensajeEnviada", "Se ha enviado su solicitud para su aprobación.");
            //request.setAttribute("error", error);

        } else if (action.equals("listarGastos")) {
            String idComisionString = request.getParameter("id_comision");

            List<String> encabezados = formSrv.getEncabezadosGastos();
            List<ListaGastosComision> valoresTabla = formSrv.getListaGastosComision(Integer.valueOf(idComisionString));

            request.setAttribute("encabezados", encabezados);
            request.setAttribute("valoresTabla", valoresTabla);
            request.setAttribute("idComision", idComisionString);
        } else if (action.equals("agregarGasto")) {

            String idComisionString = request.getParameter("id_comision");
            List<GastosComision> elementosFormulario = formSrv.getCamposGastosComision();

            request.setAttribute("elementosFormulario", elementosFormulario);
            request.setAttribute("idComision", idComisionString);
            request.setAttribute("idRegistroGastoComision", 0);
        } else if (action.equals("modificarGasto")) {

            String idRegistroGastosComision = request.getParameter("id_registro");
            String idComisionString = request.getParameter("id_comision");

            List<GastosComision> elementosFormulario = formSrv.getCamposGastosComision(Integer.valueOf(idRegistroGastosComision));

            request.setAttribute("elementosFormulario", elementosFormulario);
            request.setAttribute("idComision", idComisionString);
            request.setAttribute("idRegistroGastoComision", idRegistroGastosComision);
        } else if (action.equals("borrarGasto")) {

            String idRegistroGastosComision = request.getParameter("id_registro");
            String idComisionString = request.getParameter("id_comision");

            Properties prop = new Properties();
            try {
                prop.load(UserServices.class.getClassLoader().getResourceAsStream("archivo.properties"));

                Path rutaDestino = Paths.get(prop.getProperty("ruta") + idComisionString + "/" + idRegistroGastosComision.toString());
                Path rutaDestinoArchivo = Paths.get(rutaDestino.toString(), "factura.pdf");

                if (Files.exists(rutaDestinoArchivo)) {
                    Files.delete(rutaDestinoArchivo);
                }

                Files.delete(rutaDestino);

            } catch (IOException ex) {
                ex.printStackTrace();
            }

            formSrv.eliminarRegistroGastosComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastosComision));
        } else if (action.equals("verFacturaGasto")) {

            String idRegistroGastosComision = request.getParameter("id_registro");
            String idComisionString = request.getParameter("id_comision");

            byte[] facturaFile = null;

            Properties prop = new Properties();
            try {
                prop.load(UserServices.class.getClassLoader().getResourceAsStream("archivo.properties"));

                Path rutaDestino = Paths.get(prop.getProperty("ruta") + idComisionString + "/" + idRegistroGastosComision.toString());
                Path rutaDestinoArchivo = Paths.get(rutaDestino.toString(), "factura.pdf");

                if (Files.exists(rutaDestinoArchivo)) {
                    facturaFile = Files.readAllBytes(rutaDestinoArchivo);
                }

                response.reset();
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment;filename=factura.pdf");
                response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
                response.setHeader("Pragma", "public");
                response.setDateHeader("Expires", 0);
                response.setContentLength(facturaFile.length);
                response.setBufferSize(facturaFile.length);
                response.getOutputStream().write(facturaFile, 0, facturaFile.length);

            } catch (IOException ex) {
                ex.printStackTrace();
            }

        } else if (action.equals("guardarGastos")) {
            String idComisionString = request.getParameter("id_comision");
            String idRegistroGastoComisionString = request.getParameter("id_registro_gasto_comision");

            Integer idRegistroGastoComision = 0;
            if (!idRegistroGastoComisionString.equals("") && !idRegistroGastoComisionString.equals("0")) {
                idRegistroGastoComision = Integer.valueOf(idRegistroGastoComisionString);
            } else {
                idRegistroGastoComision = formSrv.insertarRegistroGastoComision(Integer.valueOf(idComisionString));
            }

            Part filePart = request.getPart("archivo_factura|TEXTO");

            if (filePart.getSize() > 0L && filePart.getContentType().equals("application/pdf")) {

                Properties prop = new Properties();

                try {
                    prop.load(UserServices.class.getClassLoader().getResourceAsStream("archivo.properties"));
                    InputStream archivoFactura = filePart.getInputStream();

                    Path rutaDestino = Paths.get(prop.getProperty("ruta") + idComisionString + "/" + idRegistroGastoComision.toString());

                    if (!Files.exists(rutaDestino)) {
                        Files.createDirectories(rutaDestino);
                    }

                    Path rutaDestinoArchivo = Paths.get(rutaDestino.toString(), "factura.pdf");

                    FileOutputStream archivoDestino = new FileOutputStream("factura.pdf");

                    if (!Files.exists(rutaDestinoArchivo)) {
                        Files.copy(archivoFactura, rutaDestinoArchivo);
                        Files.copy(rutaDestinoArchivo, archivoDestino);
                    } else {
                        Files.copy(archivoFactura, rutaDestinoArchivo, StandardCopyOption.REPLACE_EXISTING);
                    }

                    formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), "archivo_factura", "factura.pdf", Double.valueOf(0), null, Short.valueOf("2"));
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

            } else {
                System.out.println("No hay archivo");

                Properties prop = new Properties();
                try {
                    prop.load(UserServices.class.getClassLoader().getResourceAsStream("archivo.properties"));

                    Path rutaDestino = Paths.get(prop.getProperty("ruta") + idComisionString + "\\" + idRegistroGastoComision.toString());
                    Path rutaDestinoArchivo = Paths.get(rutaDestino.toString(), "factura.pdf");
                    if (Files.exists(rutaDestinoArchivo)) {
                        Files.delete(rutaDestinoArchivo);
                    }

                    formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), "archivo_factura", "", Double.valueOf(0), null, Short.valueOf("2"));
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

            }

            List<String> parameterNames = new ArrayList<String>(request.getParameterMap().keySet());//OTRO?
            for (String parameterName : parameterNames) {
                String tabla = "", campo = "", tipoDato = "";
                String valorParam = request.getParameter(parameterName);
                String[] paramTablaCampo = parameterName.split("\\|");
                if (paramTablaCampo.length == 3) {
                    tabla = paramTablaCampo[0];
                    campo = paramTablaCampo[1];
                    tipoDato = paramTablaCampo[2];
                } else if (paramTablaCampo.length == 2) {
                    campo = paramTablaCampo[0];
                    tipoDato = paramTablaCampo[1];
                }

                System.out.println(tabla + " - " + campo + " - " + valorParam);

                if (tipoDato.equals(TipoDato.TEXTO)) {
                    formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), campo, valorParam, Double.valueOf(0), null, Short.valueOf("2"));
                } else if (tipoDato.equals(TipoDato.NUMERO)) {
                    formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), campo, null, Double.valueOf(valorParam), null, Short.valueOf("1"));
                } else if (tipoDato.equals(TipoDato.FECHA)) {
                    try {
                        if (campo.startsWith("hora")) {
                            java.util.Date fechaComodin = new java.util.Date();
                            String fechaComodinFormat = formatterDate.format(fechaComodin);
                            String tempDate = fechaComodinFormat + " " + valorParam;

                            System.out.println("tempDate: " + tempDate + " formatterDateTime.parse(tempDate): " + formatterDateTime.parse(tempDate));
                            formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), campo, null, Double.valueOf(0), formatterDateTime.parse(tempDate), Short.valueOf("3"));
                        } else {
                            formSrv.insertarActualizarGastoComision(Integer.valueOf(idComisionString), Integer.valueOf(idRegistroGastoComision), campo, null, Double.valueOf(0), formatterDate.parse(valorParam), Short.valueOf("3"));
                        }
                    } catch (NumberFormatException | ParseException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }

        } else if (action.equals("listarProgramaPresupuestal")) {

            String ua = request.getParameter("ua");
            ArrayList<TrProgramaPresupuestalVO> programas = ppServ.obtenerProgramas(ua);
            StringBuffer jsonArrayPP = new StringBuffer();

            if (programas == null || programas.isEmpty()) {
                jsonArrayPP.append("[]");
            } else {

                int count = 0;
                jsonArrayPP.append("[");
                for (TrProgramaPresupuestalVO programa : programas) {
                    jsonArrayPP.append("{");
                    //jsonArrayPP.append("\"idPrograma\":" + (programa.getIdProgramaPresupuestal() == null ? "" : programa.getIdProgramaPresupuestal()) + ",");
                    jsonArrayPP.append("\"idPrograma\":\"" + (programa.getCvePp() == null ? "" : programa.getCvePp()) + "\",");
                    jsonArrayPP.append("\"nombrePrograma\":\"" + (programa.getDescripcionPp() == null ? "" : programa.getDescripcionPp()) + "\"}");
                    if (++count < programas.size()) {
                        jsonArrayPP.append(",");
                    }
                }
                jsonArrayPP.append("]");
            }

            System.out.println(jsonArrayPP);

            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArrayPP);            

        } else if (action.equals("listarProyectoEspecial")) {

            String ua = request.getParameter("ua");
            String pp = request.getParameter("pp");
            
            ArrayList<TrProgramaEspecialVO> proyectos = peServ.obtenerProyectos(ua, pp);
            StringBuffer jsonArray = new StringBuffer();

            if (proyectos == null || proyectos.isEmpty()) {
                jsonArray.append("[]");
            } else {

                int count = 0;
                jsonArray.append("[");
                for (TrProgramaEspecialVO proyecto : proyectos) {
                    jsonArray.append("{");
                    jsonArray.append("\"idProyecto\":\"" + (proyecto.getCvePe() == null ? "" : proyecto.getCvePe()) + "\",");
                    jsonArray.append("\"nombreProyecto\":\"" + (proyecto.getNombrePe() == null ? "" : proyecto.getNombrePe()) + "\"}");
                    if (++count < proyectos.size()) {
                        jsonArray.append(",");
                    }
                }
                jsonArray.append("]");
            }

            System.out.println(jsonArray);

            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArray);

        } else if (action.equals("listarActividades")) {

            String ua = request.getParameter("ua");
            String pp = request.getParameter("pp");
            String pe = request.getParameter("pe");
            
            ArrayList<TrActividadPresupuestalVO> actividades = acServ.obtenerActividades(ua, pp, pe);
            StringBuffer jsonArray = new StringBuffer();

            if (actividades == null || actividades.isEmpty()) {
                jsonArray.append("[]");
            } else {

                int count = 0;
                jsonArray.append("[");
                for (TrActividadPresupuestalVO actividad : actividades) {
                    jsonArray.append("{");
                    jsonArray.append("\"idActividad\":\"" + (actividad.getPrs() == null ? "" : actividad.getPrs()) + "\",");
                    jsonArray.append("\"nombreActividad\":\"" + (actividad.getNombre() == null ? "" : actividad.getNombre()) + "\"}");
                    if (++count < actividades.size()) {
                        jsonArray.append(",");
                    }
                }
                jsonArray.append("]");
            }

            System.out.println(jsonArray);

            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArray);

        } else if (action.equals("listarPaises")) {
            ArrayList<PaisVO> paises = paisSrv.obtenerPaises();

            StringBuffer jsonArray = new StringBuffer();

            if (paises == null || paises.isEmpty()) {
                jsonArray.append("[]");
            } else {
                int count = 0;
                jsonArray.append("[");
                for (PaisVO pais : paises) {
                    jsonArray.append("{");

                    jsonArray.append("\"id\":" + (pais.getId() == null ? "" : pais.getId()) + ",");
                    jsonArray.append("\"nombre\":\"" + (pais.getNombre() == null ? "" : pais.getNombre()) + "\"}");
                    if (++count < paises.size()) {
                        jsonArray.append(",");
                    }

                }
                jsonArray.append("]");
            }

            System.out.println(jsonArray);

            //request.setAttribute("paises", jsonArray);
            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArray);

        } else if (action.equals("listarEstados")) {
            String pais = request.getParameter("pais");

            ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
            ArrayList<EstadoVO> estadosFilter = new ArrayList<EstadoVO>();

            StringBuffer jsonArray = new StringBuffer();

            if (estados == null || estados.isEmpty()) {
                jsonArray.append("[]");
            } else {
                for (EstadoVO estado : estados) {
                    if (pais.equals(estado.getPais().getNombre())) {
                        estadosFilter.add(estado);
                    }
                }

                int count = 0;
                jsonArray.append("[");
                for (EstadoVO estado : estadosFilter) {
                    jsonArray.append("{");

                    jsonArray.append("\"idEstado\":" + (estado.getId() == null ? "" : estado.getId()) + ",");
                    jsonArray.append("\"nombreEstado\":\"" + (estado.getNombre() == null ? "" : estado.getNombre()) + "\"}");
                    if (++count < estadosFilter.size()) {
                        jsonArray.append(",");
                    }
                }
                jsonArray.append("]");
            }

            System.out.println(jsonArray);

            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArray);

        } else if (action.equals("listarCiudades")) {
            String pais = request.getParameter("pais");
            String estado = request.getParameter("estado");

            ArrayList<CiudadVO> ciudades = ciudadSrv.obtenerCiudades();
            ArrayList<CiudadVO> ciudadesFilter = new ArrayList<CiudadVO>();

            StringBuffer jsonArray = new StringBuffer();

            if (ciudades == null || ciudades.isEmpty()) {
                jsonArray.append("[]");
            } else {
                for (CiudadVO ciudad : ciudades) {
                    if (pais.equals(ciudad.getPais().getNombre()) && estado.equals(ciudad.getEstado().getNombre())) {
                        ciudadesFilter.add(ciudad);
                    }
                }

                int count = 0;
                jsonArray.append("[");
                for (CiudadVO ciudad : ciudadesFilter) {
                    jsonArray.append("{");

                    jsonArray.append("\"idCiudad\":" + (ciudad.getId() == null ? "" : ciudad.getId()) + ",");
                    jsonArray.append("\"nombreCiudad\":\"" + (ciudad.getNombre() == null ? "" : ciudad.getNombre()) + "\"}");
                    if (++count < ciudadesFilter.size()) {
                        jsonArray.append(",");
                    }
                }
                jsonArray.append("]");
            }

            System.out.println(jsonArray);

            response.reset();
            response.setHeader("Content-Type", "application/json");
            response.getWriter().print(jsonArray);

        } else if (action.equals("listarReportesComisiones")) {

            SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
            String username = sesion.getUsuario();//currentUser.getPrincipal().toString();

            //Se obtienen los datos del funcionario
            ArrayList<DatosFuncionariosVO> datosFuncionario = formSrv.obtenerDatosFuncionario(username);

            //Se valida que exista el funcionario
            if (datosFuncionario != null && !datosFuncionario.isEmpty()) {
                DatosFuncionariosVO funcionario = datosFuncionario.get(0);

                System.out.println("funcionario.getIdPersona(): " + funcionario.getIdPersona() + " funcionario.nombre: " + funcionario.getUsuario());

                List<String> encabezados = new ArrayList<String>();
                encabezados.add(0, "Id Comisión");
                encabezados.add(1, "Flujo 1");
                encabezados.add(2, "Flujo 2");
                encabezados.add(3, "Flujo 3");
                encabezados.add(4, "Flujo 4");
                List<FlujosComisionesVO> valoresTabla = formSrv.obtenerFlujosComision(funcionario.getIdPersona());

                request.setAttribute("encabezados", encabezados);
                request.setAttribute("valoresTabla", valoresTabla);
                request.setAttribute("idTipoPersona", funcionario.getIdTipoPersona());
            }

        } else if (action.equals("generarReporte")) {
            ServletContext context = request.getSession().getServletContext();

            String idComision = request.getParameter("id_comision");
            String idTipoPersona = request.getParameter("id_tipo_persona");
            String idFlujo = request.getParameter("id_flujo");

            String nombreReporte = "";

            Map<String, Object> parameters = new HashMap<String, Object>();

            JRBeanCollectionDataSource ds = null;

            StringBuffer reportStream = new StringBuffer(context.getRealPath(""));

            reportStream.append("/reportes/");

            parameters.put("CONTEXT", context.getRealPath(""));
            parameters.put("SUBREPORT_DIR", context.getRealPath("") + "/reportes/");
            parameters.put("ID_COMISION", Integer.valueOf(idComision));
            parameters.put("ID_TIPO_PERSONA", Integer.valueOf(idTipoPersona));
            parameters.put("ID_FLUJO", Integer.valueOf(idFlujo));

            Session session = HibernateUtil.getSessionFactory().openSession();
            SessionFactoryImplementor sessionFactoryImplementation = (SessionFactoryImplementor) session.getSessionFactory();
            ConnectionProvider connectionProvider = sessionFactoryImplementation.getConnectionProvider();
            try {
                connectionProvider.getConnection().isClosed();
                parameters.put("HIBERNATE_SESSION", connectionProvider.getConnection());
            } catch (SQLException e) {

            }

            List<ReporteFlujoComisionVO> reporteComision = formSrv.obtenerReporteFlujoComision(Integer.valueOf(idComision), Integer.valueOf(idFlujo));
            ds = new JRBeanCollectionDataSource(reporteComision);
                       
            if(idFlujo.equals("1")){
                SesionVO sesion = (SesionVO) request.getSession().getAttribute("sesion");
                String username = sesion.getUsuario();
                Map<String, Object> oficioComision = formSrv.getReporteOficioComision(Integer.valueOf(idComision), Integer.valueOf(idFlujo), username);
                parameters.put("COMISION_DETALLE", oficioComision);
                reportStream.append("reporteOficioComision.jrxml");
                nombreReporte = "reporteOficioComision";
            }else{               
                reportStream.append("reporteFormularioSolicitud.jrxml");
                nombreReporte = "reporteFormularioSolicitud";
            }

            JasperDesign jasperDesign;
            try {
                jasperDesign = JRXmlLoader.load(reportStream.toString());
                JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);

                byte[] pdfBytes = null;
                
                pdfBytes = JasperRunManager.runReportToPdf(jasperReport, parameters, ds);
                response.reset();
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment;filename=" + nombreReporte + ".pdf");
                response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
                response.setHeader("Pragma", "public");
                response.setDateHeader("Expires", 0);
                response.setContentLength(pdfBytes.length);
                response.setBufferSize(pdfBytes.length);
                response.getOutputStream().write(pdfBytes, 0, pdfBytes.length);
            } catch (JRException e) {
                e.printStackTrace();
            } catch (IOException exception) {
                System.out.println(" Error al escribir reporte en la respuesta [" + exception.getMessage() + "]");
            }

        }

        destino = "formularios/formularioSolicitud.jsp";

        if (action.equals("listarGastos") || action.equals("guardarGastos") || action.equals("borrarGasto")) {
            String idComisionString = request.getParameter("id_comision");

            List<String> encabezados = formSrv.getEncabezadosGastos();
            List<ListaGastosComision> valoresTabla = formSrv.getListaGastosComision(Integer.valueOf(idComisionString));

            request.setAttribute("encabezados", encabezados);
            request.setAttribute("valoresTabla", valoresTabla);
            request.setAttribute("idComision", idComisionString);

            destino = "formularios/listarGastos.jsp";
        } else if (action.equals("agregarGasto") || action.equals("modificarGasto")) {
            destino = "formularios/formularioGastos.jsp";
        } else if (action.equals("listarReportesComisiones") || action.equals("generarReporte")) {
            destino = "formularios/listarReportesComisiones.jsp";
        } else if (action.equals("listarComisiones")) {
            destino = "formularios/listarComisiones.jsp";
        }

        if (!action.equals("generarReporte") && !action.equals("listarPaises") && !action.equals("listarEstados") && !action.equals("listarProyectoEspecial")
                && !action.equals("listarCiudades") && !action.equals("verFacturaGasto") && !action.equals("listarProgramaPresupuestal") && !action.equals("listarActividades")) {
            System.out.println("forward");
            RequestDispatcher rd = request.getRequestDispatcher(destino);
            rd.forward(request, response);
        }
    }

    public String regresaEstatusComisionEmpleado(String estatus) {
        if (estatus.equals("C")) {
            return EstatusComisiones.C;
        } else if (estatus.equals("EA")) {
            return EstatusComisiones.EA;
        } else if (estatus.equals("R")) {
            return EstatusComisiones.R;
        } else if (estatus.equals("A")) {
            return EstatusComisiones.A;
        } else if (estatus.equals("EV")) {
            return EstatusComisiones.EV;
        } else if (estatus.equals("RV")) {
            return EstatusComisiones.RV;
        } else if (estatus.equals("F")) {
            return EstatusComisiones.F;
        } else if (estatus.equals("EG")) {
            return EstatusComisiones.EG;
        } else if (estatus.equals("RG")) {
            return EstatusComisiones.RG;
        } else if (estatus.equals("CM")) {
            return EstatusComisiones.CM;
        } else if (estatus.equals("EP")) {
            return EstatusComisiones.EP;
        } else if (estatus.equals("RP")) {
            return EstatusComisiones.RP;
        } else if (estatus.equals("P")) {
            return EstatusComisiones.P;
        } else {
            return "";
        }
    }

    public String regresaSiguienteEstatusComision(String estatus) {
        if (estatus.equals("C") || estatus.equals("R")) {
            return "EA";
        } else if (estatus.equals("A") || estatus.equals("RV")) {
            return "EV";
        } else if (estatus.equals("F") || estatus.equals("RG")) {
            return "EG";
        } else if (estatus.equals("CM") || estatus.equals("RP")) {
            return "EP";
        } else {
            return "";
        }
    }

}
