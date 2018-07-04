package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class UsuarioVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String usuario;
	private String contra;
	private String salt;
	private String descripcion;
	private Boolean habilitado;
	private Integer intentos;
	private PerfilVO perfil;
	private DependenciaVO dependencia;
	private PersonaVO persona;
	private AreaVO area;
	private Boolean jefeArea;
	private Long idBonita;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public Boolean getHabilitado() {
		return habilitado;
	}
	public void setHabilitado(Boolean habilitado) {
		this.habilitado = habilitado;
	}
	public Integer getIntentos() {
		return intentos;
	}
	public void setIntentos(Integer intentos) {
		this.intentos = intentos;
	}
	public PerfilVO getPerfil() {
		return perfil;
	}
	public void setPerfil(PerfilVO perfil) {
		this.perfil = perfil;
	}
	public DependenciaVO getDependencia() {
		return dependencia;
	}
	public void setDependencia(DependenciaVO dependencia) {
		this.dependencia = dependencia;
	}
	public PersonaVO getPersona() {
		return persona;
	}
	public void setPersona(PersonaVO persona) {
		this.persona = persona;
	}
	public AreaVO getArea() {
		return area;
	}
	public void setArea(AreaVO area) {
		this.area = area;
	}
	public Boolean getJefeArea() {
		return jefeArea;
	}
	public void setJefeArea(Boolean jefeArea) {
		this.jefeArea = jefeArea;
	}
	public Long getIdBonita() {
		return idBonita;
	}
	public void setIdBonita(Long idBonita) {
		this.idBonita = idBonita;
	}

}
