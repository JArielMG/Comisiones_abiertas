package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class DependenciaVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String siglas;
	private String nombre;
	private Boolean predeterminada;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSiglas() {
		return siglas;
	}
	public void setSiglas(String siglas) {
		this.siglas = siglas;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Boolean getPredeterminada() {
		return predeterminada;
	}
	public void setPredeterminada(Boolean predeterminada) {
		this.predeterminada = predeterminada;
	}
	
}
