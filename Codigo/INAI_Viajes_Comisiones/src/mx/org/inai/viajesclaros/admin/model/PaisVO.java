package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class PaisVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String clave;
	private String nombre;
	private Boolean predeterminado;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Boolean getPredeterminado() {
		return predeterminado;
	}
	public void setPredeterminado(Boolean predeterminado) {
		this.predeterminado = predeterminado;
	}

}
