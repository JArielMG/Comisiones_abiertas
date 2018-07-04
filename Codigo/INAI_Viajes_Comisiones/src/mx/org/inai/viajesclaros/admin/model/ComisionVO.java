package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class ComisionVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String estatus;
	private DependenciaVO dependencia;
	private PersonaVO persona;
	private UsuarioVO usuario;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public DependenciaVO getDependencia() {
		return dependencia;
	}
	public void setDependencia(DependenciaVO dependencia) {
		this.dependencia = dependencia;
	}
	public PersonaVO getPersona() {
		return persona;
	}
	public void setPersona(PersonaVO persona) {
		this.persona = persona;
	}
	public UsuarioVO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioVO usuario) {
		this.usuario = usuario;
	}
	
}
