package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class FlujosInstanciasVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private ProcesoVO flujo;
	private Long instancia;
	private ComisionVO comision;
	private Date fechaInicio;
	private Date fechaFin;
	private Boolean asignado;
	
	public ProcesoVO getFlujo() {
		return flujo;
	}
	public void setFlujo(ProcesoVO flujo) {
		this.flujo = flujo;
	}
	public Long getInstancia() {
		return instancia;
	}
	public void setInstancia(Long instancia) {
		this.instancia = instancia;
	}
	public ComisionVO getComision() {
		return comision;
	}
	public void setComision(ComisionVO comision) {
		this.comision = comision;
	}
	public Date getFechaInicio() {
		return fechaInicio;
	}
	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}
	public Date getFechaFin() {
		return fechaFin;
	}
	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}
	public Boolean getAsignado() {
		return asignado;
	}
	public void setAsignado(Boolean asignado) {
		this.asignado = asignado;
	}
	
}
