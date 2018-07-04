package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.JerarquiaVO;
import mx.org.inai.viajesclaros.admin.service.JerarquiaServices;

/**
 * Servlet implementation class JerarquiaAction
 */
@WebServlet(name = "JerarquiaAction", urlPatterns = { "/jerarquiaAction" })
public class JerarquiaAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private JerarquiaServices jerarServ = new JerarquiaServices();
    
    public JerarquiaAction() {
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
			ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
			request.setAttribute("jerarquias", jerarquias);
            destino = "workflows/listarJerarquias.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			JerarquiaVO param = new JerarquiaVO();
			param.setId(id);
			
			JerarquiaVO jerarquia = jerarServ.obtenerJerarquia(param);
			request.setAttribute("jerarquia", jerarquia);
			request.setAttribute("comando", "update");
			
			destino = "workflows/detalleJerarquia.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			JerarquiaVO param = new JerarquiaVO();
			param.setId(id);
			
			Integer res = jerarServ.eliminaJerarquia(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
			request.setAttribute("jerarquias", jerarquias);
            destino = "workflows/listarJerarquias.jsp";
			
		} else if (action.equals("agregar")) {
			destino = "workflows/detalleJerarquia.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			
			if (sid == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				
				JerarquiaVO jerarquia = new JerarquiaVO();
				jerarquia.setId(id);
				jerarquia.setNombre(nombre);
				
				Integer res = jerarServ.actualizaJerarquia(jerarquia);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
				request.setAttribute("jerarquias", jerarquias);
	            destino = "workflows/listarJerarquias.jsp";
				
			}
			
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			
			if (nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				
				JerarquiaVO jerarquia = new JerarquiaVO();
				jerarquia.setNombre(nombre);
				
				Integer res = jerarServ.insertaJerarquia(jerarquia);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
				
				ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
				request.setAttribute("jerarquias", jerarquias);
	            destino = "workflows/listarJerarquias.jsp";
				
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
