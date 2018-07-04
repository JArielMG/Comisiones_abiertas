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
import mx.org.inai.viajesclaros.admin.model.GrupoAprobacionVO;
import mx.org.inai.viajesclaros.admin.model.JerarquiaVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.service.AreaServices;
import mx.org.inai.viajesclaros.admin.service.DependenciaServices;
import mx.org.inai.viajesclaros.admin.service.GrupoAprobacionService;
import mx.org.inai.viajesclaros.admin.service.JerarquiaServices;
import mx.org.inai.viajesclaros.admin.service.ProcesoServices;

/**
 * Servlet implementation class GrupoAprobacionAction
 */
@WebServlet(name = "GrupoAprobacionAction", urlPatterns = { "/grupoAprobacionAction" })
public class GrupoAprobacionAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	GrupoAprobacionService grpServ = new GrupoAprobacionService();
	ProcesoServices procServ = new ProcesoServices();
	JerarquiaServices jerarServ = new JerarquiaServices();
	DependenciaServices depServ = new DependenciaServices();
	AreaServices areaServ = new AreaServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GrupoAprobacionAction() {
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
			ArrayList<GrupoAprobacionVO> grupos = grpServ.obtenerGruposAprobacion();
			request.setAttribute("grupos", grupos);
			destino = "workflows/listarGrupos.jsp";
			
		} else if (action.equals("modificar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			GrupoAprobacionVO param = new GrupoAprobacionVO();
			param.setId(id);
			
			GrupoAprobacionVO grupo = grpServ.obtenerGrupoAprobacion(param);
			ArrayList<ProcesoVO> flujos = procServ.obtenerProcesos();
			ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
			ArrayList<DependenciaVO> dependencias = depServ.obtenerDependencias();
			ArrayList<AreaVO> areas = areaServ.obtenerAreas();
			
			request.setAttribute("grupo", grupo);
			
			request.setAttribute("comando", "update");
			request.setAttribute("flujos", flujos);
			request.setAttribute("jerarquias", jerarquias);
			request.setAttribute("dependencias", dependencias);
			request.setAttribute("areas", areas);
			
			destino = "workflows/detalleGrupo.jsp";
			
		} else if (action.equals("borrar")) {
			String sid = request.getParameter("id");
			Integer id = Integer.parseInt(sid);
			GrupoAprobacionVO param = new GrupoAprobacionVO();
			param.setId(id);
			
			Integer res = grpServ.eliminaGrupoAprobacion(param);
			
			if (res != 0) {
				request.setAttribute("mensaje", "Error al eliminar el registro");
			}
			
			ArrayList<GrupoAprobacionVO> grupos = grpServ.obtenerGruposAprobacion();
			request.setAttribute("grupos", grupos);
			destino = "workflows/listarGrupos.jsp";
            
		} else if (action.equals("agregar")) {
			ArrayList<ProcesoVO> flujos = procServ.obtenerProcesos();
			ArrayList<JerarquiaVO> jerarquias = jerarServ.obtenerJerarquias();
			ArrayList<DependenciaVO> dependencias = depServ.obtenerDependencias();
			ArrayList<AreaVO> areas = areaServ.obtenerAreas();
			
			request.setAttribute("flujos", flujos);
			request.setAttribute("jerarquias", jerarquias);
			request.setAttribute("dependencias", dependencias);
			request.setAttribute("areas", areas);
			
			destino = "workflows/detalleGrupo.jsp";
		} else if (action.equals("actualiza")) {
			String sid = request.getParameter("id");
			String nombre = request.getParameter("nombre");
			String sFlujo = request.getParameter("flujo");
			String sDep = request.getParameter("dependencia");
			String sArea = request.getParameter("area");
			String sJerar = request.getParameter("jerarquia");
			
			if (sid == null || nombre == null || sDep == null || sFlujo == null || sArea == null || sJerar == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la actualizaci&oacute;n");
			} else {
				Integer id = Integer.parseInt(sid);
				Integer flujoId = Integer.parseInt(sFlujo);
				Integer depId = Integer.parseInt(sDep);
				Integer areaId = Integer.parseInt(sArea);
				Integer jerarId = Integer.parseInt(sJerar);
				
				ProcesoVO paramProc = new ProcesoVO();
				paramProc.setId(flujoId);
				DependenciaVO paramDep = new DependenciaVO();
				paramDep.setId(depId);
				AreaVO paramArea = new AreaVO();
				paramArea.setId(areaId);
				JerarquiaVO paramJer = new JerarquiaVO();
				paramJer.setId(jerarId);
				
				ProcesoVO flujo = procServ.obtenerProceso(paramProc);
				DependenciaVO dependencia = depServ.obtenerDependencia(paramDep);
				AreaVO area = areaServ.obtenerArea(paramArea);
				JerarquiaVO jerarquia = jerarServ.obtenerJerarquia(paramJer);
				
				GrupoAprobacionVO grupo = new GrupoAprobacionVO();
				grupo.setId(id);
				grupo.setNombre(nombre);
				grupo.setProceso(flujo);
				grupo.setDependencia(dependencia);
				grupo.setArea(area);
				grupo.setJerarquia(jerarquia);
				
				Integer res = grpServ.actualizaGrupoAprobacion(grupo);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al actualizar el registro");
				}
			}
			
			ArrayList<GrupoAprobacionVO> grupos = grpServ.obtenerGruposAprobacion();
			request.setAttribute("grupos", grupos);
			destino = "workflows/listarGrupos.jsp";
			
		} else if (action.equals("ingresa")) {
			String nombre = request.getParameter("nombre");
			String sFlujo = request.getParameter("flujo");
			String sDep = request.getParameter("dependencia");
			String sArea = request.getParameter("area");
			String sJerar = request.getParameter("jerarquia");
			
			if (nombre == null || sDep == null || sFlujo == null || sArea == null || sJerar == null) {
				request.setAttribute("mensaje", "Informaci&oacute;n insuficiente para la inserci&oacute;n");
			} else {
				Integer flujoId = Integer.parseInt(sFlujo);
				Integer depId = Integer.parseInt(sDep);
				Integer areaId = Integer.parseInt(sArea);
				Integer jerarId = Integer.parseInt(sJerar);
				
				ProcesoVO paramProc = new ProcesoVO();
				paramProc.setId(flujoId);
				DependenciaVO paramDep = new DependenciaVO();
				paramDep.setId(depId);
				AreaVO paramArea = new AreaVO();
				paramArea.setId(areaId);
				JerarquiaVO paramJer = new JerarquiaVO();
				paramJer.setId(jerarId);
				
				ProcesoVO flujo = procServ.obtenerProceso(paramProc);
				DependenciaVO dependencia = depServ.obtenerDependencia(paramDep);
				AreaVO area = areaServ.obtenerArea(paramArea);
				JerarquiaVO jerarquia = jerarServ.obtenerJerarquia(paramJer);
				
				GrupoAprobacionVO grupo = new GrupoAprobacionVO();
				grupo.setNombre(nombre);
				grupo.setProceso(flujo);
				grupo.setDependencia(dependencia);
				grupo.setArea(area);
				grupo.setJerarquia(jerarquia);
				
				Integer res = grpServ.insertaGrupoAprobacion(grupo);
				
				if (res != 0) {
					request.setAttribute("mensaje", "Error al insertar el registro");
				}
			}
			
			ArrayList<GrupoAprobacionVO> grupos = grpServ.obtenerGruposAprobacion();
			request.setAttribute("grupos", grupos);
			destino = "workflows/listarGrupos.jsp";
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
