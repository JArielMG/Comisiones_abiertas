package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;


//import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.CategoriaVO;
import mx.org.inai.viajesclaros.admin.service.CategoryServices;

/**
 * Servlet implementation class CategoryAction
 */
@WebServlet(name = "CategoryAction" , urlPatterns = { "/categoryAction" })
public class CategoryAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CategoryServices categServ = new CategoryServices();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
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
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			request.setAttribute("categorias", categorias);
            destino = "catalogos/listarCategorias.jsp";
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			CategoriaVO param = new CategoriaVO();
			param.setId(id);
			
			CategoriaVO categoria = categServ.obtenCategoria(param);
			
			request.setAttribute("categoria", categoria);
			request.setAttribute("comando", "update");
			
			destino = "catalogos/detalleCategoria.jsp";
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			CategoriaVO param = new CategoriaVO();
			param.setId(id);
			
			Integer res = categServ.eliminaCategoria(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			request.setAttribute("categorias", categorias);
            destino = "catalogos/listarCategorias.jsp";
		} else if (action.equals("agregar")) {
			destino = "catalogos/detalleCategoria.jsp";
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			String sHosp = request.getParameter("hospedaje");
			String sViat = request.getParameter("viaticos");
			
			if (sid == null || nombre == null || sHosp == null || sViat == null) {
				request.setAttribute("mensaje", "Informaci&oaucte;n insuficiente para la actualizaci&oacute;n");
				
			} else {
				Integer id = Integer.parseInt(sid);
				Double hospedaje = Double.parseDouble(sHosp);
				Double viaticos = Double.parseDouble(sViat);
				
				CategoriaVO param = new CategoriaVO();
				param.setId(id);
				param.setNombre(nombre);
				param.setTopeHospedaje(hospedaje);
				param.setTopeViaticos(viaticos);
				
				Integer res = categServ.actualizaCategoria(param);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
			}
			
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			request.setAttribute("categorias", categorias);
            destino = "catalogos/listarCategorias.jsp";
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			String sHosp = request.getParameter("hospedaje");
			String sViat = request.getParameter("viaticos");
			
			if (nombre == null || sHosp == null || sViat == null) {
				request.setAttribute("mensaje", "Informaci&oaucte;n insuficiente para la inserci&oacute;n");
				
			} else {
				Double hospedaje = Double.parseDouble(sHosp);
				Double viaticos = Double.parseDouble(sViat);
				
				CategoriaVO param = new CategoriaVO();
				param.setNombre(nombre);
				param.setTopeHospedaje(hospedaje);
				param.setTopeViaticos(viaticos);
				
				Integer res = categServ.insertaCategoria(param);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al insertar el registro");
				}
			}
			
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			request.setAttribute("categorias", categorias);
            destino = "catalogos/listarCategorias.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
