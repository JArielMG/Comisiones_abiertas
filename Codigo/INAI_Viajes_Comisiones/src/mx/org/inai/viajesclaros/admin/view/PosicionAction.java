package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.PosicionVO;
import mx.org.inai.viajesclaros.admin.service.PosicionServices;

/**
 * Servlet implementation class PosicionAction
 */
@WebServlet(name = "PosicionAction" , urlPatterns = { "/posicionAction" })
public class PosicionAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PosicionServices posSrv = new PosicionServices();
       
    public PosicionAction() {
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
			ArrayList<PosicionVO> posiciones = posSrv.obtenerPosiciones();
			request.setAttribute("posiciones", posiciones);
            destino = "catalogos/listarPosiciones.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PosicionVO param = new PosicionVO();
			param.setId(id);
			
			PosicionVO posicion = posSrv.obtenerPosicion(param);
			request.setAttribute("posicion", posicion);
			request.setAttribute("comando", "update");
			
			destino = "catalogos/detallePosicion.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PosicionVO param = new PosicionVO();
			param.setId(id);
			
			Integer res = posSrv.eliminaPosicion(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<PosicionVO> posiciones = posSrv.obtenerPosiciones();
			request.setAttribute("posiciones", posiciones);
            destino = "catalogos/listarPosiciones.jsp";
			
		} else if (action.equals("agregar")) {
			destino = "catalogos/detallePosicion.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			
			if (sid == null || nombre == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				
				PosicionVO posicion = new PosicionVO();
				posicion.setId(id);
				posicion.setNombre(nombre);
				
				Integer res = posSrv.actualizaPosicion(posicion);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<PosicionVO> posiciones = posSrv.obtenerPosiciones();
				request.setAttribute("posiciones", posiciones);
	            destino = "catalogos/listarPosiciones.jsp";
				
			} 
			
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			
			if (nombre == null) {
				request.setAttribute("mensaje", "Informaci&oaucte;n insuficiente para la actualizaci&oacute;n");
			} else {
				PosicionVO posicion = new PosicionVO();
				posicion.setNombre(nombre);
				
				Integer res = posSrv.insertaPosicion(posicion);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
				
				ArrayList<PosicionVO> posiciones = posSrv.obtenerPosiciones();
				request.setAttribute("posiciones", posiciones);
	            destino = "catalogos/listarPosiciones.jsp";
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
