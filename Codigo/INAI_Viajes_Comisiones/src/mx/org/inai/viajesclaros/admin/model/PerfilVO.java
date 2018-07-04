package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name="perfiles")
public class PerfilVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="id_perfil")
	private Integer id;
	@Column(name="nombre_perfil")
	private String nombre;
	
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

}
