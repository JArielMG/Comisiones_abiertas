package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity(name="personas")
public class PersonaVO implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id_persona")
	private Integer id;
	private String nombres;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String titulo;
	private String email;
	private CategoriaVO categoria;
	private TipoPersonaVO tipoPersona;
	private PosicionVO posicion;
	private String cargo;
	private Date fechaIngreso;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public CategoriaVO getCategoria() {
		return categoria;
	}
	public void setCategoria(CategoriaVO categoria) {
		this.categoria = categoria;
	}
	public TipoPersonaVO getTipoPersona() {
		return tipoPersona;
	}
	public void setTipoPersona(TipoPersonaVO tipoPersona) {
		this.tipoPersona = tipoPersona;
	}
	public PosicionVO getPosicion() {
		return posicion;
	}
	public void setPosicion(PosicionVO posicion) {
		this.posicion = posicion;
	}
	public String getCargo() {
		return cargo;
	}
	public void setCargo(String cargo) {
		this.cargo = cargo;
	}
	public Date getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(Date fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	
}
