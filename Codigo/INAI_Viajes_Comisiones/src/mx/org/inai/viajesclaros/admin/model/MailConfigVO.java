package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class MailConfigVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String host;
	private String puerto;
	private String usuario;
	private String contra;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getPuerto() {
		return puerto;
	}
	public void setPuerto(String puerto) {
		this.puerto = puerto;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getContra() {
		return contra;
	}
	public void setContra(String contra) {
		this.contra = contra;
	}
	
}
