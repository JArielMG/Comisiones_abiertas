package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.util.Factory;

import mx.org.inai.viajesclaros.admin.model.AreaVO;
import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.model.PerfilVO;
import mx.org.inai.viajesclaros.admin.model.PersonaVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.AreaServices;
import mx.org.inai.viajesclaros.admin.service.DependenciaServices;
import mx.org.inai.viajesclaros.admin.service.PersonaServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;

/**
 * Servlet implementation class UserAction
 */
@WebServlet(name = "UserAction" , urlPatterns = { "/userAction" })
public class UserAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserServices userSrv = new UserServices();
	private AreaServices areaSrv = new AreaServices();
	private DependenciaServices depenServ = new DependenciaServices();
	private PersonaServices perServ = new PersonaServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserAction() {
        super();
        Factory<org.apache.shiro.mgt.SecurityManager> factory = new IniSecurityManagerFactory();
		org.apache.shiro.mgt.SecurityManager securityManager = factory.getInstance();
		SecurityUtils.setSecurityManager(securityManager);
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
			action = "listarPerfiles";
		}
		
		System.out.println("Request: " + request);
		System.out.println("Response: " + response);
		
		if (request == null || response == null) {
			response.sendRedirect(destino);
		} else {
		
			if (action.equals("listarPerfiles")) {
				ArrayList<PerfilVO> perfiles = userSrv.obtenerPerfiles();
				request.setAttribute("perfiles", perfiles);
	            destino = "catalogos/listarPerfiles.jsp";
	            
			} else if (action.equals("listarUsuarios")) {
				ArrayList<UsuarioVO> usuarios = userSrv.obtenerUsuarios();
				request.setAttribute("usuarios", usuarios);
	            destino = "catalogos/listarUsuarios.jsp";
	            
			} else if (action.equals("modificar")) {
				String sid = request.getParameter("id");
				Integer id = Integer.parseInt(sid);
				UsuarioVO param = new UsuarioVO();
				param.setId(id);
				
				UsuarioVO usuario = userSrv.obtenerUsuario(param);
				ArrayList<PerfilVO> perfiles = userSrv.obtenerPerfiles();
				ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
				ArrayList<PersonaVO> personas = perServ.obtenerPersonas();
				ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
				
				request.setAttribute("usuario", usuario);
				request.setAttribute("comando", "update");
				request.setAttribute("perfiles", perfiles);
				request.setAttribute("dependencias", dependencias);
				request.setAttribute("personas", personas);
				request.setAttribute("areas", areas);
				request.setAttribute("activa", usuario.getHabilitado()?"checked":"");
				request.setAttribute("es_jefe", usuario.getJefeArea()?"checked":"");
				
				destino = "catalogos/detalleUsuario.jsp";
				
			} else if (action.equals("borrar")) {
				String sid = request.getParameter("id");
				Integer id = Integer.parseInt(sid);
				
				UsuarioVO param = new UsuarioVO();
				param.setId(id);
				
				Integer res = userSrv.eliminaUsuario(param);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al eliminar el registro");
				}
				
				ArrayList<UsuarioVO> usuarios = userSrv.obtenerUsuarios();
				request.setAttribute("usuarios", usuarios);
	            destino = "catalogos/listarUsuarios.jsp";
	            
			} else if (action.equals("agregar")) {
				ArrayList<PerfilVO> perfiles = userSrv.obtenerPerfiles();
				ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
				ArrayList<PersonaVO> personas = perServ.obtenerPersonas();
				ArrayList<AreaVO> areas = areaSrv.obtenerAreas();
				
				request.setAttribute("perfiles", perfiles);
				request.setAttribute("dependencias", dependencias);
				request.setAttribute("personas", personas);
				request.setAttribute("areas", areas);
				
				destino = "catalogos/detalleUsuario.jsp";
				
			} else if (action.equals("actualiza")) {
				String sid = request.getParameter("id");
				String usu = request.getParameter("usuario");
				String descripcion = request.getParameter("descripcion");
				Boolean habilitado = request.getParameter("habilitado") != null;
				String sPerf = request.getParameter("perfil");
				String sPers = request.getParameter("persona");
				String sDep = request.getParameter("dependencia");
				String sArea = request.getParameter("area");
				Boolean jefeArea = request.getParameter("jefe") != null;
				
				if (sid == null || usu == null || sPerf == null || sDep == null || sArea == null) {
					request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
				} else {
					Integer id = Integer.parseInt(sid);
					Integer perfId = Integer.parseInt(sPerf);
					Integer persId = Integer.parseInt(sPers);
					Integer depId = Integer.parseInt(sDep);
					Integer areaId = Integer.parseInt(sArea);
					
					PerfilVO paramPerf = new PerfilVO();
					paramPerf.setId(perfId);
					PersonaVO paramPers = new PersonaVO();
					paramPers.setId(persId);
					DependenciaVO paramDep = new DependenciaVO();
					paramDep.setId(depId);
					AreaVO paramArea = new AreaVO();
					paramArea.setId(areaId);
					
					PerfilVO perfil = userSrv.obtenerPerfil(paramPerf);
					PersonaVO persona = perServ.obtenPersona(paramPers);
					DependenciaVO dependencia = depenServ.obtenerDependencia(paramDep);
					AreaVO area = areaSrv.obtenerArea(paramArea);
					
					UsuarioVO usuario = new UsuarioVO();
					usuario.setId(id);
					usuario.setUsuario(usu);
					usuario.setDescripcion(descripcion);
					usuario.setHabilitado(habilitado);
					usuario.setPerfil(perfil);
					usuario.setPersona(persona);
					usuario.setDependencia(dependencia);
					usuario.setArea(area);
					usuario.setJefeArea(jefeArea);
					
					Integer res = userSrv.actualizaUsuario(usuario);
					
					if (res != 0) {
						request.setAttribute("mensaje", "Error al actualizar el registro");
					}
					
				}
				
				ArrayList<UsuarioVO> usuarios = userSrv.obtenerUsuarios();
				request.setAttribute("usuarios", usuarios);
	            destino = "catalogos/listarUsuarios.jsp";
				
			} else if (action.equals("ingresa")) {
				String usu = request.getParameter("usuario");
				String contr = request.getParameter("contrasena");
				String confir = request.getParameter("confirma");
				String descripcion = request.getParameter("descripcion");
				Boolean habilitado = request.getParameter("habilitado") != null;
				String sPerf = request.getParameter("perfil");
				String sPers = request.getParameter("persona");
				String sDep = request.getParameter("dependencia");
				String sArea = request.getParameter("area");
				Boolean jefeArea = request.getParameter("jefe") != null;
				
				if (!contr.equals(confir)) {
					request.setAttribute("mensaje", "Contrase&ntilde;a no coincide");
					
				} else {
					if (usu == null || sPerf == null || sDep == null || sArea == null) {
						request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
					} else {
						Integer perfId = Integer.parseInt(sPerf);
						Integer persId = Integer.parseInt(sPers);
						Integer depId = Integer.parseInt(sDep);
						Integer areaId = Integer.parseInt(sArea);
						
						PerfilVO paramPerf = new PerfilVO();
						paramPerf.setId(perfId);
						PersonaVO paramPers = new PersonaVO();
						paramPers.setId(persId);
						DependenciaVO paramDep = new DependenciaVO();
						paramDep.setId(depId);
						AreaVO paramArea = new AreaVO();
						paramArea.setId(areaId);
						
						PerfilVO perfil = userSrv.obtenerPerfil(paramPerf);
						PersonaVO persona = perServ.obtenPersona(paramPers);
						DependenciaVO dependencia = depenServ.obtenerDependencia(paramDep);
						AreaVO area = areaSrv.obtenerArea(paramArea);
						
						UsuarioVO usuario = new UsuarioVO();
						usuario.setUsuario(usu);
						usuario.setContra(contr);
						usuario.setDescripcion(descripcion);
						usuario.setHabilitado(habilitado);
						usuario.setPerfil(perfil);
						usuario.setPersona(persona);
						usuario.setDependencia(dependencia);
						usuario.setArea(area);
						usuario.setJefeArea(jefeArea);
						
						Integer res = userSrv.insertaUsuario(usuario);
						
						if (res != 0) {
							request.setAttribute("mensaje", "Error al ingresar el registro");
						}
						
					}
					
					ArrayList<UsuarioVO> usuarios = userSrv.obtenerUsuarios();
					request.setAttribute("usuarios", usuarios);
		            destino = "catalogos/listarUsuarios.jsp";
				}
				
			} else if (action.equals("contrasena")) {
				String sid = request.getParameter("id");
				Integer id = Integer.parseInt(sid);
				UsuarioVO param = new UsuarioVO();
				param.setId(id);
				
				UsuarioVO usuario = userSrv.obtenerUsuario(param);
				
				request.setAttribute("usuario", usuario);
				
				destino = "catalogos/credenciales.jsp";
				
			} else if (action.equals("credenciales")) {
				String sid = request.getParameter("id");
				String contr = request.getParameter("contrasena");
				String confir = request.getParameter("confirma");
				
				if (!contr.equals(confir)) {
					request.setAttribute("mensaje", "Contrase&ntilde;a no coincide");
					
				} else {
					Integer id = Integer.parseInt(sid);
					
					UsuarioVO usuario = new UsuarioVO();
					usuario.setId(id);
					usuario.setContra(contr);
					
					Integer res = userSrv.actualizaContrasena(usuario);
					
					if (res != 0) {
						request.setAttribute("mensaje", "Error al actualizar el registro");
					}
					
				}
				
				ArrayList<UsuarioVO> usuarios = userSrv.obtenerUsuarios();
				request.setAttribute("usuarios", usuarios);
	            destino = "catalogos/listarUsuarios.jsp";
				
			}
			RequestDispatcher rd = request.getRequestDispatcher(destino);
	        rd.forward(request, response);
		}
		
	}

}
