package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class BitacoraVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private FlujosInstanciasVO instancia;
	private PersonaVO funcionario;
	private String respuesta;
	
	public FlujosInstanciasVO getInstancia() {
		return instancia;
	}
	public void setInstancia(FlujosInstanciasVO instancia) {
		this.instancia = instancia;
	}
	public PersonaVO getFuncionario() {
		return funcionario;
	}
	public void setFuncionario(PersonaVO funcionario) {
		this.funcionario = funcionario;
	}
	public String getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(String respuesta) {
		this.respuesta = respuesta;
	}

}
