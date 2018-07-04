package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.EstadoVO;
import mx.org.inai.viajesclaros.admin.model.PaisVO;
import mx.org.inai.viajesclaros.admin.service.EstadoServices;
import mx.org.inai.viajesclaros.admin.service.PaisServices;

/**
 * Servlet implementation class EstadoAction
 */
@WebServlet(name = "EstadoAction" , urlPatterns = { "/estadoAction" })
public class EstadoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EstadoServices edoSrv = new EstadoServices();
	private PaisServices paisSrv = new PaisServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EstadoAction() {
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
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
			request.setAttribute("estados", estados);
            destino = "catalogos/listarEstados.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			EstadoVO param = new EstadoVO();
			param.setId(id);
			
			EstadoVO estado = edoSrv.obtenerEstado(param);
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			
			request.setAttribute("estado", estado);
			request.setAttribute("comando", "update");
			request.setAttribute("paises", paises);
			
			destino = "catalogos/detalleEstado.jsp";
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			EstadoVO param = new EstadoVO();
			param.setId(id);
			
			Integer res = edoSrv.eliminaEstado(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
			request.setAttribute("estados", estados);
            destino = "catalogos/listarEstados.jsp";
			
		} else if (action.equals("agregar")) {
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			request.setAttribute("paises", paises);
			
			destino = "catalogos/detalleEstado.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			String sPais = request.getParameter("pais");
			
			if (sid == null || nombre == null || sPais == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer paisId = Integer.parseInt(sPais);
				
				PaisVO paramPais = new PaisVO();
				paramPais.setId(paisId);
				
				PaisVO pais = paisSrv.obtenerPais(paramPais);
				
				EstadoVO estado = new EstadoVO();
				estado.setId(id);
				estado.setNombre(nombre);
				estado.setPais(pais);
				
				Integer res = edoSrv.actualizaEstado(estado);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
			
			}
			
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
			request.setAttribute("estados", estados);
            destino = "catalogos/listarEstados.jsp";
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			String sPais = request.getParameter("pais");
			
			if (nombre == null || sPais == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
			} else {
				Integer paisId = Integer.parseInt(sPais);
				
				PaisVO paramPais = new PaisVO();
				paramPais.setId(paisId);
				
				PaisVO pais = paisSrv.obtenerPais(paramPais);
				
				EstadoVO estado = new EstadoVO();
				estado.setNombre(nombre);
				estado.setPais(pais);
				
				Integer res = edoSrv.insertaEstado(estado);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
			
			}
			
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
			request.setAttribute("estados", estados);
            destino = "catalogos/listarEstados.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
