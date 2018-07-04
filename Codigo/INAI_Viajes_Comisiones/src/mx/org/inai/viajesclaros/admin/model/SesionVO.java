package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class SesionVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String usuario;
	private PerfilVO perfil;
	private Date fechaHora;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public PerfilVO getPerfil() {
		return perfil;
	}
	public void setPerfil(PerfilVO perfil) {
		this.perfil = perfil;
	}
	public Date getFechaHora() {
		return fechaHora;
	}
	public void setFechaHora(Date fechaHora) {
		this.fechaHora = fechaHora;
	}
	
	
}
