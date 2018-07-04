package mx.org.inai.viajesclaros.admin.view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.service.ProcesoServices;

/**
 * Servlet implementation class ProcesosAction
 */
@WebServlet(name = "ProcesosAction", urlPatterns = { "/procesosAction" })
public class ProcesosAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProcesoServices procServ = new ProcesoServices();
       
    public ProcesosAction() {
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
			ArrayList<ProcesoVO> procesos = procServ.obtenerProcesos();
			request.setAttribute("procesos", procesos);
            destino = "workflows/listarProcesos.jsp";
            
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
	}

}
