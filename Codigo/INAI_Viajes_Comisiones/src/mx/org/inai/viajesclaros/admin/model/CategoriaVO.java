package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name="categoria")
public class CategoriaVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="id_categoria")
	private Integer id;
	@Column(name="nombre_categoria")
	private String nombre;
	@Column(name="tope_hospedaje")
	private Double topeHospedaje;
	@Column(name="tope_viaticos")
	private Double topeViaticos;
	
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
	public Double getTopeHospedaje() {
		return topeHospedaje;
	}
	public void setTopeHospedaje(Double topeHospedaje) {
		this.topeHospedaje = topeHospedaje;
	}
	public Double getTopeViaticos() {
		return topeViaticos;
	}
	public void setTopeViaticos(Double topeViaticos) {
		this.topeViaticos = topeViaticos;
	}
	
}
