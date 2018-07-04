package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.CiudadVO;
import mx.org.inai.viajesclaros.admin.model.EstadoVO;
import mx.org.inai.viajesclaros.admin.model.PaisVO;
import mx.org.inai.viajesclaros.admin.service.CiudadServices;
import mx.org.inai.viajesclaros.admin.service.EstadoServices;
import mx.org.inai.viajesclaros.admin.service.PaisServices;

/**
 * Servlet implementation class CiudadAction
 */
@WebServlet(name = "CiudadAction" , urlPatterns = { "/ciudadAction" })
public class CiudadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CiudadServices ciuSrv = new CiudadServices();
	private EstadoServices edoSrv = new EstadoServices();
	private PaisServices paisSrv = new PaisServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CiudadAction() {
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
			ArrayList<CiudadVO> ciudades = ciuSrv.obtenerCiudades();
			request.setAttribute("ciudades", ciudades);
            destino = "catalogos/listarCiudades.jsp";
            
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			
			CiudadVO param = new CiudadVO();
			param.setId(id);
			
			CiudadVO ciudad = ciuSrv.obtenerCiudad(param);
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
					
			request.setAttribute("ciudad", ciudad);
			request.setAttribute("comando", "update");
			request.setAttribute("paises", paises);
			request.setAttribute("estados", estados);
			
			destino = "catalogos/detalleCiudad.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			
			CiudadVO param = new CiudadVO();
			param.setId(id);
			
			Integer res = ciuSrv.eliminaCiudad(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<CiudadVO> ciudades = ciuSrv.obtenerCiudades();
			request.setAttribute("ciudades", ciudades);
            destino = "catalogos/listarCiudades.jsp";
            
		} else if (action.equals("agregar")) {
			ArrayList<PaisVO> paises = paisSrv.obtenerPaises();
			ArrayList<EstadoVO> estados = edoSrv.obtenerEstados();
			
			request.setAttribute("paises", paises);
			request.setAttribute("estados", estados);
			
			destino = "catalogos/detalleCiudad.jsp";
		
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			String sEdo = request.getParameter("estado");
			String sPais = request.getParameter("pais");
			String latitud = request.getParameter("latitud");
			String longitud = request.getParameter("longitud");
			
			if (sid == null || nombre == null || sEdo == null || sPais == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer paisId = Integer.parseInt(sPais);
				Integer edoId = Integer.parseInt(sEdo);
				
				PaisVO paramPais = new PaisVO();
				paramPais.setId(paisId);
				
				PaisVO pais = paisSrv.obtenerPais(paramPais);
				
				EstadoVO paramEdo = new EstadoVO();
				paramEdo.setId(edoId);
				
				EstadoVO estado = edoSrv.obtenerEstado(paramEdo);
				
				CiudadVO ciudad = new CiudadVO();
				ciudad.setId(id);
				ciudad.setNombre(nombre);
				ciudad.setPais(pais);
				ciudad.setEstado(estado);
				ciudad.setLatitud(latitud);
				ciudad.setLongitud(longitud);
				
				Integer res = ciuSrv.actualizaCiudad(ciudad);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
			}
			
			ArrayList<CiudadVO> ciudades = ciuSrv.obtenerCiudades();
			request.setAttribute("ciudades", ciudades);
            destino = "catalogos/listarCiudades.jsp";
			
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			String sEdo = request.getParameter("estado");
			String sPais = request.getParameter("pais");
			String latitud = request.getParameter("latitud");
			String longitud = request.getParameter("longitud");
			
			if (nombre == null || sEdo == null || sPais == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
			} else {
				Integer paisId = Integer.parseInt(sPais);
				Integer edoId = Integer.parseInt(sEdo);
				
				PaisVO paramPais = new PaisVO();
				paramPais.setId(paisId);
				
				PaisVO pais = paisSrv.obtenerPais(paramPais);
				
				EstadoVO paramEdo = new EstadoVO();
				paramEdo.setId(edoId);
				
				EstadoVO estado = edoSrv.obtenerEstado(paramEdo);
				
				CiudadVO ciudad = new CiudadVO();
				ciudad.setNombre(nombre);
				ciudad.setPais(pais);
				ciudad.setEstado(estado);
				ciudad.setLatitud(latitud);
				ciudad.setLongitud(longitud);
				
				Integer res = ciuSrv.insertaCiudad(ciudad);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al ingresar el registro");
				}
				
			}
			
			ArrayList<CiudadVO> ciudades = ciuSrv.obtenerCiudades();
			request.setAttribute("ciudades", ciudades);
            destino = "catalogos/listarCiudades.jsp";
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
