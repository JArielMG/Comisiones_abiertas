package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class EstadoVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String nombre;
	private PaisVO pais;
	
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
	public PaisVO getPais() {
		return pais;
	}
	public void setPais(PaisVO pais) {
		this.pais = pais;
	}
	
}
