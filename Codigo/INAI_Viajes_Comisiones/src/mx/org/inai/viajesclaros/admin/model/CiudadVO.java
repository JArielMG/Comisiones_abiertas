package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class CiudadVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String nombre;
	private PaisVO pais;
	private EstadoVO estado;
	private String latitud;
	private String longitud;
	
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
	public PaisVO getPais() {
		return pais;
	}
	public void setPais(PaisVO pais) {
		this.pais = pais;
	}
	public EstadoVO getEstado() {
		return estado;
	}
	public void setEstado(EstadoVO estado) {
		this.estado = estado;
	}
	public String getLatitud() {
		return latitud;
	}
	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}
	public String getLongitud() {
		return longitud;
	}
	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}

}
