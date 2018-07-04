package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.BonitaErrorVO;
import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.model.SesionVO;
import mx.org.inai.viajesclaros.admin.service.BonitaServices;
import mx.org.inai.viajesclaros.admin.service.ProcesoServices;

/**
 * Servlet implementation class IngresaInfoFlujo
 */
@WebServlet(name = "IngresaInfoAction" , urlPatterns = { "/ingresaInfoAction" })
public class IngresaInfoAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ProcesoServices procServ = new ProcesoServices();
	BonitaServices bonServ = new BonitaServices();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IngresaInfoAction() {
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
			action = "ingreso";
		}
		if (action.equals("ingreso")) {
			ArrayList<ProcesoVO> flujos = procServ.obtenerProcesos();
			request.setAttribute("flujos", flujos);
			
			destino = "solicitudes/ingresaInformacion.jsp";
			
		} else if (action.equals("invocar")) {
			String sFlujo = request.getParameter("flujo");
			SesionVO sesion = (SesionVO)request.getSession().getAttribute("sesion");
			
			Integer idFlujo = Integer.parseInt(sFlujo);
			
			ProcesoVO param = new ProcesoVO();
			param.setId(idFlujo);
			
			ProcesoVO proceso = procServ.obtenerProceso(param);
			
			BonitaErrorVO error = bonServ.invocaProceso(proceso, sesion.getUsuario(), 1);
			
			request.setAttribute("error", error);
			
			destino = "solicitudes/ingresaInformacion.jsp";
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
