package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class NotificacionVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private long id;
	private String display;
	private FlujosInstanciasVO instanceId;
	private UsuarioVO actor;
	private Date lastUpdateDate;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDisplay() {
		return display;
	}
	public void setDisplay(String display) {
		this.display = display;
	}
	public FlujosInstanciasVO getInstanceId() {
		return instanceId;
	}
	public void setInstanceId(FlujosInstanciasVO instanceId) {
		this.instanceId = instanceId;
	}
	public UsuarioVO getActor() {
		return actor;
	}
	public void setActor(UsuarioVO actor) {
		this.actor = actor;
	}
	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	
}
