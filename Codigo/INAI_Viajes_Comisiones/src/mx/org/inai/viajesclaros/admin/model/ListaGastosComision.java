package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class ListaGastosComision implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Object valor;
	private Integer idRegistroGastoComision;
	
	public ListaGastosComision(Object valor, Integer idRegistroGastoComision) {
		this.valor=valor;
		this.idRegistroGastoComision=idRegistroGastoComision;
	}

	public Object getValor() {
		return valor;
	}
	
	public void setValor(Object valor) {
		this.valor = valor;
	}

	public Integer getIdRegistroGastoComision() {
		return idRegistroGastoComision;
	}

	public void setIdRegistroGastoComision(Integer idRegistroGastoComision) {
		this.idRegistroGastoComision = idRegistroGastoComision;
	}
}
