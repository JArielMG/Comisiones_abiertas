package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.PaisVO;
import mx.org.inai.viajesclaros.admin.service.PaisServices;

/**
 * Servlet implementation class PaisAction
 */
@WebServlet(name = "PaisAction" , urlPatterns = { "/paisAction" })
public class PaisAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PaisServices paisSrv = new PaisServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaisAction() {
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
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			request.setAttribute("paises", paises);
            destino = "catalogos/listarPaises.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PaisVO param = new PaisVO();
			param.setId(id);
			
			PaisVO pais = paisSrv.obtenerPais(param);
			
			request.setAttribute("pais", pais);
			request.setAttribute("comando", "update");
			request.setAttribute("activa", pais.getPredeterminado()?"checked":"");
			
			destino = "catalogos/detallePais.jsp";
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PaisVO param = new PaisVO();
			param.setId(id);
			
			Integer res = paisSrv.eliminaPais(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			request.setAttribute("paises", paises);
            destino = "catalogos/listarPaises.jsp";
            
		} else if (action.equals("agregar")) {
			destino = "catalogos/detallePais.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String clave = request.getParameter("clave");
			String nombre = request.getParameter("nombre");
			Boolean predeterminado = request.getParameter("predeterminado") != null;
			
			if (sid == null || clave == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
				
			} else {
				Integer id = Integer.parseInt(sid);
				
				PaisVO pais = new PaisVO();
				pais.setId(id);
				pais.setClave(clave);
				pais.setNombre(nombre);
				pais.setPredeterminado(predeterminado);
				
				Integer res = paisSrv.actualizaPais(pais);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
				request.setAttribute("paises", paises);
	            destino = "catalogos/listarPaises.jsp";
				
			}
		} else if (action.equals("ingresa")) {
			String clave = request.getParameter("clave");
			String nombre = request.getParameter("nombre");
			Boolean predeterminado = request.getParameter("predeterminado") != null;
			
			if (clave == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
				
			} else {
				PaisVO pais = new PaisVO();
				pais.setClave(clave);
				pais.setNombre(nombre);
				pais.setPredeterminado(predeterminado);
				
				Integer res = paisSrv.insertaPais(pais);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
				
				ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
				request.setAttribute("paises", paises);
	            destino = "catalogos/listarPaises.jsp";
				
			}
			
		}
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
