
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author sandro
 */
public class CargaColumnDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idDependencia;
    private String tabla;
    private String campo;
    private String despliegue;
    private Boolean editable;
    private Boolean listaHabilitada;
    private Integer secuencia;

    /**
     * @return the idDependencia
     */
    public Integer getIdDependencia() {
        return idDependencia;
    }

    /**
     * @param idDependencia the idDependencia to set
     */
    public void setIdDependencia(Integer idDependencia) {
        this.idDependencia = idDependencia;
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
     * @return the despliegue
     */
    public String getDespliegue() {
        return despliegue;
    }

    /**
     * @param despliegue the despliegue to set
     */
    public void setDespliegue(String despliegue) {
        this.despliegue = despliegue;
    }

    /**
     * @return the editable
     */
    public Boolean getEditable() {
        return editable;
    }

    /**
     * @param editable the editable to set
     */
    public void setEditable(Boolean editable) {
        this.editable = editable;
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
     * @return the secuencia
     */
    public Integer getSecuencia() {
        return secuencia;
    }

    /**
     * @param secuencia the secuencia to set
     */
    public void setSecuencia(Integer secuencia) {
        this.secuencia = secuencia;
    }
}
