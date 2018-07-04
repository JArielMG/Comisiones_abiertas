package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.BonitaErrorVO;
import mx.org.inai.viajesclaros.admin.model.FlujosInstanciasVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionDetalleVO;
import mx.org.inai.viajesclaros.admin.model.NotificacionVO;
import mx.org.inai.viajesclaros.admin.model.SesionVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.BonitaServices;
import mx.org.inai.viajesclaros.admin.service.NotificacionServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;

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
