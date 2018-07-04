package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.ArrayList;

public class NotificacionDetalleVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long taskId;
	private FlujosInstanciasVO instance;
	private ArrayList<SeccionesNotificacionVO> secciones;
	
	public long getTaskId() {
		return taskId;
	}
	public void setTaskId(long taskId) {
		this.taskId = taskId;
	}
	public FlujosInstanciasVO getInstance() {
		return instance;
	}
	public void setInstance(FlujosInstanciasVO instance) {
		this.instance = instance;
	}
	public ArrayList<SeccionesNotificacionVO> getSecciones() {
		return secciones;
	}
	public void setSecciones(ArrayList<SeccionesNotificacionVO> secciones) {
		this.secciones = secciones;
	}
	
}
