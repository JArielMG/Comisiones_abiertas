package mx.org.inai.viajesclaros.admin.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.OutputKeys;

import mx.org.inai.viajesclaros.admin.model.DetalleInterfazVO;
import mx.org.inai.viajesclaros.admin.model.ErrorInterfazVO;
import mx.org.inai.viajesclaros.admin.model.HeaderInterfazVO;
import mx.org.inai.viajesclaros.admin.model.InterfazConfigVO;
import mx.org.inai.viajesclaros.admin.model.ProcesaInterfazVO;
import mx.org.inai.viajesclaros.admin.persistence.HibernateUtil;
import mx.org.inai.viajesclaros.admin.service.UploadFileServices;

import org.hibernate.Session;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.csvreader.CsvReader;
import com.csvreader.CsvWriter;

public class FileUtil {
	
	private static final String ALTA = "I"; 
	private static final String BAJA = "E"; 
	private static final String CAMBIO = "C"; 
	Session session = null;
	
	private UploadFileServices upFileSrv = new UploadFileServices();
	
	/***********************************************************************/
	/**Genera archivo XML para descargar************************************/
	public void generaLayoutXML(String name, OutputStream os, int idDep){		
		StreamResult result = null;		
		ArrayList<InterfazConfigVO> camposLayout = upFileSrv.obtenerLayout(idDep);
		//String cadena = "";
		
		try {
			
			 
			 DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	         DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();	         	         
	         Document doc = dBuilder.newDocument();	         
	         // elemento principal
	         Element xmlviajes = doc.createElement("Viajes");
	         doc.appendChild(xmlviajes);
	         // elemento agrupador de cada viaje
	         Element viaje = doc.createElement("Viaje");
	         xmlviajes.appendChild(viaje);
	         
	         for(int i = 0; i < camposLayout.size(); i++) {   
		         // crea los hijos del viaje
		         Element hijoViaje = doc.createElement(reemplazaEspacios(camposLayout.get(i).getEtiqueta()));
		         Text valorHijoViaje = doc.createTextNode("valor");	         
		         viaje.appendChild(hijoViaje);	//Agrega los hijos a cada elemento         		         
		         hijoViaje.appendChild(valorHijoViaje);	//Agrega valores a los elementos	         
	         }
	         
	         // escribe el contenido del archivo xml
	         TransformerFactory transformerFactory = TransformerFactory.newInstance();
	         Transformer transformer = transformerFactory.newTransformer();
	         
	         transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
	         transformer.setOutputProperty(OutputKeys.VERSION, "1.0");
	         transformer.setOutputProperty(OutputKeys.ENCODING,"ISO-8859-1");
	         transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	         
	         
	         DOMSource source = new DOMSource(doc);
	         result = new StreamResult(os);
	         transformer.transform(source, result);
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	}
	
	/****************************************************************************/
	/**Genera archivo csv para descargar*****************************************/
	public CsvWriter generaLayoutCSV(OutputStream os, int idDep){

		CsvWriter csvOutput = null;	
		ArrayList<InterfazConfigVO> camposLayout = upFileSrv.obtenerLayout(idDep);		
			
		try {
			
			csvOutput = new CsvWriter(os, ',', Charset.forName("UTF-8"));
			// write out the header line
			for(int i = 0; i < camposLayout.size(); i++) {
				csvOutput.write(reemplazaEspacios(camposLayout.get(i).getEtiqueta()));						
			}
			csvOutput.endRecord();	//cierra encabezado	
			for(int i = 0; i < camposLayout.size(); i++) {
				csvOutput.write("valor");						
			}
			csvOutput.endRecord();	//cierra registro	de ejemplo
		
			csvOutput.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return csvOutput;
	}
	/********************************************************************/
	/**Valida y procesa el archivo CSV***********************************/
	public long separaCSV(InputStream contenido, String nombreArchivo, int idDep) throws IOException{				
		long res = 0;
		int numColumnas = 0;
		long llave = 0;
		int totReg = 0;
		int errorRes = 0;
		int errorCount = 0;
		String accion = "";		
		
					
		CsvReader reader = new CsvReader(contenido, Charset.forName("ISO-8859-1"));
		reader.readHeaders();
		
		String[] headers = reader.getHeaders();
		
		numColumnas = reader.getHeaderCount();
		ArrayList<InterfazConfigVO> camposLayout = upFileSrv.obtenerInterfazConfig(idDep);
		
		System.out.println("separaCSV");
		System.out.println("numColumnas: " + numColumnas + " camposLayout: " + (camposLayout.size()));
		if(numColumnas == (camposLayout.size() ) ){
			
			res = validaLayout(camposLayout, headers);
			if(res == 0){
				//escribe procesamiento
				llave = registraProcesamiento(nombreArchivo);
				while (reader.readRecord())
				{
					totReg = totReg + 1;					
					errorRes = validaDatos(camposLayout, reader, totReg, llave, idDep);
					accion = reader.get("Operacion");
					if(errorRes == 0){
						System.out.println("catalogos y tipos de datos OK");
						if(accion.equals(ALTA)){
							errorRes = validaLlave(camposLayout, reader, totReg, llave);							
							if(errorRes == 0){
								res = insertaViaje(camposLayout, reader, llave, headers, idDep);							
								if(res > 0) res = 8;
							}
						}else{
							res = actualizaEliminaViajeViaje(camposLayout, reader, accion, headers, idDep);
							if(res > 0) res = 8;
						}
					}
						errorCount = errorCount + errorRes;
					
				}//while
			    //reader.close();
			    int aceptados = totReg-errorCount;
			    System.out.println("totReg " + totReg + "errorCount "+ errorCount + "aceptados " + aceptados);
			    session = HibernateUtil.getSessionFactory().openSession();
			    res = upFileSrv.actualizaArchivosProcesados(session, llave, totReg, errorCount, aceptados);
			    session.close();
			    if(res == 0)			    	
				    if(errorCount > 0){
				    	res = llave;
				    }
			}else res = 5; //header incorrecto
			reader.close();
		}else res = 4; //numero de colunnas incorrecto
		
		return res;
	}
	
	/*******************************************************************************/
	/**Valida y procesa el archivo XML**********************************************/
public long separaXML(InputStream contenido, String nombreArchivo, int idDep) throws IOException{
		
		long res = 0;
		String entrada;
		String cadena="";		
		long llave;;		
		int totReg = 0;
		int errorRes = 0;
		int errorCount = 0;
		String accion = "";
		
		//InputStream inputStream= new FileInputStream(nombreArchivo);
		Reader reader = new InputStreamReader(contenido,"ISO-8859-1");
		BufferedReader br = new BufferedReader(reader);	
		
		System.out.println("separaXML");
		
		while ((entrada = br.readLine()) != null){
			cadena = cadena + entrada;
			//System.out.println(cadena);
		}
		try{
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
	
			InputSource archivo = new InputSource();
			archivo.setEncoding("ISO-8859-1");
			archivo.setCharacterStream(new StringReader(cadena)); 
	
			Document documento = db.parse(archivo);
			documento.getDocumentElement().normalize();
			
			NodeList nodeLista = documento.getElementsByTagName("Viaje");
			System.out.println("Informacionos Viajes");
			
			Node nodo;
			
			llave =  registraProcesamiento(nombreArchivo);
			System.out.println("llave: " + llave);
						
			ArrayList<InterfazConfigVO> camposLayout = upFileSrv.obtenerInterfazConfig(idDep);
			
			res = validaLayout(camposLayout, nodeLista);
			if(res == 0){			
				for (int j = 0; j < nodeLista.getLength(); j++) {  //nodo viaje
					nodo = nodeLista.item(j);
					totReg = totReg + 1;
					errorRes = validaDatos(totReg, camposLayout, nodo, llave, idDep);
					System.out.println("errorRes: "+ errorRes);
					if(errorRes == 0){
						accion = obtieneAccion(camposLayout, nodo);
						System.out.println("Accion: " + accion);
						if(accion.equals(ALTA)){
							errorRes = validaLlave(totReg, camposLayout, nodo, llave);							
							if(errorRes == 0){
								res = insertaViaje(camposLayout, nodo, llave, idDep);
								if(res > 0) res = 8;
							}							
						}else{
							res = actualizaEliminaViajeViaje(camposLayout, nodo, accion, idDep);
							if(res > 0) res = 8;
						}
					} //erroresRes > 1
					errorCount = errorCount + errorRes;
				}//for de viaje

				int aceptados = totReg - errorCount;
				System.out.println("totReg: " + totReg + " aceptados: " + aceptados + " rechazados: " + errorCount);
				session = HibernateUtil.getSessionFactory().openSession();
			    res = upFileSrv.actualizaArchivosProcesados(session, llave, totReg, errorCount, aceptados);
			    session.close();
			    System.out.println("Actualiza procesados: " + res);
			    if(res == 0)			    	
				    if(errorCount > 0){
				    	res = llave;
				    	//genera archivo de errores para mandar a usuario
				    	//borra registros de tabla de detalle
				    }
			}//valida layout
			br.close();
		} catch (SAXException ex) {
		    System.out.println("ERROR: El formato XML del fichero no es correcto\n"+ex.getMessage());
		    ex.printStackTrace();
		    res = 2;
		} catch (IOException ex) {
		    System.out.println("ERROR: Se ha producido un error el leer el fichero\n"+ex.getMessage());
		    ex.printStackTrace();
		    res = 2;
		} catch (ParserConfigurationException ex) {
		    System.out.println("ERROR: No se ha podido crear el generador de documentos XML\n"+ex.getMessage());
		    ex.printStackTrace();
		    res = 4;
		}
		return res;
	}
	
	/****************************************************************************/
	/**reemplaza espacios del header*********************************************/
	public String reemplazaEspacios(String cadena){
		
		cadena = cadena.replaceAll(" ", "_");
		
		return cadena;
	}
	
	public String reemplazaCaracteres(String cadena){
		String res = "";
		
		final CharsetEncoder asciiEncoder = Charset.forName("ISO-8859-1").newEncoder();
	    final StringBuilder result = new StringBuilder();
	    for (final Character character : cadena.toCharArray()) {
	        if (asciiEncoder.canEncode(character)) {
	            result.append(character);
	        } else {	 
	        	result.append("\\u");
	            result.append(Integer.toHexString(0x10000 | character).substring(1).toUpperCase());
	        }
	    }
	    //System.out.println("String resultante: "+ result.toString());
	    
	    res = result.toString();
	    
	    //Reader lectura = new InputStreamReader( new ByteArrayInputStream(result.toString().getBytes(StandardCharsets.UTF_8)));
	    
		
		/*cadena = cadena.replaceAll("&", "&amp;");
		cadena = cadena.replaceAll("<", "&lt;");
		cadena = cadena.replaceAll(">", "&gt;");
		cadena = cadena.replaceAll("\"","&quot;");
		cadena = cadena.replaceAll("'", "&apos;");
		//cadena = cadena.replaceAll("/", "&frasl;");
		cadena = cadena.replaceAll("¡", "&iexcl;");
		cadena = cadena.replaceAll("¿", "&iquest;");
		cadena = cadena.replaceAll("®", "&reg;");
		cadena = cadena.replaceAll("©", "&copy;");
		cadena = cadena.replaceAll("€", "&euro;");
		cadena = cadena.replaceAll("á", "&aacute;");
		cadena = cadena.replaceAll("é", "&eacute;");
		cadena = cadena.replaceAll("í", "&iacute;");
		cadena = cadena.replaceAll("ó", "&oacute;");
		cadena = cadena.replaceAll("ú", "&uacute;");
		cadena = cadena.replaceAll("ñ", "&ntilde;");
		cadena = cadena.replaceAll("ü", "&uuml;");
		cadena = cadena.replaceAll("Á", "&Aacute;");
		cadena = cadena.replaceAll("É", "&Eacute;");
		cadena = cadena.replaceAll("Í", "&Iacute;");
		cadena = cadena.replaceAll("Ó", "&Oacute;");
		cadena = cadena.replaceAll("Ú", "&Uacute;");
		cadena = cadena.replaceAll("Ñ", "&Ntilde;");
		cadena = cadena.replaceAll("Ü", "&Uuml;");*/
		
		return res;
	}
	
	/**********************************************************************/
	/**Valida layout de archivo CSV****************************************/
	private Integer validaLayout(ArrayList<InterfazConfigVO> camposLayout, String[] atributos){
		int res= 0;
		String etiqueta = "";
		String atrib = "";
		boolean existe;
				
		for(int i = 0; i < camposLayout.size(); i++) {
			etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
			existe = false;
			for(int x = 0; x < atributos.length; x++) {
				atrib = atributos[x];
				if(etiqueta.equals(atrib)){
					existe = true;	
					break;
				}
			}
			if(!existe){
				res = 5;
				break;				
			}
		}
		return res;
	}
	
	/**********************************************************************/
	/**Valida layout de archivo XML****************************************/
	private Integer validaLayout(ArrayList<InterfazConfigVO> camposLayout, NodeList nodeLista){
		int res= 0;
		String etiqueta = "";		
		Node nodo;
		Element elemento;
		NodeList nombreElementoLista;
		String nomNodo = "";
		boolean existe =false;	
				
		Viaje:
		for (int j = 0; j < nodeLista.getLength(); j++) {//viaje
			nodo = nodeLista.item(j);
			
			//Layout:
			for(int i = 0; i < camposLayout.size(); i++) {
				etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
				//etiqueta = "Prueba";
				elemento = (Element) nodo;
				nombreElementoLista = elemento.getChildNodes();
				
				//Hijos:
				for(int k=0;k<nombreElementoLista.getLength();k++){  
					   Node hijosViaje = nombreElementoLista.item(k);  
					   if (hijosViaje instanceof Element){   
						   nomNodo = hijosViaje.getNodeName();

							existe = false;	
							if(etiqueta.equals(nomNodo)){
								existe = true;	
								System.out.println("Iguales: "+ nomNodo + " " + etiqueta);
								//break Hijos;
								k = nombreElementoLista.getLength() + 1;
							}						
					 } //if instace 
				} //for hijos

			}//for layout
			if(!existe){
				res = 5;
				break Viaje;				
			}//if existe
		}//for nodeLista viaje
		return res;
	}
	
	/**********************************************************************/
	/**Valida datos de archivo CSV*****************************************/
	private Integer validaDatos(ArrayList<InterfazConfigVO> camposLayout, CsvReader reader, int numReg, long llave, int idDep)throws IOException{	
		int res= 0;
		String etiqueta = "";
		String tabla = "";
		String campo = "";
		String filtro ="";
		boolean valida = false;
		int resQuery;
		String error = "";
		Integer idDepReg = 0;
		Integer tipoDato = 0;			

			for(int i = 0; i < camposLayout.size(); i++) {
				etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
				valida = camposLayout.get(i).getListaHabilita();
				tabla = camposLayout.get(i).getTabla();
				campo = camposLayout.get(i).getCampo();
				filtro = reemplazaCaracteres(reader.get(etiqueta));
				tipoDato = camposLayout.get(i).getTipoDato();
				
				resQuery = 1;
				if(etiqueta.equals("Operacion")){
					if (filtro.trim().equals(ALTA) || filtro.trim().equals(BAJA) || filtro.trim().equals(CAMBIO)){
						continue;
					}else{	
						resQuery = 0;
						error = "El dato de la columna " + etiqueta + " no corresponde a una Operación válida (I,E,C).";
					} //res = 1;
				
				}else if(etiqueta.equals("Dependencia")){
					if(filtro.equals("INAI")){
						resQuery = 0;
						error = "El dato de la Dependencia no es correcto para la carga de viajes para otras dependencias.";
					}else{
						//System.out.println("*********** Service: " + upFileSrv);
						//System.out.println("*********** Filtro: " + filtro);
						idDepReg = upFileSrv.obtenerIdDependencia(filtro);
						//System.out.println("Dep selecionada: "+ idDep + " Dep del registro: " + idDepReg);
						if(idDepReg == null || idDep != idDepReg.intValue()){
							resQuery = 0;
							error = "El dato de la Dependencia no es igual a la Dependecia que seleccionó.";
						}					
					}
				}else{			
					if(valida){
						//query = "select count(*) from viajes_claros." + tabla + " where " + campo + " = " + filtro;		
					    resQuery = upFileSrv.validaDato(tabla, campo, filtro);	
					    error = "El dato de la columna " + etiqueta + " no corresponde a alguno registrado en el catálogo.";
					}					
				}
				if(resQuery == 0){
					session = HibernateUtil.getSessionFactory().openSession();
					upFileSrv.insertaDetalleError(session, llave, numReg, error);
					session.close();
					System.out.println("registro error");
					res = 1;
				}
				if(!etiqueta.equals("Operacion")){
					switch(tipoDato){
						case 2:
							break;
						case 1:	
							//if (!filtro.matches("[0-9]*")){
							if (!filtro.matches("\\d+(\\.\\d{1,2})?")){
								error = "El dato " + filtro + " de la columna " + etiqueta + " debe ser numérico.";
								session = HibernateUtil.getSessionFactory().openSession();
								upFileSrv.insertaDetalleError(session, llave, numReg, error);
								session.close();
								res = 1;
							}
							break;
						case 3:
							SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");						
							try{
								formatter.parse(filtro);
								System.out.println(formatter.parse(filtro));
							}catch (ParseException e) {
								//e.printStackTrace();
								error = "El dato " + filtro + " de la columna " + etiqueta + " debe ser una fecha válida.";
								session = HibernateUtil.getSessionFactory().openSession();
								upFileSrv.insertaDetalleError(session, llave, numReg, error);
								session.close();
								res = 1;
							}
							break;
					}//switch
				}//if etiqueta
			}//for Layout	
				
		return res;
	}
	
	/**********************************************************************/
	/**Valida datos de archivo XML*****************************************/
	private Integer validaDatos(int numReg, ArrayList<InterfazConfigVO> camposLayout, Node nodo, long llave, int idDep){	
		int res= 0;		
		int resQuery;
		Integer idDepReg = 0;
		String error = "";
		String msjError = "";
		String etiqueta="";
		String valor = "";
		String tabla = "";
		String campo = "";
		Integer tipoDato = 0;		
		boolean valida = false;
		Element elemento;
		NodeList nombreElementoLista;		
		
			for(int i = 0; i < camposLayout.size(); i++) {
				etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
				valida = camposLayout.get(i).getListaHabilita();
				tabla = camposLayout.get(i).getTabla();
				campo = camposLayout.get(i).getCampo();
				tipoDato = camposLayout.get(i).getTipoDato();
			
				elemento = (Element) nodo;
				nombreElementoLista = elemento.getChildNodes();
				
				//System.out.println("Antes de segundo for");
							
				for (int j = 0; j < nombreElementoLista.getLength(); j++) {
					resQuery = 1;
					Node hijosViaje = nombreElementoLista.item(j);  
					if (hijosViaje instanceof Element){   
						   String nomNodo = hijosViaje.getNodeName();
						   //System.out.println("Etiqueta: " + etiqueta + " Nodo: " + nomNodo);
						   if(etiqueta.equals(nomNodo)){
							   //System.out.println("Iguales: " + etiqueta + " " + nomNodo);
							   valor = hijosViaje.getTextContent();
							   valor = reemplazaCaracteres(valor);
							   //System.out.println("Valor: " + valor);
		
							   if(etiqueta.equals("Operacion")){							   
								   if (valor.trim().equals(ALTA) || valor.trim().equals(BAJA) || valor.trim().equals(CAMBIO)){
									   resQuery = 1;//sin error
								   }else{	
										resQuery = 0;
										error = "El dato de la columna " + etiqueta + " no corresponde a una Operación válida (I,E,C).";
								   } //res = 1;
							   }else if(etiqueta.equals("Dependencia")){
								   if(valor.equals("INAI")){
									   resQuery = 0;
									   error = "El dato de la Dependencia no es correcto para la carga de viajes para otras dependencias.";
								   }else{
									   //System.out.println("*********** Service: " + upFileSrv);
									   //System.out.println("*********** Valor: " + valor);
										idDepReg = upFileSrv.obtenerIdDependencia(valor);
										if(idDepReg == null || idDep != idDepReg.intValue()){
											resQuery = 0;
											error = "El dato de la Dependencia no es igual a la Dependecia que seleccionó.";
										}					
									}
							   }else{		
								   if(valida){							
										resQuery = upFileSrv.validaDato(tabla, campo, valor);
										error = "El dato de la columna " + etiqueta + " no corresponde a alguno registrado en el catálogo.";
								   }							   
							   }
							   
							   if(!etiqueta.equals("Operacion")){
									  // System.out.println("tipo dato: " + tipoDato);
									   switch(tipoDato){
											case 2:
												break;
											case 1:	
												//if (!valor.matches("[0-9]*")){
												if (!valor.matches("\\d+(\\.\\d{1,2})?")){
													msjError = "El dato " + valor + " de la columna " + etiqueta + " debe ser numérico.";
													session = HibernateUtil.getSessionFactory().openSession();
													upFileSrv.insertaDetalleError(session, llave, numReg, msjError);
													session.close();
													res = 1;
												}
												break;
											case 3:
												SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm", new Locale("es_ES"));						
												try{
													formatter.parse(valor);
													System.out.println("****fecha: " + formatter.parse(valor));
												}catch (ParseException e) {
													//e.printStackTrace();
													msjError = "El dato " + valor + " de la columna " + etiqueta + " debe ser una fecha válida.";
													session = HibernateUtil.getSessionFactory().openSession();
													upFileSrv.insertaDetalleError(session, llave, numReg, msjError);
													session.close();
													res = 1;
												}
												break;
									   }//switch
								   }//if etiqueta
						  
						   }//Element
						   if(resQuery == 0){
							   session = HibernateUtil.getSessionFactory().openSession();
							   upFileSrv.insertaDetalleError(session, llave, numReg, error);
							   session.close();
							   System.out.println("************ registro error");
							   res = 1;
						   }
						   
					 }  //etiqueta=nodo
				}//for nodos
			}//for camposLayout
			
		return res;
	}
	
	
	/**********************************************************************/
	/**Valida datos de archivo CSV*****************************************/
	private Integer validaLlave(ArrayList<InterfazConfigVO> camposLayout, CsvReader reader, int numReg, long llave)throws IOException{	
		int res= 0;
		int idViaje = 0;		
		String msjError = "";
		
		
		idViaje = obtieneViaje(camposLayout, reader);
		
		if(idViaje > 0){
			msjError = "Ya se registro anteriormente un viaje con los datos de la dependencia, nombre, apellidos y fecha de salida iguales a los del viaje en este archivo.";
			session = HibernateUtil.getSessionFactory().openSession();
			upFileSrv.insertaDetalleError(session, llave, numReg, msjError);
			session.close();
			res = 1;
		}
			
		return res;
	}
	
	/**********************************************************************/
	/**Valida datos de archivo XML*****************************************/
	private Integer validaLlave(int numReg, ArrayList<InterfazConfigVO> camposLayout, Node nodo, long llave){	
		int res= 0;		
		int idViaje = 0;
		String msjError = "";
		
		idViaje = obtieneViaje(camposLayout, nodo);
		
		if(idViaje > 0){
			msjError = "Ya se registro anteriormente un viaje con los datos de la dependencia, nombre, apellidos y fecha de salida iguales a los del viaje en este archivo.";
			session = HibernateUtil.getSessionFactory().openSession();
			upFileSrv.insertaDetalleError(session, llave, numReg, msjError);
			session.close();
			res = 1;
		}
			
		return res;
	}
	
	/**********************************************************************/
	/**Valida datos de archivo XML*****************************************/
	/*private Integer validaDatos(int numReg, ArrayList<InterfazConfigVO> camposLayout, NodeList nodeLista, long llave){	
		int res= 0;		
		int resQuery;
		String error = "";
		String etiqueta="";
		String valor = "";
		String tabla = "";
		String campo = "";
		boolean valida = false;
		Element elemento;;
		NodeList nombreElementoLista;
		Element nombreElemento;
		NodeList nombre;
		Node nodo;
		
		for(int i = 0; i < camposLayout.size(); i++) {
			etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
			valida = camposLayout.get(i).getListaHabilita();
			tabla = camposLayout.get(i).getTabla();
			campo = camposLayout.get(i).getCampo();
			//tipo_dato = camposLayout.get(i).getTipoDato();
			resQuery = 1;
			for (int j = 0; j < nodeLista.getLength(); j++) {
				nodo = nodeLista.item(j);
				if (nodo.getNodeType() == Node.ELEMENT_NODE) {
	
					elemento = (Element) nodo;
					nombreElementoLista = elemento.getElementsByTagName(etiqueta);
												
					nombreElemento = (Element) nombreElementoLista.item(j);
					nombre = nombreElemento.getChildNodes();
					valor = ((Node) nombre.item(j)).getNodeValue().toString();
					System.out.println("Valor: " + valor);
					valor = reemplazaCaracteres(valor);
					System.out.println("Valor: " + valor);
	
					if(etiqueta.equals("Operacion")){
						if (valor.trim().equals(ALTA) || valor.trim().equals(BAJA) || valor.trim().equals(CAMBIO)){
							continue;
						}else{	
							resQuery = 0;
							error = "El dato de la columna " + etiqueta + " no corresponde a una Operación válida (I,E,C).";
						} //res = 1;
					}else if(etiqueta.equals("Dependencia")){
						if(valor.equals("INAI")){
							resQuery = 0;
							error = "El dato de la Dependencia no es correcto para la carga de viajes para otras dependencias.";
						}
					}else{		
						if(valida){
							
							resQuery = upFileSrv.validaDato(tabla, campo, valor);
							error = "El dato de la columna " + etiqueta + " no corresponde a alguno registrado en el catálogo.";
						}	
					}
								
				}//Node
				//System.out.println("************ Debió fallar: " + resQuery + " - " + numReg);
				if(resQuery == 0){				
					upFileSrv.insertaDetalleError(llave, numReg, error);
					System.out.println("************ registro error");
					res = 1;
				}
			}//for nodos
		}//for camposLayout
					
		return res;
	}
	
	/**********************************************************************/
	/**Obtiene accion XML****************************************/
	private String obtieneAccion(ArrayList<InterfazConfigVO> camposLayout, Node nodo){	
		Element elemento;
		NodeList nombreElementoLista;
		String valor = "";
		String etiqueta = "";
		
		for(int i = 0; i < camposLayout.size(); i++) {
			etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());		
			elemento = (Element) nodo;
			nombreElementoLista = elemento.getChildNodes();

			for (int j = 0; j < nombreElementoLista.getLength(); j++) {
				Node hijosViaje = nombreElementoLista.item(j);  
				if (hijosViaje instanceof Element){   
					String nomNodo = hijosViaje.getNodeName();
					if(etiqueta.equals(nomNodo) && etiqueta.equals("Operacion")){
						//System.out.println("Iguales: " + etiqueta + " " + nomNodo);
						valor = hijosViaje.getTextContent();
						valor = reemplazaCaracteres(valor);
						break;
					}
				}
			}								
		}
					
		return valor;
	}
	
	/*******************************************************************/
	/**Inserta Header de archivo CSV o XML*******************************/
	private Integer insertaHeaderArchivo(long llave, int idDep){	
		int res = 0;
		//int idDep = 0;
		
		HeaderInterfazVO hiVO = new HeaderInterfazVO();
		//idDep = upFileSrv.obtenerDependencia(dependencia);
		//System.out.println("Id de dependencia: " + idDep);
		//inserta la cabecera del viaje
		hiVO.setIdDependencia(idDep);
		hiVO.setIdArchivo(llave);
		session = HibernateUtil.getSessionFactory().openSession();
		res = upFileSrv.insertaHeaderArchivo(session, hiVO);
		session.close();
		
		return res;
	}
	
	/********************************************************************/
	/**Inserta CSV***********************************************/
	private Integer insertaViaje(ArrayList<InterfazConfigVO> camposLayout, CsvReader reader, long llave, String[] atributos, int idDep)throws IOException{	
		int res = 0;		
		int idViaje = 0;
		String etiqueta = "";
		String tabla = "";
		String campo = "";
		Integer tipo_dato = 0;
		String atrib = "";
		String valor = "";
		//boolean headerIns = false;

		idViaje = insertaHeaderArchivo(llave, idDep);
		System.out.println("****** Id_Viaje: " + idViaje);
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		
		try{
			if(idViaje > 0){
				System.out.println("****** Detalle Viaje: " + idViaje);
				for(int x = 0; x < atributos.length; x++) {
					atrib = atributos[x];
					for(int i = 0; i < camposLayout.size(); i++) {
						etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
						tabla = camposLayout.get(i).getTabla();
						campo = camposLayout.get(i).getCampo();
						tipo_dato = camposLayout.get(i).getTipoDato();
						if(!etiqueta.equals("Operacion")){
						//	continue;
						//else {
							if(etiqueta.equals(atrib)){
								DetalleInterfazVO diVO = new DetalleInterfazVO();
								
								diVO.setIdViaje(idViaje);
								diVO.setTabla(tabla);
								diVO.setCampo(campo);
								
								valor = reemplazaCaracteres(reader.get(etiqueta));
								if(tipo_dato == 2)
									diVO.setValorT(valor);
								else if(tipo_dato == 1)									
									diVO.setValorN(Integer.parseInt(valor));									
								else if(tipo_dato == 3){
									Date fecha = formatter.parse(valor);
									diVO.setValorF(fecha);
								}
								session = HibernateUtil.getSessionFactory().openSession();
								res = upFileSrv.insertaDetalleArchivo(session, diVO);
								session.close();
							}
						}
					}
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		return res;
	}
	
	
	/****************************************************************/
	/****Inserta XML*************************************************/
	private Integer insertaViaje(ArrayList<InterfazConfigVO> camposLayout, Node nodo, long llave, int idDep){
		int res = 0;
		String etiqueta="";
		String valor = "";
		String tabla = "";
		String campo = "";
		Integer tipo_dato = 0;
		//String dependencia="";		
		int idViaje = 0;
		
		idViaje = insertaHeaderArchivo(llave, idDep);			
		//System.out.println("inserto Header de viaje");
				
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		
		try{
			if(idViaje > 0){
				
				Element elemento;
				NodeList nombreElementoLista;
				Layout:
				for(int i = 0; i < camposLayout.size(); i++) {
					etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
					tabla = camposLayout.get(i).getTabla();
					campo = camposLayout.get(i).getCampo();
					tipo_dato = camposLayout.get(i).getTipoDato();
					elemento = (Element) nodo;
					nombreElementoLista = elemento.getChildNodes();
					//System.out.println("Tabla: " + tabla + " campo: " + campo);
					
					for (int j = 0; j < nombreElementoLista.getLength(); j++) {
						Node hijosViaje = nombreElementoLista.item(j);  
						if (hijosViaje instanceof Element){   
							String nomNodo = hijosViaje.getNodeName();
							valor = hijosViaje.getTextContent();
							valor = reemplazaCaracteres(valor);
							if(etiqueta.equals(nomNodo)){
								if(!etiqueta.equals("Operacion")){
									//System.out.println("Etiqueta: " + etiqueta + " valor: " + valor);
									DetalleInterfazVO diVO = new DetalleInterfazVO();
									
									diVO.setIdViaje(idViaje);
									diVO.setTabla(tabla);
									diVO.setCampo(campo);					
									if(tipo_dato == 2)
										diVO.setValorT(valor);
									else if(tipo_dato == 1)									
										diVO.setValorN(Integer.parseInt(valor));
									else if(tipo_dato == 3){
										Date fecha = formatter.parse(valor);
										System.out.println("***fecha:" + fecha);
										diVO.setValorF(fecha);
									}
									session = HibernateUtil.getSessionFactory().openSession();
									res = upFileSrv.insertaDetalleArchivo(session, diVO);
									session.close();
									if(res < 0){
										res = 7;//problemas de carga
										break Layout;
									}
								}
							}//iguales					
						}//if Elemento
					}//for nodos	
				}//for camposLayout
			}else //header
				res = 7;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	/**************************************************************************/
	/**Actualiza/Elimina archivo CSV*****************************************************/
	private Integer actualizaEliminaViajeViaje(ArrayList<InterfazConfigVO> camposLayout, CsvReader reader, String accion, String[] atributos, int idDep)throws IOException{	
		int res = 0;		
		int idViaje = 0;
		String etiqueta = "";
		String tabla = "";
		String campo = "";
		Integer tipo_dato = 0;
		String atrib = "";
		String valor = "";
		boolean busca = false;
		String nombreCampo = "";
		String valorCampo = "";
		
		String dependencia = reader.get("Dependencia");
		String nombres = reader.get("Nombre_Persona");
		String apellidoP = reader.get("Apellido_Paterno");
		String apellidoM = reader.get("Apellido_Materno");
		
		//ArrayList<DetalleInterfazVO> viajes = new ArrayList<DetalleInterfazVO>();
		ArrayList<Integer> viajes = new ArrayList<Integer>();
		ArrayList<DetalleInterfazVO> viajeId = new ArrayList<DetalleInterfazVO>();
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");		
		try {

			Date fechaSalida = formatter.parse(reader.get("Fecha_Hora_Salida"));
			viajes = upFileSrv.obtenerDetalleViajesFecha(fechaSalida);
			
			for(int i = 0; i < viajes.size(); i++) {				
				viajeId = upFileSrv.obtenerDetalleViajeId(viajes.get(i));
				ViajesDet:
				for(int j = 0; j < viajeId.size(); j++) {
					nombreCampo = viajeId.get(j).getCampo();
					valorCampo = viajeId.get(j).getValorT();
					switch (nombreCampo){
						case "siglas":
							if(valorCampo.equals(dependencia)){
								busca = true;
								break;
							}else{
								busca = false;
								break ViajesDet;
							}
						case "nombres":
							if(valorCampo.equals(nombres)){
								busca = true;
								break;
							}else{
								busca = false;
								break ViajesDet;
							}
						case "apellido_paterno":
							if(valorCampo.equals(apellidoP)){
								busca = true;
								break;
							}else{
								busca = false;
								break ViajesDet;
							}
						case "apellido_materno":
							if(valorCampo.equals(apellidoM)){
								busca = true;
								break;
							}else{
								busca = false;
								break ViajesDet;
							}
					}		
					
				}//for viajeId
				if(busca){
					idViaje = viajes.get(i);
					break;	
				}
			}//for viajes fecha
		    if(idViaje > 0)
		    {
			
				for(int x = 0; x < atributos.length; x++) {
					atrib = atributos[x];
					for(int i = 0; i < camposLayout.size(); i++) {
						etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
						tabla = camposLayout.get(i).getTabla();
						campo = camposLayout.get(i).getCampo();
						tipo_dato = camposLayout.get(i).getTipoDato();
						if(etiqueta.equals("Operacion"))
							continue;
						else {
							if(etiqueta.equals(atrib)){
								DetalleInterfazVO diVO = new DetalleInterfazVO();
								
								diVO.setIdViaje(idViaje);
								diVO.setTabla(tabla);
								diVO.setCampo(campo);
								
								valor = reemplazaCaracteres(reader.get(etiqueta));
								if(tipo_dato == 2)
									diVO.setValorT(valor);
								else if(tipo_dato == 1)									
									diVO.setValorN(Integer.parseInt(valor));
								else if(tipo_dato == 3){
									Date fechaValor = formatter.parse(valor);
									diVO.setValorF(fechaValor);
								}
								
								if(accion.equals(CAMBIO)) {
									session = HibernateUtil.getSessionFactory().openSession();
									res = upFileSrv.actualizaDetalleArchivo(session, diVO);	
									session.close();
								}
								else {
									session = HibernateUtil.getSessionFactory().openSession();
									res = upFileSrv.eliminaDetalleArchivo(session, diVO);
									session.close();
								}
							}	
						}
					}
				}
		    }
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		return res;
	}

	/**************************************************************************/
	/**Actualiza/Elimina archivo XML*****************************************************/
	private Integer actualizaEliminaViajeViaje(ArrayList<InterfazConfigVO> camposLayout, Node nodo, String accion, int idDep){
		int res = 0;
		String etiqueta="";
		String valor = "";
		String tabla = "";
		String campo = "";
		Integer tipo_dato = 0;		
		int idViaje = 0;
				
		Element elemento;
		NodeList nombreElementoLista;
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		
		try{
			idViaje = obtieneViaje(camposLayout, nodo);
			
		    if(idViaje > 0)
		    {		    	
			
				for(int i = 0; i < camposLayout.size(); i++) {
					etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());					
					tabla = camposLayout.get(i).getTabla();
					campo = camposLayout.get(i).getCampo();
					tipo_dato = camposLayout.get(i).getTipoDato();
		
					elemento = (Element) nodo;
					nombreElementoLista = elemento.getChildNodes();
					
					for (int j = 0; j < nombreElementoLista.getLength(); j++) {
						Node hijosViaje = nombreElementoLista.item(j);  
						if (hijosViaje instanceof Element){   
							String nomNodo = hijosViaje.getNodeName();
							valor = hijosViaje.getTextContent();
							valor = reemplazaCaracteres(valor);
							if(etiqueta.equals(nomNodo)){
								if(etiqueta.equals("Operacion"))
									continue;
								else{
									/*if(etiqueta.equals("Dependencia")){
										dependencia = valor;
									}*/
									DetalleInterfazVO diVO = new DetalleInterfazVO();
									
									diVO.setIdViaje(idViaje);
									diVO.setTabla(tabla);
									diVO.setCampo(campo);					
									if(tipo_dato == 2)
										diVO.setValorT(valor);
									else if(tipo_dato == 1)									
										diVO.setValorN(Integer.parseInt(valor));
									else if(tipo_dato == 3){
										Date fechaValor = formatter.parse(valor);
										diVO.setValorF(fechaValor);
									}
					
									if(accion.equals(CAMBIO)) {
										session = HibernateUtil.getSessionFactory().openSession();
										res = upFileSrv.actualizaDetalleArchivo(session, diVO);
										session.close();
									}
									else {
										session = HibernateUtil.getSessionFactory().openSession();
										res = upFileSrv.eliminaDetalleArchivo(session, diVO);
										session.close();
									}
								}
							}//iguales
						}//if Node
					}//for nodos	
				}//for camposLayout
		    }
		} catch (ParseException e) {
			e.printStackTrace();
		}	    
		return res;
	}
	
	
	/**************************************************************************/
	/**Valida Llave Viaje CSV*****************************************************/
	private int obtieneViaje(ArrayList<InterfazConfigVO> camposLayout, CsvReader reader)throws IOException{
			int res = 0;
			String etiqueta="";
			String valor = "";	
			int idViaje = 0;
			boolean busca = false;
			String dependencia = "";
			String nombres = "";
			String apellidoP = "";
			String apellidoM = "";
			String fecha = "";	
			String nombreCampo = "";
			String valorCampo = "";

			//Layout:
			for(int i = 0; i < camposLayout.size(); i++) {
				etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());
				valor = reemplazaCaracteres(reader.get(etiqueta));

				if(etiqueta.equals("Operacion"))
					continue;
				else if(etiqueta.equals("Dependencia")){							
					dependencia = valor;
					continue;
				}else if(etiqueta.equals("Nombre_Persona")){
					nombres = valor;
					continue;
				}else if(etiqueta.equals("Apellido_Paterno")){
					apellidoP = valor;
					continue;
				}else if(etiqueta.equals("Apellido_Materno")){
					apellidoM = valor;
					continue;
				}else if(etiqueta.equals("Fecha_Hora_Salida")){
					fecha = valor;
					continue;
				}
						
			}//for layout

			ArrayList<Integer> viajes = new ArrayList<Integer>();
			ArrayList<DetalleInterfazVO> viajeId = new ArrayList<DetalleInterfazVO>();
			
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");		
			try {

				Date fechaSalida = formatter.parse(fecha);
				viajes = upFileSrv.obtenerDetalleViajesFecha(fechaSalida);
				//System.out.println("Tamaño lista viajes: " + viajes.size());
				for(int i = 0; i < viajes.size(); i++) {				
					viajeId = upFileSrv.obtenerDetalleViajeId(viajes.get(i));
					ViajesDet:
					for(int j = 0; j < viajeId.size(); j++) {	
						nombreCampo = viajeId.get(j).getCampo();
						valorCampo = viajeId.get(j).getValorT();
						switch (nombreCampo){
							case "siglas":
								if(valorCampo.equals(dependencia)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "nombres":
								if(valorCampo.equals(nombres)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "apellido_paterno":
								if(valorCampo.equals(apellidoP)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "apellido_materno":
								if(valorCampo.equals(apellidoM)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
						}
						
						
					}//for viajeId
					if(busca){
						idViaje = viajes.get(i);
						//System.out.println("Si hubo viaje " + idViaje);
						break;	
					}
				}//for viajes fecha
				
			    if(idViaje > 0)	
			    	res = idViaje;
		} catch (ParseException e) {
			e.printStackTrace();
		}    
		return res;
	}
	
	
	/**************************************************************************/
	/**Valida Llave Viaje XML*****************************************************/
	private int obtieneViaje(ArrayList<InterfazConfigVO> camposLayout, Node nodo){
			int res = 0;
			String etiqueta="";
			String valor = "";	
			int idViaje = 0;
			boolean busca = false;
			String dependencia = "";
			String nombres = "";
			String apellidoP = "";
			String apellidoM = "";
			String fecha = "";	
			String nombreCampo = "";
			String valorCampo = "";
					
			Element elemento;
			NodeList nombreElementoLista;
			
			//Layout:
			for(int i = 0; i < camposLayout.size(); i++) {
				etiqueta = reemplazaEspacios(camposLayout.get(i).getEtiqueta());		
				elemento = (Element) nodo;
				nombreElementoLista = elemento.getChildNodes();

				for (int j = 0; j < nombreElementoLista.getLength(); j++) {
					Node hijosViaje = nombreElementoLista.item(j);  
					if (hijosViaje instanceof Element){   
						String nomNodo = hijosViaje.getNodeName();
						valor = hijosViaje.getTextContent();
						valor = reemplazaCaracteres(valor);
						if(etiqueta.equals(nomNodo)){
							if(etiqueta.equals("Operacion"))
								continue;
							else if(etiqueta.equals("Dependencia")){							
								dependencia = valor;
								continue;
							}else if(etiqueta.equals("Nombre_Persona")){
								nombres = valor;
								continue;
							}else if(etiqueta.equals("Apellido_Paterno")){
								apellidoP = valor;
								continue;
							}else if(etiqueta.equals("Apellido_Materno")){
								apellidoM = valor;
								continue;
							}else if(etiqueta.equals("Fecha_Hora_Salida")){
								fecha = valor;
								continue;
							}
						}//iguales
					}//if nodos
				}//for nodos
			}//for layout

			ArrayList<Integer> viajes = new ArrayList<Integer>();
			ArrayList<DetalleInterfazVO> viajeId = new ArrayList<DetalleInterfazVO>();
			
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");		
			try {

				Date fechaSalida = formatter.parse(fecha);
				viajes = upFileSrv.obtenerDetalleViajesFecha(fechaSalida);
				
				for(int i = 0; i < viajes.size(); i++) {				
					viajeId = upFileSrv.obtenerDetalleViajeId(viajes.get(i));
					ViajesDet:
					for(int j = 0; j < viajeId.size(); j++) {	
						nombreCampo = viajeId.get(j).getCampo();
						valorCampo = viajeId.get(j).getValorT();
						switch (nombreCampo){
							case "siglas":
								if(valorCampo.equals(dependencia)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "nombres":
								if(valorCampo.equals(nombres)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "apellido_paterno":
								if(valorCampo.equals(apellidoP)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
							case "apellido_materno":
								if(valorCampo.equals(apellidoM)){
									busca = true;
									break;
								}else{
									busca = false;
									break ViajesDet;
								}
						}
						
						
					}//for viajeId
					if(busca){
						idViaje = viajes.get(i);
						break;	
					}
				}//for viajes fecha
				
			    if(idViaje > 0)	
			    	res = idViaje;
		} catch (ParseException e) {
			e.printStackTrace();
		}    
		return res;
	}

	private long registraProcesamiento(String nomArchivo){
		//calcular identificador de archivo
		long llave = 0;
		String sKey = "";
		Calendar calendar = Calendar.getInstance();

		int year       = calendar.get(Calendar.YEAR);
		int month      = calendar.get(Calendar.MONTH) + 1; 
		int day = calendar.get(Calendar.DAY_OF_MONTH); 

		int hour  = calendar.get(Calendar.HOUR_OF_DAY); // 24 hour clock
		int min    = calendar.get(Calendar.MINUTE);
		int sec     = calendar.get(Calendar.SECOND);
		//int millisec= calendar.get(Calendar.MILLISECOND);
		
		sKey = "" + year + month + day + hour + min + sec; 
		llave = Long.parseLong(sKey);
		System.out.println("genera llave y llama insercion");
		session = HibernateUtil.getSessionFactory().openSession();
		upFileSrv.insertaProcesamiento(session, llave, nomArchivo);
		session.close();
		
		return llave;	
		
	}
	  
	  /***************************************************************************/
	  /**Genera archivo de errores para descargar*********************************/
		public File generaErrores(long llave) throws IOException{			
			File archivo= new File("errores.txt");
			FileWriter fw = new FileWriter(archivo);
			BufferedWriter bw = new BufferedWriter(fw);
			 
			System.out.println("Hay errores genera archivo: " + llave);
			ProcesaInterfazVO bitacora = upFileSrv.obtenerBitacora(llave);
			bw.write("Archivo: " + bitacora.getArchivo());		
			bw.newLine();
			bw.write("Total de Registros Procesados: " + bitacora.getTotalReg());
			bw.newLine();
			bw.write("Total de Registros Rechazados: " + bitacora.getAceptados());
			bw.newLine();
			bw.write("Total de Registros Aceptados: " + bitacora.getRechazados());
			bw.newLine();
			bw.write("");
			bw.newLine();
			bw.write("==================== Total de errores ===================");
			bw.newLine();
			bw.write("Num Viaje\tDescripción del error");
			bw.newLine();
			
			System.out.println("Escribe encabezado de errores");
			
			ArrayList<ErrorInterfazVO> errores = upFileSrv.obtenerErrores(llave);
				
			try {
				
				for(int i = 0; i < errores.size(); i++) {
					System.out.println(errores.get(i).getLinea() + "\t" + errores.get(i).getError());
					bw.write(errores.get(i).getLinea() + "\t" + errores.get(i).getError());	
					bw.newLine();
				}
								
				bw.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return archivo;
		}
		
		
	
	public  void main ( String args[] ) {
		//registraProcesamiento();
	}

}

