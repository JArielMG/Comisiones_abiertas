package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class AreaVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String nombre;
	private DependenciaVO dependencia;
	
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
	public DependenciaVO getDependencia() {
		return dependencia;
	}
	public void setDependencia(DependenciaVO dependencia) {
		this.dependencia = dependencia;
	}

}
