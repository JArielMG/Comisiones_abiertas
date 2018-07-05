package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.Date;

public class ComisionDetalleVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer idDetalle;
	private ComisionVO comision;
	private String tabla;
	private String campo;
    private String valorTexto;
    private Double valorNumerico;
    private Date valorFecha;
    private String etiqueta;
    private String subtipo;
    
	public Integer getIdDetalle() {
		return idDetalle;
	}
	public void setIdDetalle(Integer idDetalle) {
		this.idDetalle = idDetalle;
	}
	public ComisionVO getComision() {
		return comision;
	}
	public void setComision(ComisionVO comision) {
		this.comision = comision;
	}
	public String getTabla() {
		return tabla;
	}
	public void setTabla(String tabla) {
		this.tabla = tabla;
	}
	public String getCampo() {
		return campo;
	}
	public void setCampo(String campo) {
		this.campo = campo;
	}
	public String getValorTexto() {
		return valorTexto;
	}
	public void setValorTexto(String valorTexto) {
		this.valorTexto = valorTexto;
	}
	public Double getValorNumerico() {
		return valorNumerico;
	}
	public void setValorNumerico(Double valorNumerico) {
		this.valorNumerico = valorNumerico;
	}
	public Date getValorFecha() {
		return valorFecha;
	}
	public void setValorFecha(Date valorFecha) {
		this.valorFecha = valorFecha;
	}
	public String getEtiqueta() {
		return etiqueta;
	}
	public void setEtiqueta(String etiqueta) {
		this.etiqueta = etiqueta;
	}
	public String getSubtipo() {
		return subtipo;
	}
	public void setSubtipo(String subtipo) {
		this.subtipo = subtipo;
	}
}
