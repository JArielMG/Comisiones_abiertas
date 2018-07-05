package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class ComisionesUsuario implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer idComision;
	private String estatus;
	private String fechaSalida;
	private String fechaRegreso;
	private String paisDestino;
	private String ciudadDestino;
	
	public ComisionesUsuario(Integer idComision, String estatus, String fechaSalida, String fechaRegreso,
			String paisDestino, String ciudadDestino) {
		this.idComision = idComision;
		this.estatus = estatus;
		this.fechaSalida = fechaSalida;
		this.fechaRegreso = fechaRegreso;
		this.paisDestino = paisDestino;
		this.ciudadDestino = ciudadDestino;
	}
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
	public String getFechaSalida() {
		return fechaSalida;
	}
	public void setFechaSalida(String fechaSalida) {
		this.fechaSalida = fechaSalida;
	}
	public String getFechaRegreso() {
		return fechaRegreso;
	}
	public void setFechaRegreso(String fechaRegreso) {
		this.fechaRegreso = fechaRegreso;
	}
	public String getPaisDestino() {
		return paisDestino;
	}
	public void setPaisDestino(String paisDestino) {
		this.paisDestino = paisDestino;
	}
	public String getCiudadDestino() {
		return ciudadDestino;
	}
	public void setCiudadDestino(String ciudadDestino) {
		this.ciudadDestino = ciudadDestino;
	}
}
