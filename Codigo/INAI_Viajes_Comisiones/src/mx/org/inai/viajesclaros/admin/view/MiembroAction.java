package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.JerarMiembroVO;
import mx.org.inai.viajesclaros.admin.model.JerarquiaVO;
import mx.org.inai.viajesclaros.admin.model.UsuarioVO;
import mx.org.inai.viajesclaros.admin.service.JerarquiaServices;
import mx.org.inai.viajesclaros.admin.service.MiembroServices;
import mx.org.inai.viajesclaros.admin.service.UserServices;

/**
 * Servlet implementation class MiembroAction
 */
@WebServlet(name = "MiembroAction", urlPatterns = { "/miembroAction" })
public class MiembroAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private JerarquiaServices jerarServ = new JerarquiaServices();
	private UserServices userServ = new UserServices();
	private MiembroServices miemServ = new MiembroServices();
       
    public MiembroAction() {
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
			String idJerar = request.getParameter("idJerar");
			Integer id = Integer.parseInt(idJerar);
			JerarquiaVO param = new JerarquiaVO();
			param.setId(id);
			
			JerarquiaVO jerarquia = jerarServ.obtenerJerarquia(param);
			
			ArrayList<JerarMiembroVO> miembros = miemServ.obtenerMiembros(jerarquia);
			request.setAttribute("miembros", miembros);
			request.setAttribute("idJerar", idJerar);
            destino = "workflows/listarMiembros.jsp";
            
		} else if (action.equals("modificar")) {
			String idJerar = request.getParameter("idJerar");
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			JerarMiembroVO param = new JerarMiembroVO();
			param.setId(id);
			
			JerarMiembroVO miembro = miemServ.obtenerMiembro(param);
			ArrayList<UsuarioVO> usuarios = userServ.obtenerUsuarios();
			
			request.setAttribute("miembro", miembro);
			request.setAttribute("usuarios", usuarios);
			request.setAttribute("comando", "update");
			request.setAttribute("idJerar", idJerar);
			
			destino = "workflows/detalleMiembro.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			JerarMiembroVO param = new JerarMiembroVO();
			param.setId(id);
			
			JerarMiembroVO consulta = miemServ.obtenerMiembro(param);
			Integer res = miemServ.eliminaMiembro(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<JerarMiembroVO> miembros = miemServ.obtenerMiembros(consulta.getJerarquia());
			request.setAttribute("miembros", miembros);
            destino = "workflows/listarMiembros.jsp";
			
		} else if (action.equals("agregar")) {
			String idJerar = request.getParameter("idJerar");
			request.setAttribute("idJerar", idJerar);
			Integer id = Integer.parseInt(idJerar);
			JerarquiaVO param = new JerarquiaVO();
			param.setId(id);
			
			JerarquiaVO jerarquia = jerarServ.obtenerJerarquia(param);
			ArrayList<UsuarioVO> usuarios = userServ.obtenerUsuarios();
			
			request.setAttribute("idJerar", idJerar);
			request.setAttribute("jerarquia", jerarquia);
			request.setAttribute("usuarios", usuarios);
			
			destino = "workflows/detalleMiembro.jsp";
			
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String sidJerar = request.getParameter("idJerar");
			String sidUsu = request.getParameter("usuario");
			
			if (sid == null || sidJerar == null || sidUsu == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer idJerar = Integer.parseInt(sidJerar);
				Integer idUsu = Integer.parseInt(sidUsu);
				
				JerarquiaVO jerarquia = new JerarquiaVO();
				jerarquia.setId(idJerar);
				UsuarioVO usuario =  new UsuarioVO();
				usuario.setId(idUsu);
				
				JerarMiembroVO miembro = new JerarMiembroVO();
				miembro.setId(id);
				miembro.setJerarquia(jerarServ.obtenerJerarquia(jerarquia));
				miembro.setUsuario(userServ.obtenerUsuario(usuario));
				
				Integer res = miemServ.actualizaMiembro(miembro);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<JerarMiembroVO> miembros = miemServ.obtenerMiembros(miembro.getJerarquia());
				request.setAttribute("miembros", miembros);
				request.setAttribute("idJerar", idJerar);
				
	            destino = "workflows/listarMiembros.jsp";
				
			}
			
		} else if (action.equals("ingresa")) {
			String sidJerar = request.getParameter("idJerar");
			String sidUsu = request.getParameter("usuario");
			
			if (sidJerar == null || sidUsu == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				
				Integer idJerar = Integer.parseInt(sidJerar);
				Integer idUsu = Integer.parseInt(sidUsu);
				
				JerarquiaVO jerarquia = new JerarquiaVO();
				jerarquia.setId(idJerar);
				UsuarioVO usuario =  new UsuarioVO();
				usuario.setId(idUsu);
				
				JerarMiembroVO miembro = new JerarMiembroVO();
				miembro.setJerarquia(jerarServ.obtenerJerarquia(jerarquia));
				miembro.setUsuario(userServ.obtenerUsuario(usuario));
				
				Integer res = miemServ.insertaMiembro(miembro);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
				
				ArrayList<JerarMiembroVO> miembros = miemServ.obtenerMiembros(miembro.getJerarquia());
				request.setAttribute("miembros", miembros);
				request.setAttribute("idJerar", idJerar);
				
	            destino = "workflows/listarMiembros.jsp";
				
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
