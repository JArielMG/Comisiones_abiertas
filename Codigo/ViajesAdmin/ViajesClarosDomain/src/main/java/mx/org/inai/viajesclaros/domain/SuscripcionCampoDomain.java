
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class SuscripcionCampoDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idDependencia;
    private String campo;
    private String despliegue;
    private Boolean enabled;
    private String categoria;

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
     * @return the enabled
     */
    public Boolean getEnabled() {
        return enabled;
    }

    /**
     * @param enabled the enabled to set
     */
    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
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
}
