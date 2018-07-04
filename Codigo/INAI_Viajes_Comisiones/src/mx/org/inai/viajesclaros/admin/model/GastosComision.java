package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.List;

public class GastosComision implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer idRegistroGasto;
    private String campo;
    private String etiqueta;
    private Boolean listaHabilitada;
    private Byte obligatorio;
    private Integer orden;
    private String subtipo;
    private String tipoControl;
    private String tipoDato;
    private Integer idLista;
    private String valorCampo;
    private List<CatalogoElement> catalogo;
    
	public Integer getIdRegistroGasto() {
		return idRegistroGasto;
	}
	
	public void setIdRegistroGasto(Integer idRegistroGasto) {
		this.idRegistroGasto = idRegistroGasto;
	}
	
	public String getCampo() {
		return campo;
	}
	
	public void setCampo(String campo) {
		this.campo = campo;
	}
	
	public String getEtiqueta() {
		return etiqueta;
	}
	
	public void setEtiqueta(String etiqueta) {
		this.etiqueta = etiqueta;
	}
	
	public Boolean getListaHabilitada() {
		return listaHabilitada;
	}
	
	public void setListaHabilitada(Boolean listaHabilitada) {
		this.listaHabilitada = listaHabilitada;
	}
	
	public Byte getObligatorio() {
		return obligatorio;
	}
	
	public void setObligatorio(Byte obligatorio) {
		this.obligatorio = obligatorio;
	}
	
	public Integer getOrden() {
		return orden;
	}
	
	public void setOrden(Integer orden) {
		this.orden = orden;
	}
	
	public String getSubtipo() {
		return subtipo;
	}
	
	public void setSubtipo(String subtipo) {
		this.subtipo = subtipo;
	}

	public String getTipoControl() {
		return tipoControl;
	}

	public void setTipoControl(String tipoControl) {
		this.tipoControl = tipoControl;
	}

	public String getTipoDato() {
		return tipoDato;
	}

	public void setTipoDato(String tipoDato) {
		this.tipoDato = tipoDato;
	}

	public Integer getIdLista() {
		return idLista;
	}

	public void setIdLista(Integer idLista) {
		this.idLista = idLista;
	}

	public List<CatalogoElement> getCatalogo() {
		return catalogo;
	}

	public void setCatalogo(List<CatalogoElement> catalogo) {
		this.catalogo = catalogo;
	}

	public String getValorCampo() {
		return valorCampo;
	}

	public void setValorCampo(String valorCampo) {
		this.valorCampo = valorCampo;
	}
}
