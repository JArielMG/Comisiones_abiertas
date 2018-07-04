package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.service.DependenciaServices;

/**
 * Servlet implementation class DependenciaAction
 */
@WebServlet(name = "DependenciaAction" , urlPatterns = { "/dependenciaAction" })
public class DependenciaAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DependenciaServices depenServ = new DependenciaServices();
       
    public DependenciaAction() {
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
			ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
			request.setAttribute("dependencias", dependencias);
            destino = "catalogos/listarDependencias.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			DependenciaVO param = new DependenciaVO();
			param.setId(id);
			
			DependenciaVO dependencia = depenServ.obtenerDependencia(param);
			request.setAttribute("dependencia", dependencia);
			request.setAttribute("comando", "update");
			request.setAttribute("activa", dependencia.getPredeterminada()?"checked":"");
			
			destino = "catalogos/detalleDependencia.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			DependenciaVO param = new DependenciaVO();
			param.setId(id);
			
			Integer res = depenServ.eliminaDependencia(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
			request.setAttribute("dependencias", dependencias);
            destino = "catalogos/listarDependencias.jsp";
			
		} else if (action.equals("agregar")) {
			destino = "catalogos/detalleDependencia.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String siglas = request.getParameter("siglas");
			String nombre = request.getParameter("nombre");
			Boolean predeterminada = request.getParameter("predeterminada") != null;
			
			if (sid == null || siglas == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				
				DependenciaVO dependencia = new DependenciaVO();
				dependencia.setId(id);
				dependencia.setSiglas(siglas);
				dependencia.setNombre(nombre);
				dependencia.setPredeterminada(predeterminada);
				
				Integer res = depenServ.actualizaDependencia(dependencia);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
				request.setAttribute("dependencias", dependencias);
	            destino = "catalogos/listarDependencias.jsp";
				
			}
			
		} else if (action.equals("ingresa")) {
			String siglas = request.getParameter("siglas");
			String nombre = request.getParameter("nombre");
			Boolean predeterminada = request.getParameter("predeterminada") != null;
			
			if (siglas == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oaucte;n insuficiente para la actualizaci&oacute;n");
			} else {
				DependenciaVO dependencia = new DependenciaVO();
				dependencia.setSiglas(siglas);
				dependencia.setNombre(nombre);
				dependencia.setPredeterminada(predeterminada);
				
				Integer res = depenServ.insertaDependencia(dependencia);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
				
				ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
				request.setAttribute("dependencias", dependencias);
	            destino = "catalogos/listarDependencias.jsp";
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
