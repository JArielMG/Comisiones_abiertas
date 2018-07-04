package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name="tipo_persona")
public class TipoPersonaVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="id_tipo")
	private Integer id;
	@Column(name="codigo_tipo")
	private String codigo;
	@Column(name="descripcion")
	private String descripcion;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
}
