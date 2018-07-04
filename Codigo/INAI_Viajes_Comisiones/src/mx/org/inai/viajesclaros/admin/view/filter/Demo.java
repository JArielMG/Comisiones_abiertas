package mx.org.inai.viajesclaros.admin.view.filter;

import mx.org.inai.viajesclaros.admin.model.ProcesoVO;
import mx.org.inai.viajesclaros.admin.util.SendMail;

public class Demo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ProcesoVO flujo = new ProcesoVO();
		flujo.setNombre("Prueba de Flujo para Correo");
		//ProcessInstance instance = new ProcessInstance();
		
		SendMail.email("mikengel19@gmail.com", flujo, null);
	}

}
