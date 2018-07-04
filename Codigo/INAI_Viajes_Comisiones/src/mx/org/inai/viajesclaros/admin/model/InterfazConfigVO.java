package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

public class InterfazConfigVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String tabla;
	private String campo;
	private Boolean listaHabilita;
	private String etiqueta;
	private Integer secuencia;
	private Integer tipoDato;
	
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
	public Boolean getListaHabilita() {
		return listaHabilita;
	}
	public void setListaHabilita(Boolean listaHabilita) {
		this.listaHabilita = listaHabilita;
	}
	public String getEtiqueta() {
		return etiqueta;
	}
	public void setEtiqueta(String etiqueta) {
		this.etiqueta = etiqueta;
	}
	public Integer getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(Integer secuencia) {
		this.secuencia = secuencia;
	}
	
	public Integer getTipoDato() {
		return tipoDato;
	}
	public void setTipoDato(Integer tipoDato) {
		this.tipoDato = tipoDato;
	}
}
