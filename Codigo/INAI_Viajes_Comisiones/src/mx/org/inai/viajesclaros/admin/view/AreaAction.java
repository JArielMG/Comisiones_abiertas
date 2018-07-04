package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.service.AreaServices;
import mx.org.inai.viajesclaros.admin.service.DependenciaServices;

/**
 * Servlet implementation class AreaAction
 */
@WebServlet(name = "AreaAction" , urlPatterns = { "/areaAction" })
public class AreaAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private AreaServices areaSrv = new AreaServices();
	private DependenciaServices depenServ = new DependenciaServices();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AreaAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String destino = "login.jsp";
		String action = request.getParameter("action");
		
		if (action == null) {
			action = "listar";
		}
		
		if (action.equals("listar")) {
			ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
			request.setAttribute("areas", areas);
            destino = "catalogos/listarAreas.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			AreaVO param = new AreaVO();
			param.setId(id);
			
			AreaVO area = areaSrv.obtenerArea(param);
			ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
			
			request.setAttribute("area", area);
			
			request.setAttribute("comando", "update");
			request.setAttribute("dependencias", dependencias);
			
			destino = "catalogos/detalleArea.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			AreaVO param = new AreaVO();
			param.setId(id);
			
			Integer res = areaSrv.eliminaArea(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
			request.setAttribute("areas", areas);
            destino = "catalogos/listarAreas.jsp";
            
		} else if (action.equals("agregar")) {
			ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
			request.setAttribute("dependencias", dependencias);
			
			destino = "catalogos/detalleArea.jsp";
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			String sDep = request.getParameter("dependencia");
			
			if (sid == null || nombre == null || sDep == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer depId = Integer.parseInt(sDep);
				
				DependenciaVO paramDep = new DependenciaVO();
				paramDep.setId(depId);
				
				DependenciaVO dependencia = depenServ.obtenerDependencia(paramDep);
				
				AreaVO area = new AreaVO();
				area.setId(id);
				area.setNombre(nombre);
				area.setDependencia(dependencia);
				
				Integer res = areaSrv.actualizaArea(area);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
			}
			
			ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
			request.setAttribute("areas", areas);
            destino = "catalogos/listarAreas.jsp";
			
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			String sDep = request.getParameter("dependencia");
			
			if (nombre == null || sDep == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
			} else {
				Integer depId = Integer.parseInt(sDep);
				
				DependenciaVO paramDep = new DependenciaVO();
				paramDep.setId(depId);
				
				DependenciaVO dependencia = depenServ.obtenerDependencia(paramDep);
				
				AreaVO area = new AreaVO();
				area.setNombre(nombre);
				area.setDependencia(dependencia);
				
				Integer res = areaSrv.insertaArea(area);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
			}
			
			ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
			request.setAttribute("areas", areas);
            destino = "catalogos/listarAreas.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
