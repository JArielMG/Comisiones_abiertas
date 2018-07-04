package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class Comisiones implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer idComision;
	private String estatus;
	private Integer idDependencia;
	private Integer idPersona;
	private Integer idUsuario;
	
	public Integer getIdComision() {
		return idComision;
	}
	public void setIdComision(Integer idComision) {
		this.idComision = idComision;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public Integer getIdDependencia() {
		return idDependencia;
	}
	public void setIdDependencia(Integer idDependencia) {
		this.idDependencia = idDependencia;
	}
	public Integer getIdPersona() {
		return idPersona;
	}
	public void setIdPersona(Integer idPersona) {
		this.idPersona = idPersona;
	}
	public Integer getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(Integer idUsuario) {
		this.idUsuario = idUsuario;
	}

}
