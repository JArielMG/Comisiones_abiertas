package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.BonitaErrorVO;
import mx.org.inai.viajesclaros.admin.model.CatalogoElement;
import mx.org.inai.viajesclaros.admin.model.ComisionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.FlujosInstanciasVO;
import mx.org.inai.viajesclaros.admin.model.ListaValoresVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionVO;
import mx.org.inai.viajesclaros.admin.model.SeccionesNotificacionVO;
import mx.org.inai.viajesclaros.admin.model.SesionVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.BonitaServices;
import mx.org.inai.viajesclaros.admin.service.NotificacionServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;
import mx.org.inai.viajesclaros.admin.util.TipoDato;

/**
 * Servlet implementation class NotificacionAction
 */
@WebServlet(name = "NotificacionAction" , urlPatterns = { "/notificacionAction" })
public class NotificacionAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	BonitaServices bonServ = new BonitaServices();
	UserServices usServ = new UserServices();
	NotificacionServices notServ = new NotificacionServices();
       
    public NotificacionAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destino = "login.jsp";
		String action = request.getParameter("action");
		
		if (action == null) {
			action = "listar";
		}
		
		if (action.equals("listar")) {
			SesionVO sesion = (SesionVO)request.getSession().getAttribute("sesion");
			UsuarioVO usuario = usServ.obtenerUsuario(sesion.getUsuario());
			
			List<NotificacionVO> notificaciones = bonServ.obtenerTareasPendientes(usuario);
			request.setAttribute("notificaciones", notificaciones);
			
			destino = "workflows/listarNotificaciones.jsp";
			
		} else if (action.equals("detalle")) {
			String sInstance = request.getParameter("instance");
			String sTask = request.getParameter("id");
			String sTipo = request.getParameter("tipo");
			
			Long instanceId = Long.parseLong(sInstance);
			Long task = Long.parseLong(sTask);
			Integer tipo = Integer.parseInt(sTipo);
			
			FlujosInstanciasVO instancia = bonServ.obtenerInstancia(instanceId);
			
			NotificacionDetalleVO detalle = notServ.obtenerDetalleNotificacion(instancia, task, tipo);
                        
                        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
                        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
                        //DateFormat formatoFecha = new SimpleDateFormat("h:mm a");
                                
                        
                        for(SeccionesNotificacionVO seccion : detalle.getSecciones()){
                            for(ComisionDetalleVO comision : seccion.getDetalle()){
//                                if(comision.getCampo().equals("denominacion_pviaticos")){
//                                    ListaValoresVO lista = notServ.getListaValores("denominacion_partida_viaticos");
//                                    List<CatalogoElement> denominacionViaticos = notServ.getvaloresDinamicos(lista.getIdLista());
//                                    request.setAttribute("denominacionViaticos", denominacionViaticos);
//                                }
                                System.out.println("comision etiqueta  :: " + comision.getEtiqueta() + "  comision campo ::: " + comision.getCampo() + " Registro subtipo ::: " + comision.getSubtipo());
                                switch(comision.getCampo()){
                                    case "denominacion_pviaticos":
                                            ListaValoresVO lista = notServ.getListaValores("denominacion_partida_viaticos");
                                            List<CatalogoElement> denominacionViaticos = notServ.getvaloresDinamicos(lista.getIdLista());
                                            request.setAttribute("denominacionViaticos", denominacionViaticos);
                                        break;
                                        
                                    case "fecha_hora_salida":
                                        String FechaSalidaComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaSalidaComoCadena);
                                        System.out.println("#################### FECH fecha_hora_salida" + FechaSalidaComoCadena);
                                        break;
                                        
                                    case "hora_salida_comision":
                                        String HoraSalidaComoCadena = formatoHora.format(comision.getValorFecha());
                                        comision.setValorFechaS(HoraSalidaComoCadena);
                                        System.out.println("#################### FECH hora_salida_comision" + HoraSalidaComoCadena);
                                        break;
                                        
                                    case "fecha_hora_regreso":
                                        String FechaRegresoComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaRegresoComoCadena);
                                        System.out.println("#################### FECH fecha_hora_regreso" + FechaRegresoComoCadena);
                                        break;
                                        
                                    case "hora_regreso_comision":
                                        String HoraRegresoComoCadena = formatoHora.format(comision.getValorFecha());
                                        comision.setValorFechaS(HoraRegresoComoCadena);
                                        System.out.println("#################### FECH hora_salida_comision" + HoraRegresoComoCadena);
                                        break;
                                        
                                    case "fecha_solicitud_comision":
                                        String FechaSolicitudComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaSolicitudComoCadena);
                                        System.out.println("#################### FECH fecha_solicitud_comision" + FechaSolicitudComoCadena);
                                        break;
                                        
                                    case "fecha_solicitud_viaticos":
                                        String FechaSolicitudViaticosComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaSolicitudViaticosComoCadena);
                                        System.out.println("#################### FECH fecha_solicitud_viaticos" + FechaSolicitudViaticosComoCadena);
                                        break;
                                        
                                    case "fecha_desglose_gastos":
                                        String FechaDesgloseComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaDesgloseComoCadena);
                                        System.out.println("#################### FECH fecha_desglose_gastos" + FechaDesgloseComoCadena);
                                        break;
                                    
                                    case "fecha_compra_p_ida":
                                        String FechaCompraComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaCompraComoCadena);
                                        System.out.println("#################### FECH fecha_desglose_gastos" + FechaCompraComoCadena);
                                        break;
                                        
                                    case "fecha_compra_p_vuelta":
                                        String FechaCompraVueltaComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaCompraVueltaComoCadena);
                                        System.out.println("#################### FECH fecha_desglose_gastos" + FechaCompraVueltaComoCadena);
                                        break;
                                    case "fecha_informe_comision":
                                        String FechaInformeComisionComoCadena = formatoFecha.format(comision.getValorFecha());
                                        comision.setValorFechaS(FechaInformeComisionComoCadena);
                                        System.out.println("#################### FECH fecha_desglose_gastos" + FechaInformeComisionComoCadena);
                                        break;    
                                } 
                            }
                        }                        
			request.setAttribute("detalle", detalle);
			request.setAttribute("instance", sInstance);
			request.setAttribute("id", sTask);                        
                        
			
			destino = "workflows/detalleNotificacion.jsp";
		} else if (action.equals("responde")) {
			String resp = request.getParameter("resp");
			String sInstance = request.getParameter("instance");
			String sTask = request.getParameter("id");
			String comentarios = request.getParameter("comentarios");
			SesionVO sesion = (SesionVO)request.getSession().getAttribute("sesion");
			
			Long instanceId = Long.parseLong(sInstance);
			Long task = Long.parseLong(sTask);
			
			FlujosInstanciasVO instancia = bonServ.obtenerInstancia(instanceId);
			
			BonitaErrorVO error = null;
			//System.out.println("********* Que boton fue: " + resp);
			
			if (resp != null) {
				if (resp.equals("Aprobar")) {
					error = bonServ.respondeNotificacion(instancia, task, sesion.getUsuario(), true, comentarios);
                                        String cve = request.getParameter("denomCve");
                                        if(cve != null && !cve.equals("N/A")){
                                            notServ.insertarActualizarComisionDetalle(instancia.getComision().getId(), "", "denominacion_pviaticos", null, Double.parseDouble(cve), null);
                                        }                                        
				} else if (resp.equals("Rechazar")) {
					error = bonServ.respondeNotificacion(instancia, task, sesion.getUsuario(), false, comentarios);
				}
			}
			
			UsuarioVO usuario = usServ.obtenerUsuario(sesion.getUsuario());
			
			List<NotificacionVO> notificaciones = bonServ.obtenerTareasPendientes(usuario);
			request.setAttribute("notificaciones", notificaciones);
			
			if (error != null) {
				request.setAttribute("mensaje", error.getMensaje());
			}
			
			destino = "workflows/listarNotificaciones.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
