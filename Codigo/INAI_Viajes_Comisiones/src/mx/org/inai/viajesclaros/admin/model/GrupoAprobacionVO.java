package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class GrupoAprobacionVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String nombre;
	private ProcesoVO proceso;
	private DependenciaVO dependencia;
	private AreaVO area;
	private JerarquiaVO jerarquia;
	private Boolean editable;
	
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
	public ProcesoVO getProceso() {
		return proceso;
	}
	public void setProceso(ProcesoVO proceso) {
		this.proceso = proceso;
	}
	public DependenciaVO getDependencia() {
		return dependencia;
	}
	public void setDependencia(DependenciaVO dependencia) {
		this.dependencia = dependencia;
	}
	public AreaVO getArea() {
		return area;
	}
	public void setArea(AreaVO area) {
		this.area = area;
	}
	public JerarquiaVO getJerarquia() {
		return jerarquia;
	}
	public void setJerarquia(JerarquiaVO jerarquia) {
		this.jerarquia = jerarquia;
	}
	public Boolean getEditable() {
		return editable;
	}
	public void setEditable(Boolean editable) {
		this.editable = editable;
	}
	
}
