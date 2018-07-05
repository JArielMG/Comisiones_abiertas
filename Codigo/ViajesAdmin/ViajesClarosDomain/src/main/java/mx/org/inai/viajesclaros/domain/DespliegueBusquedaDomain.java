
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
    private Byte orden;
    private Boolean mostrar;

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
     * @param orden the orden to set
     */
    public void setOrden(Byte orden) {
        this.orden = orden;
    }
    
    /**
     * @return the orden
     */
    public Byte getOrden() {
        return orden;
    }
    
    /**
     * @param mostrar the mostrar to set
     */
    public void setMostrar(Boolean mostrar) {
        this.mostrar = mostrar;
    }
    
    /**
     * @return the mostrar
     */
    public Boolean getMostrar() {
        return mostrar;
    }
}
