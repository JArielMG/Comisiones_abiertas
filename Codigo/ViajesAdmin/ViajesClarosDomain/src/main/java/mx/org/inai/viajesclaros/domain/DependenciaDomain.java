
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class DependenciaDomain implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;
    private String dependencia;
    private String siglas;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
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
     * @return the siglas
     */
    public String getSiglas() {
        return siglas;
    }

    /**
     * @param siglas the siglas to set
     */
    public void setSiglas(String siglas) {
        this.siglas = siglas;
    }

    @Override
    public boolean equals(Object other) {
        return (id != null && other != null && getClass() == other.getClass())
                ? id.equals(((DependenciaDomain) other).id)
                : (other == this);
    }

    @Override
    public int hashCode() {
        return (id != null)
                ? (getClass().hashCode() + id.hashCode())
                : super.hashCode();
    }
}
