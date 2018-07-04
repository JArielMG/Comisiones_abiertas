
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author sandro
 */
public class GraficaDependenciaDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idGrafica;
    private Integer idDependencia;
    private String grafica;
    private String codigoGrafica;
    private String dependencia;
    private Boolean enabled;

    /**
     * @return the idGrafica
     */
    public Integer getIdGrafica() {
        return idGrafica;
    }

    /**
     * @param idGrafica the idGrafica to set
     */
    public void setIdGrafica(Integer idGrafica) {
        this.idGrafica = idGrafica;
    }

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
     * @return the grafica
     */
    public String getGrafica() {
        return grafica;
    }

    /**
     * @param grafica the grafica to set
     */
    public void setGrafica(String grafica) {
        this.grafica = grafica;
    }

    /**
     * @return the dependencia
     */
    public String getDependencia() {
        return dependencia;
    }

    /**
     * @param dependencia the dependencia to set
     */
    public void setDependencia(String dependencia) {
        this.dependencia = dependencia;
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
     * @return the codigoGrafica
     */
    public String getCodigoGrafica() {
        return codigoGrafica;
    }

    /**
     * @param codigoGrafica the codigoGrafica to set
     */
    public void setCodigoGrafica(String codigoGrafica) {
        this.codigoGrafica = codigoGrafica;
    }
}
