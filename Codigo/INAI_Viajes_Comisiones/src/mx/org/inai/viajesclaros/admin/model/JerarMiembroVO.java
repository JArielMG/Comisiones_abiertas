package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class JerarMiembroVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private JerarquiaVO jerarquia;
	private UsuarioVO usuario;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public JerarquiaVO getJerarquia() {
		return jerarquia;
	}
	public void setJerarquia(JerarquiaVO jerarquia) {
		this.jerarquia = jerarquia;
	}
	public UsuarioVO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioVO usuario) {
		this.usuario = usuario;
	}
	
}
