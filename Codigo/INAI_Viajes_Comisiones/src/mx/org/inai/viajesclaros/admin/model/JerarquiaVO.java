package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class JerarquiaVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String nombre;
	private Boolean editable;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Boolean getEditable() {
		return editable;
	}
	public void setEditable(Boolean editable) {
		this.editable = editable;
	}
	
}
