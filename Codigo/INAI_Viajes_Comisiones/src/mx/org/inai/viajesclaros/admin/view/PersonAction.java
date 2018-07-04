package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.CategoriaVO;
import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.PosicionVO;
import mx.org.inai.viajesclaros.admin.model.TipoPersonaVO;
import mx.org.inai.viajesclaros.admin.service.CategoryServices;
import mx.org.inai.viajesclaros.admin.service.PersonaServices;
import mx.org.inai.viajesclaros.admin.service.PosicionServices;

/**
 * Servlet implementation class PersonAction
 */
@WebServlet(name = "PersonAction" , urlPatterns = { "/personAction" })
public class PersonAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PersonaServices personServ = new PersonaServices();
	private CategoryServices categServ = new CategoryServices();
	private PosicionServices posServ = new PosicionServices();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PersonAction() {
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
			action = "listarTipos";
		}
		
		if (action.equals("listarTipos")) {
			ArrayList<TipoPersonaVO> tipos = personServ.obtenerTiposPersonas();
			request.setAttribute("tipos", tipos);
            destino = "catalogos/listarTiposPersonas.jsp";
		} else if (action.equals("listarPersonas")) {
			ArrayList<PersonaVO> personas = personServ.obtenerPersonas();
			request.setAttribute("personas", personas);
            destino = "catalogos/listarPersonas.jsp";
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PersonaVO param = new PersonaVO();
			param.setId(id);
			
			PersonaVO persona = personServ.obtenPersona(param);
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			ArrayList<TipoPersonaVO> tipos_persona = personServ.obtenerTiposPersonas();
			ArrayList<PosicionVO> posiciones = posServ.obtenerPosiciones();
			
			request.setAttribute("persona", persona);
			request.setAttribute("categorias", categorias);
			request.setAttribute("tipos_personas", tipos_persona);
			request.setAttribute("posiciones", posiciones);
			request.setAttribute("comando", "update");
			
			destino = "catalogos/detallePersona.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			PersonaVO param = new PersonaVO();
			param.setId(id);
			
			Integer res = personServ.eliminaPersona(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<PersonaVO> personas = personServ.obtenerPersonas();
			request.setAttribute("personas", personas);
            destino = "catalogos/listarPersonas.jsp";
			
		} else if (action.equals("agregar")) {
			ArrayList<CategoriaVO> categorias = categServ.obtenerCategorias();
			ArrayList<TipoPersonaVO> tipos_persona = personServ.obtenerTiposPersonas();
			ArrayList<PosicionVO> posiciones = posServ.obtenerPosiciones();
			
			request.setAttribute("categorias", categorias);
			request.setAttribute("tipos_personas", tipos_persona);
			request.setAttribute("posiciones", posiciones);
			
			destino = "catalogos/detallePersona.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombres = request.getParameter("nombres");
			String apPaterno = request.getParameter("apPaterno");
			String apMaterno = request.getParameter("apMaterno");
			String titulo = request.getParameter("titulo");
			String correo = request.getParameter("correo");
			String sCat = request.getParameter("categoria");
			String sTipo = request.getParameter("tipo_persona");
			String sPosic = request.getParameter("posicion");
			String cargo = request.getParameter("cargo");
			String fechaIngreso = request.getParameter("fechaIngreso");
			
			if (sid == null || nombres == null || apPaterno == null || 
					correo == null || sCat == null || sTipo == null || fechaIngreso == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer categ = Integer.parseInt(sCat);
				Integer tipo = Integer.parseInt(sTipo);
				Integer posic = Integer.parseInt(sPosic);
				DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
				CategoriaVO paramCat = new CategoriaVO();
				paramCat.setId(categ);
				TipoPersonaVO paramTipo = new TipoPersonaVO();
				paramTipo.setId(tipo);
				PosicionVO paramPos = new PosicionVO();
				paramPos.setId(posic);
				
				CategoriaVO categoria = categServ.obtenCategoria(paramCat);
				TipoPersonaVO tipoPersona = personServ.obtenerTipoPersona(paramTipo);
				PosicionVO posicion = posServ.obtenerPosicion(paramPos);
				
				PersonaVO persona = new PersonaVO();
				persona.setId(id);
				persona.setNombres(nombres);
				persona.setApellidoPaterno(apPaterno);
				persona.setApellidoMaterno(apMaterno);
				persona.setTitulo(titulo);
				persona.setEmail(correo);
				persona.setCategoria(categoria);
				persona.setTipoPersona(tipoPersona);
				persona.setPosicion(posicion);
				persona.setCargo(cargo);
				try {
					persona.setFechaIngreso(formatter.parse(fechaIngreso));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				Integer res = personServ.actualizaPersona(persona);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
			}
			
			ArrayList<PersonaVO> personas = personServ.obtenerPersonas();
			request.setAttribute("personas", personas);
            destino = "catalogos/listarPersonas.jsp";
            
		} else if (action.equals("ingresa")) {
			String nombres = request.getParameter("nombres");
			String apPaterno = request.getParameter("apPaterno");
			String apMaterno = request.getParameter("apMaterno");
			String titulo = request.getParameter("titulo");
			String correo = request.getParameter("correo");
			String sCat = request.getParameter("categoria");
			String sTipo = request.getParameter("tipo_persona");
			String sPosic = request.getParameter("posicion");
			String cargo = request.getParameter("cargo");
			String fechaIngreso = request.getParameter("fechaIngreso");
			
			if (nombres == null || apPaterno == null || correo == null || 
					sCat == null || sTipo == null || fechaIngreso == null) {
				request.setAttribute("mensaje", "Informaci&oaucte;n insuficiente para la inserci&oacute;n");
			} else {
				Integer categ = Integer.parseInt(sCat);
				Integer tipo = Integer.parseInt(sTipo);
				Integer posic = Integer.parseInt(sPosic);
				
				CategoriaVO paramCat = new CategoriaVO();
				paramCat.setId(categ);
				TipoPersonaVO paramTipo = new TipoPersonaVO();
				paramTipo.setId(tipo);
				PosicionVO paramPos = new PosicionVO();
				paramPos.setId(posic);
				DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				
				CategoriaVO categoria = categServ.obtenCategoria(paramCat);
				TipoPersonaVO tipoPersona = personServ.obtenerTipoPersona(paramTipo);
				PosicionVO posicion = posServ.obtenerPosicion(paramPos);
				
				PersonaVO persona = new PersonaVO();
				persona.setNombres(nombres);
				persona.setApellidoPaterno(apPaterno);
				persona.setApellidoMaterno(apMaterno);
				persona.setTitulo(titulo);
				persona.setEmail(correo);
				persona.setCategoria(categoria);
				persona.setTipoPersona(tipoPersona);
				persona.setPosicion(posicion);
				persona.setCargo(cargo);
				try {
					persona.setFechaIngreso(formatter.parse(fechaIngreso));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				Integer res = personServ.insertaPersona(persona);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al insertar el registro");
				}
			}
			
			ArrayList<PersonaVO> personas = personServ.obtenerPersonas();
			request.setAttribute("personas", personas);
            destino = "catalogos/listarPersonas.jsp";
            
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
