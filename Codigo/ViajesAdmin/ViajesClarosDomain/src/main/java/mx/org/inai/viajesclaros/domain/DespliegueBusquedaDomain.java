
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class DespliegueBusquedaDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idDependencia;
    private String tabla;
    private String campo;
    private String despliegue;

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
}
