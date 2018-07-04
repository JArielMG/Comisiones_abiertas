
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author sandro
 */
public class CampoFlujoDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idFlujo;
    private Integer idTipoPersona;
    private String tabla;
    private String campo;
    private String etiqueta;
    private Boolean listaHabilitada;
    private Integer idSeccion;
    private Boolean obligatorio;
    private Integer orden;
    private Integer idLista;
    private String categoria;
    private String tipoControl;
    private String tipoDato;
    private String subtipo;
    private Boolean soloLectura;
    private String clase;

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
     * @return the etiqueta
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * @param etiqueta the etiqueta to set
     */
    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
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
     * @return the obligatorio
     */
    public Boolean getObligatorio() {
        return obligatorio;
    }

    /**
     * @param obligatorio the obligatorio to set
     */
    public void setObligatorio(Boolean obligatorio) {
        this.obligatorio = obligatorio;
    }

    /**
     * @return the categoria
     */
    public String getCategoria() {
        return categoria;
    }

    /**
     * @param categoria the categoria to set
     */
    public void setCategoria(String categoria) {
        this.categoria = categoria;
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
     * @return the tipoDato
     */
    public String getTipoDato() {
        return tipoDato;
    }

    /**
     * @param tipoDato the tipoDato to set
     */
    public void setTipoDato(String tipoDato) {
        this.tipoDato = tipoDato;
    }
    
    
    
    /**
     * @return the idTipoPersona
     */
    public Integer getIdTipoPersona() {
        return idTipoPersona;
    }

    /**
     * @param idTipoPersona the idTipoPersona to set
     */
    public void setIdTipoPersona(Integer idTipoPersona) {
        this.idTipoPersona = idTipoPersona;
    }

    /**
     * @return the idSeccion
     */
    public Integer getIdSeccion() {
        return idSeccion;
    }

    /**
     * @param idSeccion the idSeccion to set
     */
    public void setIdSeccion(Integer idSeccion) {
        this.idSeccion = idSeccion;
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
     * @return the soloLectura
     */
    public Boolean getSoloLectura() {
        return soloLectura;
    }

    /**
     * @param soloLectura the obligatorio to set
     */
    public void setSoloLectura(Boolean soloLectura) {
        this.soloLectura = soloLectura;
    }
    
    /**
     * @return the clase
     */
    public String getClase() {
        return clase;
    }

    /**
     * @param clase the subtipo to set
     */
    public void setClase(String clase) {
        this.clase = clase;
    }
}
