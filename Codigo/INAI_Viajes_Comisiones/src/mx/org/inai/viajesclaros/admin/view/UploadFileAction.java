package mx.org.inai.viajesclaros.admin.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.csvreader.CsvWriter;
import java.util.Calendar;

import mx.org.inai.viajesclaros.admin.model.DependenciaVO;
import mx.org.inai.viajesclaros.admin.service.DependenciaServices;
import mx.org.inai.viajesclaros.admin.service.UploadFileServices;
import mx.org.inai.viajesclaros.admin.util.FileUtil;

/**
 * Servlet implementation class SecurityAction
 */
@WebServlet(name = "uploadFileAction", urlPatterns = { "/carga/uploadFileAction" })
@MultipartConfig
public class UploadFileAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final long TAM_MAX = 10485760;  //10 Mb
	
	private UploadFileServices upFileSrv = new UploadFileServices();
	private DependenciaServices depenServ = new DependenciaServices();
	
	public UploadFileAction() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	/*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("pasando por get antes del post");
		doPost(request, response);
    }*/

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            //HttpSession sesion = request.getSession(true);
            FileUtil fu = new FileUtil();
            String destino = "cargaArchivo.jsp";
            String action = request.getParameter("submit");
            String tipo = request.getParameter("tipo");
            int idDep = Integer.parseInt(request.getParameter("dependencia"));

            DependenciaVO dep = new DependenciaVO();
            dep.setId(idDep);
            dep = depenServ.obtenerDependencia(dep);
            
            Part filePart = request.getPart("archivo");

            File errores = null;

            if (action == null) {
                    action = "listar";
            }

            if (action.equals("listar")) {
                ArrayList<DependenciaVO> dependencias = depenServ.obtenerDependencias();
                request.setAttribute("dependencias", dependencias);
            }else{
                if(!tipo.equals("0")){				
                    long res = 0;
                    int tieneLayout = upFileSrv.tieneLayout(idDep);
                    System.out.println("Tiene layout: " + tieneLayout);
                    if(tieneLayout > 0){
                        if (action.equals("Cargar")) {         	        	
                            res = validaArchivo(tipo, filePart, idDep);    
                            System.out.println("respuesta llave: "+ res);
                            if(res > 1000){//significa que genero errores en la carga
                                OutputStream os = response.getOutputStream();
                                
                                Calendar c = Calendar.getInstance();
                                String dia = String.format("%02d", c.get(Calendar.DAY_OF_MONTH));
                                String mes = String.format("%02d", c.get(Calendar.MONTH) + 1);
                                String annio = String.format("%02d", c.get(Calendar.YEAR));
                                String hora = String.format("%02d", c.get(Calendar.HOUR_OF_DAY));
                                String min = String.format("%02d", c.get(Calendar.MINUTE));
                                
                                String nombre = dep.getSiglas() + "_" + annio + mes + dia + "_" + hora + min + "_ErroresCarga.txt";
                                
                                response.addHeader("Content-Disposition","attachment;filename=" + nombre); 
                                response.setContentType("text/plain"); 
                                response.setBufferSize(8192 * 16);
                                
                                errores= fu.generaErrores(res, nombre);

                                int length = (int) errores.length();		        		 		              
                                byte[] bytes = new byte[length];		         
                                FileInputStream fin = new FileInputStream(errores);		         
                                fin.read(bytes);
                                fin.close();
                                
                                os.write(bytes);
                                os.flush();
                                os.close();
                                
                                //upFileSrv.eliminaDetalleError(res);

                            }else   if (res == 1) {
                                request.setAttribute("mensaje", "No ha seleccionado un archivo");
                            }else if (res == 2) {
                                request.setAttribute("mensaje", "Tipo de archivo inv&aacute;lido, s&oacute;lo XML y CSV, asegurese de que la extensi&oacute;n del archivo y el tipo seleccionado coincidan");
                            }else if (res == 3) {
                                request.setAttribute("mensaje", "El archivo excede de 10 MB");
                            }else if (res == 4) {
                                request.setAttribute("mensaje", "El n&uacute;mero de colmnas del archivo es incorrecto");
                            }else if (res == 5) {
                                request.setAttribute("mensaje", "Las columnas del archivo no corresponden al layout vigente");
                            }else if (res == 6) {
                                request.setAttribute("mensaje", "Se presentaron problemas en la validación de los datos");
                            }else if (res == 7) {
                                request.setAttribute("mensaje", "El archivo present&oacute; problemas en la carga");
                            }else if (res == 8) {
                                request.setAttribute("mensaje", "El archivo present&oacute; problemas en el procesamiento de algunos registros y estos nos e procesaron");            
                            } else {		            	
                                request.setAttribute("mensaje", "Archivo cargado exitosamente");
                            }
                        }else if (action.equals("Descargar Layout")) {
                            OutputStream os = response.getOutputStream();
                            if(tipo.equals("CSV")){	        	
                                response.addHeader("Content-Disposition","attachment;filename=Layout.csv"); 
                                response.setContentType("application/vnd.ms-excel"); 

                                CsvWriter layout = fu.generaLayoutCSV(os, idDep);			        	 
                                //layout.flush();
                                layout.close();
                            }else{
                                response.addHeader("Content-Disposition","attachment;filename=Layout.xml"); 			    					    		
                                response.setContentType("application/xml; charset=utf-8");
                                fu.generaLayoutXML("layout.xml", os, idDep);
                            }    	
                        }
                    }else{
                        request.setAttribute("mensaje", "La dependencia seleccionada no tiene un layout registrado en la aplicación");
                    }
                }else{
                    request.setAttribute("mensaje", "Seleccione el tipo de archivo");
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher(destino);
            rd.forward(request, response);
	}
	
	
	
	/**Valida extensión y header del archivo*/
	private long validaArchivo(String tipo, Part filePart, int idDep) throws ServletException, IOException{
		FileUtil fu = new FileUtil();
		long res = 0;
		
		/*for (String head : filePart.getHeaderNames()) {
			System.out.println("***** " + head + " - " + filePart.getHeader(head));
			for (String det : filePart.getHeaders(head)) {
				System.out.println("***** " + det + " - " + filePart.getHeader(det));
			}
		}
		
		System.out.println("***** " + filePart.getContentType());
		System.out.println("***** " + filePart.getName());*/
		//System.out.println("***** " + );
		
	    String nombreArchivo = getFileName(filePart);//filePart.getSubmittedFileName();
	    long size = filePart.getSize();
	    String contentType = filePart.getContentType();

		System.out.println(nombreArchivo);
		System.out.println(size);
		System.out.println(contentType);
    	
		/*Valida el archivo de forma general*/
		if(size <= TAM_MAX){
			if((contentType.indexOf("application/xml") != -1 && tipo.equals("XML")) ||
					(contentType.indexOf("text/xml") != -1 && tipo.equals("XML")))
		        res = fu.separaXML(filePart.getInputStream(),nombreArchivo, idDep);			    	   
			else if(contentType.indexOf("application/vnd.ms-excel") != -1 && tipo.endsWith("CSV"))
				res = fu.separaCSV(filePart.getInputStream(),nombreArchivo, idDep);			
			else if(contentType.indexOf("application/octet-stream") != -1)
				res = 1;
			else res = 2;				
		}else
			res= 3; //size	
		
		
    	return res;
	}
	

	private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= "+contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }
	
	
}

