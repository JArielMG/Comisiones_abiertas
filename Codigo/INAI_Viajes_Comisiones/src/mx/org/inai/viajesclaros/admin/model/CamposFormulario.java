package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;
import java.util.List;

public class CamposFormulario implements Serializable {

    @Override
    public String toString() {
        return "CamposFormulario{" + "idFlujo=" + idFlujo + ", tabla=" + tabla + ", campo=" + campo + ", etiqueta=" + etiqueta + ", listaHabilitada=" + listaHabilitada + ", idSeccionFormulario=" + idSeccionFormulario + ", obligatorio=" + obligatorio + ", orden=" + orden + ", tipoControl=" + tipoControl + ", tipoDato=" + tipoDato + ", idLista=" + idLista + ", subtipo=" + subtipo + ", soloLectura=" + soloLectura + ", valorCampo=" + valorCampo + ", clase=" + clase + ", catalogo=" + catalogo + '}';
    }

private static final long serialVersionUID = 1L;
    
    private Integer idFlujo; 
    private String tabla;
    private String campo;
    private String etiqueta;
    private Boolean listaHabilitada;
    private Integer idSeccionFormulario;
    private Byte obligatorio;
    private Integer orden;
    private String tipoControl;
    private String tipoDato;
    private Integer idLista;
    private String subtipo;
    private Boolean soloLectura;
    private String valorCampo;
    private String clase;
    private List<CatalogoElement> catalogo;

    /**
     * @return the idFlujo
     */
    public Integer getIdFlujo() {
        return idFlujo;
    }

    /**
     * @param idFlujo the idFlujo to set
     */
    public void setIdFlujo(Integer idFlujo) {
        this.idFlujo = idFlujo;
    }

    /**
     * @return the etiqueta
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * @param descripcion the etiqueta to set
     */
    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    /**
     * @return the tipoControl
     */
    public String getTipoControl() {
        return tipoControl;
    }

    /**
     * @param tipoControl the tipoControl to set
     */
    public void setTipoControl(String tipoControl) {
        this.tipoControl = tipoControl;
    }
    
    /**
     * @return the subtipo
     */
    public String getSubtipo() {
        return subtipo;
    }

    /**
     * @param subtipo the subtipo to set
     */
    public void setSubtipo(String subtipo) {
        this.subtipo = subtipo;
    }

    /**
     * @return the catalogo
     */
    public List<CatalogoElement> getCatalogo() {
        return catalogo;
    }

    /**
     * @param catalogo the catalogo to set
     */
    public void setCatalogo(List<CatalogoElement> catalogo) {
        this.catalogo = catalogo;
    }

    /**
     * @return the tabla
     */
    public String getTabla() {
        return tabla;
    }

    /**
     * @param tabla the tabla to set
     */
    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    /**
     * @return the campo
     */
    public String getCampo() {
        return campo;
    }

    /**
     * @param campo the campo to set
     */
    public void setCampo(String campo) {
        this.campo = campo;
    }

    /**
     * @return the listaHabilitada
     */
    public Boolean getListaHabilitada() {
        return listaHabilitada;
    }

    /**
     * @param listaHabilitada the listaHabilitada to set
     */
    public void setListaHabilitada(Boolean listaHabilitada) {
        this.listaHabilitada = listaHabilitada;
    }
    
    /**
     * @return the idSeccionFormulario
     */
    public Integer getIdSeccionFormulario() {
        return idSeccionFormulario;
    }

    /**
     * @param idSeccionFormulario the obligatorio to set
     */
    public void setIdSeccionFormulario(Integer idSeccionFormulario) {
        this.idSeccionFormulario = idSeccionFormulario;
    }
    
    /**
     * @return the obligatorio
     */
    public Byte getObligatorio() {
        return obligatorio;
    }

    /**
     * @param obligatorio the obligatorio to set
     */
    public void setObligatorio(Byte obligatorio) {
        this.obligatorio = obligatorio;
    }
    
    
    /**
     * @return the orden
     */
        public Integer getOrden() {
        return orden;
    }

    /**
     * @param orden the orden to set
     */
    public void setOrden(Integer orden) {
        this.orden = orden;
    }
    
    /**
     * @return the idLista
     */
        public Integer getIdLista() {
        return idLista;
    }

    /**
     * @param idLista the idLista to set
     */
    public void setIdLista(Integer idLista) {
        this.idLista = idLista;
    }

	public Boolean getSoloLectura() {
		return soloLectura;
	}

	public void setSoloLectura(Boolean soloLectura) {
		this.soloLectura = soloLectura;
	}

	public String getTipoDato() {
		return tipoDato;
	}

	public void setTipoDato(String tipoDato) {
		this.tipoDato = tipoDato;
	}

	public String getValorCampo() {
		return valorCampo;
	}

	public void setValorCampo(String valorCampo) {
		this.valorCampo = valorCampo;
	}

	public String getClase() {
		return clase;
	}

	public void setClase(String clase) {
		this.clase = clase;
	}
}
